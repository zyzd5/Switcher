* DESCRIPTION
    * leaving `insert` mode for auto switch to english input method
    * entering `normal` mode for restore previous input method

* USAGE (with lazy.nvim)
```lua
return {
	"zyzd5/Switcher",
    enabled = true,
    event = "VeryLazy",
	config = function()
		require("Switcher").setup()
	end,
}
```

* DEPENDENCIES:
    * im-select
```bash
brew tap daipeihust/tap
brew install im-select
```

* TODO:
    * optional input_method name for not just only mac 
