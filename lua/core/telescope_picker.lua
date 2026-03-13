local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local make_entry = require("telescope.make_entry")

local M = {}

M.modified_buffers = function(opts)
    opts = opts or {}
    opts.bufnr_width = opts.bufnr_width or 3
    opts.show_all_buffers = false
    opts.sort_lastused = true
    opts.sort_mru = true

    local results = {}
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })

    for _, buf in ipairs(buffers) do
        if buf.changed == 1 then
            table.insert(results, {
                bufnr = buf.bufnr,
                flag = buf.changed,
                info = buf,
            })
        end
    end

    if vim.tbl_isempty(results) then
        vim.notify("No modified buffers.", vim.log.levels.INFO)
        return
    end

    pickers.new(opts, {
        prompt_title = "Modified Buffers",

        finder = finders.new_table({
            results = results,
            entry_maker = make_entry.gen_from_buffer(opts),
        }),

        previewer = conf.grep_previewer(opts),
        sorter = conf.generic_sorter(opts),
    }):find()
end

return M

