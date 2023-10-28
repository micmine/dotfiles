return {
  "hoob3rt/lualine.nvim",
  lazy = false,
  config = function()
    local function fileLocation()
      return vim.fn.expand("%")
    end

    require("lualine").setup({
      theme = "oxocarbon",
      options = { section_separators = "", component_separators = "" },
      sections = {
        lualine_a = {},
        lualine_b = { "branch" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { "branch" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { fileLocation },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = { },
        lualine_c = { fileLocation },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }
    })
  end,
}
