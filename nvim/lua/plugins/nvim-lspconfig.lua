return {
  {
    "ray-x/lsp_signature.nvim",
    enable = false
  },
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "config.lsp"
    end
  }
}
