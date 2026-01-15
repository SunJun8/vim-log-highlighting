-- patterns/xml.lua - XML/HTML 标签模式
-- 职责：定义 XML/HTML 标签、注释、CDATA 等模式

local M = {}

-- XML/HTML 模式列表
M.patterns = {
  -- 开始标签
  {
    name = 'logXmlTag',
    pattern = [=[<\w\+]=], -- <tag
  },
  -- 结束标签
  {
    name = 'logXmlTag',
    pattern = [=[<\/\w\+>]=], -- </tag>
  },
  -- 标签名
  {
    name = 'logXmlTagName',
    pattern = [=[<\zs\/\?\w\+\ze\>]=], -- <tag> 中的 tag
  },
  -- XML 属性名
  {
    name = 'logXmlAttrib',
    pattern = [=[\s\zs\w\+=], -- 属性名=
  },
  -- XML 属性值
  {
    name = 'logXmlAttribValue',
    pattern = [=[="[^"]*"]=], -- ="value"
  },
  -- XML 注释
  {
    name = 'logXmlComment',
    pattern = [=[<!--.*-->]=], -- <!-- comment -->
  },
  -- CDATA 节
  {
    name = 'logXmlCData',
    pattern = [=[<!\[CDATA\[.*\]\]>]=], -- <![CDATA[ ... ]]>
  },
}

return M
