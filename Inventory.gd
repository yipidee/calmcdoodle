extends Node

var inventory = {}

func _ready():
	if inventory.empty():
		inventory = {
			"out_of_bed" : false,
			"dressed" : false,
			"has_wallet" : false
		}