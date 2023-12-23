extends Area2D




func _process(delta):
	global_position += transform.x * 5


func _on_body_entered(body):
	if body.has_method("Get_Hit"):
		body.Get_Hit()
	queue_free()
