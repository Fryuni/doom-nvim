local markdown = {}

markdown.settings = {
  --- Disables auto installing the treesitter
  --- @type boolean
  disable_treesitter = false,
  --- Treesitter grammars to install
  --- @type string|string[]
  treesitter_grammars = "markdown",

  --- Disables default LSP config
  --- @type boolean
  disable_lsp = false,
  --- Name of the language server
  --- @type string
  lsp_name = "marksman",
  --- Custom config to pass to nvim-lspconfig
  --- @type table|nil
  lsp_config = nil,

  --- Disables null-ls formatting sources
  --- @type boolean
  disable_formatting = false,
  --- Mason.nvim package to auto install the formatter from
  --- @type string
  formatting_package = "dprint",
  --- String to access the null_ls diagnositcs provider
  --- @type string
  formatting_provider = "builtins.formatting.dprint",
  --- Function to configure null-ls formatter
  --- @type function|nil
  formatting_config = nil,

  --- Disables null-ls diagnostic sources
  --- @type boolean
  disable_diagnostics = false,
  --- Mason.nvim package to auto install the diagnostics provider from
  --- @type string
  diagnostics_package = "markdownlint",
  --- String to access the null_ls diagnositcs provider
  --- @type string
  diagnostics_provider = "builtins.diagnostics.markdownlint",
  --- Function to configure null-ls diagnostics
  --- @type function|nil
  diagnostics_config = nil,
}

local langs_utils = require("doom.modules.langs.utils")
markdown.autocmds = {
  {
    "FileType",
    "markdown",
    langs_utils.wrap_language_setup("markdown", function()
      if not markdown.settings.disable_lsp then
        langs_utils.use_lsp_mason(markdown.settings.lsp_name, {
          config = markdown.settings.lsp_config,
        })
      end

      if not markdown.settings.disable_treesitter then
        langs_utils.use_tree_sitter(markdown.settings.treesitter_grammars)
      end

      if not markdown.settings.disable_formatting then
        langs_utils.use_null_ls(
          markdown.settings.formatting_package,
          markdown.settings.formatting_provider,
          markdown.settings.formatting_config
        )
      end

      if not markdown.settings.disable_diagnostics then
        langs_utils.use_null_ls(
          markdown.settings.diagnostics_package,
          markdown.settings.diagnostics_provider,
          markdown.settings.diagnostics_config
        )
      end
    end),
    once = true,
  },
}

return markdown
