-- Follows 'background' like `:colorscheme granskog`.
local variant = vim.o.background == "light" and "reinlav" or "granskog"
return require("granskog.lualine")(variant)
