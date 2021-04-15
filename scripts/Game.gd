extends Node

var pre_golden_carrots = preload("res://scenes/golden_carrots.tscn")

var skin = preload("res://resources/player_dois.tres")

var golden_carrots

var prize_carrots = [
	{
		average = .3,
		prize = 1
	},
	{
		average = .7,
		prize = 2
	},
	{
		average = 1,
		prize = 3
	}
]


enum{MENU , LOADING , LOADED, SKIN}

var status = MENU


var current_music
var current_stage
var current_stage_name
var loaded_stage
var ref_stage
var stage_coins

func _ready():
	add_to_group("game")
	$HUD/stage_exit.hide()
	if status == MENU:
		$background.visible = true
		$quit.visible = true
		$help.visible = true
		$Menu.play()
func game_selected(button):
	if status == MENU:
		status = LOADING
		$select.play()
		current_stage = button.stage
		current_music = button.music
		current_stage_name = button.stage_name
		$interface.hide()
		load_stage() 
		$HUD/Controls.show()
		$HUD/stage_exit.show()
		status = LOADED
		$background.hide()
		$quit.hide()
		$help.hide()
		$Menu.stop()
func load_stage():
	stage_coins = 0
	$HUD/Controls/CoinCounter.coins = 0
	if loaded_stage != null && ref_stage.get_ref() != null:
		loaded_stage.queue_free() #tela principal do menu
	loaded_stage = load(current_stage).instance()
	ref_stage = weakref(loaded_stage)
	if current_music:
		$music.stream = load(current_music)
	add_child(loaded_stage)
	$HUD/countdown/anim.play("count") #add animação de contagem
	yield($HUD/countdown/anim , "animation_finished") #finaliza a animação
	get_tree().call_group("player" , "start")
	play_music()
	#print(stage_coins)
func player_died():
	load_stage()
	stop_music()
	#$HUD/Controls/CoinCounter.coins = 0
	
func player_dying():
	stop_music()

#func roupa(button):
#	if status == MENU:
#		status == SKIN
#		if $"skins/skin 1":
#			load(skin)
#			get_tree().call_group("player" , "start")

func player_victory():
	stop_music()
	$stream_victory.play()
	
	var average = float($HUD/Controls/CoinCounter.coins) / float(stage_coins)
	var prize = 0
	
	
	
	for pc in prize_carrots:
		if average >= pc.average:
			prize = pc.prize
	
	#print("prize: " + str(prize))
	Game_Data.save_prize(current_stage_name , prize)
	golden_carrots = pre_golden_carrots.instance()
	
	$HUD.add_child(golden_carrots)
	golden_carrots.play(prize)
	yield(golden_carrots , "carrots_finished")
	var t = get_tree().create_timer(4) #cria o tempo de vitoria apos a realização da fase
	yield(t , "timeout")
	
#	stages()
	
	var fase1 = $interface/Stage_buttons/stage_button
	var fases2 = $interface/Stage_buttons/stage_button2
	
	
	
	exit_stage()
#	if fase1:
#		Game_Data.save_prize(current_stage_name , prize)
#		golden_carrots = pre_golden_carrots.instance()
#		$trofeu/golden_carrots.add_child(golden_carrots)
#		golden_carrots.play(prize)
#		yield(golden_carrots , "carrots_finished")
#		$trofeu/golden_carrots.visible = true
	stages()


func _on_stage_exit_pressed():
	exit_stage()

func exit_stage():
	stop_music()
	loaded_stage.queue_free()
	$interface.show()
	$HUD/Controls.hide()
	$HUD/stage_exit.hide()
	$HUD/countdown.hide()
	status = MENU
	$background.visible = true
	$quit.visible = true
	$help.visible = true
	$Menu.play()
	stop_music()
	if golden_carrots != null and weakref(golden_carrots):
		golden_carrots.hide()
	
func play_music():
	if current_music:
		$music.play()

func stop_music():
	$music.stop()

func add_stage_coins():
	stage_coins += 1

func stages():
	var fase = $interface/Stage_buttons/stage_button
	var fase2 = $interface/Stage_buttons/stage_button2
	
	if fase:
		fase2.disabled = false
	if fase2.disabled == true:
		$trofeu/golden_carrots.visible = false





