-- lua/theme.lua

local ACTIVE_THEME = "kanagawa"

local M = {}

local themes = {
    spaceduck = "spaceduck",
    kanagawa = "kanagawa",
    eldritch = "eldritch",
}

function M.apply()
    local scheme = themes[ACTIVE_THEME]
    if not scheme then
        vim.notify("Unknown theme: " .. ACTIVE_THEME, vim.log.levels.ERROR)
        return
    end

    vim.cmd.colorscheme(scheme)
end

return M

