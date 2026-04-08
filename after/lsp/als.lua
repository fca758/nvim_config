return {
    settings = {
        ada = {
            projectFile = "*.gpr",
        },
    },
    filetypes = {"ada"},
    root_dir = require("lspconfig.util").root_pattern("*.gpr", ".git"),
}
