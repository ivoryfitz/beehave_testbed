extends ConditionLeaf

var attack_origin: Vector2
var actor_was_attacked := false

func tick(actor: Node, blackboard: Blackboard):
	if not actor.was_attacked.is_connected(_actor_was_attacked):
		actor.was_attacked.connect(_actor_was_attacked)
	if actor_was_attacked:
		actor.was_attacked.disconnect(_actor_was_attacked)
		actor_was_attacked = false
		blackboard.set_value("attack_origin", attack_origin)
		return SUCCESS
	else:
		return FAILURE

func _actor_was_attacked(origin: Vector2):
	attack_origin = origin
	actor_was_attacked = true
