extends Control

@onready var label = $Multiplyer

var tween = Tween.new()
@onready var currentBet = get_node(".").currentBet
var currentMultipler = 1


func _ready():
	label.self_modulate = Color.FLORAL_WHITE
	Server.numberRushNode = self



func _on_gamble_pressed():
	Server.numberRushBetRequestSend(currentBet)

func numberRushTimerStart():
	Server.numberRushBetRequestSend(currentBet)

func countDownStart():
	print("return")
	$countUpDelay.start()



func _on_count_up_delay_timeout():
	currentMultipler += 0.01
	
	label.text = (("%.2f" % currentMultipler) + "x")
	Server.numberRushUpdateProccessSend(currentMultipler)



func numberRushBroke():
	$countUpDelay.stop()
	label.self_modulate = Color.RED
	await get_tree().create_timer(1.0).timeout
	label.self_modulate = Color.FLORAL_WHITE
	currentMultipler = 1
	label.text = ("1.00x")

func numberRushWin():
	$countUpDelay.stop()
	label.self_modulate = Color.GREEN
	await get_tree().create_timer(1.0).timeout
	label.self_modulate = Color.FLORAL_WHITE
	currentMultipler = 1
	label.text = ("1.00x")


func _on_bet_button_pressed():
	Server.numberRushBetRequestSend(currentBet)

func _on_cash_out_pressed():
	Server.numberRushCashOut(currentMultipler)
