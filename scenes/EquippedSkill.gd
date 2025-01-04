extends Control
var equipped_skill = "NONE"

func show_skill(skill):
	hide_skill()
	if skill == "DASH":
		$DashSprite.visible = true
	if skill == "DOUBLE JUMP":
		$DoubleJumpSprite.visible = true

func show_current_skill():
	show_skill(equipped_skill)

func hide_skill():
	$DashSprite.visible = false
	$DoubleJumpSprite.visible = false

func _on_SkillWheel_dash_skill_equipped():
	show_skill("DASH")
	equipped_skill = "DASH"

func _on_SkillWheel_double_jump_skill_equipped():
	show_skill("DOUBLE JUMP")
	equipped_skill = "DOUBLE JUMP"

func _on_SkillWheel_skill_menu_closed():
	show_current_skill()


func _on_SkillWheel_skill_menu_opened():
	hide_skill()
	
func play_cooldown_animation():
	$CooldownCircle.visible = true
	$Animator.play("cooldown")
