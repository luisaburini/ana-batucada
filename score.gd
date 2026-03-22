extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_pontos(bumbo, conga, triangulo):
	if bumbo != null:
		print(bumbo)
		$Background/PontosBumbo.text = str(bumbo) + "%"
	else:
		bumbo = 0
	if conga != null:
		$Background/PontosConga.text = str(conga) + "%"
	else:
		conga = 0
	if triangulo != null:
		$Background/PontosTriangulo.text = str(triangulo) + "%"
	else:
		triangulo = 0
	$Background/PontosTotal.text = str((bumbo+conga+triangulo)/3)+ "%"
