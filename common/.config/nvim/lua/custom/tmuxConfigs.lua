local M = {}

function M.in_tmux()
    return os.getenv("TMUX") ~= nil
end

return M
