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
advjl_sleeponstart = 25 -- how many seconds after map start the plugin should mute sounds

advjl_groups = {
	-- groupname = The Name of the Group to play the sound and display it's join message (IF BLANK IT'S THE DEFAULT MESSAGE).
	-- playsound = The "Sound" Name in the sound/advjl Folder keep blank for NO sound.
	-- leftsound = The "Sound" Name in the sound/advjl Folder keep blank for NO sound.
	-- messageformat = The format of how the addon displays the join message.
	-- resolvecountry = set to true if you want to show the country information.
	-- messageformatdc = The format of how the addon displays the disconnect message it does support resolvecountry now ;)
	-- INFO: If you let messageformat empty it won't send the message but still would play the sound, so if you want to disable it for a group just let palysound and messageformat blank.

	--[[
		The 11/2/2014 Update:
			It now supports multicoloring! yeahy...
			It's simple to add multiplie colors, just use hex colors codes like "#FFFFFF" example is given, have fun.

			It _also_ now supports a huge amount of data being outputted in a nice way, everything valid inside of !NAME! will be replaced with the given text.

			Heres a list of outputs you have:
			GEO-IP releated:
				!zip! 			- Player's zip code, most likely it's empty.
				!country! 		- Player's country like "Germany".
				!countryCode! 	- Player's country code like "DE".
				!query! 		- The IP of the requested info.
				!city! 			- Player's city.
				!org! 			- Player's ISP organisation.
				!region! 		- Player's regions short code like "WEYWTIT" (ok abit shorter).
				!lat! 			- Player's latitude like "48.75".
				!timezone! 		- Player's timezone like "Europe/Berlin".
				!isp! 			- Player's ISP like "mediaways".
				!regionName! 	- Player's region name like "whateveryouwanttoinsethere".

				player releated:
				!playername! 	- Player's name.
				!group! 		- Player's current group like "superadmin".
				!steamid! 		- Player's Steam ID like "STEAM_0:0:37706701".
	]]--

	-- Group: Superadmin
	{
		groupname="superadmin", 
		playsound="", 
		leftsound="", 
		messageformat="#FFFFFF[#25DB00JOIN:#FFFFFF] !playername! joined our server from #FFFFFF[#25DB00!countryCode!#FFFFFF]", 
		messageformatdc="#FFFFFF[#DB0000LEFT:#FFFFFF] !playername![!steamid!] left us.", 
		resolvecountry=true
	},
	
	-- Group: Admin
	{
		groupname="admin", 
		playsound="", 
		leftsound="", 
		messageformat="#FFFFFF[#25DB00JOIN:#FFFFFF] !playername! joined our server from #FFFFFF[#25DB00!countryCode!#FFFFFF]", 
		messageformatdc="#FFFFFF[#DB0000LEFT:#FFFFFF] !playername![!steamid!] left us.", 
		resolvecountry=true
	},
	
	-- Group: Operator
	{
		groupname="operator", 
		playsound="", 
		leftsound="",  
		messageformat="#FFFFFF[#25DB00JOIN:#FFFFFF] !playername! joined our server from #FFFFFF[#25DB00!countryCode!#FFFFFF]", 
		messageformatdc="#FFFFFF[#DB0000LEFT:#FFFFFF] !playername![!steamid!] left us.", 
		resolvecountry=true
	},

	-- Default Group (everything expect these groups above)
	{
		groupname="", 
		playsound="", 
		leftsound="",
		messageformat="#FFFFFF[#25DB00JOIN:#FFFFFF] !playername! joined our server from #FFFFFF[#25DB00!countryCode!#FFFFFF]", 
		messageformatdc="#FFFFFF[#DB0000LEFT:#FFFFFF] !playername![!steamid!] left us.", 
		resolvecountry=true
	} -- DEFAULT MESSAGE JUST EDIT IF YOU NEED TO AND DONT ADD MULTIPLIE ONES OF THIS
}
