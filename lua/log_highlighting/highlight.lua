-- highlight.lua - 高亮映射模块
-- 职责：将语法组映射到 Vim 高亮组

local M = {}
local config = require('log_highlighting.config')

--- 应用高亮链接
--- @param user_config table 用户配置（可选）
--- @return nil
function M.setup_highlights(user_config)
  local cfg = config.merge_config(user_config)
  local highlights = cfg.highlights

  -- 遍历所有高亮配置并应用链接
  for group, target in pairs(highlights) do
    if type(target) == 'string' then
      -- 简单链接到目标高亮组
      vim.api.nvim_set_hl(0, group, {
        link = target,
        default = true,
      })
    elseif type(target) == 'table' then
      -- 自定义高亮属性
      vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', {
        default = true,
      }, target))
    end
  end
end

--- 获取高亮链接映射
--- @return table 高亮链接映射
function M.get_highlight_links()
  local cfg = config.get_config()
  return cfg.highlights
end

return M
