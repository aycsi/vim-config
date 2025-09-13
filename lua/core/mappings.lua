local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<C-a>', 'ggVG', opts)
map('v', '<C-c>', '"+y', opts)
map('n', '<C-s>', ':w<CR>', opts)
map('n', '<C-f>', '/', opts)

map('n', '<F5>', function()
    local basename = vim.fn.expand("%:t:r")
    local output_dir = "output"
    if vim.fn.has("win32") == 1 then
        vim.cmd("!if not exist " .. output_dir .. " mkdir " .. output_dir)
        vim.cmd("!g++ -Wall -Wextra -g3 % -o " .. output_dir .. "/" .. basename .. ".exe")
    else
        vim.cmd("!mkdir -p " .. output_dir)
        vim.cmd("!g++ -Wall -Wextra -g3 % -o " .. output_dir .. "/" .. basename)
    end
end, opts)

map('n', '<F6>', function()
    local basename = vim.fn.expand("%:t:r")
    local output = "output/" .. basename
    if vim.fn.has("win32") == 1 then
        vim.cmd("!start cmd /c " .. output .. ".exe")
    else
        vim.cmd("!./" .. output)
    end
end, opts)

map('n', '<F7>', function()
    local basename = vim.fn.expand("%:t:r")
    local output_dir = "output"
    if vim.fn.has("win32") == 1 then
        vim.cmd("!if not exist " .. output_dir .. " mkdir " .. output_dir)
        vim.cmd("!g++ -Wall -Wextra -g3 -O0 % -o " .. output_dir .. "/" .. basename .. ".exe")
        vim.cmd("terminal gdb")
    else
        vim.cmd("!mkdir -p " .. output_dir)
        vim.cmd("!g++ -Wall -Wextra -g3 -O0 % -o " .. output_dir .. "/" .. basename)
        vim.cmd("terminal gdb")
    end
end, opts)

map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>Q', ':q!<CR>', opts)

vim.cmd("command! -bang Q quit<bang>")
vim.cmd("command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>")
vim.cmd("command! -bang WQ write<bang> | quit<bang>")
vim.cmd("command! -bang Wq write<bang> | quit<bang>")

_G.cmp_enabled = true
local function toggle_cmp()
    _G.cmp_enabled = not _G.cmp_enabled
    if _G.cmp_enabled then
        print("ENABLED")
    else
        print("DISABLED")
    end
end

map('n', '<leader>ac', toggle_cmp, opts)
map('n', 'A', toggle_cmp, opts)

