extends Area2D

@export var Fixed_Number : int = 0
@export var Number_Of_Bullets : int = 4
var Number_Chooser : int
var Random_Number

func _ready():
	if Fixed_Number != 0 : 
		$Label.text = str(Fixed_Number)
		return
	Number_Chooser = int(GH.rng.randf_range(1 , Number_Of_Bullets))
	$Label.text = str(Number_Chooser)
	
func _on_area_entered(area):
	if area.is_in_group("Weapon_Holder"):
		if Fixed_Number != 0:
			area.Update_Bullet("res://Bullets_Scenes/Bullet_"+str(Fixed_Number)+".tscn")
		else:
			area.Update_Bullet("res://Bullets_Scenes/Bullet_"+str(Number_Chooser)+".tscn")
		GH.Create_Cristal(global_position , Fixed_Number)
		$Collected.play()
		queue_free()
