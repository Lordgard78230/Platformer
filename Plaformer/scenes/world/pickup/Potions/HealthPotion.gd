extends Area2D



func _on_HealthPotion_area_entered(area: Area2D) -> void:
	if area.get_parent().player_health != 100:
		queue_free()
