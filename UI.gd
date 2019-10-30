extends Node

var curr_scene_id = 0
onready var scenes = $SceneLibrary.get_children()

func _ready():
	randomize()
	$VBoxContainer/Input.grab_focus()
	print(curr_scene_id)
	load_scene(curr_scene_id)
	

func _on_Input_text_entered(new_text):
	if not $VBoxContainer/Input.text.empty():
		$VBoxContainer/Prompt.text = scenes[curr_scene_id].perform_interaction(new_text, $Inventory.inventory)
	$VBoxContainer/Input.clear()


func _on_moved(next_scene_id):
	load_scene(next_scene_id)


func load_scene(scene_id):
	$SceneLibrary.load_scene(scene_id)
	$VBoxContainer/Details.text = scenes[scene_id].description
	$VBoxContainer/Location.text = scenes[scene_id].location
	curr_scene_id = scene_id
