extends Node2D

signal carrots_finished

func _ready():
	#play(3) #Mostrar as cenouras douradas
	pass

func play(carrots):
	carrots = clamp(carrots , 0 , 3)
	for c in range(carrots): #condição para o conjunto das cenouras
		var carrot = get_child(c) #busca a CENA Carrot para o script
		carrot.play() #ativar a animação da cenoura
		yield(carrot , "finished") #encerra a animação
	emit_signal("carrots_finished") #encerra a conexão com o sinal acima
	if carrots == 3:
		$"3 pontos".visible = true
	elif carrots == 2:
		$"2 pontos".visible = true
	else:
		$"1 ponto".visible = true
