--[[
	Simple Report's for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]

local reports = {}
util.AddNetworkString ( "SRP_SENDREPORT" )
util.AddNetworkString ( "SRP_NEWREPORT" )
util.AddNetworkString ( "SRP_OPENMENU" )


function srp_Debug(msg)
	ServerLog ( "[SRP:] " .. msg .. "\n" )
end

function srp_IsAdmin ( ply )
	if not IsValid ( ply ) then 
		return false 
	end

	if ULib.ucl.query ( ply, "srp_access" ) then 
		return true 
	end	

	return false
end


function srp_SendToAdmins ( msg )
	local pls = player.GetAll()

	for i=1, #pls do
		if pls [ i ]:IsValid() then
			if srp_IsAdmin ( pls [ i ] ) then
				pls [ i ]:ChatPrint ( msg )
			end
		end
	end
end

function srp_SendNewReport ( tbl )
	local pls = player.GetAll()

	for i=1, #pls do
		if pls [ i ]:IsValid() then
			if srp_IsAdmin ( pls [ i ] ) then
				net.Start ( "SRP_NEWREPORT" )
					net.WriteTable ( tbl )
				net.Send ( pls [ i ] )
			end
		end
	end
end

function srp_OpenAdminMenu ( ply )
	net.Start ( "SRP_SENDREPORT" )
		net.WriteTable ( reports )
	net.Send ( ply )
end

function srp_ReceivePlayeReport ( len, ply )
	local typ = net.ReadBit ( )

	if typ == 1 then
		local reportedply = net.ReadEntity ( ) 
		local reason = net.ReadString ( )

		if reportedply:IsValid ( ) and ply:IsValid ( ) then
			reports [ #reports +1 ] = {ply, reportedply, reason, #reports+1}
			srp_SendNewReport ( reports [ #reports ] )
		end
	else
		-- Custom Report 
		local reason = net.ReadString ( ) 
		local information = net.ReadString ( )

		if reason and information then
			reports [ #reports +1 ] = {nil, ply, reason, #reports+1, information}
			srp_SendNewReport ( reports [ #reports ] )
		end

	end

end

net.Receive ( "SRP_SENDREPORT", srp_ReceivePlayeReport )

function srp_Initialize ( )
	
	resource.AddFile("sound/simplereports/newreport.wav")
	ULib.ucl.registerAccess( "srp_access", ULib.ACCESS_OPERATOR, "Gives the user the ability to show and process Reports.", "Simple Reports" )  
end
hook.Add( "Initialize", "srp_Initialize", srp_Initialize )


-- Commands 


function srp_concmd_report( ply )
	net.Start ( "SRP_OPENMENU" )
	net.Send ( ply )
end
concommand.Add( "srp_report", srp_concmd_report )


function srp_concmd_remove( ply, _, args )
	if not srp_IsAdmin( ply ) then
		sn_SendMsg ( ply, "You do not have the sufficient permissions for this command.")
		return
	end
	
	if not args[ 1 ] then
		sn_SendMsg ( ply, "Arguments: srp_remove <id>" )
		return
	end

	local id = tonumber(args[ 1 ])
	if id ~= nil and id ~= -1 then
		srp_SendToAdmins ( ply:Nick() .. " solved a Report!" )
		table.remove ( reports, id )

		ply:ConCommand ( "srp_reports" ) -- reopen menu
	end

end
concommand.Add( "srp_remove", srp_concmd_remove )

function srp_concmd_remove( ply )
	if not srp_IsAdmin( ply ) then
		sn_SendMsg ( ply, "You do not have the sufficient permissions for this command.")
		return
	end

	srp_OpenAdminMenu ( ply )
end
concommand.Add( "srp_reports", srp_concmd_remove )
--