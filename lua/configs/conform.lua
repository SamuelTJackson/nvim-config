local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    tf = { "terraform_fmt" },
    hcl = { "terragrunt_hclfmt" },
    sql = { "sql_formatter" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    -- ["*"] = { "codespell" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
