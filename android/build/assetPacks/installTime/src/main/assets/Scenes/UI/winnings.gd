extends Control

@onready var label = preload("res://Scenes/UI/biggerLabel.tscn")
@onready var card = preload("res://Scenes/UI/Winning.tscn")


func _ready():
	Server.winningsNode = self
	Server.loadRewardPage()


func proccessRewardPage(WinningsInfo, winners):
	showWinnersBecauseYourNotOne(winners)
	print(WinningsInfo)
	if WinningsInfo != null:
		var newInstance = card.instantiate()
		$Winnings/ScrollContainer/HBoxContainer.add_child(newInstance)
		newInstance.UpdateInfo(WinningsInfo)

#Why are you reading this, it is 1am for me o.o
func showWinnersBecauseYourNotOne(winners):
	var newInstance
	
	for i in winners:
		newInstance = label.instantiate()
		$rightSideWinners/Winners/VBoxContainer.add_child(newInstance)
		newInstance.text = (i + " : " + str(winners[i]) + "$")
		
