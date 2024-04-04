extends NinePatchRect

signal close_options_menu

# Variable to store the non-fullscreen resolution
var windowed_resolution: Vector2
var window = get_window()

func _ready():
	# Initialize the windowed_resolution with the current window size()
	windowed_resolution = DisplayServer.window_get_size()

func handle_input(event):
	if event.is_action_pressed("z"):
		toggle_fullscreen()
	elif event.is_action_pressed("x"):
		emit_signal("close_options_menu")

func toggle_fullscreen():
	if DisplayServer.WINDOW_MODE_FULLSCREEN:
		# If currently in fullscreen, revert to windowed mode with the remembered resolution
		DisplayServer.window_set_size(windowed_resolution)
	else:
		# If currently in windowed mode, remember the resolution and switch to fullscreen
		window.mode = Window.MODE_FULLSCREEN
