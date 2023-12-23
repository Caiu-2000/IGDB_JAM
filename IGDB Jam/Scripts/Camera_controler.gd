extends Camera2D

@export var Player : Node2D 

@export var Debug_Mode : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Debug_Mode:
		global_position = Player.global_position
		return
	$"../Player/finish".global_position = Player.global_position
	global_position.y = Player.global_position.y +100


func _on_finish_zone_body_entered(body):
	$"../Player/finish".play()
