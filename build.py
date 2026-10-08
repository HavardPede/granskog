#!/usr/bin/env python3
"""Generate every Granskog port from palette.json.

    python3 build.py          # regenerate all ports
    python3 build.py --check  # print a contrast report (WCAG 2 + APCA)

Standard library only.
"""
import json
import plistlib
import sys
from pathlib import Path

ROOT = Path(__file__).parent
ORDER = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]


def load():
    return json.loads((ROOT / "palette.json").read_text())["themes"]


def palette16(t):
    return [t["ansi"][c] for c in ORDER] + [t["bright"][c] for c in ORDER]


def rgb(h):
    return tuple(int(h[i:i + 2], 16) for i in (1, 3, 5))


def write(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text)


# --- ports -------------------------------------------------------------------

def ghostty(slug, t):
    lines = [
        f"# {t['name']} — {t['description']}",
        f"background = {t['background']}",
        f"foreground = {t['foreground']}",
        f"cursor-color = {t['cursor']}",
        f"cursor-text = {t['background']}",
        f"selection-background = {t['selection']}",
        f"selection-foreground = {t['foreground']}",
    ]
    for key, value in t.get("ghostty_extra", {}).items():
        lines.append(f"{key} = {value}")
    lines += [f"palette = {i}={c}" for i, c in enumerate(palette16(t))]
    write(ROOT / "ghostty" / slug, "\n".join(lines) + "\n")


def iterm2(slug, t):
    def col(h):
        r, g, b = rgb(h)
        return {"Color Space": "sRGB", "Red Component": r / 255,
                "Green Component": g / 255, "Blue Component": b / 255,
                "Alpha Component": 1.0}
    d = {f"Ansi {i} Color": col(c) for i, c in enumerate(palette16(t))}
    d.update({
        "Background Color": col(t["background"]),
        "Foreground Color": col(t["foreground"]),
        "Bold Color": col(t["foreground"]),
        "Cursor Color": col(t["cursor"]),
        "Cursor Text Color": col(t["background"]),
        "Selection Color": col(t["selection"]),
        "Selected Text Color": col(t["foreground"]),
        "Link Color": col(t["ansi"]["blue"]),
    })
    path = ROOT / "iterm2" / f"{t['name']}.itermcolors"
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "wb") as f:
        plistlib.dump(d, f)


def claude_code(slug, t):
    cc = t["claude_code"]
    doc = {"name": t["name"], "base": cc["base"], "overrides": cc["overrides"]}
    write(ROOT / "claude-code" / f"{slug}.json", json.dumps(doc, indent=2) + "\n")


def kitty(slug, t):
    lines = [
        f"# {t['name']} — {t['description']}",
        f"background {t['background']}",
        f"foreground {t['foreground']}",
        f"cursor {t['cursor']}",
        f"cursor_text_color {t['background']}",
        f"selection_background {t['selection']}",
        f"selection_foreground {t['foreground']}",
    ]
    lines += [f"color{i} {c}" for i, c in enumerate(palette16(t))]
    write(ROOT / "kitty" / f"{slug}.conf", "\n".join(lines) + "\n")


def alacritty(slug, t):
    def block(name, colors):
        return [f"[colors.{name}]"] + [f'{c} = "{colors[c]}"' for c in ORDER] + [""]
    lines = [
        f"# {t['name']} — {t['description']}",
        "[colors.primary]",
        f'background = "{t["background"]}"',
        f'foreground = "{t["foreground"]}"',
        "",
        "[colors.cursor]",
        f'cursor = "{t["cursor"]}"',
        f'text = "{t["background"]}"',
        "",
        "[colors.selection]",
        f'background = "{t["selection"]}"',
        f'text = "{t["foreground"]}"',
        "",
    ] + block("normal", t["ansi"]) + block("bright", t["bright"])
    write(ROOT / "alacritty" / f"{slug}.toml", "\n".join(lines))


def wezterm(slug, t):
    q = lambda xs: ", ".join(f'"{x}"' for x in xs)
    p = palette16(t)
    lines = [
        f"# {t['name']} — {t['description']}",
        "[colors]",
        f'background = "{t["background"]}"',
        f'foreground = "{t["foreground"]}"',
        f'cursor_bg = "{t["cursor"]}"',
        f'cursor_border = "{t["cursor"]}"',
        f'cursor_fg = "{t["background"]}"',
        f'selection_bg = "{t["selection"]}"',
        f'selection_fg = "{t["foreground"]}"',
        f"ansi = [{q(p[:8])}]",
        f"brights = [{q(p[8:])}]",
        "",
        "[metadata]",
        f'name = "{t["name"]}"',
        "",
    ]
    write(ROOT / "wezterm" / f"{t['name']}.toml", "\n".join(lines))


def herdr(themes):
    # Herdr has no theme files: one [theme] table holds a dark and a light
    # override block, and auto_switch picks one from the host appearance.
    names = " / ".join(f"{t['name']} ({t['appearance']})" for t in themes.values())
    lines = [
        f"# {names}",
        "[theme]",
        'name = "catppuccin" # base theme, every UI token is overridden below',
        "auto_switch = true",
        "",
    ]
    for t in themes.values():
        lines.append(f"[theme.custom.{t['appearance']}]")
        lines += [f'{k} = "{v}"' for k, v in t["herdr"].items()]
        lines.append("")
    write(ROOT / "herdr" / "theme.toml", "\n".join(lines))


def blend(a, b, t):
    """Mix colour b into a by t (0..1), in sRGB."""
    ca, cb = rgb(a), rgb(b)
    return "#%02x%02x%02x" % tuple(round(x + (y - x) * t) for x, y in zip(ca, cb))


def nvim_roles(t):
    # Semantic roles for the Neovim theme. Everything is derived from colours
    # that already exist in palette.json, so the editor matches the terminal.
    cc, hd = t["claude_code"]["overrides"], t["herdr"]
    a, b, bg = t["ansi"], t["bright"], t["background"]
    return {
        "bg": bg,
        "bg_dim": hd["sidebar_bg"],
        "bg1": hd["surface0"],
        "bg2": t["selection"],
        "border": cc["promptBorder"],
        "line_nr": cc["subtle"],
        "nontext": blend(bg, cc["subtle"], 0.55),
        "fg": t["foreground"],
        "fg_alt": hd["subtext0"],
        "comment": b["black"],
        "inactive": cc["inactive"],
        "red": a["red"],
        "green": a["green"],
        "yellow": a["yellow"],
        "blue": a["blue"],
        "magenta": a["magenta"],
        "cyan": a["cyan"],
        "orange": cc["warning"],
        "bright_red": b["red"],
        "bright_green": b["green"],
        "bright_yellow": b["yellow"],
        "bright_blue": b["blue"],
        "bright_magenta": b["magenta"],
        "bright_cyan": b["cyan"],
        "cursor": t["cursor"],
        "search": blend(bg, a["yellow"], 0.30),
        "diff_add": cc["diffAdded"],
        "diff_delete": cc["diffRemoved"],
        "diff_change": blend(bg, a["blue"], 0.16),
        "diff_text": blend(bg, a["blue"], 0.34),
        "error_bg": blend(bg, a["red"], 0.12),
        "warn_bg": blend(bg, cc["warning"], 0.12),
        "info_bg": blend(bg, a["blue"], 0.12),
        "hint_bg": blend(bg, a["cyan"], 0.12),
        "ok_bg": blend(bg, a["green"], 0.12),
    }


def neovim(themes):
    out = ["-- Generated by build.py from palette.json. Do not edit by hand.", "return {"]
    for slug, t in themes.items():
        out.append(f"  {slug} = {{")
        out.append(f'    name = "{t["name"]}",')
        out.append(f'    appearance = "{t["appearance"]}",')
        for k, v in nvim_roles(t).items():
            out.append(f'    {k} = "{v}",')
        term = ", ".join(f'"{c}"' for c in palette16(t))
        out.append(f"    terminal = {{ {term} }},")
        out.append("  },")
    out.append("}")
    write(ROOT / "lua" / "granskog" / "palette.lua", "\n".join(out) + "\n")


# --- contrast report ---------------------------------------------------------

def _lin(c):
    c /= 255
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4


def wcag(a, b):
    la, lb = (0.2126 * _lin(r) + 0.7152 * _lin(g) + 0.0722 * _lin(bl)
              for r, g, bl in (rgb(a), rgb(b)))
    hi, lo = max(la, lb), min(la, lb)
    return (hi + 0.05) / (lo + 0.05)


def apca(text, bg):
    def y(h):
        r, g, b = (c / 255 for c in rgb(h))
        v = 0.2126729 * r ** 2.4 + 0.7151522 * g ** 2.4 + 0.0721750 * b ** 2.4
        return v + (0.022 - v) ** 1.414 if v < 0.022 else v
    t, b = y(text), y(bg)
    if b > t:
        s = (b ** 0.56 - t ** 0.57) * 1.14
        return 0.0 if s < 0.1 else (s - 0.027) * 100
    s = (b ** 0.65 - t ** 0.62) * 1.14
    return 0.0 if s > -0.1 else (s + 0.027) * 100


def check(themes):
    for slug, t in themes.items():
        bg = t["background"]
        print(f"\n{t['name']} ({t['appearance']}, background {bg})")
        print(f"  {'foreground':16}{t['foreground']}  WCAG {wcag(t['foreground'], bg):5.1f}  APCA {abs(apca(t['foreground'], bg)):5.1f}")
        for group in ("ansi", "bright"):
            for c in ORDER:
                h = t[group][c]
                label = ("bright " if group == "bright" else "") + c
                print(f"  {label:16}{h}  WCAG {wcag(h, bg):5.1f}  APCA {abs(apca(h, bg)):5.1f}")


def main():
    themes = load()
    if "--check" in sys.argv:
        check(themes)
        return
    for slug, t in themes.items():
        for port in (ghostty, iterm2, claude_code, kitty, alacritty, wezterm):
            port(slug, t)
    herdr(themes)
    neovim(themes)
    print("Built:", ", ".join(t["name"] for t in themes.values()))


if __name__ == "__main__":
    main()
