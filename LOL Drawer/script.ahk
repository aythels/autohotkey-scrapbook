#SingleInstance, Force
#Include, Gdip.ahk
CoordMode, pixel, screen

If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}
OnExit, Exit

Width := 1446, Height := 940
Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
Gui, 1: Show, NA
hwnd1 := WinExist()
hbm := CreateDIBSection(Width, Height)
hdc := CreateCompatibleDC()
obm := SelectObject(hdc, hbm)
G := Gdip_GraphicsFromHDC(hdc)
Gdip_SetSmoothingMode(G, 4)
return

$x::
	gosub getkillableminion
return



$s::
	Gdip_GraphicsClear(G) 
	gosub getenemypos
	gosub getplayerpos
	pPen := Gdip_CreatePen(0xffff0000, 3)
	Gdip_DrawLine(G, pPen, enemyX, enemyY, playerX, playerY)
	Gdip_DeletePen(pPen)

$j::
Gdip_GraphicsClear(G)
gosub getplayerpos
pBrush := Gdip_BrushCreateSolid(0x660000ff)
Gdip_FillEllipse(G, pBrush, playerX, playerY, 300, 200)
Gdip_DeleteBrush(pBrush)
UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)
return


/*
; Create a fully opaque red pen (ARGB = Transparency, red, green, blue) of width 3 (the thickness the pen will draw at) to draw a circle
pPen := Gdip_CreatePen(0xffff0000, 3)

; Draw an ellipse into the graphics of the bitmap (this being only the outline of the shape) using the pen created
; This pen has a width of 3, and is drawing from coordinates (100,50) an ellipse of 200x300
Gdip_DrawEllipse(G, pPen, 100, 50, 200, 300)

; Delete the pen as it is no longer needed and wastes memory
Gdip_DeletePen(pPen)

; Create a slightly transparent (66) blue pen (ARGB = Transparency, red, green, blue) to draw a rectangle
; This pen is wider than the last one, with a thickness of 10
pPen := Gdip_CreatePen(0x660000ff, 10)

; Draw a rectangle onto the graphics of the bitmap using the pen just created
; Draws the rectangle from coordinates (250,80) a rectangle of 300x200 and outline width of 10 (specified when creating the pen)
Gdip_DrawRectangle(G, pPen, 250, 80, 300, 200)

; Delete the brush as it is no longer needed and wastes memory
Gdip_DeletePen(pPen)
*/

UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)

Return

getenemypos:
	ImageSearch, enemyX, enemyY, 350, 150, 1600, 850, *30 enemyhealth.png 
	if ErrorLevel = 0
		{
			enemyX += 30
			enemyY += 90
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

getkillableminion:
	ImageSearch, SubmitX, SubmitY, 350, 150, 1400, 850, *60 new.png 
	if ErrorLevel = 0
		{
			pPen := Gdip_CreatePen(0xffff0000, 3)
			Gdip_DrawEllipse(G, pPen, SubmitX, SubmitY, 50, 40)
			Gdip_DeletePen(pPen)
			UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)
        }
return


;#######################################################################

Exit:
; gdi+ may now be shutdown on exiting the program
Gdip_Shutdown(pToken)
ExitApp
Return

ESC::
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteGraphics(G)
	ExitApp
Return