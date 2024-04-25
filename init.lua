vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/configs/snippets"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LazySync",
  callback = function()
    local uv = vim.loop

    local config = vim.fn.stdpath "config"
    local NUM_BACKUPS = 5
    local LOCKFILES_DIR = string.format("%s/lockfiles/", config)

    -- create if not existing
    if not uv.fs_stat(LOCKFILES_DIR) then
      uv.fs_mkdir(LOCKFILES_DIR, 448)
    end

    local lockfile = require("lazy.core.config").options.lockfile
    if uv.fs_stat(lockfile) then
      -- create "%Y%m%d_%H:%M:%s_lazy-lock.json" in lockfile folder
      local filename = string.format("%s_lazy-lock.json", os.date "%Y%m%d_%H:%M:%S")
      local backup_lock = string.format("%s/%s", LOCKFILES_DIR, filename)
      local success = uv.fs_copyfile(lockfile, backup_lock)
      if success then
        -- clean up backups in excess of `num_backups`
        local iter_dir = uv.fs_scandir(LOCKFILES_DIR)
        if iter_dir then
          local suffix = "lazy-lock.json"
          local backups = {}
          while true do
            local name = uv.fs_scandir_next(iter_dir)
            -- make sure we are deleting lockfiles
            if name and name:sub(-#suffix, -1) == suffix then
              table.insert(backups, string.format("%s/%s", LOCKFILES_DIR, name))
            end
            if name == nil then
              break
            end
          end
          if not vim.tbl_isempty(backups) and #backups > NUM_BACKUPS then
            -- remove the lockfiles
            for _ = 1, #backups - NUM_BACKUPS do
              uv.fs_unlink(table.remove(backups, 1))
            end
          end
        end
      end
      vim.notify(string.format("Backed up %s", filename), vim.log.levels.INFO, { title = "lazy.nvim" })
    end
  end,
})
