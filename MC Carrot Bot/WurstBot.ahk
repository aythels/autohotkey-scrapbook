#singleinstance force
If WinActive("Minecraft 1.8") ;minecraft version
CoordMode, Pixel, Screen

XLT = 0
YLT = 0
XRB = %A_ScreenWidth%
YRB = %A_ScreenHeight%

$x::
	gosub GetCoords

	loop,
	{
		ImageSearch, BMx, BMy, %XLT%, %YLT%, %XRB%, %YRB%, *30 bonemeal.png
		if ErrorLevel = 0
		{
			gosub plant
			gosub bonemeal
			send {space down}
			sleep, 60
			send {space up}
		}
		else if Errorlevel = 1
		{
			gosub plant
			gosub sell
			gosub buy
			gosub convert
			sleep, 300
		}
	}
return

GetCoords:
	;gets position of crafting slot
	sendinput e
	sleep, 200
	ImageSearch, craftslotx, craftsloty, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\StartImg\craftslot.png
	sleep, 100
	sendinput e
	
	sleep, 200
	
	;gets dimentions of hotbar
	sendinput 1
	sleep, 200
	ImageSearch, ToolbarX1, ToolbarY1, %XLT%, %YLT%, %XRB%, %YRB%, *50 %A_ScriptDir%\StartImg\toolbar1.png
	if Errorlevel = 1
		msgbox error
	ImageSearch, ToolbarX2, ToolbarY2, %XLT%, %YLT%, %XRB%, %YRB%, *50 %A_ScriptDir%\StartImg\toolbar2.png
	if Errorlevel = 1
		msgbox error
	SlotLength := (ToolbarX2 - ToolbarX1) / 8 ;does the calculation without the last slot
return

plant:
	sleep, 100
	sendinput 1 ;assuming carrots are in first slot
	sleep, 200
	Click right 12
return

bonemeal:
	sleep, 100
	ImageSearch, BMx, BMy, %XLT%, %YLT%, %XRB%, %YRB%, *30 bonemeal.png
	BoneMealPosition := BMx - ToolbarX1 
	if BoneMealPosition between % SlotLength*8 and % SlotLength*9 ;in the format of lowerbound and upperbound
		send 9
	else if BoneMealPosition between % SlotLength*7 and % SlotLength*8
		send 8
	else if BoneMealPosition between % SlotLength*6 and % SlotLength*7
		send 7
	else if BoneMealPosition between % SlotLength*5 and % SlotLength*6
		send 6
	else if BoneMealPosition between % SlotLength*4 and % SlotLength*5
		send 5
	else if BoneMealPosition between % SlotLength*3 and % SlotLength*4
		send 4
	else if BoneMealPosition between % SlotLength*2 and % SlotLength*3
		send 3
	else if BoneMealPosition between % SlotLength*1 and % SlotLength*2 ;ignores first slot
		send 2
		
	sleep, 400
return

sell:
	sleep, 100
	sendinput {t}
	sleep, 200
	sendraw /sell all
	sleep, 200
	sendinput {Enter}
return	

buy:
	sleep, 100
	sendinput t
	sleep, 200
	sendraw /shop
	sleep, 200
	sendinput {Enter}
	
	loop,
	{
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuyImg\step1.png
		if ErrorLevel = 0 
			Click %xpos% %ypos%
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuyImg\step2.png
		if ErrorLevel = 0 
			Click %xpos% %ypos%			
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuyImg\step3.png
		if ErrorLevel = 0 
			Click %xpos% %ypos%			
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuyImg\step4.png
		if ErrorLevel = 0 
		{
			Click %xpos% %ypos%			
			break
		}		
	}
	
	sendinput {esc}
return

convert:
	sleep, 100
	sendinput e
	sleep, 300
	
	loop,
	{
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 bone.png
		if ErrorLevel = 0 
		{
			MouseClickDrag, L, %xpos%, %ypos%, %craftslotx%, %craftsloty%
			
			loop,
			{
				ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 craftedslot.png
				if ErrorLevel = 0 
				{
					msgbox hi
					Send +{Click, %xpos%, %ypos%, 3}
					break
				}
			}
			msgbox wtf
		}
		if ErrorLevel = 1
			break 
	}
	
	sendinput {esc}
return

;########################################## HOT KEYS
$0:: 
	Exitapp
return