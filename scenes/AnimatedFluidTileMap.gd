extends TileMap
var offset = 0

func _process(delta):
	offset +=  delta;
	material.set_shader_param("offset", offset);
