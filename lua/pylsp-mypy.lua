local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local servers = require "nvim-lsp-installer.servers"
local server = require "nvim-lsp-installer.server"
local pip3 = require "nvim-lsp-installer.installers.pip3"


local server_name = "pylsp-mypy"

local root_dir = server.get_server_root_path(server_name)

configs[server_name] = {
    default_config = {
        filetypes = { "python" },
        root_dir = function(fname)
            local root_files = {
                'pyproject.toml',
                'setup.py',
                'setup.cfg',
                'requirements.txt',
                'Pipfile',
            }
            return lspconfig.util.root_pattern(unpack(root_files))(fname) or lspconfig.util.find_git_ancestor(fname)
        end,
        single_file_support = true
    },
}
-- 2. (mandatory) Create an nvim-lsp-installer Server instance
local my_server = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    languages = { "python" },
    installer = pip3.packages { "pylsp-mypy", "python-lsp-server" },
    default_options = {
        cmd = { pip3.executable(root_dir, "pylsp") },
    },
}
servers.register(my_server)

