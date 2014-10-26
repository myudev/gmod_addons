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

function advjl_Debug(msg)
	--ServerLog ( "[ADVJL:] " .. msg .. "\n" )
end


function advjl_Initialize( )
	util.AddNetworkString ( netMsgStr )

	-- Add Sounds
	for i=1,#advjl_groups do

		if not advjl_groups [ i ].playsound == "" then resource.AddFile ( "sound/advjl/" .. advjl_groups [ i ].playsound ) end
		if not advjl_groups [ i ].leftsound == "" then resource.AddFile ( "sound/advjl/" .. advjl_groups [ i ].leftsound ) end

	end

	
end
hook.Add( "Initialize", "advjl_Initialize", advjl_Initialize )


function advjl_IsPlayerInGroup ( ply, group )
	local rank = ""
	if self.EV_GetRank then 
		rank = ply:EV_GetRank()
	elseif ULib then
		rank = ply:GetUserGroup()
	else
		rank = ply:GetNWString ( "UserGroup" )
	end
	return (rank==group) and true or false
end


function advjl_ShowJoinMessage ( ply, arrid, country )

	if not ply:IsValid() then return end

	if advjl_groups [ arrid ].playsound == "" and advjl_groups [ arrid ].messageformat == "" then return end -- we don't want anything from you :( !

	local plyNick = ply:Nick()
	local joinMSG = ""

	if country == nil then
		country = "ERR"
	end

	if advjl_groups [ arrid ].resolvecountry then
		joinMSG = string.format( advjl_groups [ arrid ].messageformat, plyNick, country ) -- with country 
	else
		joinMSG = string.format( advjl_groups [ arrid ].messageformat, plyNick ) -- without country
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

function advjl_ShowDisconnectMessage ( ply, arrid )

	if not ply:IsValid() then
		return
	end

	if advjl_groups [ arrid ].leftsound == "" and advjl_groups [ arrid ].messageformatdc == "" then return end -- we don't want anything from you :( !

	local plyNick = ply:Nick()
	local leftMsg = string.format( advjl_groups [ arrid ].messageformatdc, plyNick ) -- without country


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


function advjl_ProcessCountry ( ply, arrid )
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
					advjl_ShowJoinMessage ( ply, arrid, data [ "countryCode" ] ) -- finally!
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

function advjl_PreHandleJoinLeftMessage ( ply, joinleave )
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
