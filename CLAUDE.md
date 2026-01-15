# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Vim/Neovim syntax highlighting plugin for generic log files. It provides comprehensive highlighting for log elements including dates, times, log levels, URLs, IP addresses, file paths, XML tags, and more.

## Repository Structure

```
.
├── ftdetect/log.vim      # File type detection - triggers for .log, *_log files
├── syntax/log.vim        # Main syntax definitions and highlighting rules
├── doc/                  # Documentation and screenshots
└── README.md             # User-facing documentation
```

## Architecture

### Syntax Definition Organization

The `syntax/log.vim` file is organized into logical sections using commented separators:

1. **Operators** (lines 14-21): Basic punctuation and separators
2. **Constants** (lines 24-37): Numbers, booleans, null values, strings
3. **Dates and Times** (lines 40-55): Multiple date/time formats with timezone support
4. **Entities** (lines 58-68): URLs, domains, UUIDs, IP/MAC addresses, file paths
5. **Syslog Columns** (lines 71-75): Syslog-specific hostname/program/patterns
6. **XML Tags** (lines 78-89): XML/HTML elements and CDATA sections
7. **Levels** (lines 92-102): Log level keywords (ERROR, INFO, DEBUG, etc.)
8. **Highlight Links** (lines 105-153): Maps syntax groups to Vim highlight groups

### Key Pattern: `nextgroup` and `contained`

The syntax file uses Vim's `nextgroup` and `contained` mechanisms to create chained matches:

- `logTime` uses `nextgroup=logTimeZone,logSysColumns` to chain timezone matches
- `logDate` uses `nextgroup=logDateDay` for day-of-month matching
- `logSysColumns` contains `logSysProcess` which contains `logNumber` and `logBrackets`

This hierarchical containment allows for precise, contextual highlighting.

### File Type Detection

The `ftdetect/log.vim` file uses `autocmd` patterns to detect log files by extension:
- `*.log` and `*.LOG` (case-sensitive)
- `*_log` and `*_LOG` suffixes

## Development Guidelines

### Adding New Syntax Rules

When adding new syntax patterns:

1. **Place rules in the appropriate section** based on the categorized structure
2. **Use appropriate Vim highlight groups** from the standard palette:
   - `Number`, `Float`, `Boolean`, `String`, `Constant` for data types
   - `Identifier`, `Function`, `Type`, `Operator` for code elements
   - `ErrorMsg`, `WarningMsg`, `Debug`, `Comment` for diagnostics
3. **Add highlight link** in the "Highlight links" section mapping your syntax group to a Vim highlight group
4. **Use `contained`** for groups that should only match inside other regions
5. **Use `nextgroup`** when patterns should chain together

### Syntax Rule Patterns

- Use `syn match` for pattern-based matching
- Use `syn keyword` for literal keywords (like log levels)
- Use `syn region` for multi-line patterns with start/end delimiters (like strings, comments)
- Use `display` modifier for performance on large files when appropriate
- Use `\@<=` (lookbehind) and `\@=` (lookahead) for zero-width assertions

### Testing Syntax Changes

To test syntax changes:

1. Copy modified files to `~/.vim/` directories:
   ```bash
   cp ftdetect/log.vim ~/.vim/ftdetect/
   cp syntax/log.vim ~/.vim/syntax/
   ```

2. Open a log file in Vim: `vim somefile.log`

3. Reload syntax: `:syntax on` or `:e`

4. Check syntax groups: Place cursor on highlighted text and run `:syn stack <line_number>`

### User Customization

Users can extend the syntax via `.vimrc`:

```viml
" Add custom log level keywords
au rc Syntax log syn keyword logLevelError MY_CUSTOM_ERROR

" Remove unwanted highlighting
au rc Syntax log syn clear logUrl
```

The `au rc Syntax log` pattern ensures these customizations apply after the base syntax is loaded.

## Common Tasks

### Add a new log level keyword

Add the keyword to the appropriate level group in the "Levels" section (lines 92-102):
```vim
syn keyword logLevelError NEW_ERROR_KEYWORD
```

### Add a new date/time format

Add a `syn match` pattern in the "Dates and Times" section (lines 40-55):
```vim
syn match logDate 'your_pattern_here'
```

### Adjust entity matching

Entity patterns are in the "Entities" section (lines 58-68). Be careful with regex specificity to avoid false positives.
