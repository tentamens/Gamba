extends Node

const DEFAULT_PORT: int = 4545

var mainSceneNode
var minesNode 
var numberRushNode
var leaderBoardNode
var winningsNode



var newScoreUpdate = []



func _ready():
	multiplayer.connected_to_server.connect(self.join_as_client)
	join_server()


func join_server():
	var peer = ENetMultiplayerPeer.new()
	
	peer.create_client('10.0.0.19', DEFAULT_PORT)
	multiplayer.multiplayer_peer = peer


func join_as_client() -> void:
	var client_id: int = multiplayer.get_unique_id()
	var player_name = Data.retrieveID()
	print(player_name)
	rpc_id(1, "serverConnectPlayer", client_id, player_name, )


@rpc("any_peer")
func serverConnectPlayer(clientID: int, playerName: String) -> void:
	pass


func calcPegValue(betValue, Zone, num):
	
	var client_id: int = multiplayer.get_unique_id()
	
	rpc_id(1, "calculatePegValue", Zone, client_id, num)




@rpc("any_peer", "reliable")
func calculatePegValue(Zone, client_id, num):
	pass




func scoreCalcLoss(score, subtractive):
	pass


@rpc("reliable")
func updateScore(score):
	Score.score = score





@rpc("reliable")
func returnUID(UID):
	print("connction to Server established")
	if UID == null:
		return
	Data.storeID(UID)


func generalDataRetrieve():
	rpc_id(1, "genData", multiplayer.get_unique_id() )


@rpc("any_peer", "reliable")
func genData(clientID):
	pass


@rpc("reliable")
func retreiveGenData(data):
	data = data["peg"]
	Data.gravity = data.gravity
	Data.side2sidePullNums = data.side2sidePullNums
	Data.range = data.range


func requestBallSpawn(currentBet):
	rpc_id(1, "requestBallSpawnSend", currentBet)



@rpc("any_peer", "reliable")
func requestBallSpawnSend(currentBet):
	pass


@rpc("reliable")
func requestBallSpawnReturn(info):
	
	mainSceneNode.requestBallSpawnReturn(info)


func betMinesRequest(currentBet):
	rpc_id(1, "betMinesRequestSend", currentBet)


@rpc("any_peer","reliable")
func betMinesRequestSend(currentBet):
	pass


func clickMineProcess(num):
	rpc_id(1, "clickMineProcessSend", num)


@rpc("any_peer", "reliable")
func clickMineProcessSend(num):
	pass


@rpc("reliable")
func clickMineProcessSendReturn(score, num, result):
	Score.score = score
	minesNode.updateButtonLook(num, result)

func cashOutMinesSend():
	rpc_id(1, "cashOutMinesRecieve")


@rpc("any_peer", "reliable")
func cashOutMinesRecieve():
	pass


func pillarBetRequestSend(currentBet):
	rpc_id(1, "pillarBetRequestRecieve", currentBet)


@rpc("any_peer", "reliable")
func pillarBetRequestRecieve(currentBet):
	pass

func numberRushBetRequestSend(currentBet):
	rpc_id(1, "numberRushBetRequestRecieve", currentBet)


@rpc("any_peer","reliable")
func numberRushBetRequestRecieve(currentBet):
	pass


func numberRushUpdateProccessSend(currentMultiple):
	rpc_id(1, "numberRushUpdateProccessReceive", currentMultiple)


@rpc("any_peer", "reliable")
func numberRushUpdateProccessReceive(currentMultiple):
	pass


@rpc( "reliable")
func numberRushCrash(score):
	Score.score = score
	numberRushNode.numberRushBroke()


func numberRushCashOut(currentMultiple):
	rpc_id(1, "NumberRushCashOutRecieve", currentMultiple)


@rpc("any_peer", "reliable")
func NumberRushCashOutRecieve(currentMultiple):
	pass

@rpc("reliable")
func numberRushWin(score, outcome):
	Score.score = score
	numberRushNode.numberRushWin(outcome)


@rpc("reliable")
func numberRushBetRequestReturn():
	numberRushNode.countDownStart()

func getLeaderBoard():
	rpc_id(1, "getLeaderBoardSend")

@rpc("any_peer", "reliable")
func getLeaderBoardSend():
	pass

@rpc("reliable")
func getLeaderBoardReturn(leaderBoard):
	leaderBoardNode.returnLeaderBoard(leaderBoard)

func cashOutSend(username):
	var UID = Data.retrieveID()
	rpc_id(1, "cashOutRequestRecieve", UID, username)

@rpc("any_peer","reliable")
func cashOutRequestRecieve(UID, username):
	pass

@rpc("unreliable")
func addScoreChangeUpdate(change,username):
	if newScoreUpdate.size() > 20:
		newScoreUpdate.insert(0, [change, username])
		newScoreUpdate.erase(-1)
		return
	
	newScoreUpdate.insert(0, [change, username])

func loadRewardPage():
	var UID = Data.retrieveID()
	rpc_id(1, "loadRewardPageReceive", UID)


@rpc("reliable", "any_peer")
func loadRewardPageReceive(UID):
	pass


@rpc("reliable")
func loadRewardPageReturn(WinningsInfo, winners):
	winningsNode.proccessRewardPage(WinningsInfo, winners)


