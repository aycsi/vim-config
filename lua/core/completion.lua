_G.cmp_enabled = true

local lspconfig = require('lspconfig')
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

local capabilities = cmp_nvim_lsp.default_capabilities()

local lua_ls_path = "$HOME/scoop/apps/lua-language-server/current"
local lua_ls_bin = lua_ls_path .. "/bin/lua-language-server.exe"

lspconfig.lua_ls.setup{
    cmd = { lua_ls_bin, "-E", lua_ls_path .. "/main.lua" },
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$HOME/AppData/Local/nvim/lua")] = true,
                },
                checkThirdParty = false,
                ignoreDir = { "node_modules", ".git", "build", "dist" },
            },
            telemetry = { enable = false },
        },
    },
    root_dir = vim.fn.expand("$HOME/AppData/Local/nvim"),
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end
}

lspconfig.pyright.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end
}

lspconfig.ts_ls.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        client.server_capabilities.documentFormattingProvider = false
    end,
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
}

lspconfig.clangd.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
    filetypes = { "c", "cpp", "cxx", "cc", "h", "hpp", "hxx" },
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm"
    },
}

lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
    filetypes = { "go", "gomod", "gosum" },
}


lspconfig.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
    filetypes = { "rust" },
}


lspconfig.jdtls.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
    filetypes = { "java" },
    root_dir = function(fname)
        return require("lspconfig").util.root_pattern("pom.xml", "build.gradle", "settings.gradle", ".git")(fname) or vim.fn.getcwd()
    end,
}

cmp.setup({
    enabled = function() return _G.cmp_enabled end,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    })
})

