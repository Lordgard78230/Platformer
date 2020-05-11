extends Area2D


func _on_PickUpDagger_area_entered(_area: Area2D) -> void:
	queue_free()
	
