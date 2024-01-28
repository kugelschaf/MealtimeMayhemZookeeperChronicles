extends CharacterBody2D

const PI_FOURTH = PI / 4
const PI_HALF = PI / 2

@export var MovementSpeed = 60
@export var WalkingDirection = CompasDirection.SOUTH

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
	if IsPrimaryActionJustPressed():
		TryInteractWithNearestEntity()
		
	if IsSecondaryActionJustPressed():
		OpenMap()

func _physics_process(delta):		
	var direction = Input.get_vector(
		"WalkLeft",  # negative X
		"WalkRight", # positive X
		"WalkUp",    # negative Y
		"WalkDown")  # positive Y

	var directionIsDefined = direction.length() > 0

	if directionIsDefined:
		var _velocity = MovementSpeed * direction;
		
		move_and_collide(_velocity * delta)
		
		WalkingDirection = ConvertToCompasDirection(direction)
		PlayAnimation(AnimationType.WALK, WalkingDirection)
	else:
		PlayAnimation(AnimationType.IDLE, WalkingDirection)


func ConvertToCompasDirection(direction: Vector2) -> CompasDirection: 
	var angle = direction.angle()
	var discreteAngle = snappedf(angle / PI_FOURTH, 1)
	
	if discreteAngle == -4:
		discreteAngle = 4

	assert(discreteAngle > -4 and discreteAngle <= 4, 
		"This should be an impossible state (angle: " + str(angle) +
		"discreteAngle " + str(discreteAngle) + 
		"). A circle can't have more than 360 degrees.")

	return discreteAngle


func ConvertWalkingDirectionToAngle(direction: CompasDirection) -> float:
	return direction * PI_FOURTH - PI_HALF


func PlayAnimation(type: AnimationType, direction: CompasDirection):
	var animationName = AnimationType.keys()[type] + "-" + \
						CompasDirection.keys()[direction]
	
	$PlayerSpriteAnimation.play(animationName)


func TryInteractWithNearestEntity():
	var interactionArea: Area2D = $PlayerInteractionArea
	interactionArea.rotation = ConvertWalkingDirectionToAngle(WalkingDirection)

	var bodies = interactionArea.get_overlapping_bodies()
		
	for body in bodies:
		if body == self:
			continue
		
		if (body.has_method("PrimaryAction")):
			body.call("PrimaryAction")
			return true
		
	print_debug("Found no entity to interact with.")
	return false

func OpenMap():
	print_verbose("Open map")
	push_warning("TODO: Not implemented yet")
