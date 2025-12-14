extends Node2D

signal entered_emcima()
signal entered_embaixo()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_emcima_area_entered(area: Area2D) -> void:
	emit_signal("entered_emcima")


func _on_embaixo_area_entered(area: Area2D) -> void:
	emit_signal("entered_embaixo")
