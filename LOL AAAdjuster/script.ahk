#singleinstance force
If WinActive("League of Legends (TM) Client")
SetMouseDelay, -1

RButton::
	MouseGetPos, xpos, ypos
	ImageSearch, enemyxX, enemyyY, % xpos-180, % ypos-230, % xpos+60, %ypos%, *30 enemyhealth.png 
	if ErrorLevel = 0
		{
			BlockInput, Mousemove
			mousemove, % enemyxX+30, % enemyyY+90
			sendraw u
			BlockInput, Mousemoveoff
        }
return

$x::
	sleep, 600
	MouseGetPos, swagx, swagy
	gosub getenemypos
	mousemove, %enemyX%, %enemyY%
	sendinput u
	sleep 200
	mousemove, %swagx%, %swagy%
	sendinput u
return

$s::
	gosub getplayerpos
	gosub GetEnemiesNear
	mousemove, %enemynearX%, %enemynearY%
return


$0::
	Exitapp
return

;#######################################################################
getenemypos:
	ImageSearch, enemynearX, enemynearY, 350, 150, 1600, 850, *30 enemyhealth.png 
	if ErrorLevel = 0 
		{
			enemyX += 30 
			enemyY += 90
        }
return

GetEnemiesNear:
	ImageSearch, enemynearX, enemynearY, % playerX-400, % playerY-339, % playerX+258, % playerY+176, *30 enemyhealth.png 
	if ErrorLevel = 0
		{
			enemynearX += 30
			enemynearY += 90
        }
return

getplayerpos:
	ImageSearch, playerX, playerY, 350, 150, 1400, 850, *30 playerhealth.png 
	if ErrorLevel = 0
		{
			playerX += 30
			playerY += 90
        }
return

