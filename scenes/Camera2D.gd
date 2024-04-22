extends Camera2D

const ZOOM_AMOUNT = 0.3
const DEFAULT_ZOOM = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("wheel up"):
		zoom_in(delta)
	if Input.is_action_just_released("wheel down"):
		zoom_out(delta)
	if Input.is_action_just_pressed("reset zoom"):
		reset_zoom()

func zoom_in(delta):
	zoom = Vector2(zoom.x - ZOOM_AMOUNT * delta, zoom.y - ZOOM_AMOUNT * delta)
		
func zoom_out(delta):
	zoom = Vector2(zoom.x + ZOOM_AMOUNT * delta, zoom.y + ZOOM_AMOUNT * delta)

func reset_zoom():
	zoom = Vector2(DEFAULT_ZOOM, DEFAULT_ZOOM)
