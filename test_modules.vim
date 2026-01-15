" 测试脚本 - 验证所有 Lua 模块能正确加载

lua << EOF
-- 设置包路径
package.path = './lua/?/init.lua;./lua/?.lua;'..package.path

-- 测试加载所有模块
local modules_to_test = {
  'log_highlighting.config',
  'log_highlighting.utils',
  'log_highlighting.highlight',
  'log_highlighting.patterns',
  'log_highlighting.patterns.operators',
  'log_highlighting.patterns.constants',
  'log_highlighting.patterns.datetime',
  'log_highlighting.patterns.entities',
  'log_highlighting.patterns.syslog',
  'log_highlighting.patterns.xml',
  'log_highlighting.patterns.levels',
}

print("开始测试 Lua 模块加载...\n")

local success_count = 0
local fail_count = 0

for _, module_name in ipairs(modules_to_test) do
  local ok, result = pcall(require, module_name)
  if ok then
    print("✓ 成功加载: " .. module_name)
    success_count = success_count + 1
  else
    print("✗ 加载失败: " .. module_name)
    print("  错误: " .. tostring(result))
    fail_count = fail_count + 1
  end
end

print("\n测试结果:")
print("成功: " .. success_count)
print("失败: " .. fail_count)

if fail_count == 0 then
  print("\n所有模块加载成功！(^_^)v")
else
  print("\n有模块加载失败，需要修复！(￣へ￣)")
end
EOF

qa
