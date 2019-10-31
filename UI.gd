extends Node

var curr_scene_id = 0

func _ready():
	randomize()
	$VBoxContainer/Input.grab_focus()
	load_scene(curr_scene_id)
	

func _on_Input_text_entered(new_text):
	if not $VBoxContainer/Input.text.empty():
		$VBoxContainer/Prompt.text = $SceneLibrary.perform_interaction(new_text, $Inventory.inventory)
	$VBoxContainer/Input.clear()


func _on_moved(next_scene_id):
	var next = $MapMapper.get_next_node(next_scene_id, $Inventory.inventory)
	print(next)
	load_scene(next)


func load_scene(scene_id):
	$SceneLibrary.load_scene(scene_id)
	$VBoxContainer/Details.text = $SceneLibrary.description
	$VBoxContainer/Location.text = $SceneLibrary.location
	curr_scene_id = scene_id
