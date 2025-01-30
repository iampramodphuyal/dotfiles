local M = {}
local tracker = require("mycodetime.tracker")

-- Show stats for today
function M.show_today_stats()
    local stats = tracker.get_today_stats()
    print(string.format("Today's Active Time: %d seconds", stats.active_time))
    print(string.format("Today's Idle Time: %d seconds", stats.idle_time))
end

-- Show all stats
function M.show_all_stats()
    local all_stats = tracker.get_all_stats()
    print("Coding Stats (by day):")
    for day, stats in pairs(all_stats) do
        print(string.format("%s - Active: %d seconds, Idle: %d seconds", day, stats.active_time, stats.idle_time))
    end
end

-- Reset stats for the current day
function M.reset_today_stats()
    tracker.stats[tracker.current_day] = { active_time = 0, idle_time = 0 }
    print("Today's stats reset.")
end

return M
