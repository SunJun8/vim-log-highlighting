-- patterns/constants.lua - 常量模式
-- 职责：定义数字、布尔值、null、字符串等常量模式

local M = {}

-- 常量模式列表
M.patterns = {
  -- 整数
  {
    name = 'logNumber',
    pattern = [=[[0-9]\+]=], -- 一个或多个数字
  },
  -- 十六进制数
  {
    name = 'logHexNumber',
    pattern = [=[0[xX][0-9A-Fa-f]\+]=], -- 0x 或 0X 开头的十六进制
  },
  -- 浮点数
  {
    name = 'logFloat',
    pattern = [=[[0-9]\+\.[0-9]\+]=], -- 带小数点的数字
  },
  -- 布尔值
  {
    name = 'logBoolean',
    pattern = [=[\c\<\(true\|false\)\>]=], -- true 或 false（不区分大小写）
  },
  -- null 值
  {
    name = 'logNull',
    pattern = [=[\c\<null\>]=], -- null（不区分大小写）
  },
  -- 单引号字符串
  {
    name = 'logString',
    pattern = [=['[^']*']=], -- 单引号包围的字符串
  },
  -- 双引号字符串
  {
    name = 'logString',
    pattern = [=[="[^"]*"]=], -- 双引号包围的字符串
  },
}

return M
