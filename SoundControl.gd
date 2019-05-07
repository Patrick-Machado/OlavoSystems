extends Node
var track
enum {NOTHING, CENTRO, DUEL, NOBLE, FAVELA}






func playsaved():
	track = NOTHING
	$Music/BackTrack.stop()
	if get_parent().tmpMusic == 1:
		centro()
	elif get_parent().tmpMusic == 2:
		duel()
	elif get_parent().tmpMusic == 3:
		noble()
	elif get_parent().tmpMusic == 4:
		favela()
	#add mais quando surgirem novas musicas
	get_parent().tmpMusic = 0

func centro():
	if track == CENTRO:
		pass
	elif track != CENTRO:
		track = CENTRO
		var temp = load("res://Audio/bensound-hipjazz.ogg")
		$Music/BackTrack.pitch_scale = 0.7
		$Music/BackTrack.stream = temp
		$Music/BackTrack.play()
		

func duel():
	if track == DUEL:
		pass
	elif track != DUEL:
		track = DUEL
		var temp = load("res://Audio/bensound-theduel.ogg")
		$Music/BackTrack.pitch_scale = 0.7
		$Music/BackTrack.stream = temp
		$Music/BackTrack.play()
func noble():
	if track == NOBLE:
		pass
	elif track != NOBLE:
		track = NOBLE
		var temp = load("res://Audio/bensound-bossanova.ogg")
		$Music/BackTrack.pitch_scale = 1
		$Music/BackTrack.stream = temp
		$Music/BackTrack.play()

func favela():
	if track == FAVELA:
		pass
	elif track != FAVELA:
		track = FAVELA
		var temp = load("res://Audio/funk.ogg")
		$Music/BackTrack.pitch_scale = 0.95
		$Music/BackTrack.stream = temp
		$Music/BackTrack.play()
		