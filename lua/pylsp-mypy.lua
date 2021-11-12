local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local servers = require "nvim-lsp-installer.servers"
local server = require "nvim-lsp-installer.server"
local pip3 = require "nvim-lsp-installer.installers.pip3"

local server_name = "pylsp-mypy"

-- 1. (optional, only if lspconfig doesn't already support the server)
--    Create server entry in lspconfig
configs[server_name] = {
    default_config = {
        filetypes = { "python" },
        root_dir = lspconfig.util.root_pattern ".git",
    },
}

local root_dir = server.get_server_root_path(server_name)

-- 2. (mandatory) Create an nvim-lsp-installer Server instance
local my_server = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    installer = pip3.packages { "pylsp-mypy", "python-lsp-server[all]" },
    default_options = {
        cmd = { pip3.executable(root_dir, "pylsp") },
    },
}

-- 3. (optional, recommended) Register your server with nvim-lsp-installer.
--    This makes it available via other APIs (e.g., :LspInstall, lsp_installer.get_available_servers()).
servers.register(my_server)
