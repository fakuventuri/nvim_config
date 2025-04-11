local lsp_config = require("plugins.configs.lspconfig")
local jdtls = require("jdtls")

local function directory_exists(path)
    local f = io.popen("cd " .. path)
    return f and not f:read("*all"):find("ItemNotFoundException")
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace/" .. project_name
if directory_exists(workspace_dir) then
else
    os.execute("mkdir " .. workspace_dir)
end
-- get the mason install path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
-- get the current OS
local os_name = string.lower(vim.loop.os_uname().sysname)

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
        "\n"
    )
)

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. install_path .. "/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        install_path .. "/config_" .. os_name,
        "-data",
        workspace_dir, },
    capabilities = lsp_config.capabilities,
    root_dir = root_dir,
    settings = {
        java = {
            signatureHelp = {
                enabled = true,
            },
            saveActions = {
                organizeImports = true,
            },
            completion = {
                maxResults = 20,
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
            },
            references = {
                includeDecompiledSources = true,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
            },
        },
    },
    init_options = {
        bundles = bundles,
    },
    on_attach = function(client, bufnr)
        lsp_config.on_attach(client, bufnr)
        local _, _ = pcall(vim.lsp.codelens.refresh)
        require("jdtls.dap").setup_dap_main_class_configs()
        jdtls.setup_dap({ hotcodereplace = "auto" })
    end
}

jdtls.start_or_attach(config)
