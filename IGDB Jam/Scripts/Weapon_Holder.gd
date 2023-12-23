extends Area2D

var Cadency : float = 0.25
@export var knockback : float = 100
@onready var Picked_Weapon : Node = $CollisionShape2D
var Can_Fire : bool = true

var Bullet

func _ready():
	Bullet = load("res://Bullets_Scenes/Bullet_1.tscn")

func Fire():
	if (Can_Fire):
		$"../AnimatedSprite2D".play("Fire")
		Can_Fire = false
		var ins_bullet = Bullet.instantiate()
		ins_bullet.global_position = self.global_position
		get_parent().get_parent().add_child(ins_bullet)
		$"../SFX/Fire_Handler".set_stream(ins_bullet.sound.get_stream())
		$"../SFX/Fire_Handler".play()
		get_parent().knockback(Vector2(0,- knockback))
		await get_tree().create_timer(Cadency).timeout
		Can_Fire = true



func Update_Bullet(Path):
	Bullet = load(Path)
	var ins_Ref_Bullet = Bullet.instantiate()
	Cadency = ins_Ref_Bullet.cad
	knockback = ins_Ref_Bullet.knb

	


