return
{
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'simrat39/rust-tools.nvim',
            {
                'folke/neodev.nvim',
                config = true,
            },
            {
                'hrsh7th/cmp-nvim-lsp',
                config = true,
                dependencies = {
                    'williamboman/mason-lspconfig.nvim',
                    config = true,
                    dependencies = {
                        'williamboman/mason.nvim',
                        config = true,
                    },
                },
            },
        },
        config = function()
            -- TODO: fix this to use vim.lsp.buf actions rather than strings
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp_attach = function(_, bufnr)
                local bufopts = { buffer = bufnr, remap = false }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

                vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, { buffer = bufnr })
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)

                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)

                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, bufopts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, bufopts)

                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
                -- vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, bufopts)

                vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { buffer = bufnr })
                vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<cr>', { buffer = bufnr })
            end

            local lspconfig = require('lspconfig')
            lspconfig.rust_analyzer.setup({
                capabilities = lsp_capabilities,
                on_attach = lsp_attach
            })
            lspconfig.lua_ls.setup({
                capabilities = lsp_capabilities,
                on_attach = lsp_attach
            })
            lspconfig.texlab.setup({
                capabilities = lsp_capabilities,
                on_attach = lsp_attach
            })
            lspconfig.clangd.setup({
                capabilities = lsp_capabilities,
                on_attach = lsp_attach
            })
            lspconfig.r_language_server.setup({
                capabilities = lsp_capabilities,
                on_attach = lsp_attach
            })
            lspconfig.ruff.setup({
                capabilities = lsp_capabilities,
                on_attach = lsp_attach,
                cmd = { "uv", "run", "ruff", "server" },
            })
            local function get_python_path(workspace)
                -- 1. Try to find .venv in the workspace
                local venv = workspace .. "/.venv/bin/python"
                if vim.fn.executable(venv) == 1 then
                    return venv
                end

                -- 2. Fallback to system Python
                return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
            end
            lspconfig.pyright.setup({
                on_init = function(client)
                    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
                end,
                capabilities = lsp_capabilities,
                on_attach = lsp_attach,
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        -- disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            -- ignore = { '*' },
                        },
                    },
                },
            })
        end,
    },
}
