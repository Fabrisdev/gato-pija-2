extends KinematicBody2D

export var gravity = 10
export var max_speed = 120
export var jump_force = 150
export var void_level = 300
export var dash_speed = 350
export var dash_cooldown = 0.35
export var degrees_to_rotate_by = 0.15
var motion = Vector2()
var rotating_direction = 0
var time_stopped = false
var skill_on_cooldown = false
var can_die = true
var has_already_used_double_jump = false
signal died

func _physics_process(delta):
	if time_stopped: return
	handle_death()
	handle_movement()
	handle_rotation()
	handle_jump()
	handle_skills()
	motion = move_and_slide(motion, Vector2.UP)

func has_died():
	for i in get_slide_count():
		if get_slide_collision(i).collider.is_in_group("danger"): return true
	return false
		
func has_fell():
	return position.y > void_level
	
func handle_death():
	if not can_die: return
	if not has_died() and not has_fell(): return
	modulate = Color.red
	emit_signal("died")

func handle_skills():
	if is_on_floor(): 
		has_already_used_double_jump = false
		modulate = Color("fff")
	if Input.is_action_just_pressed("jump") and not is_on_floor(): handle_wall_jump()
	if Input.is_action_just_pressed("jump") and not is_on_floor(): handle_double_jump_skill()
	if Input.is_action_just_pressed("use dash"): handle_dash_skill()

func _on_CooldownTimer_timeout(): 
	skill_on_cooldown = false
	modulate = Color("fff")

func _on_UI_skill_menu_opened():
	time_stopped = true
	$Manabar.visible = false
	WorldThemePlayer.pause()

func _on_UI_skill_menu_closed():
	time_stopped = false
	$Manabar.visible = true
	WorldThemePlayer.resume()

func _on_BabyBottle_level_completed(): can_die = false
func _on_Coin1_coin_obtained(): $"%UI".set_first_coin_as_obtained()
func _on_Coin2_coin_obtained(): $"%UI".set_second_coin_as_obtained()
func _on_Coin3_coin_obtained(): $"%UI".set_third_coin_as_obtained()

func handle_double_jump_skill():
	if is_on_wall(): return
	if has_already_used_double_jump: return
	$DoubleJumpSkillActivatedPlayer.play()
	$DoubleJumpParticles.emit()
	Input.start_joy_vibration(0, 0.2, 0.2, 0.2)
	has_already_used_double_jump = true
	modulate = Color("4aa2ff")
	motion.y = -jump_force * 1.5

func rotate_player(rotation_degrees):
	$Sprite.rotate(rotation_degrees)
	
func get_player_rotation_degrees():
	return $Sprite.rotation_degrees
	
func set_player_rotation_degrees(rotation_degrees):
	$Sprite.rotation_degrees = rotation_degrees

func handle_dash_skill():
	if $CooldownTimer.time_left != 0: return
	if $Manabar.remaining_mana < 50: 
		$NotEnoughManaPlayer.play()
		return
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right") and not Input.is_action_pressed("down") and not Input.is_action_pressed("look up joystick"):
		return
	$DashActiveTimer.start()
	$CooldownTimer.start(dash_cooldown)
	$Manabar.reduce_mana(50)
	$DashSkillActivatedPlayer.play()
	Input.start_joy_vibration(0, 0.2, 0.2, 0.6)
	motion.x = 0
	motion.y = 0
	handle_dash_input()
	modulate = Color("4aa2ff")
	has_already_used_double_jump = false
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
		
func handle_rotation():
	if is_on_floor():
		if Input.is_action_pressed("right"): rotating_direction = 1
		elif Input.is_action_pressed("left"): rotating_direction = -1
		else: rotating_direction = 0
	rotate_player(degrees_to_rotate_by * rotating_direction)
	if is_on_floor() or is_on_wall(): set_player_rotation_degrees(stepify(get_player_rotation_degrees(), 90))

func handle_jump():
	if is_on_floor() and Input.is_action_just_pressed("jump"): motion.y = -jump_force

func handle_movement():
	if $DashActiveTimer.time_left != 0: return
	motion.y += gravity
	var direction = 0
	if Input.is_action_pressed("left"): direction = -1
	elif Input.is_action_pressed("right"): direction = 1
	else: motion.x = lerp(motion.x, 0, 0.2)
	motion.x += direction * max_speed * 0.1
	motion.x = clamp(motion.x, -max_speed, max_speed)
