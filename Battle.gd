extends Node2D
onready var Save = get_parent().get_node("Save_Control")

#get Olavos Helth
var hero_health 
var compreencao = 7
var enemy_h = null#setar
onready var enemy_n = get_tree().get_root().get_node("World").get_child(0).get_node("Guarda"+str(get_tree().get_root().get_node("Inventory").LastFightID)).E_name

var enemy_Strenght = 3

signal DestroyE

var sorted

var scapeboolvar = false
var RedBarIsOn = false # se estiver armado a barra vermelha estara ativa
var BtnOn=false
var gunning = false
var IsInR = false #vermelho
var IsInG = false #verde

var playerTurn = false

func MidSquare():
	if IsInR==true: #RED
		IsInR = false
	else:
		IsInR = true
func IsInGBool():
	if IsInG== true: #Green
		IsInG = false
	else:
		IsInG = true
func ScapeBool():
	if scapeboolvar==true:
		scapeboolvar = false
	else:
		scapeboolvar = true

func _ready():
	#OnBattleReady()
	randomize()
#------------------Button Interaction----------------------##
func BtnBool():
	if BtnOn==true: 
		BtnOn = false
	else:
		BtnOn = true

func _on_Paw_pressed():
	if BtnOn == true:
		$Slider/SliderPipes/LimiterR.hide()
		$secondAnim.play_backwards("ChooseButtons")
		gunning=false
		get_node("Effects/PawOnEnemy").play("PawSprite")
		get_node("Effects/PawOnHero").play("PawSprite")
		$Slider.show()
		$BattleAnim.play("Slider")
		
		#BtnOn = false
func _on_Gun_pressed():
	if BtnOn == true:
		$Slider/SliderPipes/LimiterR.show()
		$secondAnim.play_backwards("ChooseButtons")
		gunning=true
		get_node("Effects/PawOnEnemy").play("Shot")
		get_node("Effects/PawOnHero").play("Shot")
		$Slider.show()
		$BattleAnim.play("Slider")
		#BtnOn = false
func _on_Talk_pressed():
	if BtnOn:
		$secondAnim.play_backwards("ChooseButtons")
		gunning = false
		sorted = randi()%compreencao+1 #sorteia de um a dois
		print("Sorted On Talk: "+str(sorted))
		$Effects/OlavoAtk.play()
		if sorted == 1:
			$BattleAnim.play("TalkingTrue")
			yield($BattleAnim, "animation_finished")
			battleEnd()
		else:
			$BattleAnim.play("TalkingFalse")
			yield($BattleAnim, "animation_finished")
			next_turn(false)
			#get_node("Effects/PawOnHero").play("Shot"); gunning = true
			
		scapeboolvar =false
		#BtnOn = false


func SliderOn(var t):# controla o inicio do slider
	if t == true:
		get_node("Slider").show()
		$BattleAnim.play("Slider")
	else:
		get_node("Slider").hide()
		

	
##-----------------Animator Controller---------------------##
func OnBattleReady():
	get_tree().paused = true
	$BattleHud/EnemyLife/EnemyName.text = enemy_n
	changeBattleImage()
	hero_health = int(Save.savedata.Life)
	#enemy_h=5 #cura a vida do personagem #rottwailer
	$BattleAnim.play("Battle_Start")
	Save.save()
	Save.read()
	SetupHBattleHearts()         #validando quantos coração tem
	EnemyLifeUpdate()
	if Save.savedata.Gun == 1:#tem arma
		get_node("ChoosenButtons/GunNode/Gun").show()
	else:# não tem arma
		get_node("ChoosenButtons/GunNode/Gun").hide()
	$Timer.start()
	yield($Timer, "timeout")
	$secondAnim.play("ChooseButtons")
func changeBattleImage():
	if enemy_n== "policial":
		$Enemy/Rottwieler.show()
		set_pitch_scale(1)
		compreencao = 7
		enemy_h=4
	elif enemy_n == "guarda":
		$Enemy/Guarda.show()
		set_pitch_scale(1.5)
		compreencao = 4
		enemy_h=3
	elif enemy_n== "policial elite":
		$Enemy/PastorAlemao.show()
		set_pitch_scale(0.8)
		compreencao = 8
		enemy_h=5
func set_pitch_scale(valorf):
	$Effects/DgAtk1.pitch_scale = valorf
	$Effects/DgAtk2.pitch_scale = valorf
	$Effects/DgAtk3.pitch_scale = valorf
	$Effects/DgHited1.pitch_scale = valorf
	$Effects/DgHited2.pitch_scale = valorf
	$Effects/DogNeg.pitch_scale = valorf
	
func SetupHBattleHearts():
	if Save.savedata.Life ==1:
		$BattleHud/OlavoLife/Heart_4.hide()
		$BattleHud/OlavoLife/Heart_3.hide()
		$BattleHud/OlavoLife/Heart_2.hide()
		hero_health = 1
	elif Save.savedata.Life ==2:
		$BattleHud/OlavoLife/Heart_4.hide()
		$BattleHud/OlavoLife/Heart_3.hide()
		hero_health = 2
	elif Save.savedata.Life ==3:
		$BattleHud/OlavoLife/Heart_4.hide()
		hero_health = 3
		
func EnemyLifeUpdate():
	if enemy_h ==1:
		$BattleHud/EnemyLife/Heart_5.hide()
		$BattleHud/EnemyLife/Heart_4.hide()
		$BattleHud/EnemyLife/Heart_3.hide()
		$BattleHud/EnemyLife/Heart_2.hide()
		$BattleHud/EnemyLife/Heart_1.show()
	elif enemy_h ==2:
		$BattleHud/EnemyLife/Heart_5.hide()
		$BattleHud/EnemyLife/Heart_4.hide()
		$BattleHud/EnemyLife/Heart_3.hide()
		$BattleHud/EnemyLife/Heart_2.show()
		$BattleHud/EnemyLife/Heart_1.show()
	elif enemy_h ==3:
		$BattleHud/EnemyLife/Heart_5.hide()
		$BattleHud/EnemyLife/Heart_4.hide()
		$BattleHud/EnemyLife/Heart_3.show()
		$BattleHud/EnemyLife/Heart_2.show()
		$BattleHud/EnemyLife/Heart_1.show()
	elif enemy_h ==4:
		$BattleHud/EnemyLife/Heart_5.hide()
		$BattleHud/EnemyLife/Heart_4.show()
		$BattleHud/EnemyLife/Heart_3.show()
		$BattleHud/EnemyLife/Heart_2.show()
		$BattleHud/EnemyLife/Heart_1.show()
	elif enemy_h ==5:#startingbattle enemy recovering health
		$BattleHud/EnemyLife/Heart_5.show()
		$BattleHud/EnemyLife/Heart_4.show()
		$BattleHud/EnemyLife/Heart_3.show()
		$BattleHud/EnemyLife/Heart_2.show()
		$BattleHud/EnemyLife/Heart_1.show()

func HeroBattleHeartsUpdate():
	if hero_health == 4:
		$BattleHud/OlavoLife/Heart_4.show()
		$BattleHud/OlavoLife/Heart_3.show()
		$BattleHud/OlavoLife/Heart_2.show()
		$BattleHud/OlavoLife/Heart_1.show()
	elif hero_health == 3:
		$BattleHud/OlavoLife/Heart_4.hide()
		$BattleHud/OlavoLife/Heart_3.show()
		$BattleHud/OlavoLife/Heart_2.show()
		$BattleHud/OlavoLife/Heart_1.show()
	elif hero_health == 2:
		$BattleHud/OlavoLife/Heart_4.hide()
		$BattleHud/OlavoLife/Heart_3.hide()
		$BattleHud/OlavoLife/Heart_2.show()
		$BattleHud/OlavoLife/Heart_1.show()
	elif hero_health == 1:
		$BattleHud/OlavoLife/Heart_4.hide()
		$BattleHud/OlavoLife/Heart_3.hide()
		$BattleHud/OlavoLife/Heart_2.hide()
		$BattleHud/OlavoLife/Heart_1.show()

	
func BackToIdle():
	$BattleAnim.play("Idle")
	
	
func HitOnEnemy():
	$BattleAnim.play("DamageE")
	if gunning ==true:
		enemy_h -=2
	elif gunning==false:
		enemy_h-=1
	EnemyLifeUpdate()
	if enemy_h <=0:
		get_node("BattleHud/EnemyLife/Heart_1").hide()
		get_node("BattleHud/EnemyLife/Heart_2").hide()
		battleEnd()
	else:
		if$ChoosenButtons/TalkNode != null:
			$ChoosenButtons/TalkNode.queue_free()
		$BattleAnim.play("Idle")
		next_turn(false)
func HitOnHero(): #vermelho piscando
	$BattleAnim.play("DamageO")
	if gunning == true:
		hero_health-=2
	else:
		hero_health-=1
	
	if hero_health <=0:
		get_node("BattleHud/OlavoLife/Heart_1").hide()
		get_node("BattleHud/OlavoLife/Heart_2").hide()
		Save.savedata.IsDead = 1 #true / morto
		Save.save()
		GameOver()
	else:
		HeroBattleHeartsUpdate()
		$BattleAnim.play("Idle")
		next_turn(true)
	
	

		
func _on_ScapeDetector_pressed(): #slider redondo
	$BattleAnim.stop()
	if scapeboolvar==true:
		#$BattleAnim.stop()
		$SliderScape.hide()
		#$Effects/Errou.set_text("Inimigo Errou")
		$BattleAnim.play("Errou3")
		yield($BattleAnim,"animation_finished")
		$BattleAnim.play("Idle")
		scapeboolvar = false
		next_turn(true)
		
	elif scapeboolvar ==false:
		#$BattleAnim.stop()
		$SliderScape.hide()
		$BattleAnim.play("AtackE")
		sorted = randi()%2+1 #sorteia de um a dois
		print("Sorted: "+str(sorted))
		if sorted != 2:
			get_node("Effects/PawOnHero").play("PawSprite") 
			gunning = false
			#hero_health-=1
		elif sorted == 2:
			get_node("Effects/PawOnHero").play("Shot") 
			gunning = true
			#hero_health-=2
		
		scapeboolvar =false

		
	
func _on_AtackDetector_pressed():
	$BattleAnim.stop()
	if IsInR==true: #pegou no vermelho???
		print("Slider Vermelho")
		if gunning== true:
			hero_health -=1
			$Slider.hide()
			$Effects/Damage2.play()
			HeroBattleHeartsUpdate()
			$BattleAnim.play("DamageO")
			yield($Effects/Damage2, "finished") 


			#yield($BattleAnim, "animation_finished")
			$BattleAnim.play("Errou2")
			yield($BattleAnim, "animation_finished")

		else:
			#$Effects/Damage2.play()
			#$BattleAnim.play("DamageO")
			$Slider.hide()
			$BattleAnim.play("Errou3")
			yield($BattleAnim, "animation_finished")
#		yield($BattleAnim, "animation_finished")
		$Slider.hide()
		if hero_health <=0:
			get_node("BattleHud/OlavoLife/Heart_1").hide()
			Save.savedata.IsDead = 1 #true / morto
			GameOver()
		else:
			$BattleAnim.play("Idle")
			next_turn(false)
		IsInG = false
		IsInR = false
	elif IsInG ==true:
		$BattleAnim.play("AtackO")
		yield($BattleAnim,"animation_finished")
		$Slider.hide()
		$BattleAnim.play("Idle")
		IsInG = false
		IsInR = false
		next_turn(false)
	elif IsInG == false and IsInR == false:
		$BattleAnim.stop()
		$Slider.hide()
		$BattleAnim.play("Errou")
		yield($BattleAnim,"animation_finished")
		$BattleAnim.play("Idle")
		IsInG = false
		IsInR = false
		next_turn(false)

		
func GameOver():
	print("GameOver") #Change Scene
	var GM_Node = load("res://Scenes/Cutscenes/GameOver.tscn")
	var tg_GM = GM_Node.instance()
	get_tree().get_root().get_node("Inventory").add_child(tg_GM)

func battleEnd():
	print("Venceu!")
	get_tree().paused = false
	Save.savedata.Life = hero_health
	get_tree().get_root().get_node("Inventory").get_node("Save_Control").atualize()
	var lastid = get_tree().get_root().get_node("Inventory").LastFightID
	get_tree().get_root().get_node("World").get_child(0).get_node("Guarda"+str(lastid)).queue_free()#.get_node("FightDec")#.BattleOrDestroy = true
	get_tree().get_root().get_node("Inventory").get_node("SoundControl").playsaved()
	get_tree().get_root().get_node("Inventory").get_node("Timer").wait_time = 0.5
	get_tree().get_root().get_node("Inventory").get_node("Timer").start()
	yield(get_tree().get_root().get_node("Inventory").get_node("Timer"),"timeout")
	get_tree().get_root().get_node("Inventory").get_node("Timer").wait_time = 3
	self.queue_free()
	
func next_turn(turnH):
	print("HeroLife "+str(hero_health))
	$secondAnim.play("Next")
	yield($secondAnim, "animation_finished")
	if turnH == true:
		IsInR = false #vermelho
		IsInG = false
		if hero_health>0:
			$secondAnim.play("ChooseButtons")
	elif turnH == false:
		if enemy_n == "guarda":#OU OUTROS
			var pic = load("res://Assets/Battlers/eCursorScape.png")
			$SliderScape/AroScape.texture = pic
			$SliderScape.show()
			scapeboolvar = false
			$ScapeAnim.play("sliderscape2")
		else:
			$SliderScape.show()
			scapeboolvar = false
			$ScapeAnim.play("sliderscape")
#---------------------------Sound Control----------------------
func NormalHit():
	if gunning:
		get_node("Effects/Damage2").play()#som tiro
	else:
		get_node("Effects/Damage").play()#som patada

func HitOnE_Sound():
	if gunning == false:
		get_node("Effects/DgHited1").play()
	elif gunning == true:
		get_node("Effects/DgHited2").play()

func Son_erro():
	get_node("Effects/Wind").play()
	
func AttackE_Sound():
	sorted = randi()%3+1 #sorteia de um a tres
	print("Sorted On Attack: "+str(sorted))
	if sorted==1:
		$Effects/DgAtk1.play()
	elif sorted==2:
		$Effects/DgAtk2.play()
	elif sorted==3:
		$Effects/DgAtk3.play()
		
func DogNeg_Sound():
	$Effects/DogNeg.play()
	
func AttackO_Sound():
	$Effects/OlavoAtk.play()



