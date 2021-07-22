#singleinstance force
If WinActive("Minecraft 1.8")															;minecraft version
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

XLT = 0
YLT = 0
XRB = %A_ScreenWidth%
YRB = %A_ScreenHeight%

;ALL COORDINATES ARE IN SCREEN (ABSOLUTE) MODE!
ToolbarX1 = 689 												
ToolbarX2 = 1227 												
SlotLength := (ToolbarX2 - ToolbarX1) / 9 

CraftedX = 1150											
CraftedY = 400													
CraftX = 979 									
CraftY = 364										

FaceY = 25											
SpinX = 200															

SlotX = 780                                                     
SlotY = 721 														

;################################ HOT KEYS
$x::
	loop,
	{
		ImageSearch, BMx, BMy, %XLT%, %YLT%, %XRB%, %YRB%, *30 bonemeal.png
		if ErrorLevel = 0
		{
			gosub plant
			gosub bonemeal
			gosub break
		
		}
		else if Errorlevel = 1
		{
			gosub plant
			gosub sell
			gosub trashseeds
			gosub buy
			gosub convert
		}
	}
	
$0:: 
	Exitapp
return

;################################ LABELS
plant:
	sleep, 100
	sendinput 1 ;assuming seeds are in first slot
	sleep, 200
	click right 
	sleep, 400
	click right
return

bonemeal:
	sleep, 100

	BoneMealPosition := BMx - ToolbarX1 	
	if BoneMealPosition between % SlotLength*8 and % SlotLength*9 ;in the format of lowerbound and upperbound
	{
		send 9
		sleep, 300
	}
	else if BoneMealPosition between % SlotLength*7 and % SlotLength*8
	{
		send 8
		sleep, 300
		send 9
	}
	else if BoneMealPosition between % SlotLength*6 and % SlotLength*7
	{
		send 7
		sleep, 300
		send 8
	}
	else if BoneMealPosition between % SlotLength*5 and % SlotLength*6
	{
		send 6
		sleep, 300
		send 7
	}
	else if BoneMealPosition between % SlotLength*4 and % SlotLength*5
	{
		send 5
		sleep, 300
		send 6
	}
	else if BoneMealPosition between % SlotLength*3 and % SlotLength*4
	{
		send 4
		sleep, 300
		send 5
	}
	else if BoneMealPosition between % SlotLength*2 and % SlotLength*3
	{
		send 3
		sleep, 300
		send 4
	}
	else if BoneMealPosition between % SlotLength*1 and % SlotLength*2 ;ignores first slot
	{
		send 2
		sleep, 300
		send 3
	}
	
	sleep, 300 ;time to allow for bonemealing
return

break:
	sleep, 100
	MouseMove,0, -%FaceY%, 10, R
	click down
	MouseMove, %SpinX%, 0, 100, R
	click up
	MouseMove,0, % FaceY * 2, 10, R
return

trashseeds:
	sleep, 100
	MouseMove,0, -100, 10, R ;fix
	sleep, 200
	click right
	
	loop, 8
	{
		sleep, 200                             
		Send +{Click, %SlotX%, %SlotY%, 2}
		SlotX += %SlotLength% 
	}

	SlotX = 780 ;FIX
	gosub CloseWindow
	MouseMove,0, % FaceY * 3, 10, R
return

sell:
	gosub OpenShop
	
	loop,
	{
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\sell1.png 
		if ErrorLevel = 0 
			Click %xpos% %ypos%
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\sell2.png 
		if ErrorLevel = 0 
			Click right %xpos% %ypos%			
			
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 %A_ScriptDir%\BuySellImg\sell3.png 
		if ErrorLevel = 0 
		{
			Click %xpos% %ypos%
			break
		}
	}

	gosub CloseWindow
return	

buy:
	gosub OpenShop
	
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
	
	gosub CloseWindow
return

convert:
	gosub OpenInventory
	
	loop,
	{
		ImageSearch, xpos, ypos, %XLT%, %YLT%, %XRB%, %YRB%, *30 bone.png
		if ErrorLevel = 0 
		{	
			click %xpos%, %ypos%
			sleep, 200
			click %CraftX%, %CraftY%
			sleep, 100
			Send +{Click, %CraftedX%, %CraftedY%, 3}
		}
		if ErrorLevel = 1
			break 
	}
	
	gosub CloseWindow
return

;################################ SMALLER LABELS
OpenShop:
	sleep, 100
	sendinput t
	sleep, 200
	sendraw /shop
	sleep, 200
	sendinput {Enter}
return

OpenInventory:
	sleep, 100
	sendinput e
	sleep, 300
return

CloseWindow:
	sleep, 300
	sendinput {esc}
return
