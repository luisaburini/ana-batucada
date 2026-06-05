extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_pontos_fase1(palmas, aro, caixa):
	$Fase1.show()
	$Fase2.hide()
	$Fase3.hide()
	if palmas != null:
		$Fase1/PontosPalmas.text = str(palmas) + "%"
	else:
		palmas = 0
		$Fase1/PontosPalmas.text = "0%"
	if aro != null:
		$Fase1/PontosAro.text = str(aro) + "%"
	else:
		aro = 0
		$Fase1/PontosAro.text = "0%"
	if caixa != null:
		$Fase1/PontosCaixa.text = str(caixa) + "%"
	else:
		caixa = 0
		$Fase1/PontosCaixa.text = "0%"
	$Fase1/PontosTotal.text = str((palmas+aro+caixa)/3)+ "%"

func set_pontos_fase2(hihat, bumbo, gankogui):
	$Fase.text = "Estadio Cerecamp Mogiana"
	$Fase1.hide()
	$Fase2.show()
	$Fase3.hide()
	if hihat != null:
		print("HIHAT IS NOT NUL")
		$Fase2/PontosHihat.text = str(hihat)+"%"
	else:
		hihat = 0
		$Fase2/PontosHihat.text = "0%"
	if bumbo != null:
		$Fase2/PontosBumbo.text = str(bumbo)+"%"
	else:
		bumbo = 0
		$Fase2/PontosBumbo.text = "0%"
	if gankogui != null:
		$Fase2/PontosGankogui.text = str(gankogui)+"%"
	else:
		gankogui = 0
		$Fase2/PontosGankogui.text = "0%"
	$Fase2/PontosTotal.text = str((hihat+bumbo+gankogui)/3) + "%"
	
func set_pontos_fase3(bumbo, congas, triangulo):
	$Fase.text = "Estacao Cultura"
	$Fase1.hide()
	$Fase2.hide()
	$Fase3.show()
	if bumbo != null:
		$Fase3/PontosBumbo.text = str(bumbo)+"%"
	else:
		bumbo = 0
		$Fase3/PontosBumbo.text = "0%"
	if congas != null:
		$Fase3/PontosConga.text = str(congas)+"%"
	else:
		congas = 0
		$Fase3/PontosConga.text = "0%"
	if triangulo != null:
		$Fase3/PontosTriangulo.text = str(triangulo)+"%"
	else:
		triangulo = 0
		$Fase3/PontosTriangulo.text = "0%"
	$Fase3/PontosTotal.text = str((bumbo+congas+triangulo)/3) + "%"
