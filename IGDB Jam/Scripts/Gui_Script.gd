extends CanvasLayer

@onready var life_bar = $Player_GUI/Life_Bar
@onready var life_numbers = $Player_GUI/Life_Bar/Life_numbers
@onready var Death_Menu = $Death_Menu
@onready var pause_menu = $Pause_Menu
@onready var player_gui = $Player_GUI

func _ready():
	GH.Set_Canvas(self)

	
func Update_Life(Max_Life , Act_Life):
	life_bar.max_value = Max_Life
	life_bar.value     = Act_Life
	life_numbers.text = str(Act_Life) + "/" + str(Max_Life)


func _on_restart_pressed():
	Death_Menu.hide()
	get_tree().paused = false
	GH.get_tree().reload_current_scene()
	


func _on_resume_pressed():
	get_tree().paused = false
	pause_menu.hide()
	player_gui.show()


func _input(event):
	if event.is_action_pressed("Esc"):
		if !get_tree().paused:
			player_gui.hide()
			pause_menu.show()
			get_tree().paused = true
		else:
			player_gui.show()
			pause_menu.hide()
			get_tree().paused = false


func _on_main_menu_pressed():
	get_tree().paused = false
	GH.Go_To_Main_Menu()


func Update_points(points):
	$Player_GUI/Control/Points_Value.text = str(points)
	$Finish_Menu/Score.text = str(points)
	$Death_Menu/Points.text = "Your Score is " + str(points) + " pts"

	$Animator.play("Shake_Score")


func _on_finish_zone_body_entered(body):
	if !body.is_in_group("Player"):
		return
	await get_tree().create_timer(1).timeout
	$Finish_Menu.show()
	$Player_GUI.hide()
