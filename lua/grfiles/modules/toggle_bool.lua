local increment_map = {}

local generate = function(loop_list, capitalize)
   local do_capitalize = capitalize or false

   for i = 1, #loop_list do
      local current = loop_list[i]
      local next = loop_list[i + 1] or loop_list[1]

      increment_map[current] = next

      if do_capitalize then
         local capitalized_current = current:gsub('^%l', string.upper)
         local capitalized_next = next:gsub('^%l', string.upper)

         increment_map[capitalized_current] = capitalized_next
      end
   end
end

-- Booleanos
generate({ 'true', 'false' }, true)
generate({ 'yes', 'no' }, true)
generate({ 'on', 'off' }, true)

return function()
   local under_cursor = vim.fn.expand('<cword>')
   local match = false or increment_map[under_cursor]

   if match ~= nil then
      return vim.cmd(':normal ciw' .. match)
   end

   return vim.cmd(':normal!' .. vim.v.count .. '')
end
