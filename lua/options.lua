local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.cindent = true

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
vim.cmd("set nowrap")

vim.lsp.enable("clangd")
