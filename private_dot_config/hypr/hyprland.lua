---@module 'hl'

-- Monitors
require("~/.config/hypr/monitors.lua")

hl.monitor({
	output = "desc:Technical Concepts Ltd Beyond TV 0x00010000",
	mode = "2560x1440@120.00",
	position = "auto",
	scale = 1.25,
})

-- Set programs that you use

local terminal = "ghostty"
local fileManager = "dolphin"
local screenshot = "flameshot gui"
local cursor_theme = "phinger-cursors-light"
local cursor_size = 32
local icon_theme = "Papirus"

--Environment variables

hl.env("XCURSOR_THEME", "phinger-cursors-light")
hl.env("XCURSOR_SIZE", 32)
hl.env("HYPRCURSOR_SIZE", 32)
hl.env("QT_CURSOR_THEME", "phinger-cursors-light")
hl.env("QT_CURSOR_SIZE", 32)
hl.env("TERMINAL", "ghostty")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
-- For styling
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Autostart
hl.on("hyprland.start", function()
	-- For styling
	hl.exec_cmd("hyprctl setcursor phinger-cursors-light 32")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme phinger-cursors-light")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 32")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
	-- Setting it via GUI doens't seem to work
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme Papirus")
	-- Manually start the portal for flameshot
	hl.exec_cmd("/usr/lib/xdg-desktop-portal")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("wayle shell")
	hl.exec_cmd("kwalletd6")
	hl.exec_cmd("flameshot")
	hl.exec_cmd("USE_LAYER_SHELL=0 vicinae server")
	hl.exec_cmd("pypr --debug /tmp/pypr.log")
	hl.exec_cmd("hyprpm reload & copyq --start-server")
	hl.exec_cmd("synology-drive")
	hl.exec_cmd("udiskie")
	hl.exec_cmd("emote")
	hl.exec_cmd("easyeffects -w")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("pika-backup-monitor")
	hl.exec_cmd("kdeconnect-indicator")
	hl.exec_cmd("kanata -c ~/.config/kanata/config.kbd")
	-- Autostart apps on login
	hl.exec_cmd("pear-desktop", { workspace = "1" })
	hl.exec_cmd("vivaldi --password-store=kwallet6", { workspace = "2" })
	hl.exec_cmd("obsidian", { workspace = "3" })
	hl.exec_cmd("code", { workspace = "6" })
end)

-- Exec (run every reload)
hl.on("config.reloaded", function()
	-- Apply stored nwg-look settings
	hl.exec_cmd("nwg-look -a")
end)

-- Look and feel
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 4,
		border_size = 2,
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
		snap = {
			enabled = true,
			border_overlap = false,
			respect_gaps = true,
		},
		col = {
			active_border = { colors = { "rgba(7dc4e4ee)", "rgba(a6da95ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
			-- For Pyprland only smh
			nogroup_border = "rgba(595959aa)",
			nogroup_border_active = { colors = { "rgba(7dc4e4ee)", "rgba(a6da95ee)" }, angle = 45 },
		},
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
		shadow = {
			enabled = false,
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			popups = true,
			noise = 0.015,
			contrast = 1,
			brightness = 1.5,
			vibrancy = 0.1,
			vibrancy_darkness = 1,
			-- ? Idk why this one is a bit lower
			popups_ignorealpha = 0.6,
		},
	},
})

local animation_speed = 2.5
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.config({
	animations = {
		enabled = true,
	},
})

hl.animation({ leaf = "windows", enabled = true, speed = animation_speed, bezier = "easeOutQuint" })
hl.animation({ leaf = "fade", enabled = true, speed = animation_speed, bezier = "easeOutQuint" })
hl.animation({ leaf = "layers", enabled = true, speed = animation_speed, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = animation_speed, bezier = "easeInOutCubic", style = "fade" })
hl.animation({
	leaf = "workspacesIn",
	enabled = true,
	speed = animation_speed,
	bezier = "easeInOutCubic",
	style = "slide",
})
hl.animation({
	leaf = "workspacesOut",
	enabled = true,
	speed = animation_speed,
	bezier = "easeInOutCubic",
	style = "slide",
})

hl.config({
	dwindle = {
		preserve_split = true,
		-- You probably want this
		smart_split = false,
	},
})

hl.config({
	misc = {
		-- Set to 0 or 1 to disable the anime mascot wallpapers
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,
		focus_on_activate = true,
		enable_swallow = true,
		swallow_regex = "(kitty|com.mitchellh.ghostty)$",
		layers_hog_keyboard_focus = false,
		initial_workspace_tracking = 0,
	},
})

hl.config({
	binds = {
		scroll_event_delay = 0,
	},
})

-- Input

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		focus_on_close = 1,
		mouse_refocus = true,
		-- -1.0 - 1.0, 0 means no modification.
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.5,
		},
	},
})

-- Gestures

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Devices
hl.device({
	name = "logitech-mx-master-3-1",
	sensitivity = -0.5,
	scroll_factor = 1,
})

hl.config({
	render = {
		new_render_scheduling = true,
	},
})

hl.config({
	cursor = {
		persistent_warps = true,
		no_hardware_cursors = 1,
	},
})

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

-- Plugins
package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")
smw.setup({
	workspace_count = 5,
	keep_focused = true,
	enable_persistent_workspaces = true,
	enable_wrapping = true,
	enable_notifications = false,
	max_workspaces = { ["DP-7"] = 2 },
})

hl.config({
	plugin = {
		dynamic_cursors = {
			enabled = true,
			mode = "stretch",
			threshold = 2,
			stretch = {
				limit = 3000,
				activation = "negative_quadratic",
				window = 100,
			},
			shake = {
				enabled = true,
				threshold = 5.0,
				base = 4.0,
				speed = 4.0,
				influence = 0.0,
				limit = 0.0,
				timeout = 1000,
				effects = true,
				ipc = false,
			},
			hyprcursor = {
				nearest = 1,
				enabled = true,
				resolution = -1,
				fallback = "clientside",
			},
		},
	},
})

-- Keybinds

local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("neovide"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + F", hl.dsp.window.float())
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd("vicinae toggle"))
-- dwindle
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
for _, dir in ipairs({ "left", "right", "up", "down" }) do
	hl.bind(mainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- Last two are for the third monitor
for i = 1, 12 do
	local key = i == 11 and "MINUS" or i == 12 and "EQUAL" or i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Switch workspaces with Tab
hl.bind(mainMod .. " + TAB", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + SHIFT + TAB", smw.cycle_workspaces("prev"))

-- Same but with mouse
hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + mouse_up", smw.cycle_workspaces("prev"))

-- Same but with arrows
hl.bind(mainMod .. " + CONTROL + right", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + CONTROL + left", smw.cycle_workspaces("prev"))

-- Logout and lock
hl.bind(
	"CONTROL + ALT + Delete",
	hl.dsp.exec_cmd(
		"wlogout -l "
		.. os.getenv("HOME")
		.. "/.config/wleave/layout.json -C "
		.. os.getenv("HOME")
		.. "/.config/wleave/style.css"
	)
)
hl.bind(mainMod .. " + " .. "L", hl.dsp.exec_cmd("hyprlock"))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))
hl.bind(mainMod .. " + " .. "HOME", hl.dsp.exec_cmd("flameshot gui"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- # Enable smart_split when positioning a window with the mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.exec_cmd("hyprctl keyword dwindle:smart_split 1"))
hl.bind(mainMod .. " + mouse:272", hl.dsp.exec_cmd("hyprctl keyword dwindle:smart_split 0"))

-- Move workspaces
local moves = {
	left = "-1",
	right = "+1",
}
for dir, offset in pairs(moves) do
	hl.bind(mainMod .. " + SHIFT + " .. dir, hl.dsp.window.move({ workspace = offset }))
end

-- Move monitors
for _, dir in ipairs({ "left", "right", "up", "down" }) do
	hl.bind(mainMod .. " + ALT + " .. dir, hl.dsp.window.move({ direction = string.sub(dir, 1, 1) }))
end

-- Kando
hl.bind("mouse:275", hl.dsp.global("kando:main-menu"))
hl.window_rule({
	name = "kando",
	match = {
		class = "kando",
	},
	no_blur = true,
	opaque = true,
	size = { "(monitor_w*1)", "(monitor_h*1)" },
	border_size = 0,
	no_anim = true,
	float = true,
	pin = true,
})

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -n1 set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -n1 set 5%-"), { locked = true })

-- Requires playerctl

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Binds specific to my laptop keyboard

hl.bind("CONTROL" .. " + " .. "F10", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("CONTROL" .. " + " .. "F11", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("CONTROL" .. " + " .. "F12", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind("F11", hl.dsp.window.fullscreen(), { locked = true })

-- Window rules

hl.window_rule({
	name = "ignore-maximize",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

-- YouTube fixed size
hl.window_rule({
	name = "pear-size",
	match = {
		class = "com.github.th-ch.youtube-music",
	},
	size = { 1200, 1000 },
	pseudo = true,
})

-- Stuff for CopyQ
hl.window_rule({
	name = "copyq-wr",
	match = {
		title = "^.*CopyQ.*$",
	},
	float = true,
	size = { 800, 400 },
	move = { "cursor_x", "cursor_y" },
})
hl.bind(mainMod .. " + " .. "V", hl.dsp.exec_cmd("copyq showAt"))

-- Stuff for Emote
hl.window_rule({
	name = "emote-wr",
	match = {
		title = "^.*emote.*$",
	},
	float = true,
	size = { 0, 0 },
	move = { "cursor_x", "cursor_y" },
})
hl.bind(mainMod .. " + " .. "period", hl.dsp.exec_cmd("emote"))

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "xwayland-dragging",
	match = {
		class = "^$",
		title = "^$",
		xwayland = 1,
		float = 1,
		fullscreen = 0,
		pin = 0,
	},
	no_focus = true,
})

-- Pyprland bind:
-- toggles the "term" scratchpad visibility
hl.bind("F12", hl.dsp.exec_cmd("pypr toggle term"))

hl.window_rule({
	name = "flameshot-handling",
	match = {
		class = "flameshot",
		title = "flameshot",
		fullscreen_state_client = 2,
	},
	animation = "fade",
	float = true,
	decorate = false,
	rounding = 0,
	center = true,
	fullscreen = false,
})

hl.window_rule({
	name = "flameshot-dialog-handling",
	match = {
		class = "flameshot",
		title = "flameshot",
		fullscreen_state_client = 0,
	},
	float = true,
	center = true,
})
hl.window_rule({
	name = "kde-connect",
	match = {
		class = "org.kde.kdeconnect.daemon",
	},
	animation = "fade",
	rounding = 0,
	border_size = 0,
	fullscreen_state = "0 3",
	float = true,
	pin = true,
	no_follow_mouse = true,
	monitor = 0,
})

-- For developing Flutter
hl.window_rule({
	name = "moniz",
	match = {
		class = "Moniz",
	},
	float = true,
	size = { 400, 800 },
})

-- Blur hyprpanel and other layers
blur_layers_rule = hl.layer_rule({
	name = "blur_layers",
	match = {
		namespace = "^(.*bar-.*|wayle.*|dms.*|notifications-window|indicator|.*menu.*|hyprshell*|logout_dialog|vicinae)",
	},
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.7,
})

hl.plugin.darkwindow.load_shader("chromakeyCatppuccin", {
	from = "chromakey",
	args = "bkg=[0.0235 0.1529 0.2275] similarity=0.25 targetOpacity=0.8",
	introduces_transparency = true,
})

blur_windows_rule = hl.window_rule({
	name = "blur_windows",
	match = {
		class =
		"^(md.obsidian.Obsidian|code|com.mitchellh.ghostty|neovide|com.github.th-ch.youtube-music|org.freedesktop.impl.portal.desktop.kde|org.kde.dolphin|org.kde.filelight|com.github.hluk.copyq|dev.zed.Zed|vicinae|emote|org.kde.gwenview|vesktop|slack)$",
	},
	["darkwindow:shade"] = "chromakeyCatppuccin",
})

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/hypr/toggle_blur.sh"))
