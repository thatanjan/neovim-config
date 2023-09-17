local notify = require "notify"

local config = {
    max_width = 100,
    render = "wrapped-compact",
    timeout=2000
}

notify.setup(config)
