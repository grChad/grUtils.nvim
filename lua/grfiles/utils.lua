local icon_separator = require('statusbar.constants').icons.separator.line
local hl_separator = require('statusbar.constants').hl_groups.separator

local M = {}

---@param hl string
---@param str string
---@return string
M.txt = function(hl, str)
   str = str or ''
   local a = '%#' .. hl .. '#' .. str
   return a
end

---@param str_hl string
---@param func string
---@param arg? integer
---@return string
M.button = function(str_hl, func, arg)
   arg = arg or 0
   local arg_str = string.format('%s', arg)

   return '%' .. arg_str .. '@' .. func .. '@' .. str_hl .. '%X'
end

---@return string
M.separator = function()
   local str = icon_separator

   return M.txt(hl_separator, str)
end

---@return string
M.space = function()
   return M.txt(hl_separator, ' ')
end

---@param str string
---@param tbl string[]
---@return boolean
M.stringInTable = function(str, tbl)
   for _, value in ipairs(tbl) do
      if value == str then
         return true
      end
   end
   return false
end

---@param tbl1 table
---@param tbl2 table
---@return table<string>
M.combineTable = function(tbl1, tbl2)
   local unique_set = {}

   -- Agregar elementos de la primera tabla
   if tbl1 and type(tbl1) == 'table' then
      for _, value in ipairs(tbl1) do
         if type(value) == 'string' then
            unique_set[value] = true
         end
      end
   end

   -- Agregar elementos de la segunda tabla
   if tbl2 and type(tbl2) == 'table' then
      for _, value in ipairs(tbl2) do
         if type(value) == 'string' then
            unique_set[value] = true
         end
      end
   end

   -- Crear una tabla de resultados a partir del conjunto
   local result = {}
   for value in pairs(unique_set) do
      table.insert(result, value)
   end

   return result
end

---@param table_user? table
---@param table_default table
---@return table
M.selectTable = function(table_user, table_default)
   if table_user == nil then
      return table_default
   elseif type(table_user) ~= 'table' then
      return table_default
   end
   return table_user
end

---@param str_user? string
---@param str_default string
---@return string
M.selectStr = function(str_user, str_default)
   if str_user == nil then
      return str_default
   elseif str_user == '' then
      return str_default
   elseif type(str_user) ~= 'string' then
      return str_default
   end
   return str_user
end

---@param bool_use? boolean
---@param bool_default boolean
---@return boolean
M.selectBool = function(bool_use, bool_default)
   if bool_use == nil then
      return bool_default
   elseif type(bool_use) ~= 'boolean' then
      return bool_default
   end
   return bool_use
end

---@param icon string
---@param status integer
---@return string
M.gitStatusAndPad = function(icon, status)
   local blank = ''
   if status == nil then
      return blank
   elseif status == 0 then
      return blank
   end
   return M.trimAndPad(icon, 3) .. status
end

---@param str string
---@return string
M.trim = function(str)
   return str:match('^%s*(.-)%s*$') or ''
end

---@alias TrimAndPadOpts 2 | 3
---@param str string
---@param len TrimAndPadOpts
---@return string
M.trimAndPad = function(str, len)
   str = M.trim(str)

   if len == 2 then
      return str .. ' '
   elseif len == 3 then
      return ' ' .. str .. ' '
   else
      return str
   end
end

return M
