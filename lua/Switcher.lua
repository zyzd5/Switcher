local Switcher = {}

Switcher.last_input_method = nil

Switcher.get_current_input_method = function()
	if not Switcher.last_input_method then
		local handle = io.popen("im-select")
		Switcher.last_input_method = handle:read("*a")
		handle:close()
	end
	return Switcher.last_input_method
end

Switcher.set_input_method = function(input_method)
	os.execute("im-select " .. input_method)
end

Switcher.InsertEnter_callback = function()
	if Switcher.last_input_method == nil then
		Switcher.last_input_method = Switcher.get_current_input_method()
	end
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
end

return Switcher
