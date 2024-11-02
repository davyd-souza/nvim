return {
	'stevearc/conform.nvim',
	opts = {},
	keys = {
		--[[
		{
			'<leader>f',
			function()
				require('conform').format({ async = true, lsp_format = 'fallback' })
			end,
			mode = '',
			desc = '[F]ormat buffer',
		},
		]]--
	},
	config = function()
		require('conform').setup({
			formatters_by_ft = {
				javascript = { 'prettierd' },
				javascriptreact = { 'prettierd' },
				typescriptreact = { 'prettierd' },
				--typescriptreact = { 'prettierd', 'eslint_d' },
			},

			format_on_save = {
				async = false,
				lsp_format = 'fallback',
				timeout_ms = 500,
			},
		})

		local formatter_group = vim.api.nvim_create_augroup('formatter', { clear = true})
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = formatter_group,
			pattern = '*',
			callback = function(args)
				require('conform').format({ bufnr = args.buf })
			end,
		})

		vim.keymap.set('n', '<leader>f', function()
			require('conform').setup({
				format_on_save = {
					async = true,
					timeout_ms = 500,
					lsp_format = 'fallback'
				}
			})
		end, { desc = '[F]ormat buffer' })
	end
}
