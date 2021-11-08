require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages: {"bash", "c", "cmake", "cpp", "cuda", "html", "javascript", "json", "julia", "lua", "python", "regex", "vim"}
  ignore_install = {"php", "tlaplus"}, -- List of parsers to ignore installing: these will cause error on Ubuntu 16.04
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

