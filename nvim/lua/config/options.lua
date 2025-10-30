-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = false  -- Disable relative line numbers
opt.wrap = true             -- Enable line wrap
opt.colorcolumn = "80"      -- Show column at 80 characters
opt.scrolloff = 8           -- Keep 8 lines visible above/below cursor
