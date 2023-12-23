extends Control



func _on_start_game_pressed():
	GH.Load_Game()



func _on_quit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	GH.load_Credits()
