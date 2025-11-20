return {
  "neoclide/coc.nvim",
  branch = "release",
  config = function()
    vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
    vim.opt.shortmess:append "c"
    vim.opt.updatetime = 300

    vim.api.nvim_set_keymap("i", "<CR>",
      'coc#pum#visible() ? coc#pum#confirm() : "<CR>"',
      { expr = true, silent = true }
    )
  end,
}

