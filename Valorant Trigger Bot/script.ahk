#singleinstance force
#NoEnv
#Include, Gdip.ahk
#UseHook
CoordMode, Pixel, Screen

if WinActive("VALORANT") = 0 {
	;MsgBox, Not Active
	;ExitApp
}

If !pToken := Gdip_Startup() {
   ;MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
   ;ExitApp
}

OnExit("Exit")

;########################################################################################################################################################


;########################################################################################### SETUP

Width := 20, Height := 20
CenterX :=  A_screenWidth / 2, CenterY := A_screenHeight / 2

Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
Gui, 1: Show, NA

hwnd1 := WinExist()
hbm := CreateDIBSection(Width, Height)
hdc := CreateCompatibleDC()
obm := SelectObject(hdc, hbm)
G := Gdip_GraphicsFromHDC(hdc)
Gdip_SetSmoothingMode(G, 4)

;############################################################################################ Drawing

outlinePen := Gdip_CreatePen(0xffff0000, 3)
onPen := Gdip_CreatePen(0xffff0000, 5)
offPen := Gdip_CreatePen(0xa632a8ff, 10)
pPen := offPen

;Gdip_DeletePen(pPen)

Gdip_DrawRectangle(G, pPen, 0, 0, width, height)
UpdateLayeredWindow(hwnd1, hdc, CenterX - width / 2, CenterY - height / 2, Width, Height)

Loop 
	{
		x1 := CenterX - width / 2
		y1 := CenterY - height / 2
		x2 := CenterX - width / 2 + width
		y2 := CenterY - height / 2 + width
			
		PixelSearch, Px, Py, x1, y1, x2, y2, 0xFA40FB, 55, Fast
		if ErrorLevel = 0 
		{
			Gdip_GraphicsClear(G)
				
			Gdip_DrawRectangle(G, pPen, 0, 0, width, height)
			Gdip_DrawEllipse(G, outlinePen, Px - (CenterX - width / 2), Py - (CenterY - height / 2) + 50, 10, 10)
			UpdateLayeredWindow(hwnd1, hdc, CenterX - width / 2, CenterY - height / 2, Width, Height)
				
			if pPen != %onPen% 
			{
				continue
			}
			
			BlockInput, MouseMove
			;DllCall("mouse_event", uint, 1, int, Px - CenterX, int, Py - CenterY + 10)
			MouseClick, left
			MouseClick, left
			MouseClick, left
			MouseClick, left
			MouseClick, left
			BlockInput, MouseMoveOff

		}
	}

Return

;############################################################################################ Keys


$i::
	click
	DllCall("mouse_event", uint, 1, int, 100, int, 0)
	click
return

$XButton2::
	if pPen = %offPen% 
	{
		pPen := onPen
	} 
	else if pPen = %onPen% 
	{
		pPen := offPen
	}
	
	Gdip_GraphicsClear(G)
	Gdip_DrawRectangle(G, pPen, 0, 0, width, height)
	UpdateLayeredWindow(hwnd1, hdc, CenterX - width / 2, CenterY - height / 2, Width, Height)
return

$0::
	ExitApp
Return

Exit() {
	MsgBox, Exiting
	
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteGraphics(G)

	Gdip_Shutdown(pToken)
	
	
	ExitApp
	Return
}