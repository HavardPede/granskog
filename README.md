<h1 align="center">Granskog</h1>

<p align="center">
  A terminal color theme sampled from a Norwegian forest floor in October.<br>
  <b>Granskog</b> (dark) · <b>Reinlav</b> (light)
</p>

![Illustrated Norwegian autumn forest with pale reindeer lichen and red blueberry foliage](assets/hero.png)

*Granskog* is Norwegian for spruce forest. *Reinlav* is reindeer lichen, the soft grey-white carpet that covers the ground beneath it.

The colors were sampled from photographs of a Norwegian forest floor. The banner is an illustration inspired by that landscape. The lichen gives the light background and the spruce gives the dark one. Blueberry heather turning red gives the red, the last birch leaves give the yellow, and lingonberry and moss give the green. The blue-grey comes from lichen on the pine bark. Everything is muted, the way a forest looks on an overcast autumn day.

## Granskog (dark)

![Granskog preview](assets/granskog.png)

## Reinlav (light)

![Reinlav preview](assets/reinlav.png)

## Palette

![Granskog and Reinlav palettes](assets/palette.png)

The full palette, including Claude Code tokens, lives in [`palette.json`](palette.json).

## Install

| Tool | Files |
| :- | :- |
| [Ghostty](#ghostty) | [`ghostty/`](ghostty) |
| [iTerm2](#iterm2) | [`iterm2/`](iterm2) |
| [Claude Code](#claude-code) | [`claude-code/`](claude-code) |
| [Kitty](#kitty) | [`kitty/`](kitty) |
| [Alacritty](#alacritty) | [`alacritty/`](alacritty) |
| [WezTerm](#wezterm) | [`wezterm/`](wezterm) |

### Ghostty

```sh
mkdir -p ~/.config/ghostty/themes
cp ghostty/granskog ghostty/reinlav ~/.config/ghostty/themes/
```

Then in `~/.config/ghostty/config`, follow the system appearance:

```
theme = light:reinlav,dark:granskog
```

Reinlav sets `minimum-contrast = 3`, so text that lands on a colored background with too little contrast is lifted automatically.

### iTerm2

Open **Settings → Profiles → Colors → Color Presets → Import…** and choose the two files in [`iterm2/`](iterm2). To follow the system appearance, check **Use separate colors for light and dark mode** and pick Granskog for dark and Reinlav for light.

### Claude Code

Claude Code supports [custom themes](https://code.claude.com/docs/en/terminal-config) as JSON files.

```sh
mkdir -p ~/.claude/themes
cp claude-code/granskog.json claude-code/reinlav.json ~/.claude/themes/
```

Run `/theme` and pick **Granskog** or **Reinlav**. Claude Code reloads theme files when they change, so running sessions update without a restart.

A custom theme is either light or dark. To follow the system appearance, select a single slot such as `custom:granskog-auto` once, and let a small script copy `granskog.json` or `reinlav.json` over `~/.claude/themes/granskog-auto.json` when macOS switches. Every open session follows.

### Kitty

```sh
cp kitty/*.conf ~/.config/kitty/
```

Add `include granskog.conf` (or `reinlav.conf`) to `kitty.conf`.

### Alacritty

```sh
mkdir -p ~/.config/alacritty/themes
cp alacritty/*.toml ~/.config/alacritty/themes/
```

```toml
[general]
import = ["~/.config/alacritty/themes/granskog.toml"]
```

### WezTerm

```sh
mkdir -p ~/.config/wezterm/colors
cp wezterm/*.toml ~/.config/wezterm/colors/
```

```lua
config.color_scheme = "Granskog" -- or "Reinlav"
```

## Readability

Muted should not mean hard to read. Both themes are checked against WCAG 2 and APCA:

| | Granskog | Reinlav |
| :- | :-: | :-: |
| Foreground on background | 10.1 : 1 | 10.7 : 1 |
| Lowest ANSI color (red–cyan, normal and bright) | 6.1 : 1 | 4.6 : 1 |
| Dim text (bright black) | 4.1 : 1 | 5.1 : 1 |

- Neither background is pure black or white. That avoids glare on light themes and halation (glowing text) on dark ones.
- Red and green are separated by lightness as well as hue, so they stay distinct with red–green color blindness (deuteranopia).
- Red is reserved for errors. The cursor and accents use birch yellow and moss green.
- As in most light themes, Reinlav's white and bright white are close to the background, because programs use them as background colors.

Run `python3 build.py --check` to print the full report.

## Building

[`palette.json`](palette.json) is the single source of truth. After editing it, regenerate every port:

```sh
python3 build.py
```

It needs only the Python standard library. Ports for other tools are welcome; add a function to `build.py` instead of editing generated files by hand.

## License

[MIT](LICENSE)
