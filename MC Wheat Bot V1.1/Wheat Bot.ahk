#singleinstance force
If WinActive("Minecraft 1.8")															;minecraft version
CoordMode, Pixel, Screen

SetTimer, shutdown, 18000000, ;runs label "shutdown" after XX time

XLT = 0
YLT = 0
XRB = %A_ScreenWidth%
YRB = %A_ScreenHeight%
ToolbarX1 = 689 													;### LEFT X OF TOOLBAR
ToolbarX2 = 1227 													;## RIGHT X OF TOOLBAR

$x::
	gosub startup
	
	loop,
	{
		ImageSearch, BMx, BMy, %XLT%, %YLT%, %XRB%, %YRB%, *30 bonemeal.png
		if ErrorLevel = 0
		{
			gosub plant
			gosub usebonemeal
			send {n down}
			sleep, 50
			send {n up}
			sleep, 1000
			send {n down}
			sleep, 50
			send {n up}
			sleep, 300
		
		}
		else if Errorlevel = 1
		{
			gosub sell
			gosub BYESEEDS
			gosub buy
			gosub convert
		}
	}
	
BYESEEDS:
	sleep, 100
	sendinput e
	sleep, 200
	
	slotx = 791                                                        ;############ LOCATION OF FIRST INVENTORY SLOT TO CLEAN
	sloty = 719
	outsidex = 784                                                      ;### WILL DRAG THE SEEDS OUTSIDE YOUR INVENTORY
	outsidey = 880
	loop, 8
	{
		sleep, 300
		slotx += 50                                                    ;################ THE DISTANCE BETWEEN TWO SLOTS
			MouseClickDrag, L, %slotx%, %sloty%, %outsidex%, %outsidey%
			click
	}

	sleep, 200
	sendinput {esc}		
return

startup:
	sleep, 100
	sendinput e
	sleep, 200
	ImageSearch, craftslotx, craftsloty, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\StartImg\craftslot.png
	sleep, 100
	sendinput e
	
	SlotLength := (ToolbarX2 - ToolbarX1) / 9 
return

plant:
	sleep, 100
	sendinput 1 ;assuming seeds are in first slot
	sleep, 200
	Click right 6
return

usebonemeal:
	sleep, 100

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
	else if BoneMealPosition between % SlotLength*1 and % SlotLength*2 
		send 2
	else if BoneMealPosition between % SlotLength*0 and % SlotLength*1 ;unnecessary but just in case bonemeal is in first slot
		send 1
		
	sleep, 500
return

sell:
	sleep, 100
	sendinput t
	sleep, 200
	sendraw /shop
	sleep, 200
	sendinput {Enter}
	
	loop,
	{
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\sell1.png 
		if ErrorLevel = 0 
			Click %xpos% %ypos%
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\sell2.png 
		if ErrorLevel = 0 
			Click right %xpos% %ypos%			
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\sell3.png ;new image
		if ErrorLevel = 0 
		{
			Click %xpos% %ypos%
			break
		}
	}

	sleep, 200
	sendinput {esc}	
	sendinput {esc}	
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
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\step1.png
		if ErrorLevel = 0 
			Click %xpos% %ypos%
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\step2.png
		if ErrorLevel = 0 
			Click %xpos% %ypos%			
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\step3.png
		if ErrorLevel = 0 
			Click %xpos% %ypos%			
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\step4.png
		if ErrorLevel = 0 
		{
			Click %xpos% %ypos%			
			break
		}		
	}
	
	sleep, 200
	sendinput {esc}
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
			sleep, 100
			MouseClickDrag, L, %xpos%, %ypos%, %craftslotx%, %craftsloty%
			click
			
			loop,
			{
				sleep, 100
				ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 craftedslot.png
				if ErrorLevel = 0 
				{
					Send +{Click, %xpos%, %ypos%, 3}
					break
				}
			}
		}
		if ErrorLevel = 1
			break 
	}
	
	sendinput {esc}
return

$s::
	gosub convert
return

shutdown:
	Shutdown, 1
	Shutdown, 1
	Shutdown, 1
	Shutdown, 1
	Shutdown, 8
	Shutdown, 8
	Shutdown, 8
	Shutdown, 8
	Shutdown, 8
return

$0:: 
	Exitapp
return