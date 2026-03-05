return {
    settings = {
        clangd = {
            arguments = {
                "--background-index",
                "--compile-commands-dir=${cmake.compile_commands}",
                "--clang-tidy",
                "--header-insertion=iwyu",
            },
        },
    },
}
