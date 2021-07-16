lua require'lspconfig'.jdtls.setup{
Commands:
  
  Default Values:
    filetypes = { "java" }
    root_dir = root_pattern(".git")
    on_attach=require'completion'.on_attach
}
