extends Node


var rng = RandomNumberGenerator.new()

var Player : Node2D
var GUI    : CanvasLayer
var Main_Scene : Node2D

var points : int = 0
var mas_points : int = 0

func Set_Canvas(Canvas):
	GUI = Canvas

func Set_Player(plyr):
	Player = plyr


func Create_Enemy(pos):
	return
	await get_tree().create_timer(3).timeout
	var enemy = load("res://Scenes/basic_enemy.tscn")
	var ins_enemy = enemy.instantiate()
	ins_enemy.global_position = pos
	add_child(ins_enemy)
	
func Create_Cristal(Global_position , Fix_Bul):
	return
	await get_tree().create_timer(3).timeout
	var cristal = load("res://Scenes/Power_Cristal.tscn")
	var ins_Cristal = cristal.instantiate()
	ins_Cristal.global_position = Global_position
	ins_Cristal.Fixed_Number = Fix_Bul
	add_child(ins_Cristal)

func Update_GUI_Life():
	if GUI == null:
		await get_tree().create_timer(0.25).timeout
	GUI.Update_Life(Player.Max_Life , Player.Life)

func Died():
	get_tree().paused = true
	GUI.Death_Menu.show()
	
	GUI.player_gui.hide()
	
func Load_Game():
	get_tree().change_scene_to_file("res://level_1.tscn")
func Go_To_Main_Menu():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func Add_Points(pts):
	points += pts
	GUI.Update_points(points)
	

func load_Credits():
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
