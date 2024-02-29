extends NinePatchRect

signal close_party_menu

# Arrow and menu item controls
var arrow_position: int = 0
@onready var select_arrow = $TextureRect
@onready var claire = $Claire_sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	select_arrow.position.y = -40
	select_arrow.position.x = 471
	claire.visible = false

# Function to handle input; you might call this from character_menu.gd
func handle_input(event):
	if event.is_action_pressed("ui_down"):
		arrow_position += 1  
		select_arrow.position.y = -40 + (arrow_position % 4) * 155
	elif event.is_action_pressed("ui_up"):
		if arrow_position == 0:
			arrow_position = 3
		else:
			arrow_position -= 1  
		select_arrow.position.y = -40 + (arrow_position % 4) * 155
	elif event.is_action_pressed("x"):
		emit_signal("close_party_menu")

func handle_party(arrow_position):
	match arrow_position:
		0:
			claire.visible = true
		1:
			claire.visible = false
		2:
			claire.visible = false
		3:
			claire.visible = false
