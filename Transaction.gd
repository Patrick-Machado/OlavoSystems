extends Sprite

var id
var qty
var uid
var max_qty

var automatic = false
var dest_obj = null

func init(id, qty, uid):
	self.id = id
	self.qty = qty
	self.uid = uid
	
	max_qty = Inventory.item_data[str(id)]["max_slot"]
	
	texture = load("res://Assets/Items/item" + str(id) + ".png")

func _process(delta):
	if automatic:
		var del_s = dest_obj.global_position - global_position
		if del_s.length() < 2:
			Inventory.store([self])
			queue_free()
		else:
			global_position += del_s.normalized() * 1.5
	else:
		global_position = get_viewport().get_mouse_position()
	
	if qty > 1:
		$Number.text = str(qty)
		$Number.show()
	else:
		$Number.hide()

func set_obj(pos, dest):
	global_position = pos
	automatic = true
	dest_obj = dest