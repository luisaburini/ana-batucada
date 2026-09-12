extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_language(language):
	if language == "pt":
		$Fase1/Palmas.text = "Palmas"
		$Fase1/Aro.text = "Aro"
		$Fase1/Caixa.text = "Caixa"
		
		$Fase2/Hihat.text = "Chimbal"
		$Fase2/Bumbo.text = "Bumbo"
		$Fase2/Guinkogui.text = "Agogô"
	
		$Fase3/Congas.text = "Conga"
		$Fase3/Bumbo.text = "Bumbo"
		$Fase3/Triangulo.text = "Triângulo"
	
	if language == "es":
		$Fase1/Palmas.text = "Palmas"
		$Fase1/Aro.text = "Aro"
		$Fase1/Caixa.text = "Caja"
		
		$Fase2/Hihat.text = "Platillo"
		$Fase2/Bumbo.text = "Bombo"
		$Fase2/Guinkogui.text = "Agogó"
		
		$Fase3/Congas.text = "Conga"
		$Fase3/Bumbo.text = "Bombo"
		$Fase3/Triangulo.text = "Triángulo"
		
	if language == "en":
		$Fase1/Palmas.text = "Clapping"
		$Fase1/Aro.text = "Rim"
		$Fase1/Caixa.text = "Snare drum"
		
		$Fase2/Hihat.text = "Hi-hat"
		$Fase2/Bumbo.text = "Bass drum"
		$Fase2/Guinkogui.text = "Gankogui"
		
		$Fase3/Congas.text = "Conga"
		$Fase3/Bumbo.text = "Bass drum"
		$Fase3/Triangulo.text = "Triangle"

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
	$Fase.text = "Estádio Cerecamp Mogiana"
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
	$Fase.text = "Estação Cultura"
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
