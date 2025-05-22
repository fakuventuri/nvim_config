--- @class Opts

--- @type table<string, fun(path: string, opts: Opts)>
local openers = {
    default = function (path, opts)
        vim.cmd("edit " .. path)
    end
}
if vim.loop.os_uname().sysname == "Linux" then
    openers = {
        xlsx = function(path, opts)
            vim.uv.spawn("libreoffice", {
                args = { path },
                stdio = { nil, nil, nil }, detached = true,
            }, function(code)
                if code ~= 0 then
                    vim.schedule(function()
                        vim.notify("LibreOffice failed with code " .. code, vim.log.levels.ERROR)
                    end)
                end
            end)
        end
    }
end

--- @param path string
local function open_with(path)
    local ext = path:match("^.+%.([a-zA-Z0-9]+)$")
    local opener = openers[ext] or openers.default
    opener(path)
end

return {
    open_with = open_with
}
