local M = {}

-- Variables to track time
M.stats_file = vim.fn.stdpath("config") .. "/mycodetime_stats.json"
M.stats = {}
M.current_day = os.date("%Y-%m-%d")
M.active_time = 0
M.idle_time = 0
M.last_active = os.time()
M.is_active = true
M.idle_timeout = 300 -- 5 minutes idle threshold

-- Utility to load stats from file
local function load_stats()
    local file = io.open(M.stats_file, "r")
    if file then
        local content = file:read("*a")
        file:close()
        if content and #content > 0 then
            M.stats = vim.fn.json_decode(content)
        end
    end
end

-- Utility to save stats to file
local function save_stats()
    local file = io.open(M.stats_file, "w")
    if file then
        file:write(vim.fn.json_encode(M.stats))
        file:close()
    end
end

-- Ensure stats exist for the current day
local function ensure_today_stats()
    if not M.stats[M.current_day] then
        M.stats[M.current_day] = { active_time = 0, idle_time = 0 }
    end
end

-- Check and update idle or active time
local function check_idle()
    local current_time = os.time()
    local elapsed = current_time - M.last_active
    ensure_today_stats()
    if M.is_active then
        M.stats[M.current_day].active_time = M.stats[M.current_day].active_time + elapsed
    else
        M.stats[M.current_day].idle_time = M.stats[M.current_day].idle_time + elapsed
    end

    M.last_active = current_time
end

-- Activity handler
function M.on_activity()
    check_idle()
    M.is_active = true
end

-- Idle handler
function M.on_idle()
    check_idle()
    M.is_active = false
end

-- Start tracking
function M.start_tracking()
    load_stats()
    ensure_today_stats()

    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "TextChanged" }, {
        callback = M.on_activity,
    })

    vim.api.nvim_create_autocmd({ "VimLeave" }, {
        callback = function()
            check_idle()
            save_stats()
        end,
    })

    -- Periodic idle checker
    vim.loop.new_timer():start(0, 1000, vim.schedule_wrap(function()
        local idle_time = os.time() - M.last_active
        if idle_time > M.idle_timeout then
            M.on_idle()
        end
    end))
end

-- Get stats for the current day
function M.get_today_stats()
    ensure_today_stats()
    return M.stats[M.current_day]
end

-- Get stats for all days
function M.get_all_stats()
    return M.stats
end

return M
