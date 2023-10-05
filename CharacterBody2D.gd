extends CharacterBody2D
class_name Sheep

signal target_reached
signal was_attacked(attack_origin: Vector2)

@onready var rays := $Rays
@onready var aggro_radius := $AggroRadius
var target_location := self.global_position:
	set(new_target_location):
		target_location = new_target_location
		enroute = true 
var enroute := false
var max_speed := 100
var attack_range := 50
var distance_tester: Callable = default_distance_tester
var leash_distance := 400

func _ready():
	aggro_radius.body_entered.connect(_on_body_entered)

func _physics_process(_delta):
	if distance_tester.call():
		if enroute:
			print("TARGET REACHED")
			enroute = false
			target_reached.emit()
	else:
		var direction = (target_location - global_position).normalized()
		velocity = direction * max_speed
		rays.look_at(target_location)
	move_and_slide()

# func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
# 	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		was_attacked.emit(get_global_mouse_position())
			
func _on_body_entered(_body: Node2D):
	print("player entered")

func default_distance_tester() -> bool:
	return global_position.distance_to(target_location) <= 5
