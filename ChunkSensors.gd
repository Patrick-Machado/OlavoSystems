extends Node2D

export var top = false
export var bottom = false
export var left = false
export var right = false


func _on_Up_body_entered( body ) :
	
	if top and body.name == "Hero":
		get_parent().exit_chunk(Vector2(0, -1))


func _on_Down_body_entered( body ):

	if bottom and body.name == "Hero":
		get_parent().exit_chunk(Vector2(0, 1))


func _on_Left_body_entered( body ):

	if left and body.name == "Hero":#body.is_in_group("Hero") :
		get_parent().exit_chunk(Vector2(-1, 0))


func _on_Right_body_entered( body ):

	if right and body.name == "Hero" :
		get_parent().exit_chunk(Vector2(1, 0))
