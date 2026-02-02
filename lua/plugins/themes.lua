-- lua/plugins/themes.lua
return {
    {
        "pineapplegiant/spaceduck",
        lazy = false,
        priority = 1000,
    },

    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup()
        end,
    },

    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("eldritch").setup()
        end,
    },
}

