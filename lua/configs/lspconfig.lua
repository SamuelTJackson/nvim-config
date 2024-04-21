local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local tele = require "telescope.builtin"
local conf = require("nvconfig").ui.lsp
local map = vim.keymap.set

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "terraformls", "golangci_lint_ls" }

local on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", tele.lsp_type_definitions, opts "Go to declaration")
  map("n", "gd", tele.lsp_definitions, opts "Go to definition")
  map("n", "K", vim.lsp.buf.hover, opts "hover information")
  map("n", "gi", tele.lsp_implementations, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  map("n", "<leader>ra", function()
    require "nvchad.lsp.renamer"()
  end, opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", tele.lsp_references, opts "Show references")

  -- setup signature popup
  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      buildFlags = { "-tags=integration,fixtures" },
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusewrites = true,
      },
    },
  },
}
