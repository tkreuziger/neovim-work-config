-- Distraction-free writing for the prose profile.
--
-- goyo.vim centers the buffer and hides the UI; limelight.vim dims
-- everything except the current paragraph. They are wired together so
-- that entering Goyo turns Limelight on and leaving turns it off.
return {
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
    keys = {
      { "<leader>z", "<cmd>Goyo<cr>", desc = "Distraction-free (Goyo)" },
    },
    init = function()
      vim.g.goyo_width = 100
      vim.g.goyo_height = "85%"
      vim.g.goyo_linenr = 0
    end,
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoEnter",
        callback = function()
          pcall(vim.cmd, "Limelight")
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoLeave",
        callback = function()
          pcall(vim.cmd, "Limelight!")
        end,
      })
    end,
  },
  {
    "junegunn/limelight.vim",
    cmd = { "Limelight" },
    keys = {
      { "<leader>ul", "<cmd>Limelight!!<cr>", desc = "Toggle Limelight" },
    },
    init = function()
      -- Dim with a Catppuccin-mocha-ish overlay colour.
      vim.g.limelight_conceal_ctermfg = "gray"
      vim.g.limelight_conceal_guifg = "#585b70"
    end,
  },
}
