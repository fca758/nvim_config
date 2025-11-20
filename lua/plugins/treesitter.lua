return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",  -- actualiza los parsers automáticamente
  config = function()
    local ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
    if not ok then return end

    ts_configs.setup {
      -- Lenguajes a instalar
      ensure_installed = { "python", "java", "c", "lua", "cpp" },

      -- Resaltado de sintaxis
      highlight = {
        enable = true,         -- activar Treesitter
        disable = {},          -- ninguno deshabilitado
      },

      -- Opciones adicionales (opcional)
      indent = {
        enable = true,         -- indentación basada en Treesitter
      },
    }
  end,
}
