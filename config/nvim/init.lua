vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
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
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  -- add this to the file where you setup your other plugins:
  {
    "monkoose/neocodeium",
    config = function()
      local neocodeium = require "neocodeium"
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
    end,
  },
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    "numToStr/Comment.nvim",
  },

  {
    "Canop/nvim-bacon",
    config = function()
      require("bacon").setup {
        quickfix = {
          enabled = true, -- Enable Quickfix integration
          event_trigger = true, -- Trigger QuickFixCmdPost after populating Quickfix list
        },
      }
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

require("Comment").setup()

-- Bind <leader>cc to comment the selected lines or current line
vim.keymap.set("n", "<leader>cc", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment (current line)" })
vim.keymap.set(
  "x",
  "<leader>cc",
  "<Plug>(comment_toggle_linewise_visual)",
  { desc = "Toggle comment (visual selection)" }
)

-- NeoCodeium Configuration
require("neocodeium").setup {
  -- If `false`, then would not start codeium server (disabled state)
  -- You can manually enable it at runtime with `:NeoCodeium enable`
  enabled = true,
  -- Path to a custom Codeium server binary (you can download one from:
  -- https://github.com/Exafunction/codeium/releases)
  bin = nil,
  -- When set to `true`, autosuggestions are disabled.
  -- Use `require'neodecodeium'.cycle_or_complete()` to show suggestions manually
  manual = false,
  -- Information about the API server to use
  server = {
    -- API URL to use (for Enterprise mode)
    api_url = nil,
    -- Portal URL to use (for registering a user and downloading the binary)
    portal_url = nil,
  },
  -- Set to `false` to disable showing the number of suggestions label in the line number column
  show_label = true,
  -- Set to `true` to enable suggestions debounce
  debounce = false,
  -- Maximum number of lines parsed from loaded buffers (current buffer always fully parsed)
  -- Set to `0` to disable parsing non-current buffers (may lower suggestion quality)
  -- Set it to `-1` to parse all lines
  max_lines = 10000,
  -- Set to `true` to disable some non-important messages, like "NeoCodeium: server started..."
  silent = false,
  -- Set to `false` to disable suggestions in buffers with specific filetypes
  -- You can still enable disabled by this option buffer with `:NeoCodeium enable_buffer`
  filetypes = {
    help = false,
    gitcommit = false,
    gitrebase = false,
    ["."] = false,
  },
  -- List of directories and files to detect workspace root directory for Codeium chat
  root_dir = { ".bzr", ".git", ".hg", ".svn", "_FOSSIL_", "package.json", "Cargo.toml" },
}

-- Go to next diagnostic with <leader>j
vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next)

-- Go to previous diagnostic with <leader>k
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev)

-- Keybind to delete the current tab without quitting Neovim
vim.keymap.set("n", "<leader>dq", ":bd<CR>", { noremap = true, silent = true })

vim.schedule(function()
  require "mappings"
end)
