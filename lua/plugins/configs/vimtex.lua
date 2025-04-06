vim.keymap.set("n", "<leader>lv", vim.cmd.VimtexView, { desc = "vimtex view" })
vim.keymap.set("n", "<leader>lc", vim.cmd.VimtexCompile, { desc = "vimtex compile" })

vim.g.vimtex_compiler_latexmk = {
    out_dir = 'build',
    options = {
        '-pdf',
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}
