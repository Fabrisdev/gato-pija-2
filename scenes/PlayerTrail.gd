extends Line2D

export var length = 25

func _process(delta):
	if get_point_count() == length or $"../Player/DashActiveTimer".time_left == 0:
		if get_point_count() > 0: remove_point(0)
		return
	var point_pos = $"../Player".position
	point_pos.y += 4
	add_point(point_pos)
