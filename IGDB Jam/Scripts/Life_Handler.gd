extends Node2D


var life = 3


func Reduce_Life(red):
	life -= red
	$Control/ProgressBar.value = life
	if (life <= 0) :
		get_parent().Can_Get_Hit = false
		get_parent().Can_Damage  = false
		$AnimationPlayer.play("Death")
		get_parent().Play_Damage()
		
	else:
		$AnimationPlayer.play("Hit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Death":
		GH.Add_Points(get_parent().points_value) 
		get_parent().queue_free()

func Get_Hit(dam):
	Reduce_Life(dam)
