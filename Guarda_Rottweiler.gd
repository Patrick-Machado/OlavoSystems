extends Node2D

var direcs = 1
var calc = false
var velocity = Vector2()
export var walk_speed = 0.8

export var ID = 0
export var E_name = ""
func _ready():
	randomize()

	$Timer.start()

func change_walk(): #mudando a animação do personagem
	calc = true
	if direcs == 1: #baixo
		$Guarda1_Sprite.flip_h = false
		$Guarda1_Sprite.play("Down")
		#print("Anim Donw")
	elif direcs == 2:
		$Guarda1_Sprite.flip_h = false #direita
		$Guarda1_Sprite.play("Right")
		#print("Anim Right")
	elif direcs == 3:
		$Guarda1_Sprite.flip_h = true #esquerda
		$Guarda1_Sprite.play("Right")
		#print("Anim Left")
	elif direcs == 4: #cima
		$Guarda1_Sprite.flip_h = false
		$Guarda1_Sprite.play("Up")
		#print("Anim UP")

	calc = false
	$Timer.start()


func _physics_process(delta): #movendo o personagem
	#randomize()
	#calc = true

	#print("Delta Started")
	if calc != true:
		velocity = Vector2(0,0)
		#print("entrou")
		if direcs == 1 and position.y < 640: #BAIXO
			velocity.y = walk_speed
			move_and_collide(Vector2(0, walk_speed))
			#print("Baixo")
		elif direcs == 2 and position.x < 640: #DIREITA
			velocity.x = walk_speed
			move_and_collide(Vector2(walk_speed, 0))
			#print("Direita")
		elif direcs == 3 and position.x > 300: #ESQUERDA
			velocity.x = -walk_speed
			move_and_collide(Vector2(-walk_speed, 0))
			#print("Esquerda")
		elif direcs == 4 and position.y > 300: #CIMA
			velocity.y = -walk_speed
			move_and_collide(Vector2(0, -walk_speed))
			#print("Cima")
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	direcs = randi()%4+1
	calc = false
	change_walk()
	





