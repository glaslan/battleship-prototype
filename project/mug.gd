extends Area2D

@export var isBroken : bool = false 
signal clicked

@export var sprite : Sprite2D
@export var brokenTexture : Texture2D

func _ready() -> void:
	if get_child_count() > 0 and get_child(0) is CollisionShape2D:
		input_event.connect(_on_collision_shape_input_event)
	else:
		push_error("Area2D must have a CollisionShape2D child to detect clicks.")
	if sprite == null:
		push_error("sprite is not set in the Inspector.")
	if brokenTexture == null:
		push_error("broken texture is not set in the Inspector.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_collision_shape_input_event(viewport, event, shape_idx):
	# Check if the event is a mouse button press.
	if event is InputEventMouseButton:
		# Ensure it's the left mouse button and it's pressed (not released).
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Emit the clicked signal.  Any script connected to this
			# Area2D's "clicked" signal will be notified.
			clicked.emit()
			isBroken = true
			sprite.texture = brokenTexture
			print("Area2D clicked!") # For debugging.
