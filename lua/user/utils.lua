local M = {}

M.makeCommand = function(command)
    local finalCommand = "<cmd> " .. command .. " <CR>"
    return finalCommand
end

return M
