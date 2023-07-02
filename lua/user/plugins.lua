local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
    git = {
        clone_timeout = 300, -- Timeout, in seconds, for git clones
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use { "wbthomason/packer.nvim" } -- Have packer manage itself
    use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
    use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
    use { "numToStr/Comment.nvim" }
    use { "JoosepAlviste/nvim-ts-context-commentstring" }
    use { "kyazdani42/nvim-web-devicons" }
    use { "kyazdani42/nvim-tree.lua" }
    use { "akinsho/bufferline.nvim" }
    use { "moll/vim-bbye" }
    use { "nvim-lualine/lualine.nvim" }
    use { "akinsho/toggleterm.nvim" }
    use { "ahmedkhalf/project.nvim" }
    use { "lewis6991/impatient.nvim" }
    use { "lukas-reineke/indent-blankline.nvim" }
    use { "goolord/alpha-nvim" }

    -- Colorschemes
    use { "folke/tokyonight.nvim" }
    use { "lunarvim/darkplus.nvim" }
    use { "morhetz/gruvbox" }
    use { "nanotech/jellybeans.vim" }

    use "AlexvZyl/nordic.nvim"
    use "shaunsingh/nord.nvim"

    -- cmp plugins
    use { "hrsh7th/nvim-cmp" } -- The completion plugin
    use { "hrsh7th/cmp-buffer" } -- buffer completions
    use { "hrsh7th/cmp-path" } -- path completions
    use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-nvim-lua" }

    -- snippets
    use { "L3MON4D3/LuaSnip" } --snippet engine
    use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use {
        "glepnir/lspsaga.nvim",
        opt = true,
        branch = "main",
        event = "LspAttach",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" },
        },
    }

    use {
        "jose-elias-alvarez/typescript.nvim",
        config = function()
            require("typescript").setup {}
        end,
    }

    -- For Linting
    use "mfussenegger/nvim-lint"

    use { "mhartington/formatter.nvim" }
    use { "RRethy/vim-illuminate" }

    -- Telescope
    use { "nvim-telescope/telescope.nvim" }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter" }

    -- Treesitter Plugins
    use { "p00f/nvim-ts-rainbow" }

    -- Git
    use { "lewis6991/gitsigns.nvim" }

    -- DAP
    use { "mfussenegger/nvim-dap" }
    use { "rcarriga/nvim-dap-ui" }
    use { "ravenxrz/DAPInstall.nvim" }

    -- Which Key
    use { "folke/which-key.nvim" }

    -- Copilot
    -- use { "github/copilot.vim" }

    -- MDX
    use "findango/vim-mdx"

    -- Trouble.nvim
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            local troubleConfig = require "./trouble"
            require("trouble").setup(troubleConfig)
        end,
    }

    -- Emmet
    use "mattn/emmet-vim"

    -- For markdown
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
    }

    -- For Neovim with editor config
    use {
        "gpanders/editorconfig.nvim",
    }

    -- For SQL lsp
    use "nanotee/sqls.nvim"

    -- For Prisma
    use "pantharshit00/vim-prisma"

    --For Todo nvim
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    -- For Rename
    use {
        "filipdutescu/renamer.nvim",
        branch = "master",
        requires = { { "nvim-lua/plenary.nvim" } },
    }

    -- For Code action prompt
    use {
        "kosayoda/nvim-lightbulb",
        --[[ requires = "antoinemadec/FixCursorHold.nvim", ]]
    }

    -- For previewing colors on code
    use {
        "norcalli/nvim-colorizer.lua",
    }

    -- For Foldings
    use {
        "kevinhwang91/nvim-ufo",
        requires = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require "statuscol.builtin"
                    require("statuscol").setup {
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    }
                end,
            },
        },
    }

    -- For auto close tag
    use "windwp/nvim-ts-autotag"

    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    }

    use "mbbill/undotree"

    use {
        "Wansmer/treesj",
        requires = { "nvim-treesitter" },
        config = function()
            require("treesj").setup {}
        end,
    }

    use {
        "SmiteshP/nvim-navbuddy",
        requires = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
            "numToStr/Comment.nvim", -- Optional
            "nvim-telescope/telescope.nvim", -- Optional
        },
        config = function()
            require("nvim-navbuddy").setup {
                lsp = {
                    auto_attach = true, -- If set to true, you don't need to manually use attach function
                },
            }
        end,
    }

    use {
        "jedrzejboczar/possession.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("possession").setup {
                autosave = {
                    current = true,
                },
                plugins = { delete_hidden_buffers = false },
                commands = {
                    save = "SSave",
                    load = "SLoad",
                    delete = "SDelete",
                    list = "SList",
                },
            }

            require("telescope").load_extension "possession"
        end,
    }

    use {
        "AlphaTechnolog/pywal.nvim",
        as = "pywal",
        config = function()
            require("pywal").setup()
        end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
