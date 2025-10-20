return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      "C:\\Users\\xcx8914\\code\\*",
      "C:\\Users\\xcx8914\\AppData\\Local\\nvim",
    },
    picker = {
      type = "telescope",
    }
  },
  init = function()
    vim.opt.sessionoptions:append("globals")
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
