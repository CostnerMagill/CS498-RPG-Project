extends CanvasLayer

# select arrow object
@onready var select_arrow = $Control/NinePatchRect/TextureRect
# menu object
@onready var menu = $Control

# menu state controls
enum menu_state {default, menu, party, inventory, options, save, exit}
var current_menu_state = menu_state.default

# Called when the node enters the scene tree for the first time.
func _ready():
	menu.visible = false

# Handles inputs for the menu
func _unhandled_input(event):
	match current_menu_state:
		menu_state.default:
			if(event.is_action_pressed("menu")):
				menu.visible = true
				current_menu_state = menu_state.menu
		menu_state.menu:
			if(event.is_action_pressed("menu") or event.is_action_pressed("x")):
				menu.visible = false
				current_menu_state = menu_state.default
