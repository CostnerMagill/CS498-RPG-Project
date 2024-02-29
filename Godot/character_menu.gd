extends CanvasLayer

# select arrow object
@onready var select_arrow = $Control/NinePatchRect/TextureRect
var arrow_position: int = 0
# menu objects
@onready var menu = $Control/NinePatchRect
@onready var party_menu = $Control/party_menu

# menu state controls
enum menu_state {default, menu, party, inventory, options, save, exit}
var current_menu_state = menu_state.default

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	menu.visible = false
	party_menu.visible = false
	select_arrow.position.y = 50 + (arrow_position % 5) * 70

# Handles inputs for the menu
func _unhandled_input(event):
	match current_menu_state:
		menu_state.default:
			if(event.is_action_pressed("menu")):
				get_tree().paused = true
				menu.visible = true
				current_menu_state = menu_state.menu
		menu_state.menu:
			handle_menu(event)
		menu_state.party:
			party_menu.visible = true
		menu_state.inventory:
			menu.visible = false
		menu_state.options:
			menu.visible = false
		menu_state.save:
			menu.visible = false
		menu_state.exit:
			menu.visible = false





func handle_menu(event):
	if event.is_action_pressed("menu") or event.is_action_pressed("x"):
		menu.visible = false
		current_menu_state = menu_state.default
		get_tree().paused = false
	elif event.is_action_pressed("ui_down"):
		if arrow_position == 4:
			arrow_position = 0
		else:
			arrow_position += 1
		select_arrow.position.y = 50 + (arrow_position % 5) * 70
	elif event.is_action_pressed("ui_up"):
		if arrow_position == 0:
			arrow_position = 4
		else:
			arrow_position -= 1
		select_arrow.position.y = 50 + (arrow_position % 5) * 70
	elif event.is_action_pressed("z"):
		match arrow_position:
			0, 1, 2, 3, 4: # Assuming all these positions lead to the party menu for simplicity
				menu.visible = false
				party_menu.visible = true
				current_menu_state = menu_state.party
