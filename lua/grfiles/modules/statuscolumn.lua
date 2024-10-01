vim.api.nvim_set_hl(0, 'FoldSignsOpen', { fg = '#EEFFFF', bg = '#292C3C' })
vim.api.nvim_set_hl(0, 'FoldSignsClosed', { fg = '#a5adce', bg = '#292C3C' })

local selectTable = require('grfiles.utils').selectTable
local opts_default = require('grfiles.constants').opts_default
local combineTable = require('grfiles.utils').combineTable

local column_num = function(win)
   local is_num = vim.wo[win].number
   local is_relnum = vim.wo[win].relativenumber

   if is_num and is_relnum then
      return '%=%{v:relnum?(v:virtnum>0?"":v:relnum):(v:virtnum>0?"":v:lnum)} '
   elseif is_num and not is_relnum then
      return '%=%{v:virtnum>0?"":v:lnum} '
   elseif is_relnum and not is_num then
      return '%=%{v:virtnum>0?"":v:relnum} '
   else
      return ''
   end
end

local column_fold = function()
   if vim.fn.eval('foldlevel(v:lnum) > foldlevel(v:lnum - 1)') == 1 then
      if vim.fn.eval('foldclosed(v:lnum) == -1') == 1 then
         return '%#FoldSignsClosed# %T'
      elseif vim.fn.eval('foldclosed(v:lnum) != -1') == 1 then
         return '%#FoldSignsOpen# %T'
      end
   else
      return '  %T'
   end
end

local M = {}

M.withFold = function()
   local win = vim.g.statusline_winid

   return table.concat({
      '%s%=%T',
      column_num(win),
      column_fold(),
   })
end

M.withoutFold = function()
   local win = vim.g.statusline_winid
   return table.concat({
      '%s%=%T',
      column_num(win),
   })
end

---@class GrStatusColumn
---@field ignore_fold_ft? table<string>
---@field disabled_statuscolum_ft? table<string>

---@param userTable GrStatusColumn
function M.setup(userTable)
   ---@type GrStatusColumn
   userTable = selectTable(userTable, opts_default)

   vim.api.nvim_create_autocmd('Filetype', {
      pattern = { '*' },
      callback = function()
         vim.opt_local.statuscolumn = "%!v:lua.require('grfiles.modules.statuscolumn').withFold()"
      end,
   })

   vim.api.nvim_create_autocmd('Filetype', {
      pattern = selectTable(userTable.ignore_fold_ft, opts_default.ignore_fold_ft),
      callback = function()
         vim.opt_local.statuscolumn = "%!v:lua.require('grfiles.modules.statuscolumn').withoutFold()"
      end,
   })

   vim.api.nvim_create_autocmd('Filetype', {
      pattern = combineTable(userTable.disabled_statuscolum_ft, opts_default.disabled_statuscolum_ft),
      callback = function()
         vim.opt_local.statuscolumn = ''
      end,
   })
end

return M
