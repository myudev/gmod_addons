--[[
	Simple Report's for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]

function ulx.report ( calling_ply )
	calling_ply:ConCommand("srp_report")
end

local reportcmd = ulx.command( "Simple Reports", "ulx report", ulx.report, "!report" )
reportcmd:defaultAccess( ULib.ACCESS_ALL )
reportcmd:help( "Opens the Menu to Report Players or sending of a custom one." )


function ulx.openreports ( calling_ply )
	calling_ply:ConCommand("srp_reports")
end

local openreportscmd = ulx.command( "Simple Reports", "ulx openreports", ulx.openreports, "!openreports" )
openreportscmd:defaultAccess( ULib.ACCESS_OPERATOR )
openreportscmd:help( "Opens the menu too see all current Reports." )