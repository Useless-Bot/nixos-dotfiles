return {
    {
    "neovim/nvim-lspconfig",
    config = function()
	vim.lsp.enable({ "nixd", "pyright", "lua_ls", "vimls" })
    end,
    },
}
