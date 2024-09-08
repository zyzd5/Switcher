local Switcher = {}

Switcher.get_current_input_method = function()
	-- how can this command return nil if not running in mac...
	local handle = io.popen("im-select")
	local result = handle:read("*a")
	handle:close()
	return result
end

Switcher.set_input_method = function(input_method)
	os.execute("im-select " .. input_method)
end

Switcher.last_input_method = Switcher.get_current_input_method()

Switcher.InsertEnter_callback = function()
	Switcher.set_input_method(Switcher.last_input_method)
end

Switcher.switch_to_en = function()
	os.execute("im-select com.apple.keylayout.ABC")
end

Switcher.InsertLeave_callback = function()
	Switcher.last_input_method = Switcher.get_current_input_method()
	Switcher.switch_to_en()
end

Switcher.helloworld = function(name)
	print("helloworld")
end

Switcher.setup = function()
	vim.api.nvim_create_autocmd("InsertEnter", {
		callback = Switcher.InsertEnter_callback,
	})

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = Switcher.InsertLeave_callback,
	})

    _G.Switcher = Switcher
end

return Switcher
