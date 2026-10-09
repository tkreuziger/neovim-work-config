----------------------------------------------------------------------
-- A minimal tabline for the prose profile.
--
-- One entry per tab, showing the current buffer's file name (and a `+`
-- when it is modified). Deliberately plain: no icons, no plugins, no
-- directory path. It appears only when there is more than one tab and is
-- hidden again in distraction-free mode (see common/text.lua).
--
-- Navigation reuses the shared tab keys:
--   <leader>yn  new tab      <leader>yl  next tab
--   <leader>yh  previous tab <leader>yd  close tab
----------------------------------------------------------------------

local M = {}

function M.render()
  local count = vim.fn.tabpagenr("$")
  if count == 1 then
    return ""
  end

  local current = vim.fn.tabpagenr()
  local parts = {}
  for i = 1, count do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
    if name == "" then
      name = "[No Name]"
    end
    local modified = vim.fn.getbufvar(bufnr, "&modified") == 1 and " +" or ""
    local highlight = (i == current) and "%#TabLineSel#" or "%#TabLine#"
    parts[#parts + 1] = ("%%%dT%s %d %s%s "):format(i, highlight, i, name, modified)
  end
  parts[#parts + 1] = "%T%#TabLineFill#"
  return table.concat(parts)
end

return M
