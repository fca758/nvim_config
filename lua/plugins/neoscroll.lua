return {
  "karb94/neoscroll.nvim",
  event = "UIEnter",
  opts = {
    easing = "quadratic",
    hide_cursor = true,
    cursor_scrolls_alone = true,
    respect_scrolloff = false,
    mappings = {},
  },
  config = function()
    require("neoscroll").setup()
    local neoscroll = require("neoscroll")
    default_scroll_opts.duration = 200
    local t = vim.o.lines
    vim.keymap.set({ "n", "v", "x" }, "<ScrollWheelDown>",
      function() neoscroll.scroll(math.floor(t * 0.25), true, 200) end)
    vim.keymap.set({ "n", "v", "x" }, "<ScrollWheelUp>",
      function() neoscroll.scroll(-math.floor(t * 0.25), true, 200) end)
    vim.keymap.set({ "n", "v", "x" }, "<Down>",
      function() neoscroll.scroll(1, true, 80) end)
    vim.keymap.set({ "n", "v", "x" }, "<Up>",
      function() neoscroll.scroll(-1, true, 80) end)
  end,
}
