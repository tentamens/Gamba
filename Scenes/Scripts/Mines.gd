extends Control


@onready var currentBet = $".".currentBet

@onready var normalStyle = load("res://MISC/styles/minesBtnNormal.tres")
@onready var disabledStyle = load("res://MISC/styles/mineBtnDisabled.tres")


var colors = [
	load("res://MISC/styles/minesBtnGreen.tres"),
	load("res://MISC/styles/minesBtnpurple.tres"),
	load("res://MISC/styles/minesBtnRed.tres"),
	]




func _ready():
	Server.minesNode = self

func _on_bet_text_changed(new_text):
	if new_text == "":
			currentBet = 0
			return
	currentBet = int(new_text)


func _on_gamble_pressed():
	Server.betMinesRequest(currentBet)


func _on_buttonPressed(extra_arg_0):
	get_node(extra_arg_0).disabled = true
	Server.clickMineProcess(int(extra_arg_0))


func updateButtonLook(num, result):
	if result == 2:
		var x = 1
		while x <= 15:
			
			get_node(str(x)).disabled = true
			x += 1
		$loseDelay.start()
	get_node(str(num)).disabled = true
	get_node(str(num)).set("theme_override_styles/disabled", colors[result])




func _on_lose_delay_timeout():
	var x = 1
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
	
	Server.cashOutMinesSend()
	$loseDelay.start()


func _on_bet_button_pressed():
	pass # Replace with function body.
