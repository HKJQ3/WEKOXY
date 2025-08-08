local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()

--白名单--
local Players = game:GetService("Players")
local player = Players.LocalPlayer  -- 提前获取本地玩家对象

-- GitHub白名单文件的原始链接（替换为你的链接）
local githubWhitelistUrl = "https://raw.githubusercontent.com/HKJQ3/WEKOXY/refs/heads/main/whitelist.txt"

-- 存储从GitHub加载的白名单
local whitelist = {}

-- 从GitHub加载白名单的函数
local function loadWhitelistFromGitHub()
    -- 发送HTTP请求
    local success, response = pcall(function()
        return game:HttpGet(githubWhitelistUrl)
    end)
    
    if success then
        -- 解析文本：按换行分割成用户名列表（根据你的文件格式调整）
        whitelist = string.split(response,"\n")
    else
        warn("FUCK：" .. response)
    end
end

-- 检查用户是否在白名单中
local function isInWhitelist(username)
    for _, whitelistedUser in pairs(whitelist) do
        -- 去除用户名前后可能的空格和换行符
        if username == string.gsub(whitelistedUser, "%s", "") then
            return true
        end
    end
    return false
end

-- 定时检查白名单函数（间隔时间可自定义，这里设为60秒）
local function startWhitelistCheckLoop()
    while true do
        wait(0)  -- 每0秒检查一次
        loadWhitelistFromGitHub()  -- 重新加载最新白名单
        -- 检查当前用户是否仍在白名单中
        if not isInWhitelist(player.Name) then
            player:Kick("发生未知错误，已移除访问权限")
            break  -- 踢出后终止循环
        end
    end
end

-- 初始化：加载白名单并执行首次检查
loadWhitelistFromGitHub()

if not isInWhitelist(player.Name) then
    -- 非白名单用户处理（如踢出）
    NotificationLibrary:SendNotification("Success", "免费版加载成功", 4)
    wait(0)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HKJQ3/WEKOXY/refs/heads/main/free.lua"))()
else
    NotificationLibrary:SendNotification("Success", "付费版加载成功", 4)
    wait(0)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HKJQ3/WEKOXY/refs/heads/main/Procedure2%20cardsecret.lua"))()
    -- 启动定时检查循环
    spawn(startWhitelistCheckLoop)  -- 使用spawn单独开启线程，避免阻塞后续代码
end
--白名单--
local id = 93919985577380
local decalInterval = 0 -- 贴图循环间隔（注意：0秒间隔可能导致性能问题）

-- 启动贴图循环的协程
coroutine.wrap(function()
    while true do
        for i, v in pairs(workspace.PlayerModels:GetDescendants()) do
            if v.Name == "SetDECAL" then
                v:FireServer(id)
            end
        end
        wait(decalInterval)
    end
end)()

while true do
for i, v in pairs(workspace.PlayerModels:GetDescendants()) do
    if v.Name == "SetMSG" then
        local event = v
        local sign = v.Parent
        local message = sign.Settings.Message.Value or sign.Main.SurfaceGui.PlayerName.Text
        if message ~= "WEKO" then
            event:FireServer("WEKO")
        end
    end
end
    wait(0)
end
