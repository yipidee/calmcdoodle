extends Node

var inventory = {}

func _ready():
	if inventory.empty():
		inventory = {
			"out_of_bed" : false,
			"dressed" : false,
			"has_wallet" : false,
			"drank_tea" : false,
			"ate_toast" : false,
			"got_cash" : false
		}