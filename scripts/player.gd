extends KinematicBody2D


export (int) var run_speed = 100
export (int) var jump_speed = -250
export (int) var gravity = 600

var velocity = Vector2()
var jumping = false
var movendo = false

func get_input():
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var jump = Input.is_action_just_pressed('jump')
	movendo = right or left

	velocity.x = 0
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		$sprite.flip_h = false
	if left:
		velocity.x -= run_speed
		$sprite.flip_h = true
	pass

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1), true)
	setAnim()
	pass

func setAnim():
	if !is_on_floor():
		if velocity.y < 0:
			$anim.play("jump")
		else:
			$anim.play("fall")
	else:
		if movendo:
			$anim.play("walk")
		else:
			$anim.play("idle")
	pass

