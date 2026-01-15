-- patterns/entities.lua - 实体模式
-- 职责：定义 URL、域名、UUID、IP、MAC、文件路径等实体模式

local M = {}

-- 实体模式列表
M.patterns = {
  -- URL（协议://...）
  {
    name = 'logUrl',
    pattern = [=[[a-z]*:\/\/\S\+]=], -- http://, https://, ftp:// 等
  },
  -- 域名
  {
    name = 'logDomain',
    pattern = [=[\w\+\.\w\+\.\w\+]=], -- example.com, www.example.com
  },
  -- UUID（标准格式）
  {
    name = 'logUUID',
    pattern = [=[\w\{8}-\w\{4}-\w\{4}-\w\{4}-\w\{12}\>]=], -- 550e8400-e29b-41d4-a716-446655440000
  },
  -- IPv4 地址
  {
    name = 'logIPV4',
    pattern = [=[\d\{1,3}\(\.\d\{1,3}\)\{3}\>]=], -- 192.168.1.1
  },
  -- IPv6 地址（简化版）
  {
    name = 'logIPV6',
    pattern = [=[\x\{1,4}\(:\x\{1,4}\)\{7}\>]=], -- 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  },
  -- MAC 地址
  {
    name = 'logMACAddress',
    pattern = [=[\x\{2}\(:\x\{2}\)\{5}\>]=], -- 00:1A:2B:3C:4D:5E
  },
  -- 文件路径（Unix 风格）
  {
    name = 'logFilePath',
    pattern = [=[\/\w\+\(\/\w\+\)*]=], -- /path/to/file
  },
  -- 文件路径（Windows 风格）
  {
    name = 'logFilePath',
    pattern = [[\a\:\\\S\+]], -- C:\path\to\file
  },
}

return M
