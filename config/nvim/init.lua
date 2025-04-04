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
  { "cordx56/rustowl", dependencies = { "neovim/nvim-lspconfig" } },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "dariuscorvus/tree-sitter-surrealdb.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false, -- This makes sure it loads immediately
    ft = { "surql", "surrealql" },
    config = function()
      require("tree-sitter-surrealdb").setup()
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
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

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

require("nvim-treesitter.parsers").get_parser_configs().just = {
  install_info = {
    url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
    -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
  },
  maintainers = { "@IndianBoy42" },
}

require("Comment").setup()
require("typescript-tools").setup {}

-- Bind <leader>cc to comment the selected lines or current line
vim.keymap.set("n", "<leader>cc", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment (current line)" })
vim.keymap.set(
  "x",
  "<leader>cc",
  "<Plug>(comment_toggle_linewise_visual)",
  { desc = "Toggle comment (visual selection)" }
)

local ft = require "Comment.ft"

ft({ "surrealql", "surql" }, "#%s")
-- Go to next diagnostic with <leader>j
vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next)

-- Go to previous diagnostic with <leader>k
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev)

-- Keybind to delete the current tab without quitting Neovim
vim.keymap.set("n", "<leader>dq", ":bd<CR>", { noremap = true, silent = true })

vim.schedule(function()
  require "mappings"
end)

vim.filetype.add {
  extension = {
    surql = "surql",
  },
}
