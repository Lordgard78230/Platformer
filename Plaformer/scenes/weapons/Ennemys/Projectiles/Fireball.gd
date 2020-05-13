extends Area2D

var fireball_speed = 200
var fireball_velocity = Vector2()
var dammage = 20


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()



func _on_Fireball_body_entered(_body: Node) -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	fireball_velocity.x =  fireball_speed * delta 
	translate(fireball_velocity)
	if fireball_velocity.x < 0:
		$Sprite.flip_h = true





