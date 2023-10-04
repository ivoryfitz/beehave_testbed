extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard):
	print("Checking should attack....")
	var target: Node2D = blackboard.get_value("target")
	if is_in_range(target.global_position, actor.global_position, actor.attack_range):
		return SUCCESS
	return FAILURE

func is_in_range(pos1: Vector2, pos2: Vector2, threshold: float) -> bool:
	return pos1.distance_to(pos2) <= threshold
