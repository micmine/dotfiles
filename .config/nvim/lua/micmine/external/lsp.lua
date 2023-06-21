return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      event = "InsertEnter",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "nvim-lua/lsp_extensions.nvim",
        {
          "ericpubu/lsp_codelens_extensions.nvim", -- plenary, nvim-dap
          dependencies = {
            "nvim-lua/plenary.nvim",
          },
        },
        {
          "jose-elias-alvarez/null-ls.nvim",
          dependencies = {
            {
              "ThePrimeagen/refactoring.nvim",
              config = function()
                require("refactoring").setup({})
              end,
            },
          },
          config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
              sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.code_actions.eslint_d,
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.completion.luasnip,
              },
            })
          end,
        },
        -- Language specific
        {
          "hrsh7th/nvim-cmp",
          dependencies = {
            -- 'onsails/lspkind-nvim',
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "lukas-reineke/cmp-rg",
          },
        },
      },
      config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
          "tsserver",
          "angularls",
          "rust_analyzer",
          "jdtls",
          "stylua",
        })

        local cmp = require("cmp")
        local cmp_mappings = lsp.defaults.cmp_mappings({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<c-y>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
          }),
          ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
          }),
        })

        lsp.setup_nvim_cmp({
          mapping = cmp_mappings,
        })

        lsp.on_attach(function(client, bufnr)
          local opts = { buffer = bufnr, remap = false }

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, ops)
          vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
          end, ops)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, ops)
          vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, ops)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, ops)

          -- modify
          vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, ops)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, ops)

          -- diagnostic
          vim.keymap.set("n", "ü", function()
            vim.diagnostic.open_float()
          end, ops)
          vim.keymap.set("n", "ö", vim.diagnostic.goto_next, ops)
          vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, ops)

          -- codelense
          vim.keymap.set("n", "<leader>xl", vim.lsp.codelens.refresh, ops)
          vim.keymap.set("n", "<leader>xr", vim.lsp.codelens.run, ops)

          -- inlay_hints
          vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
          vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = bufnr,
            callback = function()
              vim.api.nvim_set_hl(bufnr, "LspInlayHint", { bg = "#000000", fg = "#00ff55" })
              vim.lsp.buf.inlay_hint(bufnr, true)
            end,
            group = "lsp_augroup",
          })
          vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.inlay_hint(bufnr, false)
            end,
            group = "lsp_augroup",
          })
        end)

        lsp.setup()
      end,
    },
  },
  {
    "saecki/crates.nvim",
    event = "BufReadPre Cargo.toml",
    ependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "BufEnter",
    config = function()
      require("fidget").setup({})
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rs",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rust-tools").setup({})
      require("rust-tools").inlay_hints.enable()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup({})
    end,
  },
}
