extends Control

@onready var label = $Multiplyer

var tween = Tween.new()
var currentBet = 0
var currentMultipler = 0


func _ready():
	label.self_modulate = Color.FLORAL_WHITE
	Server.numberRushNode = self



func _on_gamble_pressed():
	Server.numberRushBetRequestSend(currentBet)

func numberRushTimerStart():
	Server.numberRushBetRequestSend(currentBet)


func _on_count_up_delay_timeout():
	currentMultipler += 0.01
	label.text = (str(currentMultipler) + "x")
	Server.numberRushUpdateProccessSend(currentMultipler)

func numberRushBroke():
	currentMultipler = 0
	label.text = (str(currentMultipler) + "x")
	label.self_modulate = Color.RED
	await get_tree().create_timer(1.0).timeout
	label.self_modulate = Color.FLORAL_WHITE




func _on_bet_button_pressed():
	Server.numberRushBetRequestSend(currentBet)


func _on_bet_amount_text_changed(new_text):
	if new_text == "":
			currentBet = 0
			return
	currentBet = int(new_text)
