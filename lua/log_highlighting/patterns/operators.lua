-- patterns/operators.lua - 运算符和标点符号模式
-- 职责：定义运算符、括号、空行等模式

local M = {}

-- 运算符和标点符号模式列表
-- 格式：{ name = 'group_name', pattern = 'vim_regex' }
M.patterns = {
  {
    name = 'logOperator',
    pattern = [=[[,=+\>-]]=], -- 逗号、等号、加号、大于号、连字符
  },
  {
    name = 'logBrackets',
    pattern = [=[[()\{\}\[\]]=], -- 左右方括号、圆括号、花括号（转义处理）
  },
  {
    name = 'logEmptyLines',
    pattern = [=[^$]=], -- 空行
  },
}

return M
