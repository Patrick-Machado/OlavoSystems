extends YSort

export(Vector2) var index

export var Music = 0
export var IdMap=0
onready var SoundPath = get_tree().get_root().get_node("Inventory/SoundControl")

func _ready():
	position = index * 1024
	#edição minha:
	if Music ==1:
		SoundPath.centro()
	elif Music == 2:
		SoundPath.duel()
	elif Music == 3:
		SoundPath.noble()
	elif Music == 4:
		SoundPath.favela()
	get_tree().get_root().get_node("Inventory/BackPack").set_position(Vector2(0,0))
	var hud = get_tree().get_root().get_node("Inventory/Save_Control").savedata.StartHud
	if hud == 0:
		get_tree().get_root().get_node("Inventory").InvKey(true)
		hud = 1
		get_tree().get_root().get_node("Inventory/Save_Control").save()
func exit_chunk(delta):
	get_parent().switch_chunk(self, delta)

func enter_chunk():
	get_parent().finish_switch()


