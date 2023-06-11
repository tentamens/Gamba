extends Control

var currentBet = 0


func changeValue(buttonName):
	pass


func _on_bet_text_changed(new_text):
	if new_text == "":
			currentBet = 0
			return
	currentBet = int(new_text)


func _on_gamble_pressed():
	Server.pillarBetRequestSend(currentBet)
