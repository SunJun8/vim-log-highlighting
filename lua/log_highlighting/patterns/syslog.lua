-- patterns/syslog.lua - Syslog 特定模式
-- 职责：定义 Syslog 格式相关的模式（主机名、进程名等）

local M = {}

-- Syslog 模式列表
M.patterns = {
  -- Syslog 主机名
  {
    name = 'logSysHostname',
    pattern = [=[\s\zs\w\+\ze\s\w*:\d]=], -- 匹配主机名（后跟进程名:PID）
  },
  -- Syslog 进程名和 PID
  {
    name = 'logSysProcess',
    pattern = [=[\w\+:\d\+]=], -- 进程名:PID 格式
  },
}

return M
