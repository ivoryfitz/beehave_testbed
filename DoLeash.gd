extends ActionLeaf

var target: Node2D
var target_reached := false

func tick(actor: Node, blackboard: Blackboard):
	if not actor.target_reached.is_connected(_target_reached):
		print("Leashing")
		actor.target_reached.connect(_target_reached)
	var target_location: Vector2 = blackboard.get_value("leash_position")
	actor.target_location = target_location
	actor.distance_tester = actor.default_distance_tester
	if target_reached:
		target = null
		target_reached = false
		actor.target_reached.disconnect(_target_reached)
		actor.target_location = actor.global_position
		return SUCCESS
	return RUNNING

func _target_reached():
	target_reached = true
