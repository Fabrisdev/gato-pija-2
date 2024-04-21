extends Sprite

var the_offset = 0

func _process(delta):
	the_offset += 0.3 * delta;
	material.set_shader_param("offset", the_offset);
