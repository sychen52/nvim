local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local servers = require "nvim-lsp-installer.servers"
local server = require "nvim-lsp-installer.server"
local pip3 = require "nvim-lsp-installer.installers.pip3"
local shell = require "nvim-lsp-installer.installers.shell"

local server_name = "pylsp-mypy"

local root_dir = server.get_server_root_path(server_name)

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

server_name = "julials"
root_dir = server.get_server_root_path(server_name)
-- 1. (optional, only if lspconfig doesn't already support the server)
--    Create server entry in lspconfig
configs[server_name] = {
    default_config = {
        filetypes = { "julia" },
        root_dir = lspconfig.util.root_pattern(".git", "project.toml"),
    },
}

my_server = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    languages = { "julia" },
    installer = shell.bash [[
    julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
    ]],
    default_options = {
        cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", '    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig\n    # with the regular load path as a fallback\n    ls_install_path = joinpath(\n        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),\n        "environments", "nvim-lspconfig"\n    )\n    pushfirst!(LOAD_PATH, ls_install_path)\n    using LanguageServer\n    popfirst!(LOAD_PATH)\n    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")\n    project_path = let\n        dirname(something(\n            ## 1. Finds an explicitly set project (JULIA_PROJECT)\n            Base.load_path_expand((\n                p = get(ENV, "JULIA_PROJECT", nothing);\n                p === nothing ? nothing : isempty(p) ? nothing : p\n            )),\n            ## 2. Look for a Project.toml file in the current working directory,\n            ##    or parent directories, with $HOME as an upper boundary\n            Base.current_project(),\n            ## 3. First entry in the load path\n            get(Base.load_path(), 1, nothing),\n            ## 4. Fallback to default global environment,\n            ##    this is more or less unreachable\n            Base.load_path_expand("@v#.#"),\n        ))\n    end\n    @info "Running language server" VERSION pwd() project_path depot_path\n    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)\n    server.runlinter = true\n    run(server)\n  ' },
    },
}


-- 3. (optional, recommended) Register your server with nvim-lsp-installer.
--    This makes it available via other APIs (e.g., :LspInstall, lsp_installer.get_available_servers()).
servers.register(my_server)
