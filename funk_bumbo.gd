extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func funk_bumbo(language):
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "semínima"
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "negra"
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "  quarter"

func funk_conga(language):
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		
		$VBoxContainer2/VBoxContainer4/Semicolcheia.text = "semi-colcheia"
		$VBoxContainer2/VBoxContainer6/Seminima.text = "colcheia"
		$VBoxContainer2/VBoxContainer5/Seminima.text = "colcheia pontuada"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer3/Seminima.text = ""
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		
		$VBoxContainer2/VBoxContainer4/Semicolcheia.text = "semi-corchea"
		$VBoxContainer2/VBoxContainer6/Seminima.text = "corchea"
		$VBoxContainer2/VBoxContainer5/Seminima.text = "corchea
con puntillo"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer3/Seminima.text = ""
		
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		
		$VBoxContainer2/VBoxContainer4/Semicolcheia.text = "sixteenth"
		$VBoxContainer2/VBoxContainer6/Seminima.text = "eighth"
		$VBoxContainer2/VBoxContainer5/Seminima.text = "dotted eighth"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = ""

func funk_triangulo(language):
	print(name, " ", language)
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer4/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer5/Seminima.text = "semínima"
		
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer4/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer5/Seminima.text = "negra"
		
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer4/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer5/Seminima.text = " quarter"


func afrohouse_hihat(language):
	print(name, " ", language)
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "semínima"
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "  negra"
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "  quarter"
	
func afrohouse_bumbo(language):
	print(name, " ", language)
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "semínima"
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "  negra"
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "  quarter"
	
func afrohouse_gankogui(language):
	print(name, " ", language)
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "semi-colcheia"
		$VBoxContainer2/VBoxContainer5/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer6/Colcheia.text = "colcheia pontuada"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "semínima"
		$VBoxContainer2/VBoxContainer4/Minima.text = "mínima"
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "semi-corchea"
		$VBoxContainer2/VBoxContainer5/Colcheia.text = "  corchea"
		$VBoxContainer2/VBoxContainer6/Colcheia.text = "corchea 
con puntillo"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "    negra"
		$VBoxContainer2/VBoxContainer4/Minima.text = "blanca"
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "  sixteenth"
		$VBoxContainer2/VBoxContainer5/Colcheia.text = "  eighth"
		$VBoxContainer2/VBoxContainer6/Colcheia.text = "dotted eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "     quarter"
		$VBoxContainer2/VBoxContainer4/Minima.text = "  half"
	
func samba_trap_palmas(language):
	print(name, " ", language)
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "semínima"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "mínima"
		
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "negra"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "blanca"
		
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "quarter"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "half"
		

func samba_trap_aro(language):
	print(name, " ", language)
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "semínima"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "mínima"
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "corchea"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "negra"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "blanca"
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "quarter"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "half"
		
		
	
func samba_trap_caixa(language):
	print(name, " ", language)
	if language == "pt":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Nomenclatura"
	
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "colcheia"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "semínima"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "mínima"
	if language == "es":
		$VBoxContainer2/VBoxContainer/Nota.text = "Nota"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pausa"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Tempo"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Notación"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "  corchea"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "negra"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "   blanca"
	if language == "en":
		$VBoxContainer2/VBoxContainer/Nota.text = "Note"
		$VBoxContainer2/VBoxContainer/Pausa.text = "Pause"
		$VBoxContainer2/VBoxContainer/Tempo.text = "Duration"
		$VBoxContainer2/VBoxContainer/Nomenclatura.text = "Naming"
		
		$VBoxContainer2/VBoxContainer2/Colcheia.text = "eighth"
		$VBoxContainer2/VBoxContainer3/Seminima.text = "quarter"
		$VBoxContainer2/VBoxContainer4/Seminima.text = "   half"

		
func change_language(language):
	print("CHANGE LANGUAGE ", name)
	if name == "FunkBumbo":
		funk_bumbo(language)
	if name == "FunkConga":
		funk_conga(language)
	if name == "FunkTriangulo":
		funk_triangulo(language)
	if name == "AfroHouseHihat":
		afrohouse_hihat(language)
	if name == "AfroHouseBumbo":
		afrohouse_bumbo(language)
	if name == "AfroHouseGankogui":
		afrohouse_gankogui(language)
	if name == "SambaTrapPalmas":
		samba_trap_palmas(language)
	if name == "SambaTrapAro":
		samba_trap_aro(language)		
	if name == "SambaTrapCaixa":
		samba_trap_caixa(language)
		
	
