-- credits to @Malace : https://www.reddit.com/r/neovim/comments/ql4iuj/rename_hover_including_window_title_and/
-- This is modified version of the above snippet

local M = {}

M.apply = function(curr, win)
   local newName = vim.api.nvim_get_current_line()
   if not vim.api.nvim_win_is_valid(win) then
      return
   end
   vim.api.nvim_win_close(win, true)

   if #newName > 0 and newName ~= curr then
      local params = vim.lsp.util.make_position_params()
      params.newName = newName:sub(1, #newName - 1)

      vim.lsp.buf_request(0, 'textDocument/rename', params)
   end
end

M.run = function()
   local currName = vim.fn.expand('<cword>') .. ' '

   vim.api.nvim_set_hl(0, 'ColorRename', { fg = '#51afef' })

   local win = require('plenary.popup').create(currName, {
      title = 'Rename',
      style = 'minimal',
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      relative = 'cursor',
      borderhighlight = 'ColorRename',
      titlehighlight = 'ColorRename',
      focusable = true,
      width = 25,
      height = 1,
      line = 'cursor+2',
      col = 'cursor-1',
   })

   local map_opts = { noremap = true, silent = true }

   vim.cmd('normal w')
   vim.cmd('startinsert')

   local keymaps = {
      i = "<cmd>stopinsert | lua require('grfiles.modules.rename').apply('" .. currName .. "'," .. win .. ')<CR>',
      n = "<cmd>stopinsert | lua require('grfiles.modules.rename').apply('" .. currName .. "'," .. win .. ')<CR>',
   }

   for mode, mapping in pairs(keymaps) do
      vim.api.nvim_buf_set_keymap(0, mode, '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
      vim.api.nvim_buf_set_keymap(0, mode, '<CR>', mapping, map_opts)
   end
end

return M
