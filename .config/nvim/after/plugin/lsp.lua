local lsp = require("lsp-zero")
lsp.preset("recommended")

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n"] = cmp.mapping.select_next_item(cmp_select),
    ["<TAB>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space"] = cmp.mapping.complete(),
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end, opts)
end)
lsp.setup()
vim.diagnostic.config({
    virtual_text = true,
})
