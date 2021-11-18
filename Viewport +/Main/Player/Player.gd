extends KinematicBody2D

var jet

onready var feet = $Feelings/Feet
onready var checker = $Feelings/Checker

onready var body = $Body
onready var animations = $Body/Animations

enum states {IDLE, RUN, AIR, SKID}
var state = states.AIR
var previous_state = states.IDLE

const FLOOR_NORMAL = Vector2.UP
const FRICTION = 18

export (float) var air_acceleration
const WIND_RESISTANCE = Vector2(1.2, 0.6)

const GRAVITY = 98
var gravity_scale = 4.5

const MAX_SPEED = 60
var velocity = Vector2.DOWN * GRAVITY
export (float) var acceleration = 200
var direction = Vector2.DOWN
var facing_direction = 1

func _physics_process(delta):
	match state:
		states.IDLE:
			if get_input().x != 0:
				change_state(states.RUN)
			if !is_on_ground():
				change_state(states.AIR)
			
			velocity.x = lerp(velocity.x, 0, FRICTION * delta)
			velocity = move_and_slide(velocity)
		states.RUN:
			if !is_on_ground():
				change_state(states.AIR)
			if get_input().x == 0:
				change_state(states.IDLE)
			
			velocity += get_velocity(acceleration) * delta
			velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
			velocity = move_and_slide(velocity)
		states.AIR:
			if is_on_ground():
				if abs(velocity.x) > FRICTION:
					change_state(states.SKID)
					return
				change_state(states.RUN)
			
			velocity += get_velocity(air_acceleration) * delta
			
			velocity.x = lerp(velocity.x, 0, WIND_RESISTANCE.x * delta)
			velocity.y = lerp(velocity.y, 0, WIND_RESISTANCE.y * delta)
			
			velocity = move_and_slide(velocity)
	
	body.scale.x = facing_direction

func is_on_ground():
	return feet.get_overlapping_bodies().size() > 0

func get_input():
	var _dir = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left") , 1.0)
	
	if _dir.x != 0:
		facing_direction = _dir.x
	
	return _dir

func get_velocity(_acceleration):
	direction = get_input()
	var new_velocity = Vector2()
	new_velocity.x = direction.x * _acceleration
	
	if !is_on_floor():
		new_velocity.y = GRAVITY * gravity_scale
	return new_velocity

func apply_impulse(impulse):
	velocity += impulse

#State logic...
func change_state(new_state):
	#this is temp-solution (make the stall func only call once)
	if new_state != state:
		previous_state = state
		state = new_state
		
		if new_state == states.AIR:
			return
		
		match new_state:
			states.IDLE:
				animations.play("Idle")
			states.RUN:
				animations.play("Run")
			states.SKID:
				animations.play("Skid")

func _pressed():
	print("player")
