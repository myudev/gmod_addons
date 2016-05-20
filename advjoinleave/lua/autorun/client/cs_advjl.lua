--[[
	Advanced Join & Leave Messages Supporting Sounds & GEOPIP for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]
local netMsgStr = "advjl_info"


-- TEST ME
local function AddText_Colorful ( text )
	local args = {}
	local coloring_happend = false
	for i=1, #text do
		local char = string.sub ( text , i, i )

		if char == "#" then
			local colend = i+7
			local color = string.sub ( text, i+1, i+6 )

			local r,g,b = tonumber ( "0x" .. string.sub(color, 1, 2) ), tonumber ( "0x" .. string.sub(color, 2, 3) ), tonumber ( "0x" .. string.sub(color, 3, 4) ) -- hu, hacky! 
			local iLastText = 0
			for ii=colend, #text do
				local charInner = string.sub ( text , ii, ii )
				if charInner == "#" then
					break
				else
					iLastText = ii
				end
			end
			table.insert ( args, Color(r,g,b,255) )
			table.insert ( args, string.sub(text, colend, iLastText) )
			coloring_happend = true
		end
	end

	if coloring_happend then
		chat.AddText ( unpack ( args ) )
	else
		chat.AddText ( text )
	end
	
end

net.Receive( netMsgStr, function( len )
	local data = net.ReadTable()
	if data then 
		AddText_Colorful ( data.msg )
		if not (data.playsound == "") then
			surface.PlaySound ( "advjl/" .. data.playsound )
		end
	end
end)
