local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local tidy_imports = {
    name = "tidy_imports",
    method = null_ls.methods.CODE_ACTION,
    filetypes = { "python" },
    generator = helpers.generator_factory({
        command = "tidy-imports",
        args = { "$FILENAME" },
        to_stdin = false,
        from_stderr = false,
        -- choose an output format (raw, json, or line)
        format = "raw",
        check_exit_code = function(code, stderr)
            local success = code <= 1

            if not success then
                -- can be noisy for things that run often (e.g. diagnostics), but can
                -- be useful for things that run on demand (e.g. formatting)
                print(stderr)
            end

            return success
        end,
        on_output = function(params, done)
            -- Return a single code action that applies the diff
            done({
                {
                    title = "Tidy imports (pyflyby)",
                    action = function()
                        vim.api.nvim_buf_set_lines(params.bufnr, 0, -1, false, vim.split(params.output, "\n"))
                    end,
                },
            })
        end,
    })
}

-- null_ls.register(tidy_imports)
null_ls.setup({
    sources = {
        tidy_imports,
    },
})
