local map = vim.keymap.set

vim.g.mapleader = "º"
vim.g.maplocalleader = "º"

-- Buffers (ventanas)
map('n', '<C-I>', '<C-w><C-w>', { silent = true })


-- Copiar un archivo entero al portapapeles (WIP)
map("n", "<leader>c", "ggVG\"+y")

-- Al escribir "nn" en modo insert de devuelve a normal 
map("i", "ff", "<esc>")

map("n", "<C-s>", function() vim.cmd(":noh") end)


vim.keymap.set("n", "<leader>ll", function() 
    -- 1. Definimos el target ("{up-of}" como en tu código original)
    local tmux_pane = "{top}"
    
    -- 2. Definimos el comando
    local cmd = "for _ in {1..2}; do pdflatex main.tex; done\n"
    
    -- 3. Escapamos las comillas dobles para que el shell no las rompa
    -- (No estrictamente necesario en este cmd específico, pero buena práctica)
    local safe_cmd = cmd:gsub('"', '\\"')

    -- 4. Ejecutamos el comando directo a Tmux
    -- tmux send-keys -t <panel> "<comando>"
    vim.fn.system(string.format('tmux send-keys -t "%s" "%s"', tmux_pane, safe_cmd))
    
    vim.notify("Compilando LaTeX en Tmux...", vim.log.levels.INFO)
end, { desc = "Enviar pdflatex al panel Tmux superior" })
