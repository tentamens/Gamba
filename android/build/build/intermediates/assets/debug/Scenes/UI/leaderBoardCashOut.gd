extends Control


func _ready():
	get_node("bottomCashOut/currentScore").text = str(Score.score)


func _on_number_rush_pressed():
	get_tree().change_scene_to_file("res://Scenes/miniGames/number_rush.tscn")


func _on_mines_pressed():
	get_tree().change_scene_to_file("res://Scenes/miniGames/mines.tscn")


func _on_cash_out_button_pressed():
	$CashOutUsername.visible = true


func _on_confirm_button_pressed():
	var node = $CashOutUsername/nameInput
	if node.text == "":
		Server.cashOutSend("Anonymous")
	Server.cashOutSend(node.text)
	$CashOutUsername.visible = false
