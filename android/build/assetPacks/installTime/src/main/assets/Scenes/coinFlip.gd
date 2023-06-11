extends Node2D

var currentBet = 0

@onready var redOutline = $Red
@onready var greenOutline = $Green
@onready var outcomeRed = $outcomeRed
@onready var outcomeGreen = $outcomeGreen
@onready var animationTimer = $animationFlip


var bettingSide = 1

var flipNum = 0

var outcome = 0

func _on_button_pressed():
	
	if greenOutline.visible == false:
		bettingSide = 1
		greenOutline.visible = true
		return
	bettingSide = 2
	greenOutline.visible = false
	


func _on_gamble_pressed():
	
	if currentBet < Score.score:
		outcome = randi_range(1, 2)
		
		animation()
		
		



func animation():
	
	animationTimer.start(randf_range(0.05, 0.2))



func _on_bet_text_changed(new_text):
	
	if new_text == "":
			currentBet = 0
			return
	currentBet = int(new_text)


func _on_animation_flip_timeout():
	print(flipNum)
	if flipNum == 5:
		flipNum = 0
		
		# evaluates the winnings
		if bettingSide == outcome:
			$win.restart()
			Score.score += currentBet * 2
		else:
			Score.score -= currentBet
		
		#picks the side to the outcome
		if outcome == 1:
			outcomeGreen.visible = true
			return
		
		outcomeGreen.visible = false
		return
	
	
	flipNum += 1
	animationTimer.start(randf_range(0.05, 0.2))
	
	
	if outcomeGreen.visible == false:
		outcomeGreen.visible = true
		return
	
	
	outcomeGreen.visible = false
