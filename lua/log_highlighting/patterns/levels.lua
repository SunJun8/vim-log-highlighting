-- patterns/levels.lua - 日志级别关键字模式
-- 职责：定义所有日志级别关键字模式

local M = {}

-- 日志级别模式列表（按严重程度从高到低）
M.patterns = {
  -- Emergency（最高级）
  {
    name = 'logLevelEmergency',
    pattern = [=[\c\<EMERGENCY\>]=],
  },
  {
    name = 'logLevelEmergency',
    pattern = [=[\c\<EMERG\>]=],
  },
  -- Alert
  {
    name = 'logLevelAlert',
    pattern = [=[\c\<ALERT\>]=],
  },
  -- Critical
  {
    name = 'logLevelCritical',
    pattern = [=[\c\<CRITICAL\>]=],
  },
  {
    name = 'logLevelCritical',
    pattern = [=[\c\<CRIT\>]=],
  },
  {
    name = 'logLevelCritical',
    pattern = [=[\c\<FATAL\>]=],
  },
  -- Error
  {
    name = 'logLevelError',
    pattern = [=[\c\<ERROR\>]=],
  },
  {
    name = 'logLevelError',
    pattern = [=[\c\<ERR\>]=],
  },
  {
    name = 'logLevelError',
    pattern = [=[\c\<FAILURE\>]=],
  },
  {
    name = 'logLevelError',
    pattern = [=[\c\<SEVERE\>]=],
  },
  -- Warning
  {
    name = 'logLevelWarning',
    pattern = [=[\c\<WARNING\>]=],
  },
  {
    name = 'logLevelWarning',
    pattern = [=[\c\<WARN\>]=],
  },
  -- Notice
  {
    name = 'logLevelNotice',
    pattern = [=[\c\<NOTICE\>]=],
  },
  -- Info
  {
    name = 'logLevelInfo',
    pattern = [=[\c\<INFO\>]=],
  },
  -- Debug
  {
    name = 'logLevelDebug',
    pattern = [=[\c\<DEBUG\>]=],
  },
  {
    name = 'logLevelDebug',
    pattern = [=[\c\<FINE\>]=],
  },
  -- Trace（最低级）
  {
    name = 'logLevelTrace',
    pattern = [=[\c\<TRACE\>]=],
  },
  {
    name = 'logLevelTrace',
    pattern = [=[\c\<FINER\>]=],
  },
  {
    name = 'logLevelTrace',
    pattern = [=[\c\<FINEST\>]=],
  },
}

return M
