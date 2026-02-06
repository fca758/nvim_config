return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()

local function harpoon_component()
    local harpoon = require("harpoon")
    local list = harpoon:list()
    local status = {}
    local current_file_path = vim.api.nvim_buf_get_name(0)
 
    table.insert(status, "󰀱")
    local max_index = list:length()
    if max_index == 0 then return "" end

    for i = 1, max_index do
        local item = list:get(i)
        
        if item and item.value ~= "" then
            -- Verificamos si es el archivo actual
            -- Usamos realpath para que la comparación sea exacta
            local full_item_path = vim.loop.fs_realpath(item.value) or item.value
            
            if current_file_path == full_item_path then
                -- Resaltamos el número del archivo actual con corchetes e icono
                table.insert(status, string.format("[%d]", i))
            else
                -- Número normal para los demás archivos
                table.insert(status, tostring(i))
            end
        else
            -- Si el índice está vacío (el hueco que mencionabas)
            table.insert(status, "X")
        end
    end

    -- Unimos todo con un espacio para que quede limpio
    return table.concat(status, " ")
end
      require("lualine").setup({
          sections = {
              lualine_c = {
                  {"filename"},
                  { harpoon_component },
              },
          },
          options = {
              theme = "onedark",
          },
      })
  end
  }

