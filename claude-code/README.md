# Claude Code

Claude Code supports [custom themes](https://code.claude.com/docs/en/terminal-config) as JSON files.

```sh
mkdir -p ~/.claude/themes
cp claude-code/granskog.json claude-code/reinlav.json ~/.claude/themes/
```

Run `/theme` and pick **Granskog** or **Reinlav**. Claude Code reloads theme files when they change, so running sessions update without a restart.

A custom theme is either light or dark. To follow the system appearance, select a single slot such as `custom:granskog-auto` once, and let a small script copy `granskog.json` or `reinlav.json` over `~/.claude/themes/granskog-auto.json` when macOS switches. Every open session follows.
