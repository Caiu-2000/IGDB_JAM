extends AnimatableBody2D

var Can_Get_Hit : bool = true
var Can_Damage  : bool = true
var Player_In_Area : Node2D
var Direction_1 : int = 0
var Direction_2 : int = 0
@export var distance : int = 50
const points_value : int = 10


var going : bool = true

func _ready():
	Direction_1 = global_position.x + distance 
	Direction_2 = global_position.x - distance
	
	$AnimationPlayer.play("Hover")
func _physics_process(delta):
	
	var velocity : Vector2 = Vector2.ZERO
	
	if going :
		velocity.x += 1 
	else:
		velocity.x -= 1
	if global_position.x >= Direction_1:
		going = false
		$ZombieAstrounaut.flip_h = true
	elif global_position.x <= Direction_2:
		going = true
		$ZombieAstrounaut.flip_h = false
	move_and_collide(velocity)
	pass

func Get_Hit(dam):
	if Can_Get_Hit:
		$SFX/Damaged.play()
		$Life_Handler.Reduce_Life(dam)


func _on_damage_area_area_entered(area):

	if area.is_in_group("Drill"):
		Can_Damage = false
		await  get_tree().create_timer(0.5).timeout
		Can_Damage = true


func _on_damage_area_body_entered(body):
	if body.is_in_group("Player") and Can_Damage:
		Player_In_Area = body
		Damage_Player()
		
func Damage_Player():
	Player_In_Area.Get_Damage()
	await get_tree().create_timer(1).timeout
	if Player_In_Area != null:
		Damage_Player()



func _on_damage_area_body_exited(body):
	if body == Player_In_Area:
		Player_In_Area = null

func Play_Damage():
	$SFX/Damaged.play()
