-- init.lua - 主入口模块
-- 职责：初始化插件、设置自动命令、协调所有模块

local M = {}

-- 加载依赖模块
local config = require('log_highlighting.config')
local patterns = require('log_highlighting.patterns')
local highlight = require('log_highlighting.highlight')
local utils = require('log_highlighting.utils')

-- 命名空间 ID
local ns_id = nil

--- 是否已初始化
local initialized = false

--- 应用语法高亮到缓冲区
--- @param bufnr number 缓冲区编号
--- @return nil
local function apply_syntax_highlights(bufnr)
  if not bufnr or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  -- 获取缓冲区的所有行
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local cfg = config.get_config()
  local all_patterns = patterns.get_all_patterns(cfg)

  -- 对每个模式进行匹配和高亮
  for _, pattern_def in ipairs(all_patterns) do
    local pattern_name = pattern_def.name
    local pattern_regex = pattern_def.pattern

    -- 在所有行中查找匹配
    local matches = utils.find_matches_multiline(lines, pattern_regex)

    -- 应用高亮
    for _, match in ipairs(matches) do
      local line_nr, col_start, col_end = unpack(match)
      utils.apply_highlight(bufnr, ns_id, pattern_name, line_nr, col_start, col_end)
    end
  end

  -- 添加用户自定义模式
  if cfg.custom_patterns then
    for custom_name, custom_def in pairs(cfg.custom_patterns) do
      local matches = utils.find_matches_multiline(lines, custom_def.pattern)
      for _, match in ipairs(matches) do
        local line_nr, col_start, col_end = unpack(match)
        utils.apply_highlight(bufnr, ns_id, custom_def.highlight, line_nr, col_start, col_end)
      end
    end
  end
end

--- 设置文件类型的自动命令
--- @return nil
local function setup_autocmds()
  local augroup = vim.api.nvim_create_augroup('LogHighlighting', { clear = true })

  -- 当文件类型为 log 时应用高亮
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = augroup,
    pattern = 'log',
    callback = function(opt)
      -- 先清除旧的高亮
      if ns_id then
        utils.clear_highlights(opt.buf, ns_id)
      end
      -- 应用新的高亮
      apply_syntax_highlights(opt.buf)
    end,
    desc = '应用日志高亮',
  })

  -- 当缓冲区内容改变时重新应用高亮（防抖）
  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
    group = augroup,
    pattern = '*.log',
    callback = function(opt)
      -- 只对 log 文件类型的缓冲区进行处理
      local filetype = vim.api.nvim_buf_get_option(opt.buf, 'filetype')
      if filetype == 'log' then
        -- 防抖：使用定时器延迟执行
        vim.defer_fn(function()
          utils.clear_highlights(opt.buf, ns_id)
          apply_syntax_highlights(opt.buf)
        end, 100)
      end
    end,
    desc = '日志内容改变时重新应用高亮',
  })
end

--- 设置插件（主入口函数）
--- @param user_config table 用户配置（可选）
--- @return nil
function M.setup(user_config)
  if initialized then
    return
  end

  -- 合并配置
  config.merge_config(user_config)

  -- 设置高亮链接
  highlight.setup_highlights()

  -- 获取命名空间
  ns_id = utils.get_namespace('log_highlighting')

  -- 设置自动命令
  setup_autocmds()

  initialized = true
end

--- 重新应用高亮（用户可手动调用）
--- @param bufnr number 缓冲区编号（可选，默认为当前缓冲区）
--- @return nil
function M.refresh(bufnr)
  if not bufnr or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  if filetype ~= 'log' then
    vim.notify('不是 log 文件类型', vim.log.levels.WARN)
    return
  end

  utils.clear_highlights(bufnr, ns_id)
  apply_syntax_highlights(bufnr)
end

return M
