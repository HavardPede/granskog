-- Granskog / Reinlav for Neovim.
-- Colours come from lua/granskog/palette.lua, generated from palette.json.

local M = {}

M.config = {
  italic_comments = true,
  transparent = false,
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function groups(c, cfg)
  local bg = cfg.transparent and "NONE" or c.bg
  local bg_float = cfg.transparent and "NONE" or c.bg_dim

  return {
    -- Editor ---------------------------------------------------------------
    Normal = { fg = c.fg, bg = bg },
    NormalNC = { link = "Normal" },
    NormalFloat = { fg = c.fg, bg = bg_float },
    FloatBorder = { fg = c.border, bg = bg_float },
    FloatTitle = { fg = c.yellow, bg = bg_float, bold = true },
    FloatFooter = { fg = c.inactive, bg = bg_float },
    Cursor = { fg = c.bg, bg = c.cursor },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    TermCursor = { link = "Cursor" },
    CursorLine = { bg = c.bg1 },
    CursorColumn = { bg = c.bg1 },
    ColorColumn = { bg = c.bg1 },
    CursorLineNr = { fg = c.yellow, bold = true },
    LineNr = { fg = c.line_nr },
    LineNrAbove = { link = "LineNr" },
    LineNrBelow = { link = "LineNr" },
    SignColumn = { fg = c.line_nr, bg = bg },
    FoldColumn = { fg = c.line_nr, bg = bg },
    Folded = { fg = c.fg_alt, bg = c.bg1 },
    VertSplit = { fg = c.border },
    WinSeparator = { fg = c.border },
    Visual = { bg = c.bg2 },
    VisualNOS = { link = "Visual" },
    Search = { fg = c.fg, bg = c.search },
    CurSearch = { fg = c.bg, bg = c.yellow, bold = true },
    IncSearch = { link = "CurSearch" },
    Substitute = { fg = c.bg, bg = c.orange },
    MatchParen = { fg = c.bright_yellow, bg = c.bg2, bold = true },
    NonText = { fg = c.nontext },
    Whitespace = { fg = c.nontext },
    SpecialKey = { fg = c.nontext },
    EndOfBuffer = { fg = c.bg },
    Conceal = { fg = c.comment },
    Directory = { fg = c.blue, bold = true },
    Title = { fg = c.yellow, bold = true },
    Question = { fg = c.green },
    MoreMsg = { fg = c.green },
    ModeMsg = { fg = c.fg_alt, bold = true },
    MsgArea = { fg = c.fg },
    ErrorMsg = { fg = c.red, bold = true },
    WarningMsg = { fg = c.orange },
    WildMenu = { link = "PmenuSel" },
    QuickFixLine = { bg = c.bg2, bold = true },

    StatusLine = { fg = c.fg_alt, bg = c.bg1 },
    StatusLineNC = { fg = c.inactive, bg = c.bg_dim },
    TabLine = { fg = c.inactive, bg = c.bg_dim },
    TabLineFill = { bg = c.bg_dim },
    TabLineSel = { fg = c.fg, bg = c.bg, bold = true },
    WinBar = { fg = c.fg_alt, bold = true },
    WinBarNC = { fg = c.inactive },

    Pmenu = { fg = c.fg, bg = c.bg_dim },
    PmenuSel = { fg = c.fg, bg = c.bg2, bold = true },
    PmenuSbar = { bg = c.bg1 },
    PmenuThumb = { bg = c.border },
    PmenuKind = { fg = c.cyan, bg = c.bg_dim },
    PmenuExtra = { fg = c.inactive, bg = c.bg_dim },
    PmenuMatch = { fg = c.yellow, bg = c.bg_dim, bold = true },
    PmenuMatchSel = { fg = c.bright_yellow, bg = c.bg2, bold = true },

    SpellBad = { sp = c.red, undercurl = true },
    SpellCap = { sp = c.orange, undercurl = true },
    SpellLocal = { sp = c.cyan, undercurl = true },
    SpellRare = { sp = c.magenta, undercurl = true },

    DiffAdd = { bg = c.diff_add },
    DiffDelete = { fg = c.red, bg = c.diff_delete },
    DiffChange = { bg = c.diff_change },
    DiffText = { bg = c.diff_text, bold = true },
    Added = { fg = c.green },
    Removed = { fg = c.red },
    Changed = { fg = c.blue },
    diffAdded = { link = "Added" },
    diffRemoved = { link = "Removed" },
    diffChanged = { link = "Changed" },
    diffFile = { fg = c.yellow, bold = true },
    diffLine = { fg = c.cyan },

    -- Syntax (legacy) -----------------------------------------------------
    -- Red is reserved for errors, so no syntax group uses it.
    Comment = { fg = c.comment, italic = cfg.italic_comments },
    Constant = { fg = c.yellow },
    String = { fg = c.green },
    Character = { fg = c.green },
    Number = { fg = c.yellow },
    Boolean = { fg = c.yellow },
    Float = { fg = c.yellow },
    Identifier = { fg = c.fg },
    Function = { fg = c.blue },
    Statement = { fg = c.magenta },
    Conditional = { fg = c.magenta },
    Repeat = { fg = c.magenta },
    Label = { fg = c.magenta },
    Operator = { fg = c.fg_alt },
    Keyword = { fg = c.magenta },
    Exception = { fg = c.magenta },
    PreProc = { fg = c.magenta },
    Include = { fg = c.magenta },
    Define = { fg = c.magenta },
    Macro = { fg = c.cyan },
    PreCondit = { fg = c.magenta },
    Type = { fg = c.cyan },
    StorageClass = { fg = c.magenta },
    Structure = { fg = c.cyan },
    Typedef = { fg = c.cyan },
    Special = { fg = c.cyan },
    SpecialChar = { fg = c.orange },
    Tag = { fg = c.blue },
    Delimiter = { fg = c.fg_alt },
    SpecialComment = { fg = c.comment, bold = true },
    Debug = { fg = c.orange },
    Underlined = { fg = c.blue, underline = true },
    Ignore = { fg = c.comment },
    Error = { fg = c.red },
    Todo = { fg = c.bg, bg = c.yellow, bold = true },

    -- Treesitter ------------------------------------------------------------
    ["@variable"] = { fg = c.fg },
    ["@variable.builtin"] = { fg = c.cyan, italic = true },
    ["@variable.parameter"] = { fg = c.fg },
    ["@variable.member"] = { fg = c.fg_alt },
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { fg = c.yellow, italic = true },
    ["@constant.macro"] = { link = "Macro" },
    ["@module"] = { fg = c.cyan },
    ["@module.builtin"] = { fg = c.cyan, italic = true },
    ["@label"] = { link = "Label" },
    ["@string"] = { link = "String" },
    ["@string.documentation"] = { fg = c.comment },
    ["@string.regexp"] = { fg = c.orange },
    ["@string.escape"] = { fg = c.orange },
    ["@string.special"] = { fg = c.cyan },
    ["@string.special.symbol"] = { fg = c.yellow },
    ["@string.special.url"] = { fg = c.blue, underline = true },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Float" },
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { fg = c.cyan, italic = true },
    ["@type.definition"] = { link = "Type" },
    ["@type.qualifier"] = { fg = c.magenta },
    ["@attribute"] = { fg = c.cyan },
    ["@property"] = { fg = c.fg_alt },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { fg = c.blue, italic = true },
    ["@function.call"] = { link = "Function" },
    ["@function.macro"] = { link = "Macro" },
    ["@function.method"] = { link = "Function" },
    ["@function.method.call"] = { link = "Function" },
    ["@constructor"] = { fg = c.cyan },
    ["@operator"] = { link = "Operator" },
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.function"] = { fg = c.magenta },
    ["@keyword.operator"] = { fg = c.magenta },
    ["@keyword.import"] = { link = "Include" },
    ["@keyword.return"] = { fg = c.magenta, italic = true },
    ["@keyword.exception"] = { link = "Exception" },
    ["@keyword.conditional"] = { link = "Conditional" },
    ["@keyword.repeat"] = { link = "Repeat" },
    ["@keyword.directive"] = { link = "PreProc" },
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@punctuation.bracket"] = { fg = c.fg_alt },
    ["@punctuation.special"] = { fg = c.cyan },
    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { link = "Comment" },
    ["@comment.error"] = { fg = c.red, bold = true },
    ["@comment.warning"] = { fg = c.orange, bold = true },
    ["@comment.todo"] = { link = "Todo" },
    ["@comment.note"] = { fg = c.blue, bold = true },
    ["@tag"] = { link = "Tag" },
    ["@tag.builtin"] = { fg = c.blue, italic = true },
    ["@tag.attribute"] = { fg = c.cyan },
    ["@tag.delimiter"] = { fg = c.fg_alt },
    ["@markup.heading"] = { fg = c.yellow, bold = true },
    ["@markup.heading.1"] = { fg = c.yellow, bold = true },
    ["@markup.heading.2"] = { fg = c.green, bold = true },
    ["@markup.heading.3"] = { fg = c.blue, bold = true },
    ["@markup.heading.4"] = { fg = c.magenta, bold = true },
    ["@markup.heading.5"] = { fg = c.cyan, bold = true },
    ["@markup.heading.6"] = { fg = c.fg_alt, bold = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.quote"] = { fg = c.comment, italic = true },
    ["@markup.math"] = { fg = c.cyan },
    ["@markup.link"] = { fg = c.blue },
    ["@markup.link.label"] = { fg = c.blue },
    ["@markup.link.url"] = { fg = c.blue, underline = true },
    ["@markup.raw"] = { fg = c.green },
    ["@markup.raw.block"] = { fg = c.fg_alt },
    ["@markup.list"] = { fg = c.magenta },
    ["@markup.list.checked"] = { fg = c.green },
    ["@markup.list.unchecked"] = { fg = c.comment },
    ["@diff.plus"] = { link = "Added" },
    ["@diff.minus"] = { link = "Removed" },
    ["@diff.delta"] = { link = "Changed" },

    -- LSP -------------------------------------------------------------------
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.variable"] = {},
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.method"] = { link = "@function.method" },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    LspReferenceText = { bg = c.bg2 },
    LspReferenceRead = { bg = c.bg2 },
    LspReferenceWrite = { bg = c.bg2, underline = true },
    LspInlayHint = { fg = c.inactive },
    LspCodeLens = { fg = c.inactive },
    LspSignatureActiveParameter = { fg = c.yellow, bold = true },

    DiagnosticError = { fg = c.red },
    DiagnosticWarn = { fg = c.orange },
    DiagnosticInfo = { fg = c.blue },
    DiagnosticHint = { fg = c.cyan },
    DiagnosticOk = { fg = c.green },
    DiagnosticVirtualTextError = { fg = c.bright_red, bg = c.error_bg },
    DiagnosticVirtualTextWarn = { fg = c.orange, bg = c.warn_bg },
    DiagnosticVirtualTextInfo = { fg = c.blue, bg = c.info_bg },
    DiagnosticVirtualTextHint = { fg = c.cyan, bg = c.hint_bg },
    DiagnosticVirtualTextOk = { fg = c.green, bg = c.ok_bg },
    DiagnosticUnderlineError = { sp = c.red, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.orange, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.cyan, undercurl = true },
    DiagnosticUnderlineOk = { sp = c.green, undercurl = true },
    DiagnosticUnnecessary = { fg = c.comment },
    DiagnosticDeprecated = { strikethrough = true },

    -- Plugins ---------------------------------------------------------------
    -- gitsigns
    GitSignsAdd = { fg = c.green },
    GitSignsChange = { fg = c.blue },
    GitSignsDelete = { fg = c.red },
    -- telescope
    TelescopeNormal = { link = "NormalFloat" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeTitle = { link = "FloatTitle" },
    TelescopeSelection = { bg = c.bg2, bold = true },
    TelescopeMatching = { fg = c.yellow, bold = true },
    TelescopePromptPrefix = { fg = c.yellow },
    -- snacks / fzf-lua pickers
    SnacksPickerMatch = { fg = c.yellow, bold = true },
    FzfLuaBorder = { link = "FloatBorder" },
    -- completion (nvim-cmp, blink.cmp)
    CmpItemAbbrMatch = { fg = c.yellow, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.yellow },
    CmpItemKind = { fg = c.cyan },
    CmpItemMenu = { fg = c.inactive },
    BlinkCmpLabelMatch = { fg = c.yellow, bold = true },
    BlinkCmpKind = { fg = c.cyan },
    BlinkCmpMenuBorder = { link = "FloatBorder" },
    -- indent guides
    IblIndent = { fg = c.nontext },
    IblScope = { fg = c.line_nr },
    MiniIndentscopeSymbol = { fg = c.line_nr },
    -- file trees
    NvimTreeNormal = { fg = c.fg, bg = c.bg_dim },
    NvimTreeFolderName = { fg = c.blue },
    NvimTreeOpenedFolderName = { fg = c.blue, bold = true },
    NeoTreeNormal = { fg = c.fg, bg = c.bg_dim },
    NeoTreeNormalNC = { fg = c.fg, bg = c.bg_dim },
    NeoTreeDirectoryName = { fg = c.blue },
    NeoTreeGitModified = { fg = c.blue },
    NeoTreeGitAdded = { fg = c.green },
    NeoTreeGitDeleted = { fg = c.red },
    NeoTreeGitUntracked = { fg = c.comment },
    -- which-key
    WhichKey = { fg = c.yellow },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.fg },
    WhichKeySeparator = { fg = c.comment },
    -- mini.statusline
    MiniStatuslineModeNormal = { fg = c.bg, bg = c.green, bold = true },
    MiniStatuslineModeInsert = { fg = c.bg, bg = c.blue, bold = true },
    MiniStatuslineModeVisual = { fg = c.bg, bg = c.magenta, bold = true },
    MiniStatuslineModeReplace = { fg = c.bg, bg = c.orange, bold = true },
    MiniStatuslineModeCommand = { fg = c.bg, bg = c.yellow, bold = true },
  }
end

function M.load(variant, scheme)
  local c = require("granskog.palette")[variant]
  if not c then
    error("granskog: unknown variant '" .. tostring(variant) .. "'")
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = nil
  if vim.o.background ~= c.appearance then
    vim.o.background = c.appearance
  end
  vim.o.termguicolors = true
  vim.g.colors_name = scheme or variant

  for name, spec in pairs(groups(c, M.config)) do
    vim.api.nvim_set_hl(0, name, spec)
  end
  for i, color in ipairs(c.terminal) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

-- Entry point for colors/granskog.lua. Follows 'background', so terminals and
-- auto-dark-mode plugins that set it get Reinlav in light mode.
function M.granskog()
  M.load(vim.o.background == "light" and "reinlav" or "granskog", "granskog")
end

-- Entry point for colors/reinlav.lua. Loading it selects light mode. If
-- 'background' later turns dark, Neovim reloads the scheme and we hand over to
-- Granskog instead of fighting the change.
function M.reinlav()
  if vim.g.colors_name == "reinlav" and vim.o.background == "dark" then
    M.load("granskog", "granskog")
  else
    M.load("reinlav", "reinlav")
  end
end

return M
