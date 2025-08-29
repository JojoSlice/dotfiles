local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Font
config.font_size = 14
config.line_height = 1.2
config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "DemiLight" })

-- Appearance:
config.initial_cols = 100
config.initial_rows = 40
config.color_scheme = "rose-pine-moon"
config.default_cursor_style = "BlinkingBlock"
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_and_split_indices_are_zero_based = true

local colors = {
	-- Fönsterram / border
	border = "#191724", -- mörk bakgrundston

	-- Tabbar
	tab_bar_active_tab_fg = "#c4a7e7", -- lila/mauve-ish för aktiv tab
	tab_bar_active_tab_bg = "#191724", -- samma som fönsterbakgrund för kontrast
	tab_bar_text = "#6e6a86", -- text för inaktiva tabs
	tab_bar_background = "#191724", -- bakgrund för tab-bar

	-- Leader indikator
	arrow_foreground_leader = "#c4a7e7", -- lila/mauve
	arrow_background_leader = "#191724", -- samma som tab-bar background
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = " " .. tab.tab_index .. ": " .. tab_title(tab) .. " "
	local left_edge_text = ""
	local right_edge_text = ""

	if tab_style == "rounded" then
		title = tab.tab_index .. ": " .. tab_title(tab)
		title = wezterm.truncate_right(title, max_width - 2)
		left_edge_text = wezterm.nerdfonts.ple_left_half_circle_thick
		right_edge_text = wezterm.nerdfonts.ple_right_half_circle_thick
	end

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	-- title = wezterm.truncate_right(title, max_width - 2)

	if tab.is_active then
		return {
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = left_edge_text },
			{ Background = { Color = colors.tab_bar_active_tab_fg } },
			{ Foreground = { Color = colors.tab_bar_text } },
			{ Text = title },
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = right_edge_text },
		}
	end
end)

config.window_background_image = "C:/Users/Johan/Pictures/bakgrunder/yoru.gif"
config.window_background_opacity = 0.98
config.window_background_image_hsb = {
	brightness = 0.02,
	hue = 1.0,
	saturation = 1.0,
}

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()

	-- Hämta skärmstorlek
	local screen = wezterm.gui.screens().main
	local screen_width = screen.width
	local screen_height = screen.height

	-- Bestäm fönstrets storlek
	local ratio = 0.9
	local width = screen_width * ratio
	local height = screen_height * ratio
	gui_window:set_inner_size(width, height)

	-- Beräkna position för att centrera
	local xpos = (screen_width - width) / 2
	local ypos = (screen_height - height) / 2
	gui_window:set_position(xpos, ypos)
end)

config.default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" }
--Other:
config.max_fps = 120
--KeyBinds

config.keys = {
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "Tab",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "CTRL|SHIFT",
		key = "h",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL|SHIFT",
		key = "v",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL|SHIFT",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "CTRL|SHIFT",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "CTRL|SHIFT",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "CTRL|SHIFT",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "CTRL|SHIFT",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "CTRL|SHIFT",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "CTRL|SHIFT",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "CTRL|SHIFT",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
}

for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTab(i),
	})
end

return config
