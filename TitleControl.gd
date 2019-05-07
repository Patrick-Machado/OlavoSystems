extends Node2D
var pressed = true

func _ready():
#	if get_tree().get_root().get_node("Inventory/GameOver") != null:
#		get_tree().get_root().get_node("Inventory/GameOver").queue_free()
	get_parent().get_node("Anim").play("Another")
	get_tree().get_root().get_node("Inventory").InvKey(false)
	yield(get_parent().get_node("Anim"), "animation_finished")
	pressed = false

func _on_Play_pressed():
	if pressed==false: 
		rank(false)
		pressed = true
		get_parent().get_node("Anim").play("SlideDown")
		yield(get_parent().get_node("Anim"), "animation_finished")
		get_tree().change_scene("res://Scenes/Cutscenes/Tutorial.tscn")
		

var inirank = false

func rank(boolrk):
	if boolrk == true:
		get_parent().get_node("Rank").show()
		boolrk = false
		inirank = true
	elif boolrk == false:
		get_parent().get_node("Rank").hide()
		boolrk = true
		inirank = false
	pressed = false
	
func _on_Ranking_pressed():
	if pressed==false: 
		pressed = true
		if inirank ==true:
			rank(false)
		elif inirank == false:
			rank(true)

var showedCredits = false
func _on_Creditos_pressed():
	if pressed==false: 
		rank(false)
		pressed = true
		if showedCredits == false:
			get_parent().get_node("Anim").play_backwards("credits_show")
			showedCredits = true
			yield(get_parent().get_node("Anim"), "animation_finished")
			get_parent().get_node("Creditos/Button back").show()
		elif showedCredits == true:
			get_parent().get_node("Anim").play("credits_show")
			get_parent().get_node("Creditos/Button back").hide()
			showedCredits = false
			yield(get_parent().get_node("Anim"), "animation_finished")
			get_parent().get_node("Anim").play("Static")
		pressed = false


func _on_backtotitle_pressed():
	_on_Creditos_pressed()


func _on_skipintro_pressed():
	get_parent().get_node("Anim/skipintro").queue_free()
	get_parent().get_node("Anim").stop()
	get_parent().get_node("Anim").play("Another_skip")
	

	
