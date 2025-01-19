extends Line2D

export var length = 25

func _ready():
	set_as_toplevel(true)

func _process(delta):
	if get_point_count() == length or $"../DashActiveTimer".time_left == 0:
		if get_point_count() > 0: remove_point(0)
		return
	var point_pos = get_parent().global_position
	point_pos.y += 4
	add_point(point_pos)
