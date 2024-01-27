extends RigidBody2D


@export var MovementSpeed = 400

var CurrentInputHandler = DefaultInputHandler;

func _process(delta):
	CurrentInputHandler.call(delta)
	
func DefaultInputHandler(delta):
	if Input.is_action_just_pressed("SecondaryAction"):
		print("Open Map")
		# TODO: open map
		CurrentInputHandler = MapOpenInputHandler
		return
	
	var direction = Input.get_vector(
		"WalkLeft",  # negative X
		"WalkRight", # positive X
		"WalkUp",    # negative Y
		"WalkDown")  # positive Y 
	
	var velocity = MovementSpeed * direction;
	
	if velocity.length() > 0:
		position += velocity * delta
		# TODO: set animation to walking
	else:
		pass # TODO: set animation to standing

func MapOpenInputHandler(delta):
	if Input.is_action_just_pressed("SecondaryAction"):
		print("Close Map")
		# TODO: close map
		CurrentInputHandler = DefaultInputHandler
