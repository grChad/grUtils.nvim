<h1 align="center">Gr Utils</h1>

> Plugin de utilidades como cmp.opts.formatting, `StatusColumn` y más.


## Instalar

Con [Lazy](https://github.com/folke/lazy.nvim):

```lua
{ 'grChad/grUtils.nvim', lazy = false },
```

Con [Packer](https://github.com/wbthomason/packer.nvim):

```lua
use { 'grChad/statusbar.nvim' }
```

## Uso:
#### setup StatusColumn

Opciones por defecto. Puedes modificar parcial o totalmente todas las opciones.

```lua
local grUtils = require('gr-utils')
grUtils.statuscolumn.setup({
   disabled_statuscolum_ft = {
      'alpha', 'dashboard', 'NvimTree', 'dashboard', 'Outline', 'help', 'lspinfo',
      'packer', 'qf', 'startify', 'startuptime', 'vimfiler', 'vimhelp', 'viminfo',
      'undotree', 'lazy', 'mason', 'TelescopePrompt', 'Telescope', 'toggleterm',
   },
   ignore_fold_ft = {}, -- example {'markdown', 'text'}
})
```

#### Formatting Cmp

Configurar dentro de `hrsh7th/nvim-cmp`

```lua
local cmp = require('cmp')
cmp.setup({
    --- other code
    formatting = { format = require('gr-utils').cmp_format },
})
```

#### Toggle Bolean

Una funcion que alterna valores como:
```lua
{ 'true', 'false' }
{ 'yes', 'no' }
{ 'on', 'off' }
```

Se puede usar junto con un atajo de teclado:
```lua
vim.keymap.set ('n', '<leader>b', "<cmd>lua require('gr-utils').toggle_bool()<CR>", { desc = 'Toggle boolean' })
```

#### Search

Para buscar coincidencias y enumerarlo, Tambien se puede usar como atajo de teclado:

```lua
vim.keymap.set('n', '<leader>m', "<cmd>lua require('gr-utils').search.clear()<CR>", { silent = true, desc = 'no highlight' })
vim.keymap.set('n', 'n', 'nzz' .. "<cmd>lua require('gr-utils').search.run()<CR>", { desc = 'Next search' })
vim.keymap.set('n', 'N', 'Nzz' .. "<cmd>lua require('gr-utils').search.run()<CR>", { desc = 'Previous search' })
```

#### rename

Para renombrar variables Lsp, uso con atajo de teclado.

```lua
vim.keymap.set('<leader>re', "<cmd>lua require('gr-utils').rename.run()<CR>", {desc = 'rename variable'})
```
