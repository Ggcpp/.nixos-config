return { 
    {
        "ellisonleao/gruvbox.nvim",
	enabled = false,
	lazy = false,
	priority = 1000,
	config = function()
	    vim.o.background = "dark"
	    vim.cmd([[colorscheme gruvbox]])
	end
    }
}
