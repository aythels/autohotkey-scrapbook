If WinActive("League of Legends (TM) Client")
#singleinstance force


/*
$e::
	Sendinput w
		loop,
		{
			ImageSearch, OX, OY, 412, 674, 800, 887, *5 %color%.png
			if ErrorLevel = 0
				{
					sendinput w
					break
				}
		}
return
*/

$e::
	Sendinput w
	loop,
		{
			PixelSearch, Px, Py, 575, 785, 790, 880, 0xE7E300, 20, Fast RGB
			if ErrorLevel = 0
				{
					sendinput w
					break
				}
		}
return

$F1::
	Sendinput w
	loop,
		{
			PixelSearch, Px, Py, 575, 785, 790, 880, 0xF41F1E, 20, Fast RGB
			if ErrorLevel = 0
				{
					sendinput w
					break
				}
		}
return

$w::
	sendinput w
	loop,
		{
			PixelSearch, Px, Py, 575, 785, 790, 880, 0x3C3DB8, 20, Fast RGB
			if ErrorLevel = 0
				{
					sendinput w
					break
				}
		}
return

$0::
	ExitApp
Return