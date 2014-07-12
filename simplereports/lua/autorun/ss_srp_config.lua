--[[
	Simple Report's for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]

lang = "EN" -- Language to use, please define it at the bottom of this file!
play_sound = true -- play sound if a report arrives?
report_cooldown = 5 -- how many seconds a user needs to wait to apply another report?
notification_message = true -- should players receive a message every (notification_time) seconds?
notification_time = 360


PREDEF_REASONS = { -- Reasons for the custom (nonplayer) report
	"Question",
	"Request",
	"Problem"
}

LOCAL_TEXT = {}

-- Languages
LOCAL_TEXT["EN"] = {

	NOTIFICATION_MSG = "This Server allows you to Report players by typing !report",

	SELECT_TYPE = "Select Type",
	TYPE_PLAYER = "Report Player",
	TYPE_MISC = "Send Message to Online Admins",
	SELECT_REASON = "Select any reason",
	NO_INFORMATION = "Please type in addiontial Information!",

	SELECT_PLAYER = "Select a Player",
	DEFAULT_REASON = "Please type in a reason, false reason will be warned!",
	REASON_TEXT = "Reason:",
	INFO_TEXT = "Information(s):",
	DEFAULT_INFO = "Please type in addiontial Information!",
	UNKNOWN_REASON = "Please select a reason, if it doesnt fits just select \"Other\"",

	SEND_TEXT = "SEND!",

	UNKNOWN_PLAYER = "Player does not exists or is not connected anymore.",

	NO_REASON = "Please type in an valid reason!",

	INVALID_CHARS = "The Reason length must be atleast 6 Characters long.",

	REPORT_SENT = "Report successfully sent, please wait for an Answer or an admin action!",
	TEXT_OTHER = "Other",

	REPORT_TEXT_PLAYER = "%s wrote an Report against %s type !reports to open them.",
	REPORT_TEXT_CUSTOM = "%s wrote an Report with the Reason: %s",
	
	WAIT_MSG = "You need to wait " .. report_cooldown .. " Seconds between your reports."
}
LOCAL_TEXT["DE"] = {

	NOTIFICATION_MSG = "Du kannst Spieler mit Hilfe von !report Melden, oder Admins eine Nachricht senden!",

	SELECT_TYPE = "Wähle eine Kategorie",
	TYPE_PLAYER = "Spieler Melden",
	TYPE_MISC = "Nachricht an Verfügbare Teammitglieder Senden",
	SELECT_REASON = "Wähle einen Grund",
	NO_INFORMATION = "Bitte fülle das Feld aus!",

	SELECT_PLAYER = "Wähle einen Spieler aus",
	DEFAULT_REASON = "Tippe hier einen detailierten Grund ein, Spam oder anderes wird Verwarnt!",
	REASON_TEXT = "Grund:",
	INFO_TEXT = "Informationen:",
	DEFAULT_INFO = "Bitte gebe zusätzliche Informatione an.",
	UNKNOWN_REASON = "Bitte wähle einen Grund aus, wenn keiner der Gründe passt wähle \"Anderes\"",

	SEND_TEXT = "Senden",

	UNKNOWN_PLAYER = "Spieler ist nicht mehr auf dem Server.",

	NO_REASON = "Bitte schreibe einen Grund!",

	INVALID_CHARS = "Der Grund muss mind. 6 Zeichen enthalten.",

	REPORT_SENT = "Report erfolgreich gesendet, bitte warte auf einen Antwort oder Aktion von einen Teammitglied",
	TEXT_OTHER = "Anderes",

	REPORT_TEXT_PLAYER = "%s wrote an Report against %s type !reports to open them.",
	REPORT_TEXT_CUSTOM = "%s wrote an Report with the Reason: %s",
	
	WAIT_MSG = "Du musst " .. report_cooldown .. " Sekunden warten."
}

-- Dont touch
LOCAL = LOCAL_TEXT[lang]