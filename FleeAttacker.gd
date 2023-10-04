extends ActionLeaf

@onready var timer := $Timer

var target_reached = false
var target = null
var calmed = false
var flee_magnitude := 400

func tick(actor: Node, blackboard: Blackboard):
	if not actor.target_reached.is_connected(_target_reached):
		actor.target_reached.connect(_target_reached)
	if not timer.timeout.is_connected(_done_fleeing):
		timer.timeout.connect(_done_fleeing)
	if calmed:
		print("Calmed")
		calmed = false
		target_reached = false
		target = null
		actor.target_location = actor.global_position
		actor.max_speed = actor.max_speed / 3
		timer.timeout.disconnect(_done_fleeing)
		actor.target_reached.disconnect(_target_reached)
		return SUCCESS
	if target == null:
		timer.start()
		actor.max_speed = actor.max_speed * 3
		target = actor.global_position + (flee_direction(actor.global_position, blackboard.get_value("attack_origin")) * flee_magnitude)
		actor.target_location = target
		print(str(actor.target_location))
	if target_reached:
		target_reached = false
		target = actor.global_position + (flee_direction(actor.global_position, blackboard.get_value("attack_origin")) * flee_magnitude)
		actor.target_location = target
	return RUNNING

func flee_direction(actor_global_pos: Vector2, attack_origin: Vector2) -> Vector2:
	# return actor_global_pos.direction_to(attack_origin)
	return attack_origin.direction_to(actor_global_pos)

func _target_reached():
	target_reached = true

func _done_fleeing():
	calmed = true
