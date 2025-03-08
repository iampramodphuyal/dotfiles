local M = {}
M.time = function()
    local hl = { fg = "pink", bg = "", bold = true } -- White text on a dark background
    vim.api.nvim_set_hl(0, "TimeModule", hl)
    return "%#TimeModule#" .. "  " .. os.date("%H:%M")
end

M.battery = function()
    local handle = io.popen("cat /sys/class/power_supply/BAT0/capacity")
    if (handle ~= nil) then
        local percent = handle:read("*a")
        handle:close()
        local hl = { fg = "", bg = "", bold = true } -- White text on a dark background
        vim.api.nvim_set_hl(0, "BatteryModule", hl)
        -- return " " .. percent:gsub("\n", "") .. ""
        -- return "⚡ " .. vim.trim(percent)
        return "%#BatteryModule#" .. " " .. vim.trim(percent)
    end
end

return M
