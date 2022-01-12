regonlyonweb = {}
regonlyonweb.players = {}
regonlyonweb.data = minetest.get_worldpath().."/blocked_regonlyonweb.txt"

regonlyonweb.state = true
if minetest.setting_get("regonlyonweb.state") == 'off' then
	regonlyonweb.state = false
end

-- This can be overridden with another function
function regonlyonweb:action(playername)
	if not regonlyonweb.state then return end

	disconnect_string = "Registration is only accepted for users who register for an account on the website."

	if regonlyonweb.players[playername] == 1 then
		minetest.after(0, function()
			minetest.kick_player(playername, disconnect_string)
		end)
		return disconnect_string
	end
end

function regonlyonweb:unblock_all()
	regonlyonweb.players = {}
	write_blocked_players()
end

local function write_blocked_players()
	local sdata = minetest.serialize(regonlyonweb.players)

	if not sdata then
		minetest.log("error", "No player object data")
		return
	end

	local file, err = io.open(regonlyonweb.data, "w")
	if err then return err end

	file:write(sdata)

	file:close()
end

local function read_blocked_players()
	local file, err = io.open(regonlyonweb.data, "r")
	if err then return err end

	local sdata = file:read("*a")
	file:close()

	regonlyonweb.players = minetest.deserialize(sdata)
end

function regonlyonweb:unblock(playername)
	if not playername then return end

	regonlyonweb.players[playername] = nil
	write_blocked_players()
end

function regonlyonweb:block(playername)
	if not playername then return end

	regonlyonweb.players[playername] = 1
	write_blocked_players()

	if minetest.get_player_by_name(playername) then
		regonlyonweb:action(playername)
	end
end

minetest.register_on_newplayer(function(player)
	local playername = player:get_player_name()
	regonlyonweb:block(playername)
	regonlyonweb:action(playername)
end)

minetest.register_on_prejoinplayer(function(playername, ip)
	-- If they are already in the block list, just get them here
	return regonlyonweb:action(playername)
end)

read_blocked_players()

dofile(minetest.get_modpath("regonlyonweb").."/commands.lua")
