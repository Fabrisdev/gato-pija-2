extends KinematicBody2D

export var gravity = 10
export var speed = 120
export var jump_force = 150
export var void_level = 300
var motion = Vector2()
var rotatingRight = false
var rotatingLeft = false
var firstRotationDone = false
var time_stopped = false
var skill_equipped = "NONE"

signal died

func _physics_process(delta):
	if has_died():
		emit_signal("died")
		handle_death()
		return
	if time_stopped:
		return
	if has_fell():
		emit_signal("died")
		handle_death()
	controlMovement(delta)

func has_died():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		return collision.collider.is_in_group("danger")
		
func has_fell():
	return position.y > void_level
	
func handle_death():
	modulate = Color.red

func controlMovement(delta: float):
	motion.y += gravity
	print($DashActiveTimer.time_left)
	if $DashActiveTimer.time_left == 0:
		if Input.is_action_pressed("left"):
			motion.x = clamp(motion.x, -speed, speed)
			motion.x -= speed * 0.1
		elif Input.is_action_pressed("right"):
			motion.x = clamp(motion.x, -speed, speed)
			motion.x += speed * 0.1
		else:
			motion.x = lerp(motion.x, 0, 0.2)
		
	if skill_equipped != "NONE" and Input.is_action_just_pressed("use skill"):
		handle_skill(skill_equipped, delta)	
	
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
			motion.y = -jump_force
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

func handle_skill(skill_equipped, delta):
	print("intento")
	if skill_equipped == "DASH":
		$DashActiveTimer.start()
		if Input.is_action_pressed("right"):
			print('right')
			motion.x = 350
		if Input.is_action_pressed("jump"):
			print('jump')
			motion.y = -350
		if Input.is_action_pressed("left"):
			print('left')
			motion.x = -350

func _on_SkillWheel_dash_skill_equipped():
	skill_equipped = "DASH"
	print("Skill equipped: " + skill_equipped)
