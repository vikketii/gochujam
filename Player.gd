extends Area2D


const GRAVITY = 6
const JUMP_FORCE = 5

export var speed = 100
var screen_size

var jump_position = 1
var jump_velocity = 0
var jumps = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.play("idle")

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	jump_velocity += delta * (-GRAVITY)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite.rotation_degrees = 90
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite.rotation_degrees = 270
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite.rotation_degrees = 180
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite.rotation_degrees = 0
	if Input.is_action_just_pressed("move_jump") and jumps < 2:
		jump_velocity = JUMP_FORCE
		jumps += 1 

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
	
	jump_position += jump_velocity * delta
	jump_position = clamp(jump_position, 1, 8)
	self.scale = Vector2(jump_position, jump_position)
	
	if jump_position == 1:
		jumps = 0
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x > 0 and velocity.y < 0:
		$AnimatedSprite.rotation_degrees = 45
	if velocity.x > 0 and velocity.y > 0:
		$AnimatedSprite.rotation_degrees = 135
	if velocity.x < 0 and velocity.y > 0:
		$AnimatedSprite.rotation_degrees = 225
	if velocity.x < 0 and velocity.y < 0:
		$AnimatedSprite.rotation_degrees = 315
	
