extends Node

const DEFAULT_PORT: int = 4242

var mainSceneNode
var minesNode 
var numberRushNode

func _ready():
	multiplayer.connected_to_server.connect(self.join_as_client)
	join_server()


func join_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client('127.0.0.1', DEFAULT_PORT)
	multiplayer.multiplayer_peer = peer


func join_as_client() -> void:
	var client_id: int = multiplayer.get_unique_id()
	var player_name: String = "Player"
	rpc_id(1, "serverConnectPlayer", client_id, player_name, )
	

func calcPegValue(betValue, Zone, num):
	
	var client_id: int = multiplayer.get_unique_id()
	
	rpc_id(1, "calculatePegValue", Zone, client_id, num)




@rpc("any_peer", "reliable")
func calculatePegValue(betValue, Zone, client_id, num):
	pass




func scoreCalcLoss(score, subtractive):
	pass


@rpc("reliable")
func updateScore(score):
	Score.score = score


@rpc("any_peer")
func serverConnectPlayer(clientID: int, playerName: String) -> void:
	pass


@rpc
func createPlayerNode():
#	generalDataRetrieve()
	print("connction to Server established")



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


@rpc("reliable")
func numberRushBetRequestRecieve(currentBet):
	pass


func numberRushUpdateProccessSend(currentMultiple):
	rpc_id(1, "numberRushBetProccessRecieve", currentMultiple)


@rpc("any_peer", "reliable")
func numberRushUpdateProccessReceive(currentMultiple):
	pass


@rpc( "reliable")
func numberRushCrash(score):
	Score.score = score


func numberRushCashOut(currentMultiple):
	rpc_id(1, "NumberRushCashOutRecieve", currentMultiple)


@rpc("any_peer", "reliable")
func NumberRushCashOutRecieve(currentMultiple):
	pass

@rpc("reliable")
func numberRushWin(score):
	Score.score = score



