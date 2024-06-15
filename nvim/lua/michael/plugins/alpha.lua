return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.buttons.val = {
      dashboard.button("SPC e", "Toggle file explorer", "<cmd>Explore<cr>"),
      dashboard.button("SPC ff", "Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button("SPC fs", "Find text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("q", "Quit NVIM", "<cmd>qa<cr>"),
    },

    alpha.setup(dashboard.opts)
  end
}
