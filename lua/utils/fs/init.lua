local str = require("utils.string")
local clipboard = ""
local to_move = false

local function refresh()
    vim.cmd("Ex")
end

---@alias Clipboard
---| 1 # FILES
---| 2 # SYSTEM
---@type table<string, Clipboard>
local Clipboard = {
    LOCAL = 1,
    SYSTEM = 2,
}

---@class Opts
---@field clipboard Clipboard

---@param opts ?Opts
---@param files string
local function copy(files, opts)
    opts = opts or { clipboard = Clipboard.LOCAL }
    if opts.clipboard == Clipboard.LOCAL then
        clipboard = files
    else
        -- TODO
        -- system cliboard
    end
    to_move = false
end

---@param files string
local function move(files)
    clipboard = files
    to_move = true
end

---@param dir string
---@param path string
---@return string
local function generate_unique_name(dir, path)
    local stat = vim.uv.fs_stat(path) or error("no such file or directory: " .. path, vim.log.levels.ERROR)
    local is_dir = stat.type == "directory"

    if is_dir then
        local name = vim.fn.fnamemodify(path, ":h:t")
        local final_name = name

        print("name" .. name)
        print("final" .. dir .. final_name)

        local repeated = vim.uv.fs_stat(dir .. final_name) ~= nil
        if repeated then
            final_name = name .. " copy/"
        end
        local copies = 1
        while vim.uv.fs_stat(dir .. final_name) ~= nil do
            copies = copies + 1
            final_name = name .. " copy " .. tostring(copies) .. "/"
        end

        return final_name
    else
        local name = vim.fn.fnamemodify(path, ":t:r")
        local ext = vim.fn.fnamemodify(path, ":e")

        local final_name = name .. (ext and "." .. ext or "")
        local repeated = vim.uv.fs_stat(dir .. final_name) ~= nil
        if repeated then
            final_name = name .. " copy" .. (ext and "." .. ext or "")
        end
        local copies = 1
        while vim.uv.fs_stat(dir .. final_name) ~= nil do
            copies = copies + 1
            final_name = name .. " copy " .. tostring(copies) .. (ext and "." .. ext or "")
        end

        return final_name
    end
end

---@param opts? Opts
---@param dst string
local function paste(dst, opts)
    opts = opts or { clipboard = Clipboard.LOCAL }
    local clip = clipboard

    if opts.clipboard == Clipboard.LOCAL and to_move then
        for path in str.lines(clip) do
            local name
            if vim.uv.fs_stat(path).type == "directory" then
                name = vim.fn.fnamemodify(path, ":h:t")
            else
                name = vim.fn.fnamemodify(path, ":t")
            end
            if vim.uv.fs_stat(dst .. name) then
                vim.notify("cannot move: " .. path .. ", already in dst folder", vim.log.levels.ERROR)
            else
                vim.uv.fs_rename(path, dst .. name)
            end
        end
        to_move = false
        goto after_paste
    end

    if opts.clipboard == Clipboard.SYSTEM then
        clip = ""
        for path in str.lines(vim.fn.getreg("+")) do
            local stat = vim.uv.fs_stat(path)
            if not stat then
                vim.notify("Only files can be pasted in this buffer", vim.log.levels.ERROR)
                return
            end
            if stat.type == "directory" then
                clip = (clip and clip .. "\n" or "") .. path .. "/"
            else
                clip = (clip and clip .. "\n" or "") .. path
            end
        end
    end

    for path in str.lines(clip) do
        local final_name = generate_unique_name(dst, path)
        if vim.uv.fs_stat(path).type == "directory" then
            vim.uv.fs_mkdir(dst .. final_name, 493) -- rwxr-xr-x
            vim.cmd("silent !cp -r " .. path .. "* -t " .. dst .. final_name:gsub(" ", "\\ "))
        else
            vim.uv.fs_copyfile(path, dst .. final_name)
        end
    end

    ::after_paste::
    refresh()
end

---@class delete.Opts
---@field with_confirmation boolean

---@param files string
---@param opts? delete.Opts
local function delete(files, opts)
    opts = opts or { with_confirmation = true }
    if opts.with_confirmation then
        local confirm = vim.fn.input("Deleting files:\n" .. files .. "confirm [y/N]: ")
        if confirm ~= "y" then
            return
        end
    end
    for file in str.lines(files) do
        vim.fn.delete(file:gsub("*$", ""), "rf")
    end
    refresh()
end

---return the directory currently displayed in netrw or the parent directory if viewing a file
---@return string
local function cwd()
    local dir = vim.fn.expand("%")
    if dir:sub(1, 1) == "/" then
        return dir .. "/"
    end
    dir = dir ~= "" and dir .. "/" or ""
    local root = vim.fn.getcwd() .. "/"
    return root .. dir
end

return {
    copy = copy,
    move = move,
    paste = paste,
    delete = delete,
    cwd = cwd,
    Clipboard = Clipboard,
    open_with = require("utils.fs.open").open_with
}
