extends Node

const PUNCTUATION =	[
			",", ".", ";", ":", "?", "!", "\"", "#",
			"$", "%", "&", "\'", "(", ")", "-", "="
		]

func parse_expression(text):
	var input
	input = text.to_lower()
	input = strip_punctuation(input)
	return input

func strip_punctuation(text):
	var res = text
	for c in PUNCTUATION:
		if c in res:
			res = erase_char(res, c)
	return res

func erase_char(text, character):
	var curr_text = text
	while character in curr_text:
		curr_text.erase(curr_text.find(character), 1)
	return curr_text

# reduce input to basic instruction
func format_input(input, instructions):
	var formatted_input = ""
	var keys = instructions.keys()
	var split_input = input.split(" ")
	for key in keys:
		for word in split_input:
			if word in instructions[key]:
				formatted_input += key
	return formatted_input
	