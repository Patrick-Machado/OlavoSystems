extends Panel

var Transaction = preload("res://Scenes/Transaction.tscn")

enum types {MIXED, OUT, FILTER, TRASH}
export(types) var type = MIXED
export(Array) var filter = []

var id = null
var qty = 0
var uid = null

signal changed()

func store(trans):
	var all_done = true
	
	if type == TRASH:
		trans = []
		return true
	
	var i = 0
	while i != trans.size():
		var t = trans[i]
		if id != null and id != t.id or uid != null and uid != t.uid:
			i += 1
			all_done = false
			continue
		
		id = t.id
		uid = t.uid
		
		if qty + t.qty > t.max_qty:
			t.qty -= (t.max_qty - qty)
			qty = t.max_qty
			all_done = false
			break
		else:
			qty += t.qty
			trans.remove(i)
	
	update_info()
	
	return all_done

func update_info():
	if id == null:
		$Image.texture = null
	else:
		$Image.texture = load("res://Assets/Items/item" + str(id) + ".png")
	
	if qty > 1:
		$Number.text = str(qty)
		$Number.show()
	else:
		$Number.hide()
	
	emit_signal("changed")

func _input(event):
	if event is InputEventMouseButton and event.pressed and pos_inside(event.position):
		if Inventory.is_idle() and Inventory.open:
			if id == null: return
			
			var new_trans = Transaction.instance()
			if event.button_index == 1:
				new_trans.init(id, qty, uid)
				id = null
				qty = 0
				uid = null
			else:
				if qty == 1: return
				new_trans.init(id, qty/2, uid)
				qty -= qty/2
			
			if Input.is_key_pressed(KEY_SHIFT):
				Inventory.store([new_trans])
			else:
				Inventory.set_trans(new_trans)
			
			update_info()
			
		elif Inventory.is_trans():
			if type == OUT or (type == FILTER and not filter.has(Inventory.cur_trans.id)): return
			
			if event.button_index == 1:
				
				if id != null and Inventory.cur_trans.id != id:
					var new_trans = Transaction.instance()
					new_trans.init(id, qty, uid)
					id = null
					qty = 0
					uid = null
					store([Inventory.cur_trans])
					Inventory.set_trans(new_trans)
				else:
					if store([Inventory.cur_trans]):
						Inventory.set_idle()
			
			else:
				var cur_trans = Inventory.cur_trans
				if cur_trans.qty > 1:
					var new_trans = Transaction.instance()
					new_trans.init(cur_trans.id, 1, cur_trans.uid)
					if store([new_trans]):
						cur_trans.qty -= 1
	
	elif event is InputEventMouseMotion:
		if pos_inside(get_viewport().get_mouse_position()):
			Inventory.set_info(id)

func pos_inside(pos):
	return get_global_rect().has_point(pos)




