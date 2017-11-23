﻿#NoEnv
SendMode Input 
SetWorkingDir %A_ScriptDir%  
#CommentFlag //

// // Key spammer
LAlt & t::
While GetKeyState("t","p")
{
  Send, t
  Sleep, 10
}
return


// Improved rightclick spam
LAlt & ~RButton::  
While GetKeyState("RButton","p")
{
  Click, R
  Sleep, 50
}
return


// Quick 
~b:: Click
~v:: Click, R


// Glyph notification
~p::    	
	SoundPlay, sounds/pangolier.mp3
    CreateGUI("Glyph had been used", "Blue", 3000)		
	
	Sleep, 300000 // is 5 minutes 
	
	SoundPlay, sounds/glyph.mp3
	CreateGUI("Enemy's glyph is ready", "Red", 3000)	
return

// Aegis notification
~[::    	
	SoundPlay, sounds/cheese.mp3
    CreateGUI("Roshan timer is activated", "Green", 3000)		
	
	Sleep, 287000 // is 4 minutes 47 seconds
	
	SoundPlay, sounds/aegis.mp3
	CreateGUI("Aegis expires in 10 seconds", "Red", 3000)

	Sleep, 4000  

	SoundPlay, sounds/getback.mp3			
	CreateGUI(" 3 ", "Red", 1000)		
	CreateGUI(" 2 ", "Red", 1000)	
	CreateGUI(" 1 ", "Red", 1000)	
return

~]::Reload


// GUI
CreateGUI(text, c, timer){
	Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption +LastFound +Owner	
	Gui, Color, %c%
	WinSet, Transparent, 180
	Gui, Font, cWhite s20 bold, Arial
	Gui, Add, Text, Center , %text% //;the text to display	
	Gui, Show, y50 NA

	sleep, timer
	Gui, Destroy
}


// Pause / Unpause 
numpad0::  
	suspend
	SoundPlay, sounds/scan.mp3
return



// Mana
// x1 = 950	   x2 = 1000	x3 = 1055	y1 = 800	y2 = 845	y3 = 880
LAlt & 5::
	// center 
	Send, 1
	Send, 1
	
	PixelGetColor, soulring1, 938,793, RGB	
	PixelGetColor, bottle1, 1045,835, RGB
	PixelGetColor, bottle2, 992,792, RGB	
	//msgbox, color(%bottle%)	

	// IF soulring in cd use bottle 1 or 2
	if soulring1 = 0x1D1D24 
	{ 				
		if bottle2 = 0xB11314 
		{
			use(2)
		}
		if bottle1 = 0x640C0C
		{
			use(6)
		}
		use(-1)	
		Goto, Skipper
	}
	
	if bottle1 = 0x640C0C	
		use(6)	
	else
		drop(6)		

	if bottle2 = 0xB11314 
		use(2)	
	else
		drop(2)							
		
	if soulring1 != 0x4A496B // || soulring != 0x4A496B
		drop(1)

	drop(3)
	
	// use soulring when others are dropped
	if soulring1 = 0x4A496B 
		use(1)

	if soulring1 != 0x4A496B				
		drag(7, 1)

	if bottle2 != 0xB11314		
		drag(8, 2)

	if soulring1 != 0x4A496B	
		use(1)	

	if bottle1 != 0x640C0C
		use(2)	
	
	if soulring1 != 0x4A496B				
		drag(1, 7)

	if bottle2 != 0xB11314		
		drag(2, 8)		

	pickup()		
	
	// extra bottle use
	if bottle1 = 0x640C0C				
		use(6)
	if bottle2 = 0xB11314				
		use(2)
	
	use(-1)
	Skipper:
return
	
// x1 = 950	   x2 = 1000	x3 = 1055	y1 = 800	y3 = 845	y3 = 880

// Drop item 
drop(item)
{ 	
	if item = 1			
		SendEvent {Click 950, 800, down}{click 758, 470 , up} // 797, 458
	else if item = 2
		SendEvent {Click 1000, 800, down}{click 784, 476 , up} // 820, 449
	else if item = 3
		SendEvent {Click 1055, 800, down}{click 810, 477 , up} // 818, 427
	else if item = 6
		SendEvent {Click 1055, 845, down}{click 824, 462 , up} // 788, 510
}

// pick up items back	
pickup()
{		
	if soulring1 != 0x4A496B
	{
		Click, 748, 470, right
		Sleep, 50
	}	
	if bottle1 != 0xB11314
	{
		Click, 784, 476, right
		Sleep, 50
	}
	Click, 810, 477, right 
	Sleep, 50	
	if bottle2 != 0x640C0C	
	{
		Click, 834, 462, right
		Sleep, 50	
	}	

}

// Drag item
drag(item1, item2)
{ 	
	if (item1 = 7 && item2 = 1)
		SendEvent {Click 950, 880, down}{click 950, 800 , up} 	

	else if (item1 = 8 AND item2 = 2)
		SendEvent {Click 1000, 880, down}{click 1000, 800 , up} 	

	else if (item1 = 1 AND item2 = 7)
		SendEvent {Click 950, 800, down}{click 950, 880 , up} 

	else if (item1 = 2 AND item2 = 8)
		SendEvent {Click 1000, 800, down}{click 1000, 880 , up} 
		
}

// press item
use(item)
{		
	if item = 1
		Send, Z
	else if item = 2
	{	
		Sleep, 100	
		Send, X		
	}
	else if item = 6
		Send {WheelDown}	
	else if item = -1
		Send, R		
	Sleep, 100		
}