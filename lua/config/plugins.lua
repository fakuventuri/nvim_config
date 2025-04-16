local config_files = io.popen("ls " .. require("utils.path").config .. "lua/plugins/configs") or {}
local configs = {}

for file in config_files:lines() do
    local name = file:sub(1, -5) -- taking out extention
    configs[name] = function()
        require("plugins.configs." .. name)
    end
end

local function add_configs(plugins)
    for _, spec in ipairs(plugins) do
        if not spec.config then
            local plugin = spec[1] or spec.url or spec.dir
            local config_name = plugin:gsub(".*/", ""):gsub("n?vim%-", ""):gsub("%-", "_"):gsub("%.n?vim", ""):lower()
            spec.config = configs[config_name]
        end
    end
end

return {
    add_configs = add_configs,
}
