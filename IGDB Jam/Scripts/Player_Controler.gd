extends CharacterBody2D


var Max_Life : int = 3
var Life     : int = 3
var coyote_counting : bool = false
var coyote_Time     : int  = 10
var coyote_counter  : int  = 0


@export var Speed = 300.0
@export var Jump_Force = -400
@export var  Traction : int = 100
@export var  Gravity = 800
@export var Traction_air = 5
@export var Traction_floor = 100
@export var Drill_Velocity = 400
var can_fire : bool = true

@onready var Jump_Aud   = $SFX/Jump_SFX
@onready var Laser_Aud  = $SFX/Laser
@onready var Weapon_Holder  = $Weapon
@onready var animator = $Animator


var Can_Be_Damaged = true

func _ready():
	
	GH.Set_Player(self)
	GH.Update_GUI_Life()

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += Gravity * delta
		coyote_counting = true
	else:
		coyote_counting = false
		coyote_counter  = 0
	if coyote_counting == true:
		coyote_counter +=1
	
	var direction = Input.get_axis("a", "d") 
	if direction and is_on_floor():
		$AnimatedSprite2D.play("runing")
	else:
		$AnimatedSprite2D.play("default")
	if direction:
		velocity.x = direction * Speed
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, Traction)
		$AnimatedSprite2D.play("default")
	
	if Input.is_action_just_pressed("Jump") and coyote_counter <= coyote_Time:
		$AnimatedSprite2D.play("jumping")
		velocity.y = Jump_Force
		Jump_Aud.play()
	if Input.is_action_just_pressed("Jump"):
		print(coyote_counter)

	if Input.is_action_pressed("fire") and can_fire:
		Weapon_Holder.Fire()
	move_and_slide()

func knockback(direction : Vector2):
	velocity.y = 0
	velocity += direction


func Drill_Detected_Body(body):

	if body.has_method("Get_Hit"):
		body.Get_Hit(1)
		GH.Add_Points(5)
		knockback(Vector2(0,-300))


func Get_Damage():
	if Can_Be_Damaged:
		Can_Be_Damaged = false
		Life -= 1
		$SFX/Damaged.play()
		animator.play("Get_Hit")
		GH.Update_GUI_Life()
		if Life <= 0:
			Death()
		else:
			await get_tree().create_timer(0.5).timeout
			Can_Be_Damaged = true

func Death():
	GH.Died()
