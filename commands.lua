minetest.register_privilege("regonlyonweb", "Allow configuring regonlyonweb")

local function tokenize(argstring)
	local args = {}
	
	for token in argstring:gmatch("[^%s]+") do
		args[#args+1] = token
	end

	return args
end

minetest.register_chatcommand("roow_unblockall", {
	description = "Unblock all players",
	privs = {regonlyonweb = true},
	func = function(caller, argstring)
		regonlyonweb:unblock_all()
	end,
})

minetest.register_chatcommand("roow_unblock", {
	description = "Unblock players",
	privs = {regonlyonweb = true},
	params = "<player1> <player2> ...",
	func = function(caller, argstring)
		local tokens = tokenize(argstring)
	
		for i = 1, #tokens do
			minetest.debug("regonlyonweb: "..caller.." unblocks "..tokens[i])
			regonlyonweb:unblock( tokens[i] )
		end
	end,
})

minetest.register_chatcommand("roow_block", {
	description = "",
	privs = {regonlyonweb = true},
	params = "<player1> <player2> ...",
	func = function(caller, argstring)
		local tokens = tokenize(argstring)
	
		for i = 1, #tokens do
			minetest.debug("regonlyonweb: "..caller.." blocks "..tokens[i])
			regonlyonweb:block( tokens[i] )
		end
	end,
})

local function setstate(caller, argstring, option)
	local tokens = tokenize(argstring)
	local value = tokens[1]

	if value == 'on' then
		regonlyonweb[option] = true
	elseif value == 'off' then
		regonlyonweb[option] = false
	end

	minetest.chat_send_player(caller, "regonlyonweb "..option..": "..tostring(regonlyonweb[option]) )
end

minetest.register_chatcommand("roow_state",{
	description = "",
	privs = {regonlyonweb = true},
	params = "{ on | off }",
	func = function(caller, argstring)
		setstate(caller, argstring, "state")
	end,
})
