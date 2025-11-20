local sysname = vim.loop.os_uname().sysname

if sysname == "Windows_NT" then
    vim.cmd("colorscheme gruvbox")
else
    vim.cmd("colorscheme onedark")
end

