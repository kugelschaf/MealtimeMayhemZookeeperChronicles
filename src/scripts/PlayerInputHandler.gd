extends CharacterBody2D

const PI_4TH = PI / 4
@export var MovementSpeed = 40

var CurrentInputHandler = DefaultInputHandler;
var WalkingDirection = CompasDirection.SOUTH

enum AnimationType
{
	IDLE,
	WALK
}

enum CompasDirection 
{
	EAST = 0,
	SOUTH_EAST = 1,
	SOUTH = 2,
	SOUTH_WEST = 3,
	WEST = 4,
	NORTH_WEST = -3,
	NORTH = -2,
	NORTH_EAST = -3,
}

func IsPrimaryActionJustPressed():
	return Input.is_action_just_pressed("PrimaryAction")


func IsSecondaryActionJustPressed():
	return Input.is_action_just_pressed("SecondaryAction")


func _process(delta):
	CurrentInputHandler.call(delta)


func DefaultInputHandler(delta):
	var direction = Input.get_vector(
		"WalkLeft",  # negative X
		"WalkRight", # positive X
		"WalkUp",    # negative Y
		"WalkDown")  # positive Y

	var directionIsDefined = direction.length() > 0
	
	if IsPrimaryActionJustPressed():
		var interactionArea: Area2D = $PlayerInteractionArea
		#interactionArea.transform.set_rotation(direction.angle())
		var bodies = interactionArea.get_overlapping_bodies()
		
		var interacted = false
		for body in bodies:
			if body == self:
				continue
			
			if (body.has_method("PrimaryAction")):
				body.call("PrimaryAction")
				interacted = true
				break;
		
		if not interacted:
			print_debug("Found no body to interact with")
	
	if IsSecondaryActionJustPressed():
		$PlayerInteractionArea.set_
		
		#print("Open Map")
		# TODO: open map
		#CurrentInputHandler = MapOpenInputHandler
		return
	
	if directionIsDefined:
		var _velocity = MovementSpeed * direction;
		
		move_and_collide(_velocity * delta)
		
		WalkingDirection = ConvertToCompasDirection(direction)
		PlayAnimation(AnimationType.WALK, WalkingDirection)
	else:
		PlayAnimation(AnimationType.IDLE, WalkingDirection)

func ConvertToCompasDirection(direction: Vector2) -> CompasDirection: 
	var angle = direction.angle()
	var discreteAngle = snappedf(angle / (PI / 4), 1)
	
	if discreteAngle == -4:
		discreteAngle = 4

	assert(discreteAngle > -4 and discreteAngle <= 4, 
		"This should be an impossible state (angle: " + str(angle) +
		"discreteAngle " + str(discreteAngle) + 
		"). A circle can't have more than 360 degrees.")

	return discreteAngle

func PlayAnimation(type: AnimationType, direction: CompasDirection):
	var animationName = AnimationType.keys()[type] + "-" + \
						CompasDirection.keys()[direction]
	
	$PlayerSpriteAnimation.play(animationName)

func MapOpenInputHandler(delta):
	# TODO: implement map
	print_debug("Map not implemented yet!")
	CurrentInputHandler = DefaultInputHandler
