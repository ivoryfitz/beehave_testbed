extends ActionLeaf

var target: Node2D
var target_reached := false

func tick(actor: Node, blackboard: Blackboard):
	if not actor.target_reached.is_connected(_target_reached):
		actor.target_reached.connect(_target_reached)
	target = blackboard.get_value("target")
	actor.target_location = target.global_position
	actor.distance_tester = make_distance_threshold_tester(actor.global_position, target.global_position, actor.attack_range)
	if target_reached:
		print("Pursuit Success...")
		target = null
		target_reached = false
		actor.target_reached.disconnect(_target_reached)
		actor.target_location = actor.global_position
		return SUCCESS
	print("Pursuing...")
	return RUNNING

func interrupt(actor: Node, _blackboard: Blackboard) -> void:
	target = null
	target_reached = false
	actor.target_reached.disconnect(_target_reached)

func _target_reached():
	print("Oh shit I'm still connected...-Pursuit")
	target_reached = true

func make_distance_threshold_tester(pos1: Vector2, pos2: Vector2, threshold: float) -> Callable:
	return (func test() -> bool: return pos1.distance_to(pos2) <= threshold)
