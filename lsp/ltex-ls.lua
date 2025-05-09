local lspconfig = require("plugins.lspconfig").export

return {
    on_attach = function(client, bufnr)
        lspconfig.on_attach(client, bufnr)
        require("ltex_extra").setup({
            path = "./.ltex/",
        })
    end,
    settings = {
        ltex = {
            language = "es",
            additionalRules = {
                languageModel = "~/models/ngrams/",
                -- enablePickyRules = true,
            },
            disabledRules = {
                ["es"] = {
                    "MORFOLOGIK_RULE_ES",
                    "\\\\\\\\cite{.*}",
                    "\\\\\\\\acr\\\\w*{.*}",
                },
                -- ["en"] = { "MORFOLOGIK_RULE_EN" },
            },
        },
    }
}
