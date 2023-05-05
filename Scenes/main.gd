extends Node2D

var total = 0

var currentBet = 0

var far = 0
var mid = 0
var RL = 0
var middle = 0





func _ready():
	Server.mainSceneNode = self


func moveLeft():
	$Camera2D.position.x = 1730


func moveRight():
	$Camera2D.position.x = 574


func _on_move_left_pressed():
	$Camera2D.position.x = 1727


func _on_bet_text_changed(new_text):
	if new_text == "":
			currentBet = 0
			return
	currentBet = int(new_text)



#
#func _on_far_left_area_entered(area):
#	far += 1
#	$Pegs/stats/FAR/total.text = str(far)
#	Server.calcPegValue(area.get_parent().bet, "far", area.get_parent().num)
#
#
#
#func _on_mid_left_area_entered(area):
#	mid += 1
#	$Pegs/stats/MID/total.text = str(mid)
#	Server.calcPegValue(area.get_parent().bet, "mid", area.get_parent().num)
#
#
#func _on_left_area_entered(area):
#	RL += 1
#	$Pegs/stats/RL/total.text = str(RL)
#	Server.calcPegValue(area.get_parent().bet, "RL", area.get_parent().num)
#
#
#func _on_middle_area_entered(area):
#	middle += 1
#	$Pegs/stats/MIDDLE/total.text = str(middle)
#	Server.calcPegValue(area.get_parent().bet, "middle", area.get_parent().num)
#


#func _on_button_pressed():
#
#	Server.requestBallSpawn(currentBet)


#func _on_timer_timeout():
#	return
#	if currentBet < Score.score and currentBet != 0:
#		Score.score -= currentBet
#
#		var x = randf_range(leftPoint.position.x, rightPoint.position.x)
#
#		var newInstance = ball.instantiate()
#
#		ballContainer.add_child(newInstance)
#
#		newInstance.position = Vector2(x, leftPoint.position.y)
#		newInstance.bet = currentBet
#		total += 1
#
#		$Pegs/stats/Total/total.text = str(total)

#func requestBallSpawnReturn(info):
#
#	Score.score = info[0]
#
#	var newInstance = ball.instantiate()
#
#	ballContainer.add_child(newInstance)
#
#	newInstance.position = info[1]
#
#	newInstance.num = info[2]
	


#func _on_gamble_pressed():
#
#	Server.requestBallSpawn(currentBet)






