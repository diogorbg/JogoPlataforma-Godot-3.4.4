extends KinematicBody2D


const GRAVITY = 9.8 * 16.0 * 3.0
const WALK_FORCE = 800
const STOP_FORCE = 1000
const WALK_MAX_SPEED = 100
const JUMP_SPEED = 250

var dirX = 0
var velocity = Vector2()
var noChao = false
var pulando = false
var estavaNoAr = false

# É recomendado inicializar as referências com onready ou na função _ready
onready var sprite = $sprite
onready var rayCast1 = $rayCast1
onready var rayCast2 = $rayCast2
onready var anim = $anim
onready var animScale = $animScale

func _physics_process(delta):
	noChao = rayCast1.is_colliding() or rayCast2.is_colliding() or is_on_floor()
	if (pulando and velocity.y>=0):
		pulando = false

	moveProcess(delta)

	if noChao and Input.is_action_just_pressed("jump"):
		pulando = true
		velocity.y = -JUMP_SPEED
		animScale.play("jump")
		
	if noChao and estavaNoAr and not pulando:
		animScale.play("fall")

	animUpdate()
	
	estavaNoAr = !noChao

func animUpdate():
	if dirX > 0:
		sprite.flip_h = false
	elif dirX < 0:
		sprite.flip_h = true

	var movendo = abs(dirX) > 0
	if noChao and not pulando:
		if movendo:
			anim.play("walk")
		else:
			anim.play("idle")
	else:
		if velocity.y <= 0:
			anim.play("jump")
		else:
			anim.play("fall")

func moveProcess(delta):
	dirX = 0
	dirX += Input.get_action_strength("move_right")
	dirX -= Input.get_action_strength("move_left")

	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * dirX
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply GRAVITY.
	velocity.y += GRAVITY * delta

	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP, true)


func _on_areaAgua_body_entered(body):
	print(body.name)
	if get_tree().reload_current_scene() != OK:
		print("Erro ao recarregar cena!")
