extends Control


@onready var currentBet = 0

@onready var normalStyle = load("res://MISC/styles/minesBtnNormal.tres")
@onready var disabledStyle = load("res://MISC/styles/mineBtnDisabled.tres")


var colors = [
	load("res://MISC/styles/minesBtnGreen.tres"),
	load("res://MISC/styles/minesBtnpurple.tres"),
	load("res://MISC/styles/minesBtnRed.tres"),
	]




func _ready():
	Server.minesNode = self




func _on_buttonPressed(extra_arg_0):
	get_node(extra_arg_0).disabled = true
	Server.clickMineProcess(int(extra_arg_0))


func updateButtonLook(num, result, multiplyer, fullBoard):
	if result == null:
		$mulitplayer.text = (str(multiplyer) + "x")
		return
	
	if result == 2:
		var x = 1
		while x <= 15:
			get_node(str(x)).disabled = true
			x += 1
		# sets all the colors of what the board was
		for i in fullBoard[0]:
			get_node(str(i)).set("theme_override_styles/disabled", colors[0])
		for i in fullBoard[1]:
			get_node(str(i)).set("theme_override_styles/disabled", colors[1])
		for i in fullBoard[2]:
			get_node(str(i)).set("theme_override_styles/disabled", colors[2])

		$loseDelay.start()
	
	
	get_node(str(num)).disabled = true
	get_node(str(num)).set("theme_override_styles/disabled", colors[result])
	if multiplyer == 0:
		return
	get_node("mulitplayer").text = (str(multiplyer) + "x")




func _on_lose_delay_timeout():
	var x = 1
	$mulitplayer.text = ""
	while x <= 15:
		var node = get_node(str(x))
		get_node(str(x)).set("theme_override_styles/disabled", disabledStyle)
		node.disabled = false
		x += 1


func _on_cash_out_pressed():
	var x = 1
	while x <= 15:
		get_node(str(x)).disabled = true
		get_node(str(x)).set("theme_override_styles/disabled", disabledStyle)
		x += 1
	
	get_node("mulitplayer").text = ""
	
	Server.cashOutMinesSend()
	$loseDelay.start()


func _on_bet_button_pressed():
	Server.betMinesRequest(currentBet)



func _on_bet_amount_text_changed(new_text):
	if new_text == "":
			currentBet = 0
			return
	currentBet = int(new_text)
	


func _on_go_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/leaderBoardCashOut.tscn")
