--[[
	Advanced Join & Leave Messages Supporting Sounds & GEOPIP for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]
local iDefaultID = 0
local netMsgStr = "advjl_info"

if not advjl_msgdelay then
	include ( "ss_advjl_config.lua" )
end

local function advjl_Debug(msg)
	--ServerLog ( "[ADVJL:] " .. msg .. "\n" )
end


local function advjl_Initialize( )
	util.AddNetworkString ( netMsgStr )

	-- Add Sounds
	for i=1,#advjl_groups do

		if not (advjl_groups [ i ].playsound == "") then resource.AddFile ( "sound/advjl/" .. advjl_groups [ i ].playsound ) end
		if not (advjl_groups [ i ].leftsound == "") then resource.AddFile ( "sound/advjl/" .. advjl_groups [ i ].leftsound ) end

	end

	
end
hook.Add( "Initialize", "advjl_Initialize", advjl_Initialize )
advjl_Initialize()

local function advjl_GetPlayerGroup ( ply )
	local rank = ""
	if ply.EV_GetRank then 
		rank = ply:EV_GetRank()
	elseif ULib then
		rank = ply:GetUserGroup()
	else
		rank = ply:GetNWString ( "UserGroup" )
	end
	return rank
end

local function advjl_IsPlayerInGroup ( ply, group )
	return (advjl_GetPlayerGroup(ply)==group) and true or false
end


local function advjl_ShowJoinMessage ( ply, arrid, geo_data )

	if not ply:IsValid() then return end

	if advjl_groups [ arrid ].playsound == "" and advjl_groups [ arrid ].messageformat == "" then return end -- we don't want anything from you :( !

	local plyNick = ply:Nick()
	local joinMSG = advjl_groups [ arrid ].messageformat

	if geo_data == nil then
		geo_data = { -- Provide some data, even if it's failed (good for local loopback)
			zip     		=		"0",
			city    		=       "N/A",
			org    			=       "N/A",
			status  		=       "N/A",
			region  		=       "N/A",
			timezone        =       "N/A",
			regionName      =       "N/A",
			country 		=       "N/A",
			lon     		=       0,
			countryCode     =       "N/A",
			query   		=       "N/A",
			isp     		=       "N/A",
			as      		=       "N/A",
			lat     		=       0.0
		}
	end

	geo_data["playername"] = string.gsub(plyNick, "#", "")
	geo_data["steamid"] = ply:SteamID()
	geo_data["group"] = advjl_GetPlayerGroup(ply)
	ply.geo_dat_cached = geo_data
	for k,v in pairs(geo_data) do
		local match = "!"..k.."!"
		joinMSG = string.gsub( joinMSG, match, tostring(v), 1 ) 
	end


	-- finally we can tell them the good news ;)

	local infoTable = {
		msg = joinMSG,
		playsound = advjl_groups [ arrid ].playsound
	}

    for _, pl in pairs( player.GetAll ( ) ) do
    	if not advjl_sendtoownplayer and pl == ply then continue end -- skip own player if required.

    	net.Start ( netMsgStr )
    		net.WriteTable ( infoTable )
    	net.Send ( pl )
    end
end

local function advjl_ShowDisconnectMessage ( ply, arrid )

	if not ply:IsValid() then
		return
	end

	if advjl_groups [ arrid ].leftsound == "" and advjl_groups [ arrid ].messageformatdc == "" then return end -- we don't want anything from you :( !

	local plyNick = ply:Nick()
	local leftMsg = advjl_groups [ arrid ].messageformatdc



	for k,v in pairs(ply.geo_dat_cached) do
		local match = "!"..k.."!"
		leftMsg = string.gsub( leftMsg, match, tostring(v), 1 ) 
	end

	local infoTable = {
		msg = leftMsg,
		playsound = advjl_groups [ arrid ].leftsound
	}

    for _, pl in pairs( player.GetAll ( ) ) do
    	if pl == ply then continue end -- meh fuck it.

    	net.Start ( netMsgStr )
    		net.WriteTable ( infoTable )
    	net.Send ( pl )
    end
end

local function advjl_ProcessCountry ( ply, arrid )
	local plyAddr = ply:IPAddress ( )
	if plyAddr == "loopback" then return end -- singleplayer seession?

	local plyIP = string.Explode( ":", plyAddr )[ 1 ] -- give us finally his damn ip.

	-- ip-api, is extremely reliable im using it since i can think about it.
	http.Fetch( "http://ip-api.com/json/"..plyIP , 
		function ( data )
			-- Request was successful
			if string.len ( data ) > 5 then
				-- Make sure no corrupted data comes trough

				data = util.JSONToTable ( data ) -- it actually returns the data in json format

				if data [ "countryCode" ] then -- damn so much checking is going on
					advjl_ShowJoinMessage ( ply, arrid, data ) -- finally!
				else
					-- srsly ?
					advjl_ShowJoinMessage ( ply, arrid, nil ) -- finally all this for nothing!
				end
			end
		end
		,
		function ( err )
			-- Request was NOT successful f*** it!
			advjl_ShowJoinMessage ( ply, arrid, nil ) -- nope, a damn error
		end)
end

local function advjl_PreHandleJoinLeftMessage ( ply, joinleave )
	if not ply:IsValid() or ply:IsBot() then return end -- he left us or he's a bot :'(

	-- We could do this abit more elegant, dont we?
	for i=1,#advjl_groups do
		if advjl_groups [ i ].groupname == "" then
			iDefaultID = i
			continue -- skip default only custom group handling here
		end

		if advjl_IsPlayerInGroup ( ply, advjl_groups [ i ].groupname ) then
			
			if advjl_groups [ i ].resolvecountry then -- maaaan, need to get country first :(
				if joinleave then
					advjl_ProcessCountry ( ply, i, nil )
				else
					advjl_ShowDisconnectMessage ( ply, i )
				end
			else -- yeahy we're done !
				if joinleave then
					advjl_ShowJoinMessage ( ply, i, nil )
				else 
					advjl_ShowDisconnectMessage ( ply, i )
				end
			
			end 
			
			return -- gotcha 
		end
	end

	-- Fallback to the Default
	if advjl_groups [ iDefaultID ].resolvecountry then -- maaaan, need to get country first :(
		if joinleave then
			advjl_ProcessCountry ( ply, iDefaultID, nil )
		else
			advjl_ShowDisconnectMessage ( ply, iDefaultID )
		end
	else -- yeahy we're done !
		if joinleave then
			advjl_ShowJoinMessage ( ply, iDefaultID, nil )
		else
			advjl_ShowDisconnectMessage ( ply, iDefaultID )
		end
	end 



end

-- Hooks
local function advjl_PlayerJoin ( ply )
	timer.Simple( advjl_msgdelay, function() advjl_PreHandleJoinLeftMessage ( ply, true ) end )
end
hook.Add( "PlayerInitialSpawn", "advjl_PlayerJoin", advjl_PlayerJoin )

local function advjl_PlayerDisconnect ( ply )
	advjl_PreHandleJoinLeftMessage ( ply, false )
end
hook.Add( "PlayerDisconnected", "advjl_PlayerDisconnect", advjl_PlayerDisconnect )

