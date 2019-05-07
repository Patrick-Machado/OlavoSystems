extends Control

var attack_force = 0
var helm_ratio = 1
var breast_ratio = 1

func _on_SlotSword_changed():
	var id = $SlotSword.id
	if id == null:
		attack_force = 0
	else:
		attack_force = Inventory.item_data[str(id)]["damage"]
	print("Ataque com ", attack_force)

func _on_SlotHelm_changed():
	var id = $SlotHelm.id
	if id == null:
		helm_ratio = 1
	else:
		helm_ratio = Inventory.item_data[str(id)]["defense"]
	print("Defesa de elmo de ", helm_ratio)

func get_def_ratio():
	return helm_ratio * breast_ratio