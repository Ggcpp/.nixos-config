return {
    {
	"L3MON4D3/LuaSnip"
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
	    local cmp = require("cmp")
	    local luasnip = require("luasnip")

	    local icons = {
	      Text = "",
	      Method = "",
	      Function = "",
	      Constructor = "",
	      Field = "",
	      Variable = "",
	      Class = "ﴯ",
	      Interface = "",
	      Module = "",
	      Property = "ﰠ",
	      Unit = "",
	      Value = "",
	      Enum = "",
	      Keyword = "",
	      Snippet = "",
	      Color = "",
	      File = "",
	      Reference = "",
	      Folder = "",
	      EnumMember = "",
	      Constant = "",
	      Struct = "",
	      Event = "",
	      Operator = "",
	      TypeParameter = ""
	    }

	    cmp.setup({
                -- bind snippet engine
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },

                mapping = {
                    ["<C-p>"] = cmp.mapping({
                        i = cmp.mapping.abort(),    -- for insert mode
                        c = cmp.mapping.close()     -- for command mode
                    }),

                    ["<C-y>"] = cmp.mapping(function(fallback) -- fallback execute the default behavior
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }), -- Insert and Select mode

                    ["<C-e>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }), -- Insert and Select mode

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm( { select = true }) -- select = true: select the first item even if nothing is selected
                        else
                            fallback()
                        end
                    end, { "i", "n" }) -- Insert and Select mode
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lua" }
                }),

                formatting = { -- [print Function [Lua]] -> [abbr kind menu]
                    fields = { "kind", "abbr", "menu" },  -- VS-Code like
                    format = function(entry, vim_item)
                        vim_item.kind = icons[vim_item.kind]  -- To replace default `kinds` by icons
                        vim_item.abbr = string.sub(vim_item.abbr, 1, 30)  -- Max abbr size to 60
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Snippet]",
                            nvim_lua = "[Lua]"
                        })[entry.source.name]

                        return vim_item
                    end
                },

                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false
                }
	    })
    	end
    }
}
