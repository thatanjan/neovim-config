return {
    settings = {
        yaml = {
            format = {
                enable = true,
            },
            schemaStore = {
                -- TODO: You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    },
}
