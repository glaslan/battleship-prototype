extends Area2D

@export var isClicked : bool = false 
signal clicked
@export var X : Line2D
@export var O : Line2D
@export var click1Audio : AudioStream
@export var click2Audio : AudioStream
@export var soundPlayer : AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	X.hide()
	O.hide()
	if get_child_count() > 0 and get_child(0) is CollisionShape2D:
		input_event.connect(_on_collision_shape_input_event)
	else:
		push_error("Area2D must have a CollisionShape2D child to detect clicks.")


func _on_collision_shape_input_event(viewport, event, shape_idx):
	# Check if the event is a mouse button press.
	if event is InputEventMouseButton:
		# Ensure it's the left mouse button and it's pressed (not released).
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Emit the clicked signal.  Any script connected to this
			# Area2D's "clicked" signal will be notified.
			clicked.emit()
			isClicked = true
			X.show()
			soundPlayer.stream = click1Audio
			soundPlayer.play()
			print("Area2D X clicked!") # For debugging.
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			# Emit the clicked signal.  Any script connected to this
			# Area2D's "clicked" signal will be notified.
			clicked.emit()
			isClicked = true
			O.show()
			soundPlayer.stream = click2Audio
			soundPlayer.play()
			print("Area2D O clicked!") # For debugging.
