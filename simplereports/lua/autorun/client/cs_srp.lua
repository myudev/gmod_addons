--[[
	Simple Report's for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]

local srp_report_gui = nil
local srp_admin_gui = nil
local last_report_time = 0
surface.CreateFont( "label_font", { size = 16, weight = 600, font = "Tahoma"} )

local iBaseWidth = 350
local iBaseHeight = 300
local iSelectsHeight = 25

if not LOCAL then
	include ( "ss_srp_config.lua" )
end


function OpenAdminGUI ( len ) 
 
	if srp_admin_gui then
		srp_admin_gui:Remove ( ) 
		srp_admin_gui = nil
	end

	local reports = net.ReadTable ( ) 

	local iAdminBaseWidth = 600
	local iAdminBaseHeight = 300

	srp_admin_gui = vgui.Create( "DFrame" )
	srp_admin_gui:SetSize ( iAdminBaseWidth, iAdminBaseHeight )
	srp_admin_gui:Center ( )
	srp_admin_gui:SetTitle ( "Admin Panel - Simple Reports by Fannney'" )
	srp_admin_gui:SetVisible ( true )
	srp_admin_gui:SetDraggable ( true )
	srp_admin_gui:ShowCloseButton ( true )
	srp_admin_gui:MakePopup ( ) 

	srp_admin_gui.panel_container = vgui.Create( "DPanel", srp_admin_gui )
	srp_admin_gui.panel_container:SetPos(5,30)
	srp_admin_gui.panel_container:SetSize(iAdminBaseWidth, iAdminBaseHeight-30)
	srp_admin_gui.panel_container.Paint = function() end 

	srp_admin_gui.list = vgui.Create ( "DListView", srp_admin_gui.panel_container )
	srp_admin_gui.list:SetPos(0,0)
	srp_admin_gui.list:SetSize(iAdminBaseWidth-10, iAdminBaseHeight-35)	
	srp_admin_gui.list:AddColumn ( "##" ):SetFixedWidth ( 25 )
	local coln1 = srp_admin_gui.list:AddColumn ( "Reported Player" )
	local coln2 = srp_admin_gui.list:AddColumn ( "Reported By" )
	srp_admin_gui.list:AddColumn ( "Reason" )
	srp_admin_gui.list:SetMultiSelect ( false )
	srp_admin_gui.list.OnClickLine = function(parent, line, selected)
		local menu = DermaMenu()

		menu:SetPos(line:GetPos())
		menu:AddOption("Popout", 
			function() 
				local id = tonumber(line:GetValue(1)) or -1

				local tgui = vgui.Create( "DFrame" )
				tgui:SetSize ( 350, 200 )
				tgui:Center ( )
				tgui:SetTitle ( "Report against " .. line:GetValue(2) .. " by " .. line:GetValue(3) )
				tgui:SetVisible ( true )
				tgui:SetDraggable ( true )
				tgui:ShowCloseButton ( true )
				tgui:MakePopup ( ) 

				tgui.reason = vgui.Create( "DTextEntry", tgui )
				tgui.reason:SetPos ( 5, 30 )
				tgui.reason:SetSize ( 340, 165 )
				tgui.reason:SetText ( line:GetValue(4) )
				tgui.reason:SetMultiline ( true )
				tgui.reason:SetEditable ( false )

			end )
		menu:AddOption("Remove", 
			function() 
				local id = tonumber(line:GetValue(1)) or -1
				LocalPlayer():ConCommand( "srp_remove " .. id )
			end )
			
		local quickactions = menu:AddSubMenu( "Quick Actions" )
		
		-- Reported Player
		if line:GetValue(2) ~= "None" then
			quickactions:AddOption ( "Bring Reported Player" , function() 
				LocalPlayer():ConCommand ( "ulx bring \"" .. line:GetValue(2) .. "\"" )
			end)
		end
		if line:GetValue(2) ~= "None" then
			quickactions:AddOption ( "Goto Reported Player" , function() 
				LocalPlayer():ConCommand ( "ulx goto \"" .. line:GetValue(2) .. "\"" )
			end)
		end
		
		-- Reporting Player
		if line:GetValue(3) ~= "None" then
			quickactions:AddOption ( "Bring Reporting Player" , function() 
				LocalPlayer():ConCommand ( "ulx bring \"" .. line:GetValue(3) .. "\"" )
			end)
		end
	
		
		if line:GetValue(3) ~= "None" then
			quickactions:AddOption ( "Goto Reporting Player" , function() 
				LocalPlayer():ConCommand ( "ulx goto \"" .. line:GetValue(3) .. "\"" )
			end)
		end
	
		menu:Open()
	end
	
	for i=1,#reports do
		local id = reports [ i ][ 4 ] or 0
		local repPlayer = (reports [ i ][ 1 ] and reports [ i ][ 1 ]:IsValid()) and reports [ i ][ 1 ]:Nick() or "None"
		local repBy = (reports [ i ][ 2 ] and reports [ i ][ 2 ]:IsValid()) and reports [ i ][ 2 ]:Nick() or "None"
		local reason = reports [ i ][ 3 ] or ""
		local description = reports [ i ][ 5 ] or ""

		if not ( reports [ i ][ 1 ] and reports [ i ][ 1 ]:IsValid() ) then
			srp_admin_gui.list:AddLine ( id, repPlayer, repBy, "("..reason..":) ".. description )
		else
			srp_admin_gui.list:AddLine ( id, repPlayer, repBy, reason )
		end
	end

	-- Adjust Sizes
	local lines = srp_admin_gui.list:GetLines()
	local mostLen_1 = 8
	local mostLen_2 = 8
	for i=1,#lines do
		local len = string.len(lines [ i ]:GetValue(2))
		if len > mostLen_1 then
			mostLen_1 = len
		end

		local len = string.len(lines [ i ]:GetValue(3))
		if len > mostLen_2 then
			mostLen_2 = len
		end
	end

	coln1:SetFixedWidth ( mostLen_1 * 10 + 5 )
	coln2:SetFixedWidth ( mostLen_2 * 10 + 5 )
end 
net.Receive ( "SRP_SENDREPORT", OpenAdminGUI )

function OpenGUI ( len )
	if srp_report_gui then
		srp_report_gui:Remove ( ) 
		srp_report_gui = nil
	end


	srp_report_gui = vgui.Create( "DFrame" )
	srp_report_gui:SetSize ( iBaseWidth, iBaseHeight )
	srp_report_gui:Center ( )
	srp_report_gui:SetTitle ( "Simple Reports by Fannney'" )
	srp_report_gui:SetVisible ( true )
	srp_report_gui:SetDraggable ( true )
	srp_report_gui:ShowCloseButton ( true )
	srp_report_gui:MakePopup ( ) 

	srp_report_gui.panel_container = vgui.Create( "DPanel", srp_report_gui )
	srp_report_gui.panel_container:SetPos(5,30)
	srp_report_gui.panel_container:SetSize(iBaseWidth, iBaseHeight-30)
	srp_report_gui.panel_container.Paint = function() end 

	srp_report_gui.select_type = vgui.Create( "DComboBox", srp_report_gui.panel_container )
	srp_report_gui.select_type:SetSize( iBaseWidth-20, iSelectsHeight )
	srp_report_gui.select_type:SetPos( 5, 0 )
	srp_report_gui.select_type:SetValue ( LOCAL.SELECT_TYPE )
	srp_report_gui.select_type:AddChoice ( LOCAL.TYPE_PLAYER )
	srp_report_gui.select_type:AddChoice ( LOCAL.TYPE_MISC )
	srp_report_gui.select_type.OnSelect = function( panel, index, value )
		if index == 1 or index == 2 then
			GUIAddCustomFields ( index )
		end
	end



	srp_report_gui.fields = {}
end
net.Receive ( "SRP_OPENMENU", OpenGUI )

function SubmitPlayerReport ( ply, reason )

	if CurTime() >= last_report_time then
		net.Start ( "SRP_SENDREPORT" )
			net.WriteBit ( true )
			net.WriteEntity ( ply )
			net.WriteString ( reason )
		net.SendToServer ( )

		chat.AddText(Color(0,255,0), LOCAL.REPORT_SENT)
		
		last_report_time = CurTime() + report_cooldown
		return true
	else
		chat.AddText ( Color(255,0,0), LOCAL.WAIT_MSG )
		return false
	end
	
	return false
end

function SubmitCustomReport ( reason, information )
	if CurTime() >= last_report_time then
		net.Start ( "SRP_SENDREPORT" )
			net.WriteBit ( false )
			net.WriteString ( reason )
			net.WriteString ( information )
		net.SendToServer ( )

		chat.AddText(Color(0,255,0), LOCAL.REPORT_SENT)
		
		last_report_time = CurTime() + report_cooldown
		return true
	else
		chat.AddText ( Color(255,0,0), LOCAL.WAIT_MSG )
		return false
	end
	
	return false
end


function GUIAddCustomFields ( reporttype )
	if srp_report_gui.fields.panel_player then
		srp_report_gui.fields.panel_player:Remove ( ) 
		srp_report_gui.fields.panel_player = nil		
	end
	
	if srp_report_gui.fields.panel_misc then
		srp_report_gui.fields.panel_misc:Remove ( ) 
		srp_report_gui.fields.panel_misc = nil		
	end
	
	local function DoPlayerReportThings()
		local selected_player = nil
		local pls = player.GetAll()

		srp_report_gui.fields.panel_player = vgui.Create( "DPanel", srp_report_gui )
		srp_report_gui.fields.panel_player:SetPos(5,60)
		srp_report_gui.fields.panel_player:SetSize(iBaseWidth-10, iBaseHeight-70)
		srp_report_gui.fields.panel_player.Paint = function() end

		srp_report_gui.fields.panel_player.playerlist = vgui.Create( "DComboBox", srp_report_gui.fields.panel_player )
		srp_report_gui.fields.panel_player.playerlist:SetSize( iBaseWidth-20, iSelectsHeight )
		srp_report_gui.fields.panel_player.playerlist:SetPos( 5, 0 )
		srp_report_gui.fields.panel_player.playerlist:SetValue ( LOCAL.SELECT_PLAYER )
		srp_report_gui.fields.panel_player.playerlist.OnSelect = function( panel, index, value ) -- Better way? Documentation sucks...
			for i=1,#pls do
				if not pls [ i ]:IsValid() then
					continue
				end

				if pls [ i ] :Nick() == value then
					selected_player = pls [ i ]
					break
				end
			end
			
		end

		for i=1,#pls do
			srp_report_gui.fields.panel_player.playerlist:AddChoice ( pls [ i ]:Nick() )
		end

		srp_report_gui.fields.panel_player.labelreason = vgui.Create( "DLabel", srp_report_gui.fields.panel_player )
		srp_report_gui.fields.panel_player.labelreason:SetSize ( iBaseWidth-20, 25 )
		srp_report_gui.fields.panel_player.labelreason:SetPos ( 5, iSelectsHeight-1 )
		srp_report_gui.fields.panel_player.labelreason:SetText ( LOCAL.REASON_TEXT )
		srp_report_gui.fields.panel_player.labelreason:SetFont ( "label_font" )

		srp_report_gui.fields.panel_player.reasontext = vgui.Create( "DTextEntry", srp_report_gui.fields.panel_player )
		srp_report_gui.fields.panel_player.reasontext:SetPos ( 5, iSelectsHeight+20 )
		srp_report_gui.fields.panel_player.reasontext:SetSize ( iBaseWidth-20, 160 )
		srp_report_gui.fields.panel_player.reasontext:SetText ( LOCAL.DEFAULT_REASON )
		srp_report_gui.fields.panel_player.reasontext:SetMultiline ( true )

		
		srp_report_gui.fields.panel_player.buttonsend = vgui.Create( "DButton", srp_report_gui.fields.panel_player )
		srp_report_gui.fields.panel_player.buttonsend:SetPos ( 5, 210 )			
		srp_report_gui.fields.panel_player.buttonsend:SetSize ( iBaseWidth-20, 20 )
		srp_report_gui.fields.panel_player.buttonsend:SetText ( LOCAL.SEND_TEXT )
		srp_report_gui.fields.panel_player.buttonsend:SetFont ( "label_font" )
		srp_report_gui.fields.panel_player.buttonsend.DoClick = function()
			if selected_player and selected_player:IsValid() then
				local reason = srp_report_gui.fields.panel_player.reasontext:GetText()
				if reason == LOCAL.DEFAULT_REASON then
					chat.AddText(Color(255,0,0), LOCAL.NO_REASON)
					return
				end

				local len = string.len(reason)
				if len < 6 or len > 256 then
					chat.AddText(Color(255,0,0), LOCAL.INVALID_CHARS)
					return
				end


				if SubmitPlayerReport ( selected_player, reason ) then
					srp_report_gui:Remove ( )
					srp_report_gui = nil				
				end
			else
				chat.AddText(Color(255,0,0), LOCAL.UNKNOWN_PLAYER)
			end
		end	
	end
	
	local function DoMiscReportThings()
		local selected_reason = nil
		local pls = player.GetAll()

		srp_report_gui.fields.panel_misc = vgui.Create( "DPanel", srp_report_gui )
		srp_report_gui.fields.panel_misc:SetPos(5,60)
		srp_report_gui.fields.panel_misc:SetSize(iBaseWidth-10, iBaseHeight-70)
		srp_report_gui.fields.panel_misc.Paint = function() end

		srp_report_gui.fields.panel_misc.reasonList = vgui.Create( "DComboBox", srp_report_gui.fields.panel_misc )
		srp_report_gui.fields.panel_misc.reasonList:SetSize( iBaseWidth-20, iSelectsHeight )
		srp_report_gui.fields.panel_misc.reasonList:SetPos( 5, 0 )
		srp_report_gui.fields.panel_misc.reasonList:SetValue ( LOCAL.SELECT_REASON )
		srp_report_gui.fields.panel_misc.reasonList.OnSelect = function( panel, index, value ) selected_reason = value end

		for i=1,#PREDEF_REASONS do
			srp_report_gui.fields.panel_misc.reasonList:AddChoice ( PREDEF_REASONS [ i ] )
		end

		srp_report_gui.fields.panel_misc.reasonList:AddChoice ( LOCAL.TEXT_OTHER ) 


		srp_report_gui.fields.panel_misc.labelinfo = vgui.Create( "DLabel", srp_report_gui.fields.panel_misc )
		srp_report_gui.fields.panel_misc.labelinfo:SetSize ( iBaseWidth-20, 25 )
		srp_report_gui.fields.panel_misc.labelinfo:SetPos ( 5, iSelectsHeight-1 )
		srp_report_gui.fields.panel_misc.labelinfo:SetText ( LOCAL.INFO_TEXT )
		srp_report_gui.fields.panel_misc.labelinfo:SetFont ( "label_font" )

		srp_report_gui.fields.panel_misc.infotext = vgui.Create( "DTextEntry", srp_report_gui.fields.panel_misc )
		srp_report_gui.fields.panel_misc.infotext:SetPos ( 5, iSelectsHeight+20 )
		srp_report_gui.fields.panel_misc.infotext:SetSize ( iBaseWidth-20, 160 )
		srp_report_gui.fields.panel_misc.infotext:SetText ( LOCAL.DEFAULT_INFO )
		srp_report_gui.fields.panel_misc.infotext:SetMultiline ( true )
		
		srp_report_gui.fields.panel_misc.buttonsend = vgui.Create( "DButton", srp_report_gui.fields.panel_misc )
		srp_report_gui.fields.panel_misc.buttonsend:SetPos ( 5, 210 )			
		srp_report_gui.fields.panel_misc.buttonsend:SetSize ( iBaseWidth-20, 20 )
		srp_report_gui.fields.panel_misc.buttonsend:SetText ( LOCAL.SEND_TEXT )
		srp_report_gui.fields.panel_misc.buttonsend:SetFont ( "label_font" )
		srp_report_gui.fields.panel_misc.buttonsend.DoClick = function()
			if selected_reason then
				local information = srp_report_gui.fields.panel_misc.infotext:GetText()
				if information == LOCAL.DEFAULT_INFO then
					chat.AddText(Color(255,0,0), LOCAL.NO_INFORMATION)
					return
				end

				local len = string.len(information)
				if len < 6 or len > 256 then
					chat.AddText(Color(255,0,0), LOCAL.INVALID_CHARS)
					return
				end

				if SubmitCustomReport ( selected_reason, information ) then
					srp_report_gui:Remove ( )
					srp_report_gui = nil
				end

			else
				chat.AddText(Color(255,0,0), LOCAL.UNKNOWN_REASON)
			end
		end	

	end

	if reporttype == 1 then
		-- Player Report
		DoPlayerReportThings ( )
	elseif reporttype == 2 then
		DoMiscReportThings ( )
	end

end


-- Misc
if notification_message then
	function SendNotification()
		chat.AddText ( Color(255,0,0), "[SRP:] ", Color(255,255,255) , LOCAL.NOTIFICATION_MSG )
	end
	timer.Create( "srp_Notifications", notification_time, 0, SendNotification )
end

-- Recv
function srp_ReceiveNewReport ( len )
	local tbl = net.ReadTable ( )

	local repPlayer = (tbl [ 1 ] and tbl [ 1 ]:IsValid()) and tbl [ 1 ]:Nick() or nil
	local repBy = (tbl [ 2 ] and tbl [ 2 ]:IsValid()) and tbl [ 2 ]:Nick() or nil


	if repPlayer then
		chat.AddText ( Color(255,0,0), "[SRP:] " , Color(255,255,255) , string.format(LOCAL.REPORT_TEXT_PLAYER, repBy, repPlayer) )
	else
		chat.AddText ( Color(255,0,0), "[SRP:] " , Color(255,255,255) , string.format(LOCAL.REPORT_TEXT_CUSTOM, repBy, tbl [ 3 ]) )
	end

	

	if play_sound then 
		surface.PlaySound ( "buttons/button16.wav" )
	end
end

net.Receive ( "SRP_NEWREPORT", srp_ReceiveNewReport )