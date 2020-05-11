extends Control
var pause_state : bool = false


func _input(event):
	if event.is_action_pressed("ui_cancel") and pause_state == false:
		pause_state = true
		get_tree().paused = pause_state
		self.show()
	elif event.is_action_pressed("ui_cancel") and pause_state == true:
		pause_state = false
		get_tree().paused = pause_state
		self.hide()
	

#func _on_Resume_pressed() -> void:
	#pause_state = false
	#get_tree().paused = pause_state
	#self.hide()


func _on_Menu_pressed() -> void:
	get_tree().change_scene("res://scenes/UI/MainScreen.tscn")
