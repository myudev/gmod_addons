--[[
	Advanced Join & Leave Messages Supporting Sounds & GEOPIP for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]

advjl_sendtoownplayer = true -- set the own player the information too.
advjl_msgdelay = 3 -- When it should send the message after Player connect (seconds)? usually you want to keep it at 3 seconds after join

advjl_groups = {
	-- groupname = The Name of the Group to play the sound and display it's join message (IF BLANK IT'S THE DEFAULT MESSAGE).
	-- playsound = The "Sound" Name in the sound/advjl Folder keep blank for NO sound.
	-- leftsound = The "Sound" Name in the sound/advjl Folder keep blank for NO sound.
	-- messageformat = The format of how the addon displays the join message example: "[MYSERVER:] %s joined our Server from [%s] welcome!" (!!IMPORTANT!!: If you dont enable resolvecountry just dont add the second "%s").
	-- resolvecountry = set to true if you want to show the country short code in the message example, "DE", "AUT", "DK" and so on. 
	-- messageformatdc = The format of how the addon displays the disconnect message IT DOES NOT SUPPORT RESOLVECOUNTRY for obvious reasons.
	-- INFO: If you let messageformat empty it won't send the message but still would play the sound, so if you want to disable it for a group just let palysound and messageformat blank.

	// Group: Superadmin
	{
		groupname="superadmin", 
		playsound="superadminjoin.wav", 
		leftsound="", 
		messageformat="[JOIN:] %s our shiny Owner from [%s] connected!", 
		messageformatdc="[DISCONNECT:] %s left us!", 
		resolvecountry=true
	},
	
	// Group Admin
	{
		groupname="admin", 
		playsound="adminjoin.wav", 
		leftsound="", 
		messageformat="[JOIN:] %s our shiny Admin from [%s] connected!", 
		messageformatdc="[DISCONNECT:] %s left us!", 
		resolvecountry=true
	},
	
	// Group Operator
	{
		groupname="operator", 
		playsound="opjoin.wav", 
		leftsound="",  
		messageformat="[JOIN:] %s our shiny Operator from [%s] connected!", 
		messageformatdc="[DISCONNECT:] %s left us!", 
		resolvecountry=true
	},

	// Default Group (everything expect these groups above)
	{
		groupname="", 
		playsound="", 
		messageformat="[JOIN:] %s connected to our Server from [%s] welcome!", 
		messageformatdc="[DISCONNECT:] %s left us!", 
		resolvecountry=true
	} -- DEFAULT MESSAGE JUST EDIT IF YOU NEED TO AND DONT ADD MULTIPLIE ONES OF THIS
}