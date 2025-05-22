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

---@param file string
---@param dst string
local function paste_file(file, dst)
    local name = vim.fn.fnamemodify(file, ":t:r")
    local ext = vim.fn.fnamemodify(file, ":e")

    local name_ext = name .. (ext and "." .. ext or "")
    local repeated = vim.uv.fs_stat(dst .. name_ext) ~= nil
    if repeated then
        if to_move then
            vim.notify("cannot move: " .. file .. ", already in dst folder", vim.log.levels.ERROR)
            return
        end
        name_ext = name .. " copy" .. (ext and "." .. ext or "")
    end
    local copies = 1
    while vim.uv.fs_stat(dst .. name_ext) ~= nil do
        copies = copies + 1
        name_ext = name .. " copy " .. tostring(copies) .. (ext and "." .. ext or "")
    end

    if to_move then
        vim.uv.fs_rename(file, dst .. name_ext)
        to_move = false
    else
        vim.uv.fs_copyfile(file, dst .. name_ext)
    end
    refresh()
end

---@param dir string
---@param dst string
local function paste_dir(dir, dst)
    local name = vim.fn.fnamemodify(dir, ":h:t")
    local final_name = name

    print("fname: " .. final_name)
    local repeated = vim.uv.fs_stat(dst .. final_name) ~= nil
    if repeated then
        if to_move then
            vim.notify("cannot move: " .. dir .. ", already in dst folder", vim.log.levels.ERROR)
            return
        end
        final_name = name .. " copy/"
    end
    local copies = 1
    while vim.uv.fs_stat(dst .. final_name) ~= nil do
        copies = copies + 1
        final_name = name .. " copy " .. tostring(copies) .. "/"
    end

    print("name: " .. final_name)
    final_name = dst .. final_name
    vim.uv.fs_mkdir(final_name, 493) -- rwxr-xr-x
    if to_move then
        vim.cmd("silent !mv " .. dir .. "* " .. final_name:gsub(" ", "\\ "))
        vim.cmd("silent !rm -r " .. dir)
        to_move = false
    else
        vim.cmd("silent !cp -r " .. dir .. "* -t " .. final_name:gsub(" ", "\\ "))
    end
    refresh()
end

---@param opts? Opts
---@param dst string
local function paste(dst, opts)
    opts = opts or { clipboard = Clipboard.LOCAL }
    local clip = clipboard
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
        if vim.uv.fs_stat(path).type == "directory" then
            paste_dir(path, dst)
        else
            paste_file(path, dst)
        end
    end
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
