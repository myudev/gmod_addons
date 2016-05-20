--[[
	Advanced Join & Leave Messages Supporting Sounds & GEOPIP for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]--

<<<<<<< HEAD
=======
advjl_sendtoownplayer = true -- set the own player the information too.
advjl_msgdelay = 3 -- When it should send the message after Player connect (seconds)? usually you want to keep it at 3 seconds after join
advjl_sleeponstart = 25 -- how many seconds after map start the plugin should mute sounds
>>>>>>> origin/advjoinleave

--[[
	Please read:
		The addon allows to add HTML Color codes to your message (#FF0000 for red, #FFFFFF for white and so on examples below)
		Also, it allows you to access a bunch of GEO-IP releated data limited to the JSON output of the API.

		You can add these things using the !name_of_the_value! specifier.
		
		Here's a list of available specifiers:
			GEO-IP Data:
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

			Player Data:
				!playername! 	- Player's name.
				!group! 		- Player's current group like "superadmin".
				!steamid! 		- Player's Steam ID like "STEAM_0:0:37706701".

<<<<<<< HEAD
	Some other stuff:
		You can keep the join messages empty to omit them.
]]--


advjl = {
	---- General Settings
	SkipOwnPlayer = false, -- This allows you to hide the message for the player that connects.
	MsgDelay = 3, -- How many seconds should the script wait before sending the connect message?
	API = "http://ip-api.com/json/", -- DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING (i hope caps helps)

	---- Group Settings
	groups = 
	{
		-- Admin Groups (example of multiplie groups)
		{
			groupnames = {"superadmin", "admin", "operator"}, -- Group(s) which will use the message.
			receivers = nil, -- This is a list of groups which will receive the messages.
			resolvegeodata = true, -- If you want to resolve geo data for this message (REQUIRED FOR GEO-IP RELEATED MESSAGES!)

			sounds = {
				join = "",
				leave = ""
			},

			messages = {
				join = "#FFFFFF[#9C7878JOIN:#FFFFFF] !playername! joined our server from #FFFFFF[#9C7878!countryCode!#FFFFFF]",
				leave = "#FFFFFF[#9C7878LEFT:#FFFFFF] !playername![!steamid!] left us."
			}
		},

		-- VIP Group (example of a single group)
		{
			groupnames = {"superadmin"}, -- Group(s) which will use the message.
			receivers = nil, -- This is a list of groups which will receive the messages.
			resolvegeodata = true, -- If you want to resolve geo data for this message (REQUIRED FOR GEO-IP RELEATED MESSAGES!)

			sounds = {
				join = "",
				leave = ""
			},

			messages = {
				join = "#FFFFFF[#9C7878VIP JOIN:#FFFFFF] Shiny, shiny !playername! joined our server from #FFFFFF[#9C7878!countryCode!#FFFFFF]",
				leave = "#FFFFFF[#9C7878VIP LEFT:#FFFFFF] !playername![!steamid!] left us."
			}
		},

		-- Default message if user is not in any group defined above ^
		{
			groupnames = nil, -- Group(s) which will use the message.
			receivers = nil, -- This is a list of groups which will receive the messages.
			resolvegeodata = true, -- If you want to resolve geo data for this message (REQUIRED FOR GEO-IP RELEATED MESSAGES!)

			sounds = {
				join = "",
				leave = ""
			},

			messages = {
				join = "#FFFFFF[#9C7878JOIN:#FFFFFF] !playername! joined our server from #FFFFFF[#9C7878!countryCode!#FFFFFF]",
				leave = "#FFFFFF[#9C7878LEFT:#FFFFFF] !playername![!steamid!] left us."
			}
		}
	}
}
=======
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
>>>>>>> origin/advjoinleave
