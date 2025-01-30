local tracker = require("mycodetime.tracker")
local commands = require("mycodetime.commands")

-- Start tracking
tracker.start_tracking()

-- Create commands
vim.api.nvim_create_user_command("TodayCodingStats", commands.show_today_stats, {})
vim.api.nvim_create_user_command("AllCodingStats", commands.show_all_stats, {})
vim.api.nvim_create_user_command("ResetTodayStats", commands.reset_today_stats, {})

print("CodeTime plugin with daily tracking loaded!")
