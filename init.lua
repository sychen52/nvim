vim.g["mapleader"] = " "
local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
    "savq/paq-nvim";                                      -- Let Paq manage itself
    "neovim/nvim-lspconfig";                              -- Mind the semi-colons
    {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"}; -- better syntax highlighting
    "nvim-lua/completion-nvim";                           -- Auto completion for lsp
    "nvim-lua/plenary.nvim";
    "nvim-telescope/telescope.nvim";                      -- fuzzy file finder, and grep: Manual install rpigrep
    "tpope/vim-fugitive";                                 -- Git
    "vim-airline/vim-airline";                            -- buffer line and status line
    "rlue/vim-barbaric";                                  -- Auto switch input method
    "folke/which-key.nvim";                               -- suggest key binding
    "folke/tokyonight.nvim";                              -- A color scheme support treesitter
}
require("treesitter")
require("lsp")
require("telescope")
require("which-key").setup{}

--[[tokyonight]]
vim.cmd[[colorscheme tokyonight]]
vim.g["tokyonight_style"] = "night"

--[[vim-airline]]
vim.g["airline#extensions#syntastic#enabled"] = 1
vim.g["airline#extensions#branch#enabled"] = 1
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tagbar#enabled"] = 1
vim.g["airline_skip_empty_sections"] = 1
vim.g["airline#extensions#tabline#ignore_bufadd_pat"] = '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'


--[[netrw]]
vim.g["netrw_liststyle"] = 3
vim.g["netrw_browse_split"] = 4
vim.g["netrw_altv"] = 1
vim.g["netrw_winsize"] = 20
vim.g["netrw_list_hide"] = '.*.swp$,.*.pyc'

vim.opt.background = "dark"
vim.opt.mouse = "nv"
vim.opt.path:append("**")
vim.opt.clipboard = "unnamed"           -- System clipboard to "+

vim.opt.expandtab = true                -- Use spaces instead of tabs
vim.opt.ignorecase = true               -- Ignore case
vim.opt.joinspaces = false              -- No double spaces with join
vim.opt.list = true                     -- Show some invisible characters
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Relative line numbers
vim.opt.scrolloff = 4                   -- Lines of context
vim.opt.shiftround = true               -- Round indent
vim.opt.shiftwidth = 4                  -- Size of an indent
vim.opt.sidescrolloff = 8               -- Columns of context
vim.opt.smartcase = true                -- Do not ignore case with capitals
vim.opt.smartindent = true              -- Insert indents automatically
vim.opt.splitbelow = true               -- Put new windows below current
vim.opt.splitright = true               -- Put new windows right of current
vim.opt.tabstop = 4                     -- Number of spaces tabs count for
vim.opt.termguicolors = true            -- True color support
vim.opt.hidden = true                   -- Enable background buffers
--vim.opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
--vim.opt.wrap = false                    -- Disable line wrap


vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap=true})      --escape terminal
vim.api.nvim_set_keymap('n', '<Tab>',  ':bn<CR>', {noremap=true})         --Buffer nav
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', {noremap=true})        --Buffer nav

