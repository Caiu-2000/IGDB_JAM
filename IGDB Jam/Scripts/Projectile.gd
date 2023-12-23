extends Area2D

var Speed : int = 200

@export var cad : float = 0.25
@export var knb : int   = 50
@export var damage : int = 1
@onready var sound = $Sound
@onready var hit_sound = $Hit_Sound



func _physics_process(delta):
	global_position += transform.x * 15

func _on_body_entered(body):
	return
	if body.has_method("Get_Hit"):
		body.Get_Hit(damage) 
	hit_sound.play()
	queue_free()


func _on_area_entered(area):
	if area.get_parent().has_method("Get_Hit"):
		area.get_parent().Get_Hit(damage)
	queue_free()
