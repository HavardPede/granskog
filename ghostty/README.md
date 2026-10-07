# Ghostty

```sh
mkdir -p ~/.config/ghostty/themes
cp ghostty/granskog ghostty/reinlav ~/.config/ghostty/themes/
```

Then in `~/.config/ghostty/config`, follow the system appearance:

```
theme = light:reinlav,dark:granskog
```

Reinlav sets `minimum-contrast = 3`, so text that lands on a colored background with too little contrast is lifted automatically.
