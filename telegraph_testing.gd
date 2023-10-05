extends Node2D

var rotation_angle = 50.0
var angle_from = 75.0
var angle_to = 195.0
var center = Vector2(200, 200)
var max_radius = 300.0
var fill_radius = max_radius * 0.01

@onready var fill_timer := $FillTimer
@onready var area := $Hitbox
@onready var cooldown_timer := $CooldownTimer

var points: PackedVector2Array

func _ready():
  fill_timer.timeout.connect(_on_fill_timer_timeout)
  cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
  area.body_entered.connect(_on_body_entered)
  fill_timer.start()

func _on_body_entered(_body: Node2D):
  print("PLAYER HIT")

func _on_cooldown_timer_timeout():
  fill_timer.start()
  pass

func _on_fill_timer_timeout():
  print("Trigger Attack!")
  cooldown_timer.start()
  var hitbox_collision_shape := ConvexPolygonShape2D.new()
  hitbox_collision_shape.points = points
  $Hitbox/CollisionShape2D.shape = hitbox_collision_shape

func _process(_delta):
  var elapsed_percentage = 1 - (fill_timer.time_left / fill_timer.wait_time)
  fill_radius = max_radius * elapsed_percentage
  queue_redraw()

func _physics_process(_delta):
  pass

func _draw():

  #draw_circle_arc_polyline(center, radius, color)
  points = draw_circle_arc_poly(max_radius, Color(1, 0, 0, 0.25))
  draw_circle_arc_poly(fill_radius, Color(1, 0, 0, 1))

func draw_circle_arc_poly(radius, color):
  var nb_points = 32
  var points_arc = PackedVector2Array()
  points_arc.push_back(center)
  var colors = PackedColorArray([color])

  for i in range(nb_points + 1):
    var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
    points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
  draw_polygon(points_arc, colors)
  return points_arc

# func draw_circle_arc_polyline(center, radius, color):
#   var nb_points = 32
#   var points_arc = PackedVector2Array()
#   points_arc.push_back(center)

#   for i in range(nb_points + 1):
#     var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
#     points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
#   # draw_polygon(points_arc, colors)
#   points_arc.push_back(center)
#   draw_polyline(points_arc, color)
