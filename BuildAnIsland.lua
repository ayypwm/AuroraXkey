local TARGET_PLACE_ID = 101949297449238
local SCRIPT_URL      = "https://raw.githubusercontent.com/ayypwm/Aurorax1/main/AuroraXBeta.lua"

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local function log(tag, msg)
	print(string.format("[AuroraX][%s] %s", tostring(tag), tostring(msg)))
end

local function showKickCoreGUI()
	local old = CoreGui:FindFirstChild("AuroraX_KickUI")
	if old then old:Destroy() end

	local sg = Instance.new("ScreenGui")
	sg.Name = "AuroraX_KickUI"
	sg.ResetOnSpawn = false
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sg.Parent = CoreGui

	local blur = Instance.new("Frame")
	blur.BackgroundColor3 = Color3.fromRGB(0,0,0)
	blur.BackgroundTransparency = 0.3
	blur.Size = UDim2.new(1,0,1,0)
	blur.Parent = sg

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 420, 0, 140)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
	frame.BorderSizePixel = 0
	frame.Parent = sg

	local uiCorner = Instance.new("UICorner", frame)
	uiCorner.CornerRadius = UDim.new(0, 10)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.GothamBold
	title.TextSize = 22
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Text = "Unsupported Experience"
	title.Parent = frame

	local desc = Instance.new("TextLabel")
	desc.Size = UDim2.new(1, -40, 0, 60)
	desc.Position = UDim2.new(0, 20, 0, 60)
	desc.BackgroundTransparency = 1
	desc.Font = Enum.Font.Gotham
	desc.TextSize = 16
	desc.TextColor3 = Color3.fromRGB(200,200,200)
	desc.TextWrapped = true
	desc.Text = "AuroraX chỉ hỗ trợ Build an Island.\nBạn sẽ bị ngắt kết nối."
	desc.Parent = frame

	task.wait(1.5)
	pcall(function()
		if LocalPlayer then
			LocalPlayer:Kick("Unsupported experience (AuroraX supports Build an Island only)")
		end
	end)
end

local function loadAuroraX()
	log("INFO", "Tải script từ: " .. tostring(SCRIPT_URL))
	local ok, data = pcall(function()
		return game:HttpGet(SCRIPT_URL, false)
	end)

	if not ok or not data or #data < 50 then
		log("ERROR", "Không thể tải script hoặc dữ liệu rỗng.")
		return false
	end

	local ran, err = pcall(function()
		loadstring(data)()
	end)

	if not ran then
		log("ERROR", "Lỗi khi chạy script: " .. tostring(err))
		return false
	end

	log("SUCCESS", "AuroraX đã tải thành công")
	return true
end

pcall(function()
	local currentID = tonumber(game.PlaceId)
	log("INFO", "PlaceId hiện tại: " .. tostring(currentID))
	if currentID ~= TARGET_PLACE_ID then
		log("WARN", "Sai PlaceId — kick.")
		showKickCoreGUI()
		return
	end

	if not loadAuroraX() then
		log("WARN", "Không thể tải script chính. Kiểm tra link GitHub hoặc mạng.")
	end
end)
