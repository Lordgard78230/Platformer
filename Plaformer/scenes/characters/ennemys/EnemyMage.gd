extends Actors


var FIREBALL = preload("res://scenes/weapons/Fireball.tscn")

onready var fireball_timer = $FireballTimer
onready var raycasts = $Raycasts

var ennemy_health := 50
var can_shoot := true
var should_shoot := false
var player_position
var magier_max_speed = Vector2(50,0)
var player_in_front : bool


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -magier_max_speed.x
	fireball_timer.set_wait_time(0.5)




func _on_KillDetector_area_entered(area: Area2D):
	ennemy_health -= area.dammage
	


func _on_Detection_body_entered(body: Node) -> void:
	should_shoot = true

func _on_Detection_body_exited(_body: Node) -> void:
	should_shoot = false
	fireball_timer.stop()
	can_shoot = true


func _on_FireballTimer_timeout() -> void:
	can_shoot = true



func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
	#sprite
	if _velocity.x < 0:
		$Sprite.flip_h = false
	elif _velocity.x > 0:
		$Sprite.flip_h = true

	$HealthBar.value = ennemy_health
	ennemy_health = $HealthBar.value 
	if ennemy_health == 0:
		queue_free()
	
	if can_shoot == true and should_shoot == true:
		fireball_fire()
		fireball_timer.start()
		can_shoot = false
	
	#should_shoot = check_raycasts()

#func check_raycasts():
	#for raycast in raycasts.get_children():
		#if raycast.is_colliding():
			#return true
			
	#return false



func fireball_fire():
	var fireball = FIREBALL.instance()
	get_parent().add_child(fireball)
	if $Sprite.flip_h == false:
		fireball.fireball_speed *= -1
	fireball.position = $FireballSpawner.global_position






