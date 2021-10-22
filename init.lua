local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
    "savq/paq-nvim";                                                    -- Let Paq manage itself
    {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"};               -- Better syntax highlighting
    "neovim/nvim-lspconfig";                                            -- Mind the semi-colons
    "williamboman/nvim-lsp-installer";                                  -- Install LSPs
    "hrsh7th/nvim-cmp";                                                 -- 5 plugins for auto complete
    "hrsh7th/cmp-nvim-lsp";
    --"hrsh7th/cmp-buffer";
    --"L3MON4D3/LuaSnip";
    --"saadparwaiz1/cmp_luasnip";
    "ray-x/lsp_signature.nvim";                                         -- Show function signature as you type
    "ray-x/material_plus.nvim";                                         -- A colorscheme with treesitter support
    "nvim-lua/plenary.nvim";                                            -- required by telescope
    "nvim-telescope/telescope.nvim";                                    -- Fuzzy file finder, and grep: Manual install rpigrep
    "tpope/vim-fugitive";                                               -- Git
    "vim-airline/vim-airline";                                          -- Buffer line and status line
    "vim-airline/vim-airline-themes";                                   -- Buffer line and status line
    "rlue/vim-barbaric";                                                -- Auto switch input method
    "folke/which-key.nvim";                                             -- Suggest key binding
    {"iamcco/markdown-preview.nvim", run=":call mkdp#util#install()"};  -- Markdown preview
    "sychen52/gF-python-traceback";
    "sychen52/smart-term-esc.nvim";
}

vim.api.nvim_command [[
autocmd ColorScheme * highlight Pmenu ctermbg=black guibg=black
autocmd BufEnter *.tpp :setlocal filetype=cpp " Treat tpp as c++ files
]]


_G.show_position = function()
    local ret = require("nvim-treesitter").statusline({
        indicator_size = 200,
        type_patterns = {'file', 'class', 'function', 'method'},
        transform_fn = function(line) return line:gsub('%(.*%)', '') end,
    })
    return ret
end
--[[vim-airline]]
vim.g["airline_section_c"] = '%{v:lua.show_position()}'
vim.g["airline#extensions#syntastic#enabled"] = 1
vim.g["airline#extensions#branch#enabled"] = 1
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tagbar#enabled"] = 1
vim.g["airline_skip_empty_sections"] = 1
vim.g["airline#extensions#tabline#ignore_bufadd_pat"] = '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'
vim.g["airline_theme"] = 'molokai'

--[[netrw]]
vim.g["netrw_liststyle"] = 3
vim.g["netrw_browse_split"] = 4
vim.g["netrw_altv"] = 1
vim.g["netrw_winsize"] = 20
vim.g["netrw_list_hide"] = '.*.swp$,.*.pyc'

vim.g["mapleader"] = " "
vim.opt.background = "dark"
vim.opt.mouse = "a"                                         -- Enable mouse in all mode
vim.opt.path:append("**")
vim.opt.clipboard:append("unnamed")                         -- unnamed is mouse mid button; unnamedplus is ctrl-c. You need xclip for this to work
vim.opt.complete:append("kspell")                           -- complete based on spell is ":set spell"
vim.opt.inccommand = 'split'                                -- live view of replace. 'split' has a locallist; 'nosplit' does not.
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99                                      -- unfolded by default; use za to alter

vim.opt.expandtab = true                                    -- Use spaces instead of tabs
vim.opt.ignorecase = true                                   -- Ignore case
vim.opt.joinspaces = false                                  -- No double spaces with join
vim.opt.list = true                                         -- Show some invisible characters
vim.opt.number = true                                       -- Show line numbers
vim.opt.relativenumber = true                               -- Relative line numbers
vim.opt.shiftround = true                                   -- Round indent
vim.opt.shiftwidth = 4                                      -- Size of an indent
vim.opt.sidescrolloff = 8                                   -- Columns of context
vim.opt.smartcase = true                                    -- Do not ignore case with capitals
vim.opt.smartindent = true                                  -- Insert indents automatically
vim.opt.splitbelow = true                                   -- Put new windows below current
vim.opt.splitright = true                                   -- Put new windows right of current
vim.opt.tabstop = 4                                         -- Number of spaces tabs count for
vim.opt.termguicolors = true                                -- True color support
vim.opt.hidden = true                                       -- Enable background buffers
vim.opt.wildmode = {'longest:full', 'full'}                 -- Command-line completion mode; longest:full for the first tab, full for the second tab
--vim.opt.scrolloff = 4                                       -- Lines of context
--vim.opt.wrap = false                                        -- Disable line wrap

vim.api.nvim_set_keymap('n', '<Tab>',  ':bn<CR>', {noremap=true})           --Buffer nav
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', {noremap=true})          --Buffer nav
--vim.api.nvim_set_keymap('n', '<C-j>',  '<C-w><C-j>', {noremap=true})        --Switch between windows
--vim.api.nvim_set_keymap('n', '<C-k>',  '<C-w><C-k>', {noremap=true})        --Switch between windows
--vim.api.nvim_set_keymap('n', '<C-h>',  '<C-w><C-h>', {noremap=true})        --Switch between windows
--vim.api.nvim_set_keymap('n', '<C-l>',  '<C-w><C-l>', {noremap=true})        --Switch between windows

require("treesitter")
require("lsp")
require("telescope")
require("which-key").setup()
require('material')
require('material.functions').change_style("monokai")
require('smart-term-esc').setup()

