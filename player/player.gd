extends CharacterBody3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x*0.4
		%Camera3D.rotation_degrees.x -= event.relative.y*0.4
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -70,70)
		
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func _physics_process(delta):
	const speed = 5.5
	var inputDirection2D = Input.get_vector(
		"move_left", "move_right", "move_forward","move_back"
	)
	
	var inputDirection3D = Vector3(
		inputDirection2D.x, 0.0,inputDirection2D.y
	)
	var direction = transform.basis*inputDirection3D
	
	velocity.x = direction.x*speed
	velocity.z = direction.z*speed
	if Input.is_action_just_pressed("jump"):
		velocity.y=10.0
	move_and_slide()
	
