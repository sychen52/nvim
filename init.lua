vim.api.nvim_command [[
autocmd ColorScheme * highlight Pmenu ctermbg=black guibg=black
autocmd BufEnter *.tpp :setlocal filetype=cpp " Treat tpp as c++ files
]]

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
vim.opt.clipboard:append("unnamedplus")                         -- unnamed is mouse mid button; unnamedplus is ctrl-c. You need xclip for this to work
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
_G.show_position = function()
    local ret = require("nvim-treesitter").statusline({
        indicator_size = 200,
        type_patterns = {'file', 'class', 'function', 'method'},
        transform_fn = function(line) return line:gsub('%(.*%)', '') end,
    })
    print(ret)
end
vim.api.nvim_set_keymap('n', '<leader>p',  '<cmd>lua show_position()<CR>', {noremap=true})

require('plugins')
