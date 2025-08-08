local keys = {
    ["Virt_weekTwEV7bt7hMwsUcDLS2mdlGsdXRfuqyS6"] = {time = 7, generatetime = "1754653852"},
    ["Virt_month8tum9R1PGtScDetpT6BNqm4iC9GPTa3c"] = {time = 30, generatetime = "1754653852"},
    ["Virt_weekiWbHSrDnPwNg9tAxlChH8JAwiPsi1BSH"] = {time = 7, generatetime = "1754653852"},
    ["Virt_forevermryPQo7NdExhWvE2bZ4DoVbqFXvllJMH"] = {time = -1, generatetime = "1754653852"},
    ["Virt_weeklfTXaN784NsZIC9M9esxaaBeMQmEbJZz"] = {time = 7, generatetime = "1754653852"},
    ["Virt_weekvLQZkUmDFn4WO1vNgCDjXZhIIMAdrGN1"] = {time = 7, generatetime = "1754653852"},
    ["Virt_week4Ou6mCjMEyO22r8TVNjX9DeEyGS9j0qP"] = {time = 7, generatetime = "1754653852"},
    ["Virt_foreverB7Rhrxzb4Dzq9Jpi7fCkmXuNfUY9tRhQ"] = {time = -1, generatetime = "1754653852"},
    ["Virt_forevermOcjZA1fwk9aXVN5TNVKUSODH9h6gzMu"] = {time = -1, generatetime = "1754653852"},
    ["Virt_foreverj2iAylYn5aah3tWOfT2ZteqCBxRAumEW"] = {time = -1, generatetime = "1754653852"},
}
--放你的卡密表变量
--local keys = loadstring(game:HttpGet("https://raw.githubusercontent.com/HKJQ3/WEKOXY/refs/heads/main/Key.lua"))()
local function validateKey(keys, key)
    local keyData = keys[key]
    if not keyData then
        return false,"无"
    end

    -- 永久卡密
    if keyData.time == -1 then
        return true,"inf"
    end

    -- 计算当前时间与卡密生成时间的差值（秒）
    local currentTime = os.time()
    local generateTime = os.time({year = tonumber(keyData.generatetime:sub(1, 4)),
                                  month = tonumber(keyData.generatetime:sub(6, 7)),
                                  day = tonumber(keyData.generatetime:sub(9, 10)),
                                  hour = tonumber(keyData.generatetime:sub(12, 13)),
                                  min = tonumber(keyData.generatetime:sub(15, 16)),
                                  sec = tonumber(keyData.generatetime:sub(18, 19))})
    local elapsedTime = currentTime - generateTime

    -- 将有效时间从天转换为秒
    local validTimeInSeconds = keyData.time * 24 * 60 * 60

    if elapsedTime < validTimeInSeconds then
        return true, (validTimeInSeconds - elapsedTime) / (24 * 60 * 60) .. "天" --返回成功和剩余时间
    else
        return false,"无"
    end
end

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/kkaaccnnbb/Logan/refs/heads/main/uiilb"))()

local win = UI:new("Virtual")

local uiTab1 = win:Tab("卡密系统", '4483345998')
local section = uiTab1:section("验证卡密", true)

-- 文本框用于输入卡密
local inputKey = ""
section:Textbox("请输入卡密", 'TextBoxfalg', "卡密", function(txt)
    inputKey = txt
end)

-- 添加验证按钮
section:Button("验证卡密", function()
    local success, message = validateKey(keys, inputKey)
    if success then
        warn("[验证成功] " .. message)  -- 成功信息
                wait(0)
        loadstring(game:HttpGet("https://github.com/HKJQ3/-script/raw/refs/heads/main/销毁"))()
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HKJQ3/WEKOXY/refs/heads/main/paid.lua"))()
    else
        warn("[验证失败] " .. message)  -- 失败信息
                wait(0)
        loadstring(game:HttpGet("https://github.com/HKJQ3/-script/raw/refs/heads/main/销毁"))()
    end
end)
section:Label("作者：小叶")
section:Label("漏洞修复者：Nova")
section:Label("技术支持者：Nova")
section:Label("没有卡密就找当时卖你脚本的那个人要")
section:Button("    ", function()
    local code = "https://discord.com/invite/AujFYRu5tQ"
    setclipboard(code)  -- 复制到剪贴板
end)
--[[-- 定义时间单位及其对应的时间值（以天为单位）
local timeUnits = {
    {unit = "day", time = 1},
    {unit = "week", time = 7},
    {unit = "month", time = 30},
    {unit = "forever", time = -1}  -- 假设 -1 表示永久
}

-- 生成随机字符串
local function generateRandomString(length)
    local chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    local randomString = ""
    for i = 1, length do
        local randomIndex = math.random(1, #chars)
        randomString = randomString .. string.sub(chars, randomIndex, randomIndex)
    end
    return randomString
end

-- 生成指定数量的卡密
local function spawnkeys(num)
    local keys = {}  -- 用于存储生成的卡密及其时间信息
    for i = 1, num do
        -- 随机选择一个时间单位
        local unit = timeUnits[math.random(#timeUnits)]
        -- 生成一个随机字符串，长度为32
        local randomString = generateRandomString(32)
        -- 构造卡密
        local key = "Virt_" .. unit.unit .. randomString
        -- 记录卡密的生成时间和有效时间
        keys[key] = {
            time = unit.time,  -- 有效时间（天）
            generatetime = os.time()  -- 当前时间（格式化为年月日时分秒）
        }
    end
    return keys
end

-- 格式化生成的卡密表为字符串
local function formatKeysTable(keysTable)
    local result = "local keys = {\n"
    for key, value in pairs(keysTable) do
        result = result .. '    ["' .. key .. '"] = {time = ' .. value.time .. ', generatetime = "' .. value.generatetime .. '"},\n'
    end
    result = result .. "}"
    return result
end

-- 示例：生成10个随机卡密
local numKeys = 10
local generatedKeys = spawnkeys(numKeys)

-- 打印格式化的字符串
local formattedKeys = formatKeysTable(generatedKeys)
setclipboard(formattedKeys)
]]
