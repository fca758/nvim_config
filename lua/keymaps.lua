local map = vim.keymap.set

-- Buffers (ventanas)
map("n", "<C-I>", "<C-w><C-w>", { silent = true })

-- Copiar un archivo entero al portapapeles (WIP)
map("n", "<leader>c", "ggVG\"+y")

-- Al escribir "ff" en modo insert se vuelve a normal
map("i", "ff", "<esc>")

map("n", "<C-s>", function() vim.cmd(":noh") end)

map("n", "<leader>ll", function()
    vim.cmd("write")
    local tmux_pane = "{top}"
    local cmd = "for _ in {1..2}; do pdflatex main.tex; done\n"
    local safe_cmd = cmd:gsub('"', '\\"')
    vim.fn.system(string.format('tmux send-keys -t "%s" "%s"', tmux_pane, safe_cmd))
    vim.notify("Compilando LaTeX en Tmux...", vim.log.levels.INFO)
end, { desc = "Enviar pdflatex al panel Tmux superior" })
