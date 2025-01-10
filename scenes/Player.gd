extends KinematicBody2D

export var gravity = 10
export var speed = 120
export var jump_force = 150
export var void_level = 300
export var dash_speed = 350
var diagonal_dash_speed = sqrt(pow(dash_speed, 2) / 2)
var motion = Vector2()
var rotatingRight = false
var rotatingLeft = false
var firstRotationDone = false
var time_stopped = false
var skill_equipped = "NONE"
var skill_on_cooldown = false
var can_die = true
var has_already_used_double_jump = false
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
	else:
		motion.y -= gravity
		if is_on_ceiling() || is_on_floor() || is_on_wall():
			$DashActiveTimer.stop()
	
	if skill_equipped != "NONE" and Input.is_action_just_pressed("use skill"):
		handle_skill(skill_equipped, delta)	
		
	if is_on_floor(): 
		has_already_used_double_jump = false
		if skill_equipped == "DOUBLE JUMP":
			$"../UI/EquippedSkill".play_reset_cooldown_animation()
	if skill_equipped == "DOUBLE JUMP" and Input.is_action_just_pressed("jump"):
		motion.y = handle_double_jump_skill(motion.y)
	
	if rotatingRight:
		if not firstRotationDone:
			if floor(abs(get_player_rotation_degrees())) in range(170, 179):
				set_player_rotation_degrees(180)
				rotatingRight = false
				firstRotationDone = true
			else:
				rotate_player(0.15)
		else:
			if floor(abs(get_player_rotation_degrees())) in range(0, 10) || floor(abs(get_player_rotation_degrees())) in range(350, 370):
				set_player_rotation_degrees(0)
				rotatingRight = false
				firstRotationDone = false
			else:
				rotate_player(0.15)
	
	if rotatingLeft:
		if not firstRotationDone:
			if floor(abs(get_player_rotation_degrees())) in range(170, 179):
				set_player_rotation_degrees(180)
				rotatingLeft = false
				firstRotationDone = true
			else:
				rotate_player(-0.15)
		else:
			if floor(abs(get_player_rotation_degrees())) in range(0, 10):
				set_player_rotation_degrees(0)
				rotatingLeft = false
				firstRotationDone = false
			else:
				rotate_player(-0.15)
	
	if not is_on_floor() and Input.is_action_just_pressed("jump"):
		handle_wall_jump()
		
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
	if skill_equipped == "DASH": handle_dash_skill()

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


func _on_UI_double_jump_skill_equipped():
	skill_equipped = "DOUBLE JUMP"
	print("Skill equipped: " + skill_equipped)

func handle_double_jump_skill(motion_y):
	if is_on_floor(): 
		has_already_used_double_jump = false
		$"../UI/EquippedSkill".play_reset_cooldown_animation()
		return motion_y
	if has_already_used_double_jump: return motion_y
	if $Manabar.remaining_mana < 20:
		$NotEnoughManaPlayer.play()
		return motion_y
	$Manabar.reduce_mana(20)
	$DoubleJumpSkillActivatedPlayer.play()
	has_already_used_double_jump = true
	$DoubleJumpParticles.emit()
	$"../UI/EquippedSkill".play_set_on_cooldown_animation()
	Input.start_joy_vibration(0, 0.2, 0.2, 0.2)
	return -jump_force * 1.5

func rotate_player(rotation_degrees):
	$Sprite.rotate(rotation_degrees)
	$CollisionShape2D.rotate(rotation_degrees)
	
func get_player_rotation_degrees():
	return $Sprite.rotation_degrees
	
func set_player_rotation_degrees(rotation_degrees):
	$Sprite.rotation_degrees = rotation_degrees
	$CollisionShape2D.rotation_degrees = rotation_degrees

func handle_dash_skill():
	if is_on_floor(): return
	if $Manabar.remaining_mana < 50: 
		$NotEnoughManaPlayer.play()
		return
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right") and not Input.is_action_pressed("down") and not Input.is_action_pressed("look up joystick"):
		return
	$DashActiveTimer.start()
	$CooldownTimer.start(0.5)
	$Manabar.reduce_mana(50)
	$DashSkillActivatedPlayer.play()
	$"../UI/EquippedSkill".play_cooldown_animation()
	Input.start_joy_vibration(0, 0.2, 0.2, 0.6)
	motion.x = 0
	motion.y = 0
	handle_dash_input()
	skill_on_cooldown = true

func handle_dash_input():
	if Input.is_action_pressed("left"): motion.x = -1
	if Input.is_action_pressed("right"): motion.x = 1
	if Input.is_action_pressed("look up joystick"): motion.y = -1
	if Input.is_action_pressed("down"): motion.y = 1
	motion = motion.normalized() * dash_speed

func handle_wall_jump():
	var is_touching_left_side = false
	var is_touching_right_side = false
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		var normal = collision.normal
		if normal.x < 0:
			is_touching_right_side = true
		elif normal.x > 0:
			is_touching_left_side = true
	if is_touching_left_side:
		motion.y = -jump_force * 1.5
		motion.x = jump_force * 1.5
		$DoubleJumpParticles.emit()
		$DoubleJumpSkillActivatedPlayer.play()
	if is_touching_right_side:
		motion.y = -jump_force * 1.5
		motion.x = -jump_force * 1.5
		$DoubleJumpParticles.emit()
		$DoubleJumpSkillActivatedPlayer.play()
