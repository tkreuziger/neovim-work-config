----------------------------------------------------------------------
-- Shared lazy.nvim bootstrap.
--
-- Plugins are installed once into a shared directory so that every
-- profile reuses the same download, and a single lockfile keeps the
-- versions consistent. Profiles only provide their own spec.
----------------------------------------------------------------------

local M = {}

-- Shared data root. We deliberately reuse the historical `nvim` data
-- directory so existing plugins/Mason/treesitter installs keep working.
local SHARED_CONFIG = vim.fn.expand("~/.config/nvim-shared")
local SHARED_DATA = vim.fn.expand("~/.local/share/nvim")
local SHARED_LOCK = SHARED_CONFIG .. "/lazy-lock.json"

local function ensure_lazy(root)
  local lazypath = root .. "/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      lazyrepo,
      lazypath,
    })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

-- The default spec always loads the shared plugin layer (`lua/common/plugins`,
-- e.g. Catppuccin) and, when the profile ships its own `lua/plugins`, those
-- specs as well. lazy.nvim's `import` only walks one root per module name, so
-- the two layers use distinct namespaces.
local function default_spec()
  local spec = { { import = "common.plugins" } }
  if (vim.uv or vim.loop).fs_stat(vim.fn.stdpath("config") .. "/lua/plugins") then
    table.insert(spec, { import = "plugins" })
  end
  return spec
end

---@param opts? { root?: string, lockfile?: string, spec?: table, config?: table }
function M.setup(opts)
  opts = opts or {}

  local root = opts.root or (SHARED_DATA .. "/lazy")
  local lockfile = opts.lockfile or SHARED_LOCK

  ensure_lazy(root)

  local config = vim.tbl_deep_extend("force", {
    spec = opts.spec or default_spec(),
    root = root,
    lockfile = lockfile,
    checker = { enabled = true },
    install = { colorscheme = { "catppuccin", "default" } },
    rocks = { hererocks = false, enabled = false },
    -- lazy.nvim resets `runtimepath` to a known-good set during setup, which
    -- would drop the shared core directory. Re-add it explicitly so imports
    -- (`require("common.*")`) keep working.
    performance = {
      rtp = {
        paths = { SHARED_CONFIG },
      },
    },
  }, opts.config or {})

  require("lazy").setup(config)
end

return M
