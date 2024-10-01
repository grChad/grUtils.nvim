local icons = {
   Array = ' ',
   Boolean = '󰨙 ',
   Class = ' ',
   Control = ' ',
   Collapsed = ' ',
   Constant = '󰏿 ',
   Constructor = ' ',
   Enum = ' ',
   EnumMember = ' ',
   Event = ' ',
   Field = '󰜢 ',
   File = '󰈙 ',
   Folder = '󰉋 ',
   Function = '󰊕 ',
   Interface = ' ',
   Key = ' ',
   Keyword = '󰌋 ',
   Method = '󰊕 ',
   Module = ' ',
   Namespace = '󰦮 ',
   Null = ' ',
   Number = '󰎠 ',
   Object = ' ',
   Operator = '󰆕 ',
   Package = ' ',
   Property = ' ',
   Reference = ' ',
   Snippet = ' ',
   String = ' ',
   Struct = '󰆼 ',
   Text = '󰉿 ',
   TypeParameter = ' ',
   Unit = '󰑭 ',
   Value = ' ',
   Variable = '󰀫 ',
   Color = '󰏘 ',
   Tailwind = '󰝤󰝤󰝤󰝤󰝤󰝤󰝤',

   -- IA autocompletion
   TabNine = '󰏚 ',
   Copilot = ' ',
   Codeium = ' ',
   Supermaven = ' ',
}

return function(entry, vim_item)
   local documentation = entry.completion_item.documentation
   local color

   if vim_item.kind == 'Color' and documentation then
      local _, _, r, g, b = string.find(documentation, '^rgb%((%d+), (%d+), (%d+))')

      -- condicional para buscar por rgb(r,g,b)
      if r and g and b then
         color = string.format('%02x%02x%02x', r, g, b)
      else
         color = documentation:gsub('#', '')
      end

      local group = 'Tw_' .. color

      if vim.api.nvim_call_function('hlID', { group }) < 1 then
         -- color debe tener 6 caracteres siempre
         vim.api.nvim_set_hl(0, group, { fg = '#' .. string.sub(color, 1, 6) })
      end

      vim_item.kind = icons.Tailwind
      vim_item.kind_hl_group = group

      return vim_item
   end

   vim_item.kind = vim_item.kind

   return vim_item
end
