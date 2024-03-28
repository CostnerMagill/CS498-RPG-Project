extends NinePatchRect

signal close_party_menu

# Arrow and menu item controls
var arrow_position: int = 0
@onready var select_arrow = $TextureRect
@onready var claire = $Claire_sprite
@onready var etho = $Etho_sprite
@onready var flynn = $Flynn_sprite
@onready var kavya = $Kavya_sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	select_arrow.position.y = -40
	select_arrow.position.x = 548
	claire.visible = true
	etho.visible = false
	flynn.visible = false
	kavya.visible = false

# Function to handle input; you might call this from character_menu.gd
func handle_input(event):
	if event.is_action_pressed("ui_down"):
		arrow_position += 1  
		select_arrow.position.y = -40 + (arrow_position % 4) * 155
		handle_party(arrow_position)
	elif event.is_action_pressed("ui_up"):
		if arrow_position == 0:
			arrow_position = 3
		else:
			arrow_position -= 1  
		select_arrow.position.y = -40 + (arrow_position % 4) * 155
		handle_party(arrow_position)
	elif event.is_action_pressed("x"):
		emit_signal("close_party_menu")

func handle_party(arrow_position):
	match arrow_position % 4:
		0:
			claire.visible = true
			etho.visible = false
			flynn.visible = false
			kavya.visible = false
		1:
			claire.visible = false
			etho.visible = true
			flynn.visible = false
			kavya.visible = false
		2:
			claire.visible = false
			etho.visible = false
			flynn.visible = true
			kavya.visible = false
		3:
			claire.visible = false
			etho.visible = false
			flynn.visible = false
			kavya.visible = true
