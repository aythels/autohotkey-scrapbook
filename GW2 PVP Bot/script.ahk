#singleinstance force
#Persistent
#NoEnv
CoordMode, Pixel, Screen 

start:=A_TickCount

queueMenuButton := "0button.jpg"
queueMenuButtonB := "0buttonB.jpg"

queueButton := "1button.jpg"
queueAcceptButton := "2button.jpg"
gameReadyButton := "3button.jpg"
gameStartButton := "4button.jpg"
gameFinishButton := "5button.jpg"
isGameState := "gameState.jpg"

gameState := 1

$i::
	loop, {
		
		gosub pvpScript
		sleep, 1000
	}
return

pvpScript:

	;menu
	if (gameState = 0) {
	
		;difference:= A_TickCount-start
		;if (difference > 14400000) {
		;	msgbox, shutting
		;	Shutdown, 1
		;}
	
	
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 %queueMenuButton%
		if (ErrorLevel = 1)
			ControlSend, , p, Guild Wars 2	
		else if (ErrorLevel = 0)
			gameState := 1
	}
	
	
	;queue
	if (gameState = 1) {
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 %queueButton%
		if (ErrorLevel = 0) {
			Click, %FoundX%, %FoundY%
			MouseMove, 0, 0
		}
			
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *70 %queueAcceptButton%
		if (ErrorLevel = 0) {
			Click, %FoundX%, %FoundY%
			MouseMove, 0, 0
		}	
		
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 %gameReadyButton%
		if (ErrorLevel = 0) {
			Click, %FoundX%, %FoundY%	
			MouseMove, 0, 0
			sleep, 120000
			ControlSend, , {f5}, Guild Wars 2	
			gameState := 2
		}
	}
	
	if (gameState = 2) {
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 %gameFinishButton%
		if (ErrorLevel = 0) {
			Click, %FoundX%, %FoundY%
			MouseMove, 0, 0
			sleep, 5000
			gameState := 0
		}
	}

return

antiAFK:
	sleep, 120000
	ControlSend, , {f5}, Guild Wars 2	
return

$0::
	msgbox, leaving
	ExitApp
Return