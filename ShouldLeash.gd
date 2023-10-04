extends ConditionLeaf

func tick(actor: Node, blackboard: Blackboard):
	print("Checking Should Leash...")
	if actor.leash_distance <= actor.global_position.distance_to(blackboard.get_value("leash_position")):
		return SUCCESS
	return FAILURE
