local ok, catppuccin = pcall(require, "catppuccin")

if ok then
    catppuccin.setup({
        flavour = "frappe",
        transparent_background = true,
        integrations = {
            treesitter = true,
            native_lsp = { enabled = true },
            telescope = { enabled = true },
            lualine = true,
            blink_cmp = true,
            mason = true,
            mini = { enabled = true },
            dap = true,
            dap_ui = true,
            harpoon = true,
        },
    })
    vim.cmd.colorscheme("catppuccin-frappe")
else
    vim.cmd.colorscheme("habamax")
end
