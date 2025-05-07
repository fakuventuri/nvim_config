-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'
vim.diagnostic.config({ virtual_text = true })
local api = vim.api

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

local function load_mappings(opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>ra', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
end

local function check_triggeredChars(triggerChars)
    local cur_line = api.nvim_get_current_line()
    local pos = api.nvim_win_get_cursor(0)[2]
    local prev_char = cur_line:sub(pos - 1, pos - 1)
    local cur_char = cur_line:sub(pos, pos)

    for _, char in ipairs(triggerChars) do
        if cur_char == char or prev_char == char then
            return true
        end
    end
end

local function setup(client, bufnr)
    local group = api.nvim_create_augroup("LspSignature", { clear = false })
    api.nvim_clear_autocmds { group = group, buffer = bufnr }

    local triggerChars = client.server_capabilities.signatureHelpProvider.triggerCharacters

    api.nvim_create_autocmd("TextChangedI", {
        group = group,
        buffer = bufnr,
        callback = function()
            if check_triggeredChars(triggerChars) then
                vim.lsp.buf.signature_help({ focus = false })
            end
        end,
    })
end

local function on_attach(client, bufnr)
    load_mappings({ buffer = bufnr })

    if (client.server_capabilities or {}).signatureHelpProvider then
        setup(client)
    end
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                on_attach({ vim.lsp.get_client_by_id(event.data.client_id) }, event.buffer)
            end,
        })

        vim.lsp.config("*", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    export = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
}
