local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

function M.modified_buffers(opts)
  opts = opts or {}

  -- build entries: list of tables { bufnr = <num>, name = <str> }
  local entries = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
      local listed = vim.fn.buflisted(bufnr) == 1
      if modified and listed then
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name == "" then name = "[No Name]" end
        table.insert(entries, {
          bufnr = bufnr,
          name = name,
          display = string.format("%3d %s", bufnr, name),
          ordinal = tostring(bufnr) .. " " .. name,
        })
      end
    end
  end

  if vim.tbl_isempty(entries) then
    vim.notify("No modified buffers", vim.log.levels.INFO)
    return
  end

  pickers.new(opts, {
    prompt_title = "Modified Buffers",
    finder = finders.new_table {
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          ordinal = entry.ordinal,
          display = entry.display,
          bufnr = entry.bufnr,
        }
      end,
    },
    previewer = conf.buffer_previewer_maker,
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection and selection.bufnr and vim.api.nvim_buf_is_valid(selection.bufnr) then
          vim.api.nvim_set_current_buf(selection.bufnr)
        else
          vim.notify("Buffer not valid", vim.log.levels.WARN)
        end
      end)
      return true
    end,
  }):find()
end

return M
