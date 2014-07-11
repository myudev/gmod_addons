--[[
	Advanced Join & Leave Messages Supporting Sounds & GEOPIP for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]
local netMsgStr = "advjl_info"

--[[
-- TEST ME
concommand.Add("test",function( ply )

	local args = {}

	-- Color formating
	local joinMSG = "#FFFFFF[#9C7878JOIN:#FFFFFF] Fannney our shiny Owner from [DE] connected!"
	local CStart,CEnd = 0,0
	local CLastEnd = 0
	local iteration = 0

	for i=1, #joinMSG do
		local char = string.sub ( joinMSG , i, i )

		if char == "#" then

			print ( "Found color for " .. char .. " adding! ")

			CStart = i
			CEnd = i+6

			local color = string.sub ( joinMSG, CStart+1, CEnd )
			print ( "Color is: " .. color)
			local r,g,b = tonumber ( "0x" .. string.sub(color, 1, 2) ), tonumber ( "0x" .. string.sub(color, 2, 3) ), tonumber ( "0x" .. string.sub(color, 3, 4) ) -- hu, hacky! 

			print("\n")
			print("Parsing from " .. CStart .. " to " .. CEnd)

			table.insert ( args, string.sub ( joinMSG, CEnd, CStart - 1 ) )
			table.insert ( args, Color(r,g,b,255) )
			table.insert ( args, string.sub ( joinMSG, CEnd+1, -1  ) )

			print ("Parse (" .. string.sub ( joinMSG, CEnd, CStart - 1 ) .. ") to ("..string.sub ( joinMSG, CEnd+1, -1  )..")")


			iteration = iteration +1
		end

	end

--	PrintTable ( args )

	--chat.AddText (unpack(args))

end)
--]]

net.Receive( netMsgStr, function( len )
	local data = net.ReadTable()
	if data then 
		chat.AddText ( Color(255,255,255,255), data.msg )
		if not data.playsound == "" then
			surface.PlaySound ( "sound/advjl/" .. data.playsound.playsound )
		end
	end
end)