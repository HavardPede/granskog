-- Builds a lualine theme from a Granskog variant.
return function(variant)
  local c = require("granskog.palette")[variant]
  local function mode(color)
    return {
      a = { fg = c.bg, bg = color, gui = "bold" },
      b = { fg = c.fg, bg = c.bg2 },
      c = { fg = c.fg_alt, bg = c.bg1 },
    }
  end
  return {
    normal = mode(c.green),
    insert = mode(c.blue),
    visual = mode(c.magenta),
    replace = mode(c.orange),
    command = mode(c.yellow),
    terminal = mode(c.cyan),
    inactive = {
      a = { fg = c.inactive, bg = c.bg_dim, gui = "bold" },
      b = { fg = c.inactive, bg = c.bg_dim },
      c = { fg = c.inactive, bg = c.bg_dim },
    },
  }
end
