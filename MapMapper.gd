extends Node

const map = {
			"0" : {"out_of_bed" : 2}
			}

func get_next_node(next_node_id, inventory):
	if map.has(str(next_node_id)):
		var key = map[str(next_node_id)].keys()[0]
		if inventory.has(key):
			return map[str(next_node_id)][key]
	return next_node_id