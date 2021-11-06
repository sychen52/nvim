local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        -- Better syntax highlighting
        'nvim-treesitter/nvim-treesitter',
        run=':TSUpdate',
        config=function() require("treesitter") end
    }
    use {
        'neovim/nvim-lspconfig',
        config=function() require("lsp") end
    }
    -- Install LSPs
    use 'williamboman/nvim-lsp-installer'
    -- 5 plugins for auto complete
    use 'hrsh7th/nvim-cmp'
    -- Lsp source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'
    --use 'hrsh7th/cmp-buffer'
    --use 'L3MON4D3/LuaSnip'
    --use 'saadparwaiz1/cmp_luasnip'
    use {
        -- A colorscheme with treesitter support
        'ray-x/material_plus.nvim',
        config=function()
            require("material")
            require("material.functions").change_style("monokai")
        end
    }
    use {
        -- Fuzzy file finder and grep: Manual install rpigrep
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config=function() require("telescope") end
    }
    use {
        -- magit
        'TimUntersberger/neogit',
        cmd = 'Neogit',  -- without this neovim will crash on open
        requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
        config = function()
            require("neogit").setup{
                disable_commit_confirmation = true,
                integrations={diffview=true}
            } end
        }
        -- Git
        --use 'tpope/vim-fugitive'
        -- :Make async
        use 'tpope/vim-dispatch'
        -- Additional compilers such as python
        --use 'Konfekt/vim-compilers'
        use {
            'akinsho/bufferline.nvim',
            requires = {'kyazdani42/nvim-web-devicons'},
            config=function() require("bufferline").setup() end
        }
        use {
            'nvim-lualine/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons'},
            config=function() require("evil_lualine") end
        }
        -- Buffer line and status line
        --use 'vim-airline/vim-airline'
        --use 'vim-airline/vim-airline-themes'
        -- Auto switch input method
        use 'rlue/vim-barbaric'
        use {
            -- Suggest key binding
            'folke/which-key.nvim',
            config=function() require("which-key").setup() end
        }
        use {
            'iamcco/markdown-preview.nvim',
            run=':call mkdp#util#install()',
            config=function() vim.g["mkdp_preview_options"]={content_editable=true} end
        }
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function() require'nvim-tree'.setup {} end
        }
        use 'sychen52/gF-python-traceback'
        use {
            'sychen52/smart-term-esc.nvim',
            config=function() require("smart-term-esc").setup() end
        }
        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end)
