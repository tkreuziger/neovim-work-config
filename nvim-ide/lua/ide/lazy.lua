----------------------------------------------------------------------
-- IDE plugin setup.
--
-- Uses the shared lazy bootstrap (shared plugin dir + lockfile). The
-- default spec loads the shared plugin layer (`common.plugins`, e.g.
-- Catppuccin) plus every spec from this profile's `lua/plugins/`.
----------------------------------------------------------------------

require("common.lazy").setup({})

return true
