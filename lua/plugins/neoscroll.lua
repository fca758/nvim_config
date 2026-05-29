return {
  "karb94/neoscroll.nvim",
  event = "UIEnter",
  opts = {
    mappings = {},
  },
  config = function()
    require("neoscroll").setup()
    local ns = require("neoscroll")
    default_scroll_opts.duration = 200
    local lines = math.floor(vim.o.lines * 0.25)
    vim.keymap.set({ "n", "v", "x" }, "<ScrollWheelDown>",
      function() ns.scroll(lines, { move_cursor = true, duration = 200 }) end)
    vim.keymap.set({ "n", "v", "x" }, "<ScrollWheelUp>",
      function() ns.scroll(-lines, { move_cursor = true, duration = 200 }) end)
  end,
}
