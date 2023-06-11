extends Control


# info amount pin cvc date
func UpdateInfo(info):
	$Info/Pin.text = str(info[2][1])
	$Info/Date.text = str(info[2][3])
	$Info/CVC.text = str(info[2][2])
	$Win.text = str(info[2][0]) + "$"


