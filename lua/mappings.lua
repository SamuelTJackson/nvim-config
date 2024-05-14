require "nvchad.mappings"

-- Disable mappings
local nomap = vim.keymap.del

nomap("n", "<C-n>")
nomap("n", "<leader>h")
nomap("n", "<leader>n")
nomap("n", "<leader>gt")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

map("n", "<leader>jb", "<C-o>", { desc = "Jump backward buffer" })
map("n", "<leader>jf", "<C-i>", { desc = "Jump forward buffer" })

map("n", "<leader>sw", function()
  require("hop").hint_patterns()
end, { desc = "Hop to word" })

map("n", "<leader>op", function()
  require("telescope").extensions.projects.projects {}
end, { desc = "Open projects" })

-- Go mappings
map("n", "<leader>gi", "<cmd>GoImports<CR>", { desc = "Go imports" })
map("n", "<leader>gfs", ":w<CR><cmd>GoFillStruct<CR>", { desc = "Fill go struct" })
map("n", "<leader>gie", "<cmd>GoIfErr<CR>", { desc = "Go if err" })
map("n", "<leader>gii", function()
  require("telescope").extensions.goimpl.goimpl {}
end, { desc = "Implement some interface" })

map("n", "<leader>gat", function()
  local input = vim.fn.input "Tag name: "
  vim.cmd ":w"
  vim.cmd(":GoTagAdd " .. input)
end, { desc = "Add go tags to struct" })

map("n", "<leader>gtf", ":wa<CR><cmd>GoTestFile<CR>", { desc = "Fill go struct" })

-- nvimtree
map("n", "<leader>tf", "<cmd>NvimTreeFocus<CR>", { desc = "Nvim tree focus browser" })
map("n", "tt", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle" })
map("n", "tc", "<cmd>NvimTreeClose<CR>", { desc = "Nvimtree toggle" })
map("n", "nt", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle" })

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

--quicklist
map("n", "<leader>qc", ":cclose<CR>", { desc = "Fill go struct" })

--Harpoon
--
local harpoon = require "harpoon"
harpoon:setup {}

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

map("n", "<leader>hl", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

map("n", "<leader>ha", function()
  harpoon:list():add()
end)

map("n", "<leader>h1", function()
  harpoon:list():select(1)
end)
map("n", "<leader>h2", function()
  harpoon:list():select(2)
end)
map("n", "<leader>h3", function()
  harpoon:list():select(3)
end)
map("n", "<leader>h4", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<leader>hp", function()
  harpoon:list():prev()
end)
map("n", "<leader>hn", function()
  harpoon:list():next()
end)

--refactoring
--vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end)
map("x", "<leader>rf", function()
  require("refactoring").refactor "Extract Function To File"
end, { desc = "" })
-- Extract function supports only visual mode
map("x", "<leader>rv", function()
  require("refactoring").refactor "Extract Variable"
end, { desc = "" })
-- Extract variable supports only visual mode
map("n", "<leader>rI", function()
  require("refactoring").refactor "Inline Function"
end, { desc = "" })
-- Inline func supports only normal
map({ "n", "x" }, "<leader>ri", function()
  require("refactoring").refactor "Inline Variable"
end, { desc = "" })
-- Inline var supports both normal and visual mode

map("n", "<leader>rb", function()
  require("refactoring").refactor "Extract Block"
end, { desc = "" })
map("n", "<leader>rbf", function()
  require("refactoring").refactor "Extract Block To File"
end, { desc = "" })
-- Extract block supports only normal mode
