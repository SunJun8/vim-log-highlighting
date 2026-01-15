-- patterns/init.lua - 模式聚合模块
-- 职责：聚合所有模式模块，提供统一的接口

local M = {}

-- 加载所有模式模块
local operators = require('log_highlighting.patterns.operators')
local constants = require('log_highlighting.patterns.constants')
local datetime = require('log_highlighting.patterns.datetime')
local entities = require('log_highlighting.patterns.entities')
local syslog = require('log_highlighting.patterns.syslog')
local xml = require('log_highlighting.patterns.xml')
local levels = require('log_highlighting.patterns.levels')

--- 获取所有模式（按类别分组）
--- @param config table 配置表（用于过滤启用的模式）
--- @return table 分组的模式表
function M.get_all_patterns(config)
  local enable = config and config.enable or {}
  local all_patterns = {}

  -- 只有在启用的情况下才添加模式
  if enableoperators ~= false then
    for _, pattern in ipairs(operators.patterns) do
      table.insert(all_patterns, pattern)
    end
  end

  if enable.constants ~= false then
    for _, pattern in ipairs(constants.patterns) do
      table.insert(all_patterns, pattern)
    end
  end

  if enable.datetime ~= false then
    for _, pattern in ipairs(datetime.patterns) do
      table.insert(all_patterns, pattern)
    end
  end

  if enable.entities ~= false then
    for _, pattern in ipairs(entities.patterns) do
      table.insert(all_patterns, pattern)
    end
  end

  if enable.syslog ~= false then
    for _, pattern in ipairs(syslog.patterns) do
      table.insert(all_patterns, pattern)
    end
  end

  if enable.xml ~= false then
    for _, pattern in ipairs(xml.patterns) do
      table.insert(all_patterns, pattern)
    end
  end

  if enable.levels ~= false then
    for _, pattern in ipairs(levels.patterns) do
      table.insert(all_patterns, pattern)
    end
  end

  return all_patterns
end

--- 获取所有模式的名称列表
--- @param config table 配置表
--- @return table 模式名称列表
function M.get_pattern_names(config)
  local patterns = M.get_all_patterns(config)
  local names = {}
  for _, pattern in ipairs(patterns) do
    table.insert(names, pattern.name)
  end
  return names
end

return M
