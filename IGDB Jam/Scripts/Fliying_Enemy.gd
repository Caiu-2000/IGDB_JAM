extends AnimatableBody2D

var Direcction_1 : Vector2 = Vector2.ZERO
var Direcction_2 : Vector2 = Vector2.ZERO
var going : bool = true
var Can_Get_Hit : bool = true
@export var Dir_Horizontal : bool = false
@export var Wall: bool = false
@export var Distance : int = 100
var Player_In_Area : Node2D
var Can_Damage : bool = true
const points_value : int = 50

var velocity : Vector2 = Vector2.ZERO
func _ready():
	
	$Directions_Storage/Up.position.y  = Distance *-1
	$Directions_Storage/Down.position.y = Distance
	$Directions_Storage/Lefht.position.x = Distance * -1
	$Directions_Storage/Right.position.x = Distance 
	
	if Wall:
		$Sprite.frame = 0
	else:
		$Sprite.frame = 1
		
	
	if Dir_Horizontal:
		Direcction_1 = $Directions_Storage/Lefht.global_position
		Direcction_2 = $Directions_Storage/Right.global_position
	else:
		Direcction_1 = $Directions_Storage/Up.global_position
		Direcction_2 = $Directions_Storage/Down.global_position

func _physics_process(delta):
	if going:
		velocity = self.global_position.direction_to(Direcction_1)
		if global_position.distance_squared_to(Direcction_1) <= 1:
			going = false
			if Dir_Horizontal:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_v = true

	else:
		
		velocity = self.global_position.direction_to(Direcction_2)
		if global_position.distance_squared_to(Direcction_2) <= 1:
			going = true
			if Dir_Horizontal:
				$Sprite.flip_h = false
			else:
				$Sprite.flip_v = false
	
	
	move_and_collide(velocity)
func Get_Hit(dam):
	print("Hiteado")
	$Life_Handler.Get_Hit(dam)
	$SFX/Damaged.play()
		

func Play_Damage():
	$SFX/Damaged.play()

func _on_damage_area_area_entered(area):
	if area.is_in_group("Drill"):
		if (area.get_parent().velocity.y >= area.get_parent().Drill_Velocity):
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


