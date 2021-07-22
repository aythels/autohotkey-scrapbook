#singleinstance force

Radius = 70

$x::
	MouseGetPos, CurrentXPos, CurrentYPos
	
	loop,
	{
		gosub GenCircularPosition
		click %CircularPosition%
		sleep, 400
		send d
		sleep, 10000
		
		Click %CurrentXPos% %CurrentYPos%
		sleep, 400
		send d
		sleep, 10000
	}
return

GenCircularPosition:
	Random, Degree, 0, 360
	Radian := Degree * 0.01745329252
	
	NewXPos := Radius * Cos(Radian)
	NewYPos := Radius * Sin(Radian)
	
	CircularPosition := CurrentXPos+NewXPos  A_Space  CurrentYPos+NewYPos
	;msgbox %CurrentXPos% %CurrentYPos% %NewXPos% %NewYPos% %CircularPosition%
return
	
ExitWindow:
	ImageSearch, Xvar, Yvar, 350, 150, 1400, 850, *10 x.png 
	if ErrorLevel = 0
		click
return

$0::
	Exitapp
return