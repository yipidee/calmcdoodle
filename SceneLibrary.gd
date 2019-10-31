extends Node

signal moved

var interpreter = load("res://Interpreter.gd").new()

var location
var description
var responses = {}
var defaults = []
var instructions = {}
var prerequisites = {}
var failed_prereq_responses = {}
var state_changes = {}
var movement = {}

# The ready function loads required data from external source files
func load_scene(id):
	var filename = "res://scenes/scene" + str(id) + ".json"
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	location = data["location"]
	description = data["description"]
	responses = data["responses"]
	instructions = data["instructions"]
	prerequisites = data["prerequisites"]
	failed_prereq_responses = data["failed_prereq_responses"]
	state_changes = data["state_changes"]
	movement = data["movement"]
	defaults = data["defaults"]
	file.close()	

# Step through game logic, return text for GUI
func perform_interaction(input, inventory):
	var parsed_input = interpreter.parse_expression(input)
	var formatted_input = interpreter.format_input(parsed_input, instructions)
	var response = update_scene(formatted_input, inventory)
	return response

func update_scene(input, inventory):
	# Check if there are prerequisites
	var response
	if prerequisites.has(input):
		var meets_prereqs = true
		var prereqs = prerequisites[input]
		for prereq in prereqs:
			meets_prereqs = meets_prereqs and inventory[prereq]
		if not meets_prereqs:
			return failed_prereq_responses[input][randi() % failed_prereq_responses[input].size()]
	#check if affects inventory and update accordingly
	if state_changes.has(input):
		inventory[state_changes[input]] = true
	#check for movement and change scene as appropriate
	response = get_response(input) #get the appropriate response before potential scene change
	if movement.has(input):
		emit_signal("moved", movement[input])
	#return message to user
	return response

# Gets the appropriate response for GUI
func get_response(input):
	if responses.has(input):
		return responses[input]
	return defaults[randi() % defaults.size()]