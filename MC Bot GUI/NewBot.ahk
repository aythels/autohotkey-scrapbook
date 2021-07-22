SetKeyDelay, 30, 10   ;delay/press duration

;ALL VARIABLES (DO NOT TOUCH THIS! TOUCH CONFIG!)
Delay = 

Client = 

SmallChestSquare1X =
SmallChestSquare1Y =
SmallChestSquare2X =
SmallChestSquare2Y =

LargeChestSquare1X =
LargeChestSquare1Y =
LargeChestSquare2X =
LargeChestSquare2Y =

CraftingGridX =
CraftingGridY =
CraftedSquareX =
CraftedSquareY = 

;READ CONFIG
IniRead, Delay, config.ini, constants, Delay
IniRead, Client, config.ini, constants, Client
IniRead, SmallChestSquare1X, config.ini, constants, SmallChestSquare1X
IniRead, SmallChestSquare1Y, config.ini, constants, SmallChestSquare1Y
IniRead, SmallChestSquare2X, config.ini, constants, SmallChestSquare2X
IniRead, SmallChestSquare2Y, config.ini, constants, SmallChestSquare2Y
IniRead, LargeChestSquare1X, config.ini, constants, LargeChestSquare1X
IniRead, LargeChestSquare1Y, config.ini, constants, LargeChestSquare1Y
IniRead, LargeChestSquare2X, config.ini, constants, LargeChestSquare2X
IniRead, LargeChestSquare2Y, config.ini, constants, LargeChestSquare2Y
IniRead, CraftingGridX, config.ini, constants, CraftingGridX
IniRead, CraftingGridY, config.ini, constants, CraftingGridY
IniRead, CraftedSquareX, config.ini, constants, CraftedSquareX
IniRead, CraftedSquareY, config.ini, constants, CraftedSquareY

;LAUNCH GUI
Gui, Add, Text, x10 y10, Delay Between Actions
Gui, Add, Slider, x10 y30 w200 h20 gSlider vSliderPercent, 30
Gui, Add, Text, x250 y30 w100 vSliderText, %Delay% MS

	;Small Chest
Gui, Add, Text, x10 y50, Small Chest Coordinates
;
Gui, Add, Button, x10 y70 w50 gChange1, Change
Gui, Add, Text, x140 y70 w200 vChange1Text, Square1 x%SmallChestSquare1X% y%SmallChestSquare1Y%
;
Gui, Add, Button, x10 y100 w50 gChange2, Change
Gui, Add, Text, x140 y100 w200 vChange2Text, Square2 x%SmallChestSquare2X% y%SmallChestSquare2Y%

	;Large Chest
Gui, Add, Text, x10 y130, Large Chest Coordinates
;
Gui, Add, Button, x10 y150 w50 gChange3, Change
Gui, Add, Text, x140 y150 w200 vChange3Text, Square1 x%LargeChestSquare1X% y%LargeChestSquare1Y%
;
Gui, Add, Button, x10 y180 w50 gChange4, Change
Gui, Add, Text, x140 y180 w200 vChange4Text, Square2 x%LargeChestSquare2X% y%LargeChestSquare2Y%

	;Crafting
Gui, Add, Text, x10 y210, Crafting Coordinates
;
Gui, Add, Button, x10 y230 w50 gChange5, Change
Gui, Add, Text, x140 y230 w200 vChange5Text, CraftingGrid x%CraftingGridX% y%CraftingGridY%
;
Gui, Add, Button, x10 y260 w50 gChange6, Change
Gui, Add, Text, x140 y260 w200 vChange6Text, CraftingSquare x%CraftedSquareX% y%CraftedSquareY%

Gui, Show, w300 h500, Wheat Bot
return

;GUI CONTROLS
Slider:
	GuiControlGet, SliderValue,, SliderPercent
	delay = % SliderValue * 10
	GuiControl,, SliderText, %delay% MS
	IniWrite, %delay%, config.ini, constants, Delay
	Gui, Submit, nohide
return

Change1:
	KeyWait, LButton, D
	MouseGetPos, SmallChestSquare1X, SmallChestSquare1Y
	GuiControl,, Change1Text, Square1 x%SmallChestSquare1X% y%SmallChestSquare1Y%
	IniWrite, %SmallChestSquare1X%, config.ini, constants, SmallChestSquare1X
	IniWrite, %SmallChestSquare1Y%, config.ini, constants, SmallChestSquare1Y
	Gui, Submit, nohide
return

Change2:
	KeyWait, LButton, D
	MouseGetPos, SmallChestSquare2X, SmallChestSquare2Y
	GuiControl,, Change2Text, Square2 x%SmallChestSquare2X% y%SmallChestSquare2Y%
	IniWrite, %SmallChestSquare2X%, config.ini, constants, SmallChestSquare2X
	IniWrite, %SmallChestSquare2Y%, config.ini, constants, SmallChestSquare2Y
	Gui, Submit, nohide
return

Change3:
	KeyWait, LButton, D
	MouseGetPos, LargeChestSquare1X, LargeChestSquare1Y
	GuiControl,, Change3Text, Square1 x%LargeChestSquare1X% y%LargeChestSquare1Y%
	IniWrite, %LargeChestSquare1X%, config.ini, constants, LargeChestSquare1X
	IniWrite, %LargeChestSquare1Y%, config.ini, constants, LargeChestSquare1Y
	Gui, Submit, nohide
return

Change4:
	KeyWait, LButton, D
	MouseGetPos, LargeChestSquare2X, LargeChestSquare2Y
	GuiControl,, Change4Text, Square2 x%LargeChestSquare2X% y%LargeChestSquare2Y%
	IniWrite, %LargeChestSquare2X%, config.ini, constants, LargeChestSquare2X
	IniWrite, %LargeChestSquare2Y%, config.ini, constants, LargeChestSquare2Y
	Gui, Submit, nohide
return

Change5:
	KeyWait, LButton, D
	MouseGetPos, CraftingGridX, CraftingGridY
	GuiControl,, Change5Text, CraftingGrid x%CraftingGridX% y%CraftingGridY%
	IniWrite, %CraftingGridX%, config.ini, constants, CraftingGridX
	IniWrite, %CraftingGridY%, config.ini, constants, CraftingGridY
	Gui, Submit, nohide
return

Change6:
	KeyWait, LButton, D
	MouseGetPos, CraftedSquareX, CraftedSquareY
	GuiControl,, Change6Text, CraftingSquare x%CraftedSquareX% y%CraftedSquareY%
	IniWrite, %CraftedSquareX%, config.ini, constants, CraftedSquareX
	IniWrite, %CraftedSquareY%, config.ini, constants, CraftedSquareY
	Gui, Submit, nohide
return

;CALCULATIONS TO FIND PLACEMENT ON SHOP BUTTONS


;#####################################################HOTKEYS
$x::
																		;DO STUFF
	
$0::
	ExitApp
return

GuiClose:
	ExitApp
return

;#####################################################COMMANDS
OpenShop:
	send t
	sleep, % Delay - 50
	sendraw /shop
	sleep, % Delay - 50
	send {enter}
	sleep, %Delay%
return

OpenInventory:
	send e
	sleep, %Delay%
return

CloseWindow:
	send {esc}
	sleep, %Delay%
return

;################################################# PROCESSES
ProcessSell:
	gosub OpenShop
	
	click
	sleep, 200
	click, 
	sleep, 200
	click, 
	sleep, 200

	gosub CloseWindow
return

ProcessBuy:
	gosub OpenShop

	click
	sleep, 200
	click, 
	sleep, 200
	click, 
	sleep, 200
	click
	sleep, 200
	
	gosub CloseWindow
return

ProcessConvert:
	gosub OpenInventory
	
	loop, 2
	{
		click,
		sleep, 100
		click, 
		sleep, 100
		Send +{Click, x,y }
		sleep, 100
	}
	
	gosub CloseWindow
return

ProcessPlant:
	click right
	sleep, xxxx
	
	loop, 2
	{
		send k
	}
	
	sleep, 100
return

ProcessBoneMeal:
	send 2
	sleep, xxxx
return

ProcessClearInventory:

return


