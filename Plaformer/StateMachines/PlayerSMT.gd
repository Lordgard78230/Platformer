extends StateMachine


extends StateMachine





func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)
	
func _input(event: InputEvent) -> void: #jump
	if [states.idel, states.run].has(state):
		if event.is_action_pressed("jump"):
			parent.player_velocity.y = parent.max_jump_velocity
			parent.is_jumping = true

func state_logic(delta):
	parent._get_input()
	parent.apply_gravity(delta)
	parent.movement()

func get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.player_velocity.y < 0:
					return states.jump
				elif  parent.player_velocity.y > 0:
					return states.fall
			elif parent.player_velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent.player_velocity.y < 0:
					return states.jump
				elif  parent.player_velocity.y > 0:
					return states.fall
			elif parent.player_velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idel
			elif parent.player_velocity.y > 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idel
			elif parent.player_velocity.y < 0:
				return states.jump
		
	return null

func enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.body.sprite.play("Idle")#help
		states.run:
			parent.body.sprite.play("Run")
		states.jump:
			parent.body.sprite.play("Run")
		states.fall:
			parent.body.sprite.play("Run")

func exit_state(old_state, new_state):
	pass
