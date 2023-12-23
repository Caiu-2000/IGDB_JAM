extends Control


@onready var Speed          =$VBoxContainer/HBoxContainer/LineEdit
@onready var Jump_Force     =$VBoxContainer/HBoxContainer2/LineEdit
@onready var Traction       =$VBoxContainer/HBoxContainer3/LineEdit
@onready var Gravity        =$VBoxContainer/HBoxContainer4/LineEdit
@onready var Drill_Velocity =$VBoxContainer/HBoxContainer5/LineEdit
@onready  var Player = $"../../Player"


func _input(event):
	if event.is_action_pressed("Enter"):
		release_focus()
	#	print(int(float(Speed.text)))
		Speed.release_focus()
		Jump_Force.release_focus()
		Traction.release_focus()
		Gravity.release_focus()
		Drill_Velocity.release_focus()
		Player.Update_Stats(int(float(Speed.text)) , int(float(Jump_Force.text)),int(float(Traction.text)),int(float(Gravity.text)),int(float(Drill_Velocity.text)))
		


func _ready():
	$VBoxContainer2/Label.text = str(Player.Speed)
	$VBoxContainer2/Label2.text = str(Player.Jump_Force * -1)
	$VBoxContainer2/Label3.text = str(Player.Traction)
	$VBoxContainer2/Label4.text = str(Player.Gravity)
	$VBoxContainer2/Label5.text = str(Player.Drill_Velocity)
