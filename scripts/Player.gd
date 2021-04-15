extends KinematicBody2D

const VELX = 500
const GRAV = 1500
var vel = Vector2(500 , 0)
var jump = false
var jump_release = false
var was_on_floor = false
var controled_jump = false

const ASAS = preload("res://scenes/fly_powerUp.tscn")
const FLUTUAR = preload("res://scenes/jetpack.tscn")

onready var mask = collision_mask
onready var layer = collision_layer

enum{IDLE , RUNNING ,FLYING , DEAD , VICTORY , JETPACK, BOING}

var status = IDLE

func _ready():
	add_to_group("player")
	$sprite.play("idle")
	set_process_input(true)


func _physics_process(delta):
	
	if status == RUNNING:
		running(delta)
	elif status == FLYING:
		flying(delta)
	elif status == DEAD:
		dead(delta)
	elif status == JETPACK:
		jetpack(delta)
	if status == BOING:
		pulo_alto(delta)

	if status != DEAD:
		if position.y > ProjectSettings.get_setting("display/window/size/height"): #quando o personagem cair no chao , morre( não importa a resolução da tela)
			killed()
	jump = false
	jump_release = false

func running(delta):
	vel.y += GRAV * delta
	vel.x = VELX
	vel = move_and_slide(vel , Vector2(0 , -1)) #se mover para a direita

	if is_on_floor(): #Se estiver no chão, pode pular
		if not was_on_floor:
			$anim.play("boing")
			$dust/anim.play("dust")
		$sprite.play("walk")
		if jump:
			jump(800 , true) #altura do pulo
			$jump.play()
	else:
		$sprite.play("jump")
		if jump_release and vel.y < 0 and controled_jump: #durante a queda do pulo
			vel.y *= .3 # A proporção da queda após o pulo
	
	was_on_floor = is_on_floor()

func pulo_alto(delta):
	vel.y += GRAV * delta
	vel.x = VELX
	vel = move_and_slide(vel , Vector2(0 , -1)) #se mover para a direita

	if is_on_floor(): #Se estiver no chão, pode pular
		if not was_on_floor:
			$anim.play("boing")
			$dust/anim.play("dust")
			$Bolha/anim.play("impacto")
		$sprite.play("ball")
		if jump:
			jump(1100 , true) #altura do pulo
			$jump.play()
	else:
		$sprite.play("ball")
		if jump_release and vel.y < 0 and controled_jump: #durante a queda do pulo
			vel.y *= .3 # A proporção da queda após o pulo
	
	was_on_floor = is_on_floor()


func dead(delta):
	$sprite.play("hurt") #animação do personagem quando é ferido
	translate(vel * delta) #faz com o que o personagem tenha uma reação
	vel.y += GRAV * delta # saia do cenário
	if global_position.y > ProjectSettings.get_setting("display/window/size/height") + 100:
		get_tree().call_group("game" , "player_died") # reinicia o game quando morre
		
func flying(delta):
	if jump == false:
		vel.y += GRAV * delta
		vel.x = VELX
		vel = move_and_slide(vel , Vector2(0 , -1))
	if jump:
		$wings/anim.play("flap")
		jump(350 , false)
		$flap.play()

	if is_on_floor():
		get_tree().call_group("power_up_bar" , "stop") #Desliga a barra de powerUp
		powerup_finished()
		

func jetpack(delta):
	vel.y += GRAV * delta
	vel.x = VELX
	vel = move_and_slide(vel , Vector2(0 , -1))
	if jump:
		$Jet_pack/anim.play("mochila_jato")
		jump(250 , false)
		
		

	if is_on_floor():
		get_tree().call_group("power_up_bar" , "stop") #Desliga a barra de powerUp
		powerup_finished()


#func _output(event):
#	if event is InputEventScreenTouch: #Quando clicar no touch
#		if event.pressed:
#			jump = true
#		else:
#			jump_release = true


func _input(event):
	if event is InputEventScreenTouch or event.is_action("jump"): #Quando clicar no touch
		if event.pressed:
			jump = true
		else:
			jump_release = true

func jump(force , controled):
	vel.y = -force
	controled_jump = controled

func voar(force , controled):
	vel.x = -force
	controled_jump = controled

func boing(force , controled):
	vel.y = -force
	controled_jump = controled

func killed():
	if status != DEAD:
		status = DEAD
		collision_mask = 0
		collision_layer = 0
		vel = Vector2(0 , -1000) # determina a altura quando é atingido
		$dead.play()
		get_tree().call_group("power_up_bar" , "stop")
		get_tree().call_group("game" , "player_dying")
func fly():
	$sprite.play("voa")
	jump(350 , false)
	status = FLYING
	$wings.visible = true
	$power_up.play()

func bolha():
	jump(200 , false)
	$sprite.play("ball")
	status = BOING
	$Bolha.visible = true
	$bolha_em_acao.play()
	$power_up.play()

func flutuar():
	$sprite.play("foguete")
	voar(250 , false)
	status = JETPACK
	$Jet_pack.visible = true
	$foguete.play()
	$power_up.play()
func victory():
	$sprite.play("victory")
	status = VICTORY
	get_tree().call_group("game" , "player_victory")
	
	
func powerup_finished():
	if status == BOING:
		$bolha_encerrada.play()
	if status != DEAD:
		status = RUNNING
		$wings.hide()
		$Jet_pack.hide()
		$foguete.stop()
		$Bolha.hide()
		$bolha_em_acao.stop()

func start():
	status = RUNNING


func _on_sky_body_entered(body):
	get_tree().call_group("power_up_bar" , "stop")
	powerup_finished()
