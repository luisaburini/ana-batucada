extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_pontos(bumbo, conga, triangulo):
	$Fase1.show()
	$Fase2.hide()
	$Fase3.hide()
	if bumbo != null:
		$Fase1/PontosBumbo.text = str(bumbo) + "%"
	else:
		bumbo = 0
		$Fase1/PontosBumbo.text = "0%"
	if conga != null:
		$Fase1/PontosConga.text = str(conga) + "%"
	else:
		conga = 0
		$Fase1/PontosConga.text = "0%"
	if triangulo != null:
		$Fase1/PontosTriangulo.text = str(triangulo) + "%"
	else:
		triangulo = 0
		$Fase1/PontosTriangulo.text = "0%"
	$Fase1/PontosTotal.text = str((bumbo+conga+triangulo)/3)+ "%"

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
	
func set_pontos_fase3(palmas, aro, caixa):
	$Fase.text = "Estacao Cultura"
	$Fase1.hide()
	$Fase2.hide()
	$Fase3.show()
	if palmas != null:
		$Fase3/PontosPalmas.text = str(palmas)+"%"
	else:
		palmas = 0
		$Fase3/PontosPalmas.text = "0%"
	if aro != null:
		$Fase3/PontosAro.text = str(aro)+"%"
	else:
		aro = 0
		$Fase3/PontosAro.text = "0%"
	if caixa != null:
		$Fase3/PontosCaixa.text = str(caixa)+"%"
	else:
		caixa = 0
		$Fase3/PontosCaixa.text = "0%"
	$Fase3/PontosTotal.text = str((palmas+aro+caixa)/4) + "%"
