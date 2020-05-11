extends Actors



const DAGGER = preload("res://scenes/weapons/Dagger.tscn")

onready var dagger_timer = $Timer/DaggerTimer
onready var hero_sword_timer = $Timer/HeroSwordTimer

var can_shoot := true
var player_health : float = 100
var dagger_number : float = 0
var weapon_choice : int



func _ready() -> void:
	dagger_timer.set_wait_time(0.5)
	hero_sword_timer.set_wait_time(0.5)
	$HeroSword2/AnimatedSprite.flip_h = true
	$HeroSword/CollisionShape2D.disabled = true
	$HeroSword2/CollisionShape2D.disabled = true






func _on_Pause_pressed() -> void:
	get_tree().change_scene("res://scenes/UI/Windows/PauseMenu.tscn")


func _on_DaggerTimer_timeout() -> void:
	can_shoot = true


func _on_HeroSwordTimer_timeout() -> void:
	$HeroSword/AnimatedSprite.stop()
	$HeroSword/AnimatedSprite.set_frame(0)
	$HeroSword2/AnimatedSprite.stop()
	$HeroSword2/AnimatedSprite.set_frame(0)
	$HeroSword/CollisionShape2D.disabled = true
	$HeroSword2/CollisionShape2D.disabled = true


func _on_PickUpArea_area_entered(area: Area2D) -> void: #increases dagger number by 1
	if area.get_parent().name == "PickUpDagger":
		dagger_number += 1
	elif area.get_parent().name == "HealthPotion":
		player_health += 50


func _on_enemyDetector_area_entered(area: Area2D) -> void:
	player_health -= area.dammage


func _physics_process(_delta: float) -> void:
	#var is_jump_interrupted := Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, max_speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	#sprite
	sprite_direction(_velocity, direction)
	
	#dagger
	dagger_number = min(dagger_number, 10)
	dagger_number()
	if dagger_number == 0:
		$DaggerSprite.hide()
	else:
		$DaggerSprite.show()
	
	
	#updates health and kills play if player_health == 0
	$UI/HealthBar.value = player_health 
	player_health = $UI/HealthBar.value 
	if player_health == 0:
		die()
	
	hero_sword_position()
	dagger_position()
	
	#weapon choice
	weapon_equiped()
	
	
	attack()
	
	
	player_health = min(player_health, 100)

func get_direction() -> Vector2:
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	, -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0)

func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2,max_speed: Vector2) -> Vector2:
	var out: = linear_velocity
	out.x = max_speed.x * direction.x 
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = max_speed.y * direction.y
	#if is_jump_interrupted:
		#out.y = 0.0
	return out 

func sprite_direction(velocity: Vector2, direction):
	if velocity.x == 0 and is_on_floor():
		$Sprite.play("Idle")
	elif direction.x < 0 and velocity.x != 0:
		$Sprite.flip_h = true
		$DaggerSprite.flip_h = true
		$Sprite.play("Run")

		
		
		
	elif direction.x > 0 and velocity.x != 0:
		$Sprite.flip_h = false
		$DaggerSprite.flip_h = false
		$Sprite.play("Run")


func dagger_position():
	if weapon_choice  != 1:
		$DaggerSprite.hide()
	if weapon_choice  == 1 and dagger_number != 0:
		$DaggerSprite.show()

func dagger_fire():
	var dagger = DAGGER.instance()
	get_parent().add_child(dagger)
	if $DaggerSprite.flip_h == true:
		dagger.dagger_speed *= -1
	dagger.position = $DaggerSpawnPosition.global_position
	dagger_timer.start()
	can_shoot = false

func dagger_deacrease():#decresses number of daggers by 1
	dagger_number -= 1 

func dagger_number():
	if dagger_number == 1:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.hide()
		$UI/WeaponMenu/DaggerScore/Dagger3.hide()
		$UI/WeaponMenu/DaggerScore/Dagger4.hide()
		$UI/WeaponMenu/DaggerScore/Dagger5.hide()
		$UI/WeaponMenu/DaggerScore/Dagger6.hide()
		$UI/WeaponMenu/DaggerScore/Dagger7.hide()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 2:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.hide()
		$UI/WeaponMenu/DaggerScore/Dagger4.hide()
		$UI/WeaponMenu/DaggerScore/Dagger5.hide()
		$UI/WeaponMenu/DaggerScore/Dagger6.hide()
		$UI/WeaponMenu/DaggerScore/Dagger7.hide()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 3:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.hide()
		$UI/WeaponMenu/DaggerScore/Dagger5.hide()
		$UI/WeaponMenu/DaggerScore/Dagger6.hide()
		$UI/WeaponMenu/DaggerScore/Dagger7.hide()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 4:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.show()
		$UI/WeaponMenu/DaggerScore/Dagger5.hide()
		$UI/WeaponMenu/DaggerScore/Dagger6.hide()
		$UI/WeaponMenu/DaggerScore/Dagger7.hide()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 5:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.show()
		$UI/WeaponMenu/DaggerScore/Dagger5.show()
		$UI/WeaponMenu/DaggerScore/Dagger6.hide()
		$UI/WeaponMenu/DaggerScore/Dagger7.hide()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 6:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.show()
		$UI/WeaponMenu/DaggerScore/Dagger5.show()
		$UI/WeaponMenu/DaggerScore/Dagger6.show()
		$UI/WeaponMenu/DaggerScore/Dagger7.hide()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 7:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.show()
		$UI/WeaponMenu/DaggerScore/Dagger5.show()
		$UI/WeaponMenu/DaggerScore/Dagger6.show()
		$UI/WeaponMenu/DaggerScore/Dagger7.show()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 8:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.show()
		$UI/WeaponMenu/DaggerScore/Dagger5.show()
		$UI/WeaponMenu/DaggerScore/Dagger6.show()
		$UI/WeaponMenu/DaggerScore/Dagger7.show()
		$UI/WeaponMenu/DaggerScore/Dagger8.show()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 9:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.show()
		$UI/WeaponMenu/DaggerScore/Dagger5.show()
		$UI/WeaponMenu/DaggerScore/Dagger6.show()
		$UI/WeaponMenu/DaggerScore/Dagger7.show()
		$UI/WeaponMenu/DaggerScore/Dagger8.show()
		$UI/WeaponMenu/DaggerScore/Dagger9.show()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()
	elif dagger_number == 10:
		$UI/WeaponMenu/DaggerScore/Dagger1.show()
		$UI/WeaponMenu/DaggerScore/Dagger2.show()
		$UI/WeaponMenu/DaggerScore/Dagger3.show()
		$UI/WeaponMenu/DaggerScore/Dagger4.show()
		$UI/WeaponMenu/DaggerScore/Dagger5.show()
		$UI/WeaponMenu/DaggerScore/Dagger6.show()
		$UI/WeaponMenu/DaggerScore/Dagger7.show()
		$UI/WeaponMenu/DaggerScore/Dagger8.show()
		$UI/WeaponMenu/DaggerScore/Dagger9.show()
		$UI/WeaponMenu/DaggerScore/Dagger10.show()
	elif dagger_number == 0:
		$UI/WeaponMenu/DaggerScore/Dagger1.hide()
		$UI/WeaponMenu/DaggerScore/Dagger2.hide()
		$UI/WeaponMenu/DaggerScore/Dagger3.hide()
		$UI/WeaponMenu/DaggerScore/Dagger4.hide()
		$UI/WeaponMenu/DaggerScore/Dagger5.hide()
		$UI/WeaponMenu/DaggerScore/Dagger6.hide()
		$UI/WeaponMenu/DaggerScore/Dagger7.hide()
		$UI/WeaponMenu/DaggerScore/Dagger8.hide()
		$UI/WeaponMenu/DaggerScore/Dagger9.hide()
		$UI/WeaponMenu/DaggerScore/Dagger10.hide()

func die():
	queue_free()
	get_tree().change_scene("res://scenes/UI/Windows/GameOver.tscn")

func weapon_equiped():
	if Input.is_action_just_pressed("one"):
		weapon_choice = 1
	elif Input.is_action_just_pressed("two"):
		weapon_choice = 2
	elif Input.is_action_just_pressed("three"):
		weapon_choice = 3
	elif Input.is_action_just_pressed("four"):
		weapon_choice = 4
	elif Input.is_action_just_pressed("five"):
		weapon_choice = 5
	elif Input.is_action_just_pressed("six"):
		weapon_choice = 6
	elif Input.is_action_just_pressed("seven"):
		weapon_choice = 7
	elif Input.is_action_just_pressed("eight"):
		weapon_choice = 8
	elif Input.is_action_just_pressed("nine"):
		weapon_choice = 9

func hero_sword_attack():#sword attack
	if Input.is_action_just_pressed("left mouse button"):
		if $Sprite.flip_h == false:
			$HeroSword/AnimatedSprite.play()
			$HeroSword/CollisionShape2D.disabled = false
		elif $Sprite.flip_h == true:
			$HeroSword2/AnimatedSprite.play()
			$HeroSword2/CollisionShape2D.disabled = false
		hero_sword_timer.start()

func hero_sword_position():
	if weapon_choice != 2:
		$HeroSword.hide()
		$HeroSword2.hide()
		
	elif weapon_choice == 2:
		if $Sprite.flip_h == false:
			$HeroSword.show()
			$HeroSword2.hide()
		elif $Sprite.flip_h == true:
			$HeroSword.hide()
			$HeroSword2.show()

func attack():
	if can_shoot == true and dagger_number > 0 and weapon_choice == 1:
		if Input.is_action_just_pressed("left mouse button"):
			dagger_fire()
			dagger_deacrease()
	elif weapon_choice == 2:
			hero_sword_attack()

