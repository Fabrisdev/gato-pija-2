extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 10
const MAXTIREDSPEED = 80
const MAXSPEED = 100
const MAXRUNNINGSPEED = 120
const JUMPFORCE = 150
var motion = Vector2()
var rotatingRight = false
var rotatingLeft = false
var firstRotationDone = false

func _physics_process(_delta):
	controlMovement()

func controlMovement():
	motion.y += GRAVITY
	var consumedHealthRect = get_node("../CanvasLayer/ConsumedHealthColor")
	var fullHealthRect = get_node("../CanvasLayer/FullHealthColor")
	var remainingHealth = (fullHealthRect.rect_size.x - consumedHealthRect.rect_size.x) - 1
	if remainingHealth > 1:
		if Input.is_action_pressed("run") && Input.is_action_pressed("left"):
			motion.x = clamp(motion.x, -MAXRUNNINGSPEED, MAXRUNNINGSPEED)
			motion.x -= MAXRUNNINGSPEED * 0.1
			reduceHealth()
		elif Input.is_action_pressed("run") && Input.is_action_pressed("right"):
			motion.x = clamp(motion.x, -MAXRUNNINGSPEED, MAXRUNNINGSPEED)
			motion.x += MAXRUNNINGSPEED * 0.1
			reduceHealth()
		elif Input.is_action_pressed("left"):
			motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
			motion.x -= MAXSPEED * 0.1
			incrementHealth()
		elif Input.is_action_pressed("right"):
			motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
			motion.x += MAXSPEED * 0.1
			incrementHealth()
		else:
			motion.x = lerp(motion.x, 0, 0.2)
			incrementHealth()
	elif not Input.is_action_pressed("run"):
		if Input.is_action_pressed("left"):
			motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
			motion.x -= MAXSPEED * 0.1
		elif Input.is_action_pressed("right"):
			motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
			motion.x += MAXSPEED * 0.1
		else:
			motion.x = lerp(motion.x, 0, 0.2)
		incrementHealth()
	else:
		if Input.is_action_pressed("left"):
			motion.x = clamp(motion.x, -MAXTIREDSPEED, MAXTIREDSPEED)
			motion.x -= MAXTIREDSPEED * 0.1
		elif Input.is_action_pressed("right"):
			motion.x = clamp(motion.x, -MAXTIREDSPEED, MAXTIREDSPEED)
			motion.x += MAXTIREDSPEED * 0.1
		else:
			motion.x = lerp(motion.x, 0, 0.2)
			
	if rotatingRight:
		if not firstRotationDone:
			if floor(abs(rotation_degrees)) in range(170, 179):
				rotation_degrees = 180
				rotatingRight = false
				firstRotationDone = true
			else:
				rotate(0.15)
		else:
			if floor(abs(rotation_degrees)) in range(0, 10):
				rotation_degrees = 0
				rotatingRight = false
				firstRotationDone = false
			else:
				rotate(0.15)
	
	if rotatingLeft:
		if not firstRotationDone:
			if floor(abs(rotation_degrees)) in range(170, 179):
				rotation_degrees = 180
				rotatingLeft = false
				firstRotationDone = true
			else:
				rotate(-0.15)
		else:
			if floor(abs(rotation_degrees)) in range(0, 10):
				rotation_degrees = 0
				rotatingLeft = false
				firstRotationDone = false
			else:
				rotate(-0.15)
				
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
			if Input.is_action_pressed("right"):
				rotatingRight = true
			elif Input.is_action_pressed("left"):
				rotatingLeft = true
			
	motion = move_and_slide(motion, UP)
func reduceHealth():
	var FullHealthRect = get_node("../CanvasLayer/FullHealthColor")
	var MAX_HEALTH = FullHealthRect.rect_size.x
	var MIN_POSITION = FullHealthRect.rect_position.x
	var MAX_POSITION = FullHealthRect.rect_position.x + MAX_HEALTH
	var consumedHealthRect = get_node("../CanvasLayer/ConsumedHealthColor")
	
	consumedHealthRect.set_position(Vector2(consumedHealthRect.rect_position.x - 1, consumedHealthRect.rect_position.y))
	consumedHealthRect.set_size(Vector2(consumedHealthRect.rect_size.x + 1, consumedHealthRect.rect_size.y))
	consumedHealthRect.rect_size.x = clamp(consumedHealthRect.rect_size.x, 0, MAX_HEALTH)
	consumedHealthRect.rect_position.x = clamp(consumedHealthRect.rect_position.x, MIN_POSITION, MAX_POSITION)

func incrementHealth():
	var FullHealthRect = get_node("../CanvasLayer/FullHealthColor")
	var MAX_HEALTH = FullHealthRect.rect_size.x
	var MIN_POSITION = FullHealthRect.rect_position.x
	var MAX_POSITION = FullHealthRect.rect_position.x + MAX_HEALTH
	var consumedHealthRect = get_node("../CanvasLayer/ConsumedHealthColor")
	
	consumedHealthRect.set_position(Vector2(consumedHealthRect.rect_position.x + 1, consumedHealthRect.rect_position.y))
	consumedHealthRect.set_size(Vector2(consumedHealthRect.rect_size.x - 1, consumedHealthRect.rect_size.y))
