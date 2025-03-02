# Neovim configuration
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraConfig = ''
      let mapleader = " "
      let maplocalleader = " "
      let g:netrw_browse_split = 0
      let g:netrw_banner = 0
      let g:netrw_winsize = 25
      let g:python3_host_prog = "/usr/bin/python3"
      let g:loaded_python3_provider = v:null

      set guicursor=
      set number
      set relativenumber
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
      set nowrap
      set noswapfile
      set nobackup
      set undodir=${config.home.homeDirectory}/.vim/undodir
      set undofile
      set nohlsearch
      set incsearch
      set termguicolors
      set scrolloff=8
      set signcolumn=yes
      set updatetime=50
      set laststatus=3
      set clipboard=unnamedplus
    '';

    extraLuaConfig = ''
      -- Highlight on yank
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd

      local yank_group = augroup('HighlightYank', {})
      autocmd('TextYankPost', {
          group = yank_group,
          pattern = '*',
          callback = function()
              vim.highlight.on_yank({
                  higroup = 'IncSearch',
                  timeout = 40,
              })
          end,
      })

      -- Remove trailing whitespace on save
      local acnGroup = augroup('acn', {})
      autocmd({"BufWritePre"}, {
          group = acnGroup,
          pattern = "*",
          command = [[%s/\s\+$//e]],
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
      vim.keymap.set("n", "J", "mzJ`z")
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")
      vim.keymap.set("n", "n", "nzzzv")
      vim.keymap.set("n", "N", "Nzzzv")
      vim.keymap.set("n", "<leader>Y", [["+Y]])
      vim.keymap.set("n", "<leader>y", [["+y]])
      vim.keymap.set("n", "<leader>d", [["_d]])
      vim.keymap.set("n", "Q", "<nop>")
      vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
      vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
      vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
      vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
      vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
      vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
      vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

      -- Visual mode mappings
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
      vim.keymap.set("v", "<leader>p", [["_dP]])
      vim.keymap.set("v", "<leader>y", [["+y]])
      vim.keymap.set("v", "<leader>d", [["_d]])

      -- Insert mode mappings
      vim.keymap.set("i", "<C-c>", "<Esc>")
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          local on_attach = function(_, bufnr)
            local opts = {buffer = bufnr, remap = false}
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          end

          require('mason').setup()
          require('mason-lspconfig').setup({
            ensure_installed = {
              'lua_ls',
              'clangd',
              'rust_analyzer',
            },
            automatic_installation = true,
          })

          local servers = {
            lua_ls = {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                },
              },
            },
            clangd = {
              cmd = {
                "clangd"
              },
            },
          }

          for server, config in pairs(servers) do
            config.on_attach = on_attach
            config.capabilities = capabilities
            lspconfig[server].setup(config)
          end
        '';
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup({
            highlight = { enable = true },
            indent = { enable = true },
          })
        '';
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require('cmp')
          local luasnip = require('luasnip')

          cmp.setup({
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-p>'] = cmp.mapping.select_prev_item(),
              ['<C-n>'] = cmp.mapping.select_next_item(),
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-u>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              { name = 'buffer' },
              { name = 'path' },
            }),
          })
        '';
      }

      {
        plugin = rose-pine;
        type = "lua";
        config = ''
          require('rose-pine').setup({
            disable_background = true,
            disable_float_background = true,
          })
          vim.cmd('colorscheme rose-pine')
        '';
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
        '';
      }

      {
        plugin = harpoon;
        type = "lua";
        config = ''
          local mark = require("harpoon.mark")
          local ui = require("harpoon.ui")

          vim.keymap.set("n", "<leader>ha", mark.add_file)
          vim.keymap.set("n", "<leader>hd", mark.rm_file)
          vim.keymap.set("n", "<leader>hc", mark.clear_all)
          vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

          vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
          vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
          vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
          vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
        '';
      }

      # Dependencies
      mason-nvim
      mason-lspconfig-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      plenary-nvim

      # Utilities
      undotree
      vim-fugitive
      autoclose-nvim
    ];

    extraPackages = with pkgs; [
      # LSP servers
      nodePackages.typescript-language-server
      lua-language-server
      rust-analyzer
      clang-tools

      # Tools needed by plugins
      ripgrep
      fd
      git

      # Wayland
      wl-clipboard
    ];
  };
}
