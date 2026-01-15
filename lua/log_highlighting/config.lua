-- config.lua - 配置管理模块
-- 职责：管理用户配置和默认配置

local M = {}

-- 默认配置
-- 遵循开闭原则：用户可通过 setup() 覆盖默认值，无需修改此模块
M.default_config = {
  -- 高亮组映射（用户可自定义）
  highlights = {
    -- 运算符
    logOperator = 'Operator',
    logBrackets = 'Delimiter',

    -- 常量
    logNumber = 'Number',
    logHexNumber = 'Number',
    logFloat = 'Float',
    logBoolean = 'Boolean',
    logNull = 'Constant',
    logString = 'String',

    -- 日期时间
    logDate = 'Identifier',
    logTime = 'Identifier',
    logTimeZone = 'Special',
    logDateDay = 'Number',

    -- 实体
    logUrl = 'Underlined',
    logDomain = 'String',
    logUUID = 'Constant',
    logIPV4 = 'Constant',
    logIPV6 = 'Constant',
    logMACAddress = 'Constant',
    logFilePath = 'String',

    -- Syslog
    logSysHostname = 'Identifier',
    logSysProcess = 'Function',

    -- XML
    logXmlTag = 'Function',
    logXmlTagName = 'Function',
    logXmlAttrib = 'Type',
    logXmlAttribValue = 'String',
    logXmlComment = 'Comment',
    logXmlCData = 'String',

    -- 日志级别
    logLevelEmergency = 'ErrorMsg',
    logLevelAlert = 'ErrorMsg',
    logLevelCritical = 'ErrorMsg',
    logLevelError = 'ErrorMsg',
    logLevelWarning = 'WarningMsg',
    logLevelNotice = 'Debug',
    logLevelInfo = 'Debug',
    logLevelDebug = 'Debug',
    logLevelTrace = 'Comment',
  },

  -- 启用/禁用特定模式（默认全部启用）
  enable = {
    operators = true,
    constants = true,
    datetime = true,
    entities = true,
    syslog = true,
    xml = true,
    levels = true,
  },

  -- 用户自定义模式（格式：{ pattern = 'regex', highlight = 'HighlightGroup' }）
  custom_patterns = {},
}

-- 当前配置（合并后的配置）
M.current_config = vim.deepcopy(M.default_config)

--- 合并用户配置到默认配置
--- @param user_config table 用户配置
--- @return table 合并后的配置
function M.merge_config(user_config)
  local merged = vim.deepcopy(M.default_config)

  if user_config then
    -- 合并 highlights
    if user_config.highlights then
      merged.highlights = vim.tbl_extend('force', merged.highlights, user_config.highlights)
    end

    -- 合并 enable
    if user_config.enable then
      merged.enable = vim.tbl_extend('force', merged.enable, user_config.enable)
    end

    -- 合并 custom_patterns
    if user_config.custom_patterns then
      merged.custom_patterns = user_config.custom_patterns
    end
  end

  M.current_config = merged
  return merged
end

--- 获取当前配置
--- @return table 当前配置
function M.get_config()
  return M.current_config
end

return M
