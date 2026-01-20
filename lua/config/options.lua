vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local options = {
	wrap = false,
	swapfile = false,
	timeout = false,
	number = true,
	hlsearch = true,
	relativenumber = true,
	cursorline = true,
	termguicolors = true,
	signcolumn = "yes",
	pumheight = 16,
	tabstop = 4,
	shiftwidth = 4,
	cmdheight = 2,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
