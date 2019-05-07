extends KinematicBody2D

var walk_speed = 200

var velocity = Vector2(0, 0)

enum {UP, DOWN, LEFT, RIGHT}
var facing = DOWN

var switch_delta = Vector2(0, 0)

var active_obj = null


	
func _physics_process(delta):
	get_child(0).get_parent().add_to_group("Hero")
	#print coordenada
	#print(position)
	if switch_delta == Vector2(0, 0):
	
		var walk_left = Input.is_action_pressed("left")
		var walk_right = Input.is_action_pressed("right")
		var walk_up = Input.is_action_pressed("up")
		var walk_down = Input.is_action_pressed("down")
		
		var pressed = Input.is_action_pressed("press") #edicao minha
		
		velocity = Vector2()
		
		if walk_left and position.x > 0:
			velocity.x = -walk_speed
			facing = LEFT
		elif walk_right and position.x < 1024:
			velocity.x = walk_speed
			facing = RIGHT
		elif walk_up and position.y > 10:
			velocity.y = -walk_speed
			facing = UP
		elif walk_down and position.y < 1024:
			velocity.y = walk_speed
			facing = DOWN
	
	else:
		velocity = switch_delta * walk_speed
	
	velocity = move_and_slide(velocity)
	
	set_anim()

func set_anim():
	#var helm_ratio = Inventory.get_node("Equip").helm_ratio
	
	if facing == RIGHT:
		$AnimMove.current_animation = "right_walk" if velocity.x != 0 else "right_stand"
		#$Head.frame = 21 if helm_ratio == 1 else 20
	elif facing == LEFT:
		$AnimMove.current_animation = "left_walk" if velocity.x != 0 else "left_stand"
		#$Head.frame = 18 if helm_ratio == 1 else 19
	elif facing == DOWN:
		$AnimMove.current_animation = "down_walk" if velocity.y != 0 else "down_stand"
		#$Head.frame = 16 if helm_ratio == 1 else 17
	elif facing == UP:
		$AnimMove.current_animation = "up_walk" if velocity.y != 0 else "up_stand"
		#$Head.frame = 23 if helm_ratio == 1 else 22

func anim_switch(from, to):
	switch_delta = to.index - from.index
	var global = global_position
	from.remove_child(self)
	to.add_child(self)
	global_position = global
	
	$SwitchTimer.start()

func pass_door(from, to, door):
	switch_delta = door.out_dir
	from.remove_child(self)
	to.add_child(self)
	global_position = door.global_position
	
	$SwitchTimer.start()

func _on_SwitchTimer_timeout():
	switch_delta = Vector2(0, 0)
	get_parent().enter_chunk()

func activate(obj):
	active_obj = obj

func deactivate(obj):
	active_obj = null
#
#func _input(event):
#	if event is InputEventKey and event.pressed:
#		if event.scancode == KEY_SPACE and active_obj != null:
#			active_obj.use()
#	elif event is InputEventMouseButton and event.pressed:
#		if event.button_index == 1:
#			$AttackArea.attack(facing, Inventory.get_node("Equip").attack_force)
#







