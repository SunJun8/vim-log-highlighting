# Vim Log Highlighting

![Log highlighting example](doc/screenshot.jpg)

## Overview

Provides syntax highlighting for generic log files in Vim/Neovim.

Some of the highlighted elements are:
- Dates and times
- Common log level keywords like ERROR, INFO, DEBUG
- Numbers, booleans and strings
- URLs and file paths
- IP and MAC addresses
- SysLog format columns
- XML Tags

**🎉 New: Lua implementation for Neovim with improved performance and extensibility!**



## Installation

### [VimPlug](https://github.com/junegunn/vim-plug)

Add `Plug 'mtdl9/vim-log-highlighting'` to your `~/.vimrc` and run `PlugInstall`.

### [Vundle](https://github.com/gmarik/Vundle.vim)

Add `Plugin 'mtdl9/vim-log-highlighting'` to your `~/.vimrc` and run `PluginInstall`.

### [Pathogen](https://github.com/tpope/vim-pathogen)

    $ git clone https://github.com/mtdl9/vim-log-highlighting ~/.vim/bundle/vim-log-highlighting

### Manual Install

Copy the contents of the `ftdetect` and `syntax` folders in their respective ~/.vim/\* counterparts.

### Neovim (Lua Implementation)

For Neovim users, the plugin now includes a native Lua implementation with improved performance:

1. Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
  'mtdl9/vim-log-highlighting',
  config = function()
    require('log_highlighting').setup()
  end
}
```

2. Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
use {
  'mtdl9/vim-log-highlighting',
  config = function()
    require('log_highlighting').setup()
  end
}
```

3. Manual setup in `init.lua`:
```lua
-- Add the plugin to runtime path
vim.opt.runtimepath:append('/path/to/vim-log-highlighting')

-- Initialize the plugin
require('log_highlighting').setup()
```



## Configuration

### Vim (Vim script)

Once installed, the syntax highlighting will be enabled by default for files ending with `.log` and `_log` suffixes.

By default only uppercase keywords are recognized as level indicators in the log files.
You can add additional log level keywords using the standard VIM syntax functions, for example by adding this to your `.vimrc` file:

```viml
" Add custom level identifiers
au rc Syntax log syn keyword logLevelError MY_CUSTOM_ERROR_KEYWORD
```

Likewise you can disable highlighting for elements you don't need:

```viml
" Remove highlighting for URLs
au rc Syntax log syn clear logUrl
```

### Neovim (Lua)

The Lua implementation provides a more flexible configuration system:

```lua
require('log_highlighting').setup({
  -- 自定义高亮组
  highlights = {
    logLevelError = { link = 'ErrorMsg' },
    logUrl = { link = 'Underlined' },
    -- 你也可以直接设置高亮属性
    logDate = { fg = '#00ff00', bold = true },
  },

  -- 启用/禁用特定模式
  enable = {
    operators = true,
    constants = true,
    datetime = true,
    entities = true,
    syslog = true,
    xml = true,
    levels = true,
  },

  -- 添加自定义模式
  custom_patterns = {
    my_custom_log = {
      pattern = 'MY_LOG:',
      highlight = 'Keyword',
    },
  },
})
```

#### Manual Refresh

If you need to manually refresh the highlighting:
```lua
require('log_highlighting').refresh()
```



## Related Projects

* VIM Built-in /var/log/messages highlighting
* [vim-log-syntax](https://github.com/dzeban/vim-log-syntax) by dzeban
* [vim-log4j](https://github.com/tetsuo13/Vim-log4j) by tetsuo13
* [ccze](https://github.com/cornet/ccze) by cornet
