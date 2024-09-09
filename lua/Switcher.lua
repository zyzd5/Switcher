local Switcher = {}
Switcher.last_input_method = nil

Switcher.get_current_input_method = function()
	local handle = io.popen("im-select")
	if handle then
		local result = handle:read("*a"):gsub("%s+", "")
		handle:close()
		Switcher.last_input_method = result
		return result
	else
		print("can not retrieve current input method")
		return nil
	end
end

Switcher.set_input_method = function(input_method)
	if input_method then
		os.execute("im-select " .. input_method)
	end
end

Switcher.InsertEnter_callback = function()
	if Switcher.last_input_method then
		Switcher.set_input_method(Switcher.last_input_method)
	end
end

Switcher.switch_to_en = function()
	os.execute("im-select com.apple.keylayout.ABC")
end

Switcher.InsertLeave_callback = function()
	Switcher.last_input_method = Switcher.get_current_input_method()
	if Switcher.last_input_method and Switcher.last_input_method ~= "com.apple.keylayout.ABC" then
		Switcher.switch_to_en()
	end
end

Switcher.setup = function()
	vim.api.nvim_create_autocmd("InsertEnter", {
		callback = Switcher.InsertEnter_callback,
	})

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = Switcher.InsertLeave_callback,
	})
end

Switcher.helloworld = function()
	print("helloworld")
end

Switcher.print_cur_input_method = function()
	print(Switcher.last_input_method)
end

return Switcher
