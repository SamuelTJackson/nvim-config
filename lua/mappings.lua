require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("n", "nf", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle" })

map("n", "<leader>jb", "<C-o>", { desc = "Jump backward buffer" })
map("n", "<leader>jf", "<C-i>", { desc = "Jump backward buffer" })

map("n", "<leader>jbb", function()
  require("bufjump").backward()
end, { desc = "Jump backward buffer" })

map("n", "<leader>jfb", function()
  require("bufjump").forward()
end, { desc = "Jump forward buffer" })

map("n", "<leader>sw", function()
  require("hop").hint_patterns()
end, { desc = "Hop to word" })

map("n", "<leader>op", ":wa<CR><cmd>ProjectMgr<CR>", { desc = "Open projects" })

-- Go mappings
map("n", "<leader>gi", "<cmd>GoImports<CR>", { desc = "Go imports" })
map("n", "<leader>gfs", ":w<CR><cmd>GoFillStruct<CR>", { desc = "Fill go struct" })
map("n", "<leader>gie", "<cmd>GoIfErr<CR>", { desc = "Go if err" })
map("n", "<leader>gii", function()
  require("telescope").extensions.goimpl.goimpl {}
end, { desc = "Implement some interface" })

map("n", "<leader>gat", function()
  local input = vim.fn.input "Tag name: "
  vim.cmd(":GoTagAdd " .. input)
end, { desc = "Add go tags to struct" })

-- nvimtree
map("n", "<leader>ft", "<cmd>NvimTreeFocus<CR>", { desc = "Nvim tree focus browser" })
map("n", "<leader>tf", "<cmd>NvimTreeFocus<CR>", { desc = "Nvim tree focus browser" })

-- general mappings
map("n", "<leader>vr", "<cmd>Lspsaga rename ++project<CR>", { desc = "Rename variable" })
map("n", "<leader>c", "<cmd>:close<CR>", { desc = "Close window" })
map("v", "<leader>fw", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", { desc = "Live grep word" })
map("n", "<leader>nd", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "<leader>pd", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

-- multiLIne
map("n", "<C-j>", "<Plug>(VM-Find-Under)", { desc = "Multi line find under" })

--DB
map("n", "<leader>dbt", "<cmd>DBUIToggle<CR>", { desc = "DB ui toggle" })

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<C-n>")
