extends ActionLeaf

var wander_points = [
	Vector2(0, -200),
	Vector2(0, 200),
	Vector2(200, 0),
	Vector2(-200, 0)
]

var target_reached = false
var target = null

func tick(actor: Node, _blackboard: Blackboard):
	if not actor.target_reached.is_connected(_target_reached):
		actor.target_reached.connect(_target_reached)
	if target_reached:
		target_reached = false
		target = null
		actor.target_reached.disconnect(_target_reached)
		return SUCCESS
	if target == null:
		target = wander_points[randi_range(0, 3)]
		print("Wandering Relative to " + str(target))
		actor.target_location = actor.global_position + target
		print("wander global " + str(actor.target_location))
	return RUNNING

func _target_reached():
	target_reached = true
