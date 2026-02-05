local map = vim.keymap.set



-- Buffers (ventanas)
map('n', '<C-I>', '<C-w><C-w>', { silent = true })


-- Ponemos las direcciones de nvim una más a la izquierda (h j k l) -> (j k l ñ)
map({"n","v","o"},"h","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"j","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"k","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"l","<nop>",{noremap=true,silent=true})
map({"n","v","o"},"j","h",{noremap=true,silent=true})
map({"n","v","o"},"k","j",{noremap=true,silent=true})
map({"n","v","o"},"l","k",{noremap=true,silent=true})
map({"n","v","o"},"ñ","l",{noremap=true,silent=true})

-- Ctrl + q abre el directorio actual
map("n","<C-q>", function() vim.cmd("vs .") end)

-- Copiar un archivo entero al portapapeles (WIP)
-- map("n", "<leader-c>", "ggVG\"+y")
--

-- Al escribir "nn" en modo insert de devuelve a normal 
map("i", "ff", "<esc>")

