----------------------------------------------------------------------
-- Shared text-editing helpers, used by the commit and prose profiles.
----------------------------------------------------------------------

local M = {}

-- Toggle spellchecking in the current window.
function M.toggle_spell()
  vim.wo.spell = not vim.wo.spell
  vim.notify("spell: " .. (vim.wo.spell and "on" or "off"))
end

-- Toggle line wrapping in the current window.
function M.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("wrap: " .. (vim.wo.wrap and "on" or "off"))
end

-- Human-readable word count for the current buffer or visual selection.
function M.word_count()
  local wc = vim.fn.wordcount()
  if wc.visual then
    return string.format("%d words (%d chars)", wc.words, wc.chars)
  end
  return string.format("%d words", wc.words)
end

-- Print the word count.
function M.report_word_count()
  vim.notify(M.word_count(), vim.log.levels.INFO)
end

-- A statusline component showing the word count.
function M.statusline()
  local wc = vim.fn.wordcount()
  return string.format(" %d words ", wc.words or 0)
end

-- Distraction-free mode: hide everything that is not the text.
local distraction = { active = false, saved = {} }

function M.distraction_free()
  local saved = distraction.saved

  if not distraction.active then
    saved.number = vim.wo.number
    saved.relativenumber = vim.wo.relativenumber
    saved.signcolumn = vim.wo.signcolumn
    saved.cursorline = vim.wo.cursorline
    saved.laststatus = vim.o.laststatus
    saved.showtabline = vim.o.showtabline
    saved.cmdheight = vim.o.cmdheight
    saved.wrap = vim.wo.wrap
    saved.linebreak = vim.wo.linebreak
    saved.list = vim.wo.list

    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
    vim.wo.cursorline = false
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.o.laststatus = 0
    vim.o.showtabline = 0
    vim.o.cmdheight = 1
    distraction.active = true
    vim.notify("distraction-free: on")
  else
    vim.wo.number = saved.number
    vim.wo.relativenumber = saved.relativenumber
    vim.wo.signcolumn = saved.signcolumn
    vim.wo.cursorline = saved.cursorline
    vim.wo.wrap = saved.wrap
    vim.wo.linebreak = saved.linebreak
    vim.wo.list = saved.list
    vim.o.laststatus = saved.laststatus
    vim.o.showtabline = saved.showtabline
    vim.o.cmdheight = saved.cmdheight
    distraction.active = false
    vim.notify("distraction-free: off")
  end
end

return M
