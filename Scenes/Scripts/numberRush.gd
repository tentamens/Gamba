extends Control

@onready var label = $Multiplyer

var tween = Tween.new()
var currentBet = 0
var currentMultipler = 1


func _ready():
	label.self_modulate = Color.FLORAL_WHITE
	Server.numberRushNode = self



func _on_gamble_pressed():
	Server.numberRushBetRequestSend(currentBet)

func numberRushTimerStart():
	Server.numberRushBetRequestSend(currentBet)

func countDownStart():
	$countUpDelay.start()

var multiplyerSending = 0

func _on_count_up_delay_timeout():
	currentMultipler += 0.01
	multiplyerSending += 0.01
	
	label.text = (("%.2f" % currentMultipler) + "x")
	if multiplyerSending >= 0.05:
		print("sent")
		Server.numberRushUpdateProccessSend(currentMultipler)
		multiplyerSending = 0


func numberRushBroke():
	$countUpDelay.stop()
	label.self_modulate = Color.RED
	await get_tree().create_timer(1.0).timeout
	label.self_modulate = Color.FLORAL_WHITE
	currentMultipler = 1
	label.text = ("1.00x")


func numberRushWin(outcome):
	$countUpDelay.stop()
	label.self_modulate = Color.GREEN
	$OutComePrice.text = (("%.2f" % outcome) + "x")
	await get_tree().create_timer(1.0).timeout
	label.self_modulate = Color.FLORAL_WHITE
	currentMultipler = 1
	label.text = ("1.00x")
	$OutComePrice.text = ""


func _on_bet_button_pressed():
	Server.numberRushBetRequestSend(currentBet)

func _on_cash_out_pressed():
	Server.numberRushCashOut(currentMultipler)


func _on_bet_amount_text_changed(new_text):
	if new_text == "":
			currentBet = 0
			return
	currentBet = int(new_text)


func _on_go_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/leaderBoardCashOut.tscn")


func betAmountButtonPressed(percentage):
	currentBet = Score.score * percentage
	$UI/BetAmount.text = str(currentBet)
