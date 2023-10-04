extends ConditionLeaf

@export var aggro_radius: Area2D
var aggrod := false
var target: Node2D = null

func tick(actor: Node, blackboard: Blackboard):
	if not aggro_radius.body_entered.is_connected(_on_body_entered):
		aggro_radius.body_entered.connect(_on_body_entered)
	if aggrod:
		print("Aggroing...")
		aggrod = false
		aggro_radius.body_entered.disconnect(_on_body_entered)
		blackboard.set_value("target", target)
		blackboard.set_value("leash_position", actor.global_position)
		return SUCCESS
	return FAILURE

func _on_body_entered(body: Node2D):
	print("player entered - checkaggro")
	aggrod = true
	target = body

