extends KinematicBody2D

export var gravity = 10
export var speed = 120
export var jump_force = 150
export var void_level = 300
export var dash_speed = 350
var motion = Vector2()
var rotatingRight = false
var rotatingLeft = false
var firstRotationDone = false
var time_stopped = false
var skill_equipped = "NONE"
var skill_on_cooldown = false
var can_die = true

signal died

func _physics_process(delta):
	if has_died() and can_die:
		emit_signal("died")
		handle_death()
		return
	if time_stopped:
		return
	if has_fell() and can_die:
		emit_signal("died")
		handle_death()
	controlMovement(delta)

func has_died():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("danger"):
			return true
	return false
		
func has_fell():
	return position.y > void_level
	
func handle_death():
	modulate = Color.red
	$"%UI/SkillWheel".can_open_menu = false

func controlMovement(delta: float):
	motion.y += gravity
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

func handle_skill(skill_equipped, delta):
	if skill_on_cooldown: return
	if skill_equipped == "DASH":
		if $Manabar.remaining_mana < 50: 
			$NotEnoughManaPlayer.play()
			return
		$DashActiveTimer.start()
		$CooldownTimer.start(1.5)
		$Manabar.reduce_mana(50)
		$DashSkillActivatedPlayer.play()
		$"../UI/EquippedSkill".play_cooldown_animation()
		if Input.is_action_pressed("right"):
			motion.x = dash_speed + gravity
		if Input.is_action_pressed("jump") or Input.is_action_pressed("look up joystick"):
			motion.y = -dash_speed
		if Input.is_action_pressed("left"):
			motion.x = -dash_speed
			
		
	skill_on_cooldown = true

func _on_UI_dash_skill_equipped():
	skill_equipped = "DASH"
	print("Skill equipped: " + skill_equipped)


func _on_CooldownTimer_timeout():
	skill_on_cooldown = false

func _on_UI_skill_menu_opened():
	time_stopped = true
	$Manabar.visible = false
	WorldThemePlayer.pause()

func _on_UI_skill_menu_closed():
	time_stopped = false
	$Manabar.visible = true
	WorldThemePlayer.resume()

func _on_BabyBottle_level_completed():
	can_die = false


func _on_Coin1_coin_obtained():
	$"%UI".set_first_coin_as_obtained()

func _on_Coin2_coin_obtained():
	$"%UI".set_second_coin_as_obtained()

func _on_Coin3_coin_obtained():
	$"%UI".set_third_coin_as_obtained()
