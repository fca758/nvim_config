local M = {}

M.last_binary = nil

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO)
end

local function shellescape(path)
    return vim.fn.shellescape(path)
end

local function makefile(root)
    for _, name in ipairs({ "Makefile", "makefile", "GNUmakefile" }) do
        local path = root .. "/" .. name
        if vim.fn.filereadable(path) == 1 then
            return path
        end
    end
end

local function has_make_target(root, target)
    local path = makefile(root)
    if not path then
        return false
    end

    local pattern = "^" .. vim.pesc(target) .. "%s*:"
    for _, line in ipairs(vim.fn.readfile(path)) do
        if line:match(pattern) then
            return true
        end
    end
    return false
end

local function is_c_family()
    local ft = vim.bo.filetype
    return ft == "c" or ft == "cpp"
end

local function compiler_for(ft)
    if ft == "cpp" then
        return "g++", "-std=c++20"
    end
    return "gcc", "-std=c17"
end

local function single_file_binary()
    return vim.fn.expand("%:p:r")
end

local function compile_single_file()
    if not is_c_family() then
        notify("CCompile solo funciona con archivos C/C++", vim.log.levels.WARN)
        return false
    end

    local source = vim.fn.expand("%:p")
    local binary = single_file_binary()
    local compiler, std = compiler_for(vim.bo.filetype)

    vim.bo.makeprg = table.concat({
        compiler,
        "-Wall",
        "-Wextra",
        "-g",
        "-O0",
        std,
        shellescape(source),
        "-o",
        shellescape(binary),
    }, " ")

    vim.cmd("make")

    local ok = vim.v.shell_error == 0
    if ok then
        M.last_binary = binary
    end
    return ok
end

local function find_executables(root)
    local found = {}

    local function scan(dir, depth)
        if depth > 3 then
            return
        end

        local ok, iter = pcall(vim.fs.dir, dir)
        if not ok then
            return
        end

        for name, kind in iter do
            if name:sub(1, 1) ~= "." and name ~= "node_modules" and name ~= "CMakeFiles" then
                local path = dir .. "/" .. name
                if kind == "directory" then
                    scan(path, depth + 1)
                elseif kind == "file"
                    and vim.fn.executable(path) == 1
                    and not name:match("%.(sh|py|rb|pl)$")
                    and name ~= "configure"
                then
                    table.insert(found, path)
                end
            end
        end
    end

    scan(root, 0)
    return found
end

local function choose_binary(root)
    if M.last_binary and vim.fn.executable(M.last_binary) == 1 then
        return M.last_binary
    end

    local candidates = find_executables(root)
    if #candidates == 1 then
        return candidates[1]
    end

    if #candidates > 1 then
        local choice
        vim.ui.select(candidates, { prompt = "¿Qué binario quieres ejecutar?" }, function(item)
            choice = item
        end)
        return choice
    end

    local input = vim.fn.input("Binario a ejecutar: ", root .. "/a.out", "file")
    if input ~= "" then
        return vim.fn.expand(input)
    end
end

local function run_binary(cmd, root)
    if type(cmd) == "string" then
        cmd = { cmd }
    end

    vim.cmd("botright new")
    vim.fn.termopen(cmd, { cwd = root })
    vim.cmd("startinsert")
end

function M.root()
    return vim.fs.root(0, { "Makefile", "makefile", "GNUmakefile", "CMakeLists.txt", ".git" })
        or vim.fn.getcwd()
end

function M.build()
    local root = M.root()

    if makefile(root) then
        vim.bo.makeprg = "make -C " .. shellescape(root)
    elseif vim.fn.filereadable(root .. "/CMakeLists.txt") == 1 then
        if vim.fn.executable("cmake") == 0 then
            notify("cmake no está instalado", vim.log.levels.ERROR)
            return false
        end

        local build_dir = root .. "/build"
        if vim.fn.filereadable(build_dir .. "/CMakeCache.txt") == 0 then
            local out = vim.fn.systemlist({ "cmake", "-S", root, "-B", build_dir })
            if vim.v.shell_error ~= 0 then
                notify("CMake falló al configurar:\n" .. table.concat(out, "\n"), vim.log.levels.ERROR)
                return false
            end
        end
        vim.bo.makeprg = "cmake --build " .. shellescape(build_dir)
    elseif is_c_family() then
        return compile_single_file()
    else
        notify("No hay Makefile, CMakeLists.txt ni archivo C/C++ para compilar", vim.log.levels.WARN)
        return false
    end

    vim.cmd("make")

    local ok = vim.v.shell_error == 0
    if not ok and #vim.fn.getqflist() > 0 then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
    return ok
end

function M.compile()
    local ok = compile_single_file()
    if ok then
        notify("Compilado: " .. M.last_binary)
    else
        notify("Error de compilación", vim.log.levels.ERROR)
    end
end

function M.run()
    local root = M.root()

    if not M.build() then
        return
    end

    if makefile(root) and has_make_target(root, "run") then
        run_binary({ "make", "run" }, root)
        return
    end

    local binary = choose_binary(root)
    if not binary then
        notify("No se encontró ningún binario para ejecutar", vim.log.levels.WARN)
        return
    end

    M.last_binary = binary
    run_binary(binary, root)
end

function M.run_last()
    local binary = M.last_binary
    if not binary or vim.fn.executable(binary) ~= 1 then
        notify("No hay último binario; compilando primero", vim.log.levels.INFO)
        M.run()
        return
    end

    run_binary(binary, M.root())
end

function M.clean()
    local root = M.root()

    if makefile(root) and has_make_target(root, "clean") then
        vim.fn.system({ "make", "-C", root, "clean" })
        notify("make clean ejecutado")
    elseif vim.fn.isdirectory(root .. "/build") == 1 then
        if vim.fn.executable("cmake") == 0 then
            notify("cmake no está instalado", vim.log.levels.ERROR)
            return
        end

        vim.fn.system({ "cmake", "--build", root .. "/build", "--target", "clean" })
        notify("Build de CMake limpiado")
    elseif M.last_binary then
        vim.fn.delete(M.last_binary)
        M.last_binary = nil
        notify("Binario eliminado")
    else
        notify("No hay nada que limpiar", vim.log.levels.WARN)
    end
end

vim.api.nvim_create_user_command("CBuild", function() M.build() end, { desc = "Compilar el proyecto" })
vim.api.nvim_create_user_command("CCompile", function() M.compile() end, { desc = "Compilar el archivo actual" })
vim.api.nvim_create_user_command("CRun", function() M.run() end, { desc = "Compilar y ejecutar" })
vim.api.nvim_create_user_command("CRunLast", function() M.run_last() end, { desc = "Ejecutar el último binario" })
vim.api.nvim_create_user_command("CClean", function() M.clean() end, { desc = "Limpiar artefactos de compilación" })

vim.keymap.set("n", "<leader>rb", function() M.build() end, { desc = "Build del proyecto" })
vim.keymap.set("n", "<leader>rc", function() M.compile() end, { desc = "Compilar archivo actual" })
vim.keymap.set("n", "<leader>rr", function() M.run() end, { desc = "Compilar y ejecutar" })
vim.keymap.set("n", "<leader>rt", function() M.run_last() end, { desc = "Ejecutar último binario" })
vim.keymap.set("n", "<leader>rC", function() M.clean() end, { desc = "Limpiar compilación" })

return M
