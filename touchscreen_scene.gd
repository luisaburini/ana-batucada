extends Node2D

var selected := false
var touch_offset := Vector2.ZERO
signal is_dragging(position)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var global_rect = Rect2($Batedor.global_position, $Batedor.size)
		if global_rect.has_point(event.position):
			selected = true
			touch_offset = position - event.position
	if event is InputEventScreenDrag and selected:
		emit_signal("is_dragging", event.position)
		position = event.position + touch_offset
