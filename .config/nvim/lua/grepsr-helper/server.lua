function create_local_server()
    local socket = require "socket"
    local http = require "socket.http"
    local server = assert(socket.bind("127.0.0.1", 4060))
    local ip, port = server:getsockname()
    print("Server Listening on http://" .. ip .. ":" .. port)
    while true do
        local client = server.accept()
        client:settimeout(10)
        local request = client:receive()
        if request then
            local method, path = request:match "([A-Z]+) (.+) HTTP"
            if method == "GET" then
                if path:match "/open" then
                    local file_or_dir = path:match "/open%?path=(.+)"
                    if file_or_dir then
                        file_or_dir = file_or_dir:gsub("%%(%x%x)", function(hex)
                            return string.char(tonumber(hex, 16))
                        end)
                        vim.cmd(":e " .. file_or_dir)
                        client:send("HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nOpened: " .. file_or_dir)
                    else
                        client:send "HTTP/1.1 400 Bad Request\r\nContent-Type: text/plain\r\n"
                    end
                end
            end
        end
    end
end
