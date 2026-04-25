local M = {}

M.config = {
	output = {
		path = "~/Pictures",
		format = function()
			return "snapshot_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".png"
		end,
	},

	args = {
		background = "#fff0", -- transparent default

		-- ========================
		-- WINDOW
		-- ========================
		window_title = function()
			return vim.fn.expand("%:t")
		end,

		-- ========================
		-- FONT & TEXT
		-- ========================
		-- font = "JetBrainsMono Nerd Font=34",
		line_pad = 2,
		tab_width = 4,

		-- ========================
		-- PADDING / LAYOUT
		-- ========================
		pad_horiz = 80,
		pad_vert = 100,

		-- ========================
		-- SHADOW
		-- ========================
		shadow_blur_radius = 0,
		shadow_offset_x = 0,
		shadow_offset_y = 0,
		shadow_color = "#000000",

		-- ========================
		-- LINE NUMBERS
		-- ========================
		line_offset = 1,
	},
}

local function silicon(mode, title)
	local opts = M.config
	if vim.fn.executable("silicon") == 0 then
		vim.notify("silicon binary not found.")
		return
	end

	if vim.fn.isdirectory(opts.output.path) == 0 then
		vim.fn.mkdir(opts.output.path, "p")
	end

	opts.args.window_title = title == "" and opts.args.window_title or title

	local format = opts.output.format() or opts.output.format
	local output = vim.fn.expand(opts.output.path .. "/" .. format)

	local filetype = vim.bo.filetype

	local lines

	if mode == "range" then
		local start = vim.fn.line("'<")
		local finish = vim.fn.line("'>")
		lines = vim.api.nvim_buf_get_lines(0, start - 1, finish, false)
	elseif mode == "file" then
		lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	elseif mode == "line" then
		local lnum = vim.fn.line(".")
		lines = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)
	end

	local tmpfile = vim.fn.tempname() .. ".txt"
	vim.fn.writefile(lines, tmpfile)

	local cmd = { "silicon", tmpfile, "--language", filetype, "--theme", require("theme"), "-o", output }

	for key, val in pairs(opts.args) do
		val = type(val) == "function" and val() or val
		key = "--" .. key:gsub("_", "-")

		table.insert(cmd, key)
		table.insert(cmd, val)
	end

	vim.system(cmd, {}, function(res)
		if res.code == 0 then
			vim.schedule(function()
				vim.notify("Snapshot saved: " .. output, vim.log.levels.INFO, { title = "Silicon" })
			end)
		else
			vim.schedule(function()
				vim.notify("Silicon failed", vim.log.levels.ERROR, { title = "Silicon" })
			end)
		end
	end)
end

vim.api.nvim_create_user_command("SiliconFile", function(opts)
	silicon("file", opts.args)
end, { nargs = "*" })

vim.api.nvim_create_user_command("SiliconLine", function(opts)
	silicon("line", opts.args)
end, { nargs = "*" })

vim.api.nvim_create_user_command("SiliconRange", function(opts)
	silicon("range", opts.args)
end, { nargs = "*", range = true })

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

return M
