vim.opt.wrap = true
vim.opt.linebreak = true
vim.b.textwidth = 80

vim.g.vimtex_quickfix_open_on_warning = 0;

vim.cmd "TSDisable highlight"

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = 'okular'

-- This is necessary for VimTeX to load properly. The "indent" is optional.
-- Note: Most plugin managers will do this automatically!
-- filetype plugin indent on

-- Most VimTeX mappings rely on localleader and this can be changed with the
-- following line. The default is usually fine and is the symbol "\".
vim.maplocalleader = ","

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
