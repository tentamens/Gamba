extends ScrollContainer

@onready var label = load("res://Scenes/UI/preloads/leaderBoardLabel.tscn")

var lb


func _ready():
	await get_tree().create_timer(1.0).timeout
	Server.leaderBoardNode = self
	Server.getLeaderBoard()


func returnLeaderBoard(leaderBoard: Array):
	var i = 0
	
	lb = leaderBoard
	
	while i < leaderBoard.size():
		var newInstance = label.instantiate()
		get_node("VBoxContainer").add_child(newInstance)
		newInstance.text = (str(i + 1) + " " + leaderBoard[i][1] + " : " + str(leaderBoard[i][0]))
		i += 1
	
	get_parent().get_node("LineEdit").text = str(projectLeaderBoardPos())


func projectLeaderBoardPos():
	var leaderBoard: Array = lb
	leaderBoard.insert(leaderBoard.size(), [Score.score, "Why you looking at the code o.O"])
	leaderBoard.sort_custom(sort_ascending)
	
	return leaderBoard.bsearch(["Why you looking at the code o.O"], false)


func sort_ascending(a, b):
	if a[0] > b[0]:
		return true
	return false


