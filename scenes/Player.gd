extends KinematicBody2D

const GRAVITY = 10
const MAXTIREDSPEED = 80
const MAXSPEED = 100
const MAXRUNNINGSPEED = 120
const JUMPFORCE = 150
var motion = Vector2()
var rotatingRight = false
var rotatingLeft = false
var firstRotationDone = false
var time_stopped = false

signal died

func _physics_process(delta):
	if has_died():
		emit_signal("died")
		handle_death()
		return
	if time_stopped:
		return
	controlMovement(delta)

func has_died():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		return collision.collider.is_in_group("danger")

func handle_death():
	modulate = Color.red

func controlMovement(delta: float):
	motion.y += GRAVITY
	if Input.is_action_pressed("left"):
		motion.x = clamp(motion.x, -MAXRUNNINGSPEED, MAXRUNNINGSPEED)
		motion.x -= MAXRUNNINGSPEED * 0.1
	elif Input.is_action_pressed("right"):
		motion.x = clamp(motion.x, -MAXRUNNINGSPEED, MAXRUNNINGSPEED)
		motion.x += MAXRUNNINGSPEED * 0.1
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
	motion = move_and_slide(motion, Vector2.UP)

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


func _on_SkillWheel_skill_menu_opened():
	time_stopped = true


func _on_SkillWheel_skill_menu_closed():
	time_stopped = false
