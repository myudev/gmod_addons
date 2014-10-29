--[[
	Written by Fannney' or also known as MyU
	Contact:
	Skype: myudev
	Mail: myudev0@googlemail.com
	Steam: http://steamcommunity.com/id/fannney/
]]

local id_start_index = 0
local function FormatVector ( vec )
	return vec.x .. " " .. vec.y .. " " .. vec.z
end

local function SaveTheMess ( ply )
	local count = 0
	file.CreateDir ( "prop_spawns" )
	local name = "prop_spawns/" .. game.GetMap() .. "_" .. os.date("%H-%M-%S-%d-%m-%Y") .. ".txt"
	file.Write ( name, "PROP SPAWNS FOR " .. game.GetMap() .. " kindly presented by Fannney'\n" )
	file.Append ( name, "Just copy all values after this text in your map's vmf, keep in mind to set the index as high as you need to!\nThis tool is meant to be for expierenced mapper's who know what todo.\n")
	
	local undo_table = undo.GetTable()
	for k, v in pairs(undo_table) do
		for i=1,#v do
			if v[i]["Name"] == "Prop" then
				local ent = v[i]["Entities"][1]

				if IsValid(ent) then
					local modelname = ent:GetModel()
					local classname = ent:GetClass()
					local pos = ent:GetPos()
					local ang = ent:GetAngles()

					file.Append (name, "entity\n{\n")
						file.Append (name, "\t\"id\" \""..id_start_index.."\"\n")
						file.Append (name, "\t\"classname\" \""..classname.."\"\n")
						file.Append (name, "\t\"angles\" \""..FormatVector(ang).."\"\n")
						file.Append (name, "\t\"fademindist\" \"-1\"\n")
						file.Append (name, "\t\"fadescale\" \"1\"\n")
						file.Append (name, "\t\"model\" \""..modelname.."\"\n")
						file.Append (name, "\t\"skin\" \"0\"\n")
						file.Append (name, "\t\"solid\" \"6\"\n")
						file.Append (name, "\t\"origin\" \""..FormatVector(pos).."\"\n")	

						file.Append (name, "\teditor\n\t{\n")
							file.Append (name, "\t\t\"color\" \"255 255 0\"\n")
							file.Append (name, "\t\t\"visgroupshown\" \"1\"\n")
							file.Append (name, "\t\t\"visgroupautoshown\" \"1\"\n")
							file.Append (name, "\t\t\"logicalpos\" \"[0 0]\"\n")
						file.Append (name, "\t}\n")
					file.Append (name, "}\n")

					count = count + 1
					id_start_index = id_start_index + 1
				end
			end
			
		end
	end	

	ply:PrintMessage ( HUD_PRINTCONSOLE, "I just saved " .. count .. " props to your garry's mod folder in data/" .. name )

end

concommand.Add( "save_props", function( ply, cmd, args )
	if args[1] ~= nil then
		id_start_index = tonumber(args[1]) or 1
		SaveTheMess ( ply )
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "Please provide a start index of min. 1")
	end
end )
