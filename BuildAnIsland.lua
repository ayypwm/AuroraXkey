local TARGET_PLACE_ID = 101949297449238
local SCRIPT_URL      = "https://raw.githubusercontent.com/ayypwm/Aurorax1/main/AuroraXBeta.lua"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function log(tag, msg)
	print(string.format("[AuroraX][%s] %s", tostring(tag), tostring(msg)))
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
		log("ERROR", "...: " .. tostring(err))
		return false
	end

	log("SUCCESS", "AuroraX Very good")
	return true
end

pcall(function()
	local currentID = tonumber(game.PlaceId)
	log("INFO", "PlaceId hiện tại: " .. tostring(currentID))
	if currentID ~= TARGET_PLACE_ID then
		log("WARN", "Sai PlaceId — kick.")
		pcall(function()
			if LocalPlayer then
				LocalPlayer:Kick("Unsupported experience (AuroraX supports Build an Island only)")
			end
		end)
		return
	end

	if not loadAuroraX() then
		log("Failed")
	end
end)
