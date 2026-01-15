-- utils.lua - 工具函数模块
-- 职责：提供正则匹配和高亮应用的通用工具函数

local M = {}

--- 使用 vim.regex() 编译正则表达式（带缓存）
--- @param pattern string 正则表达式
--- @return table vim.regex 对象
local regex_cache = {}
function M.compile_regex(pattern)
  if not regex_cache[pattern] then
    regex_cache[pattern] = vim.regex(pattern)
  end
  return regex_cache[pattern]
end

--- 在单行文本中查找所有匹配项
--- @param line string 要搜索的行文本
--- @param pattern string 正则表达式
--- @return table 匹配项列表 { {start, end}, ... }
function M.find_matches(line, pattern)
  local regex = M.compile_regex(pattern)
  local matches = {}
  local start_idx = 0

  while true do
    local from, to = regex:match_str(line:sub(start_idx + 1))
    if not from then
      break
    end

    -- 转换为全局索引（from 和 to 是 0-based 的字节偏移）
    table.insert(matches, { start_idx + from, start_idx + to })
    start_idx = start_idx + to
  end

  return matches
end

--- 在文本中查找所有匹配项（支持多行）
--- @param lines table 行文本列表
--- @param pattern string 正则表达式
--- @return table 匹配项列表 { {line_nr, col_start, col_end}, ... }
function M.find_matches_multiline(lines, pattern)
  local matches = {}

  for line_nr, line in ipairs(lines) do
    local line_matches = M.find_matches(line, pattern)
    for _, match in ipairs(line_matches) do
      table.insert(matches, { line_nr - 1, match[1], match[2] }) -- line_nr 是 0-based
    end
  end

  return matches
end

--- 应用高亮到缓冲区
--- @param bufnr number 缓冲区编号
--- @param ns_id number 命名空间 ID
--- @param group string 高亮组名称
--- @param line number 行号（0-based）
--- @param col_start number 起始列（0-based）
--- @param col_end number 结束列（0-based）
function M.apply_highlight(bufnr, ns_id, group, line, col_start, col_end)
  vim.api.nvim_buf_add_highlight(bufnr, ns_id, group, line, col_start, col_end)
end

--- 批量应用高亮（优化性能）
--- @param bufnr number 缓冲区编号
--- @param ns_id number 命名空间 ID
--- @param highlights table 高亮列表 { {group, line, col_start, col_end}, ... }
function M.apply_highlights(bufnr, ns_id, highlights)
  for _, hl in ipairs(highlights) do
    M.apply_highlight(bufnr, ns_id, hl[1], hl[2], hl[3], hl[4])
  end
end

--- 清除缓冲区的高亮
--- @param bufnr number 缓冲区编号
--- @param ns_id number 命名空间 ID
--- @return nil
function M.clear_highlights(bufnr, ns_id)
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
end

--- 创建命名空间（带缓存）
--- @param name string 命名空间名称
--- @return number 命名空间 ID
local ns_cache = {}
function M.get_namespace(name)
  if not ns_cache[name] then
    ns_cache[name] = vim.api.nvim_create_namespace(name)
  end
  return ns_cache[name]
end

--- 设置高亮链接
--- @param from string 源高亮组
--- @param to string 目标高亮组
--- @return nil
function M.set_hl_link(from, to)
  vim.api.nvim_set_hl(0, from, {
    link = to,
    default = true, -- 使用 default 避免覆盖用户配置
  })
end

--- 批量设置高亮链接
--- @param links table { [group_name] = target_group, ... }
--- @return nil
function M.set_hl_links(links)
  for from, to in pairs(links) do
    M.set_hl_link(from, to)
  end
end

return M
