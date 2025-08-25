require "config.options"
require "config.keymaps"

-- vim.lsp.enable("rust_analyzer")

require("lazy").setup({
  spec = {
    { import = "plugins" }
  }
})
