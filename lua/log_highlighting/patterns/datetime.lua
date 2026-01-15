-- patterns/datetime.lua - 日期时间模式
-- 职责：定义日期、时间、时区等模式

local M = {}

-- 日期时间模式列表
M.patterns = {
  -- ISO 8601 日期（带 T 分隔符）
  {
    name = 'logDate',
    pattern = [=[\d\d\d\d-\d\d-\d\dT]=], -- 2018-03-12T
  },
  -- 斜杠分隔的日期（日/月/年）
  {
    name = 'logDate',
    pattern = [=[\d\d\/\d\d\/\d\d\d\d\>]=], -- 12/03/2018
  },
  -- 斜杠分隔的日期（日/月缩写/年）
  {
    name = 'logDate',
    pattern = [=[\d\d\/\a\a\a\/\d\d\d\d\>]=], -- 12/Mar/2018
  },
  -- 8 位连续日期（年月日）
  {
    name = 'logDate',
    pattern = [=[^20\d\d\d\d\d\d\>]=], -- 20180312
  },
  -- 时间（HH:MM:SS）带可选毫秒和时区
  {
    name = 'logTime',
    pattern = [=[\d\d:\d\d:\d\d\(\.\d\{2,6}\)\?[ ]\?\([+-]\d\{2,4}\|Z\)\?\>]=], -- HH:MM:SS[.ms][TZ]
  },
  -- 时区
  {
    name = 'logTimeZone',
    pattern = [=[\([+-]\d\{2,4}\|Z\)\>]=], -- +0800, -05, Z
  },
  -- 日期中的日数（1-31）
  {
    name = 'logDateDay',
    pattern = [=[\s\zs\d\d\?\s]=], -- 用于匹配日期后的空格和日数
  },
}

return M
