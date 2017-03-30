.section .text 
 	#this program tests the error checking core of our project by displaying a text 
 	#for a short duration (as determined by timer) before erasing the text 
 	#r8 points to vga 
 	#r9 points to char buffer 
 	#r10 points to button 
 	#r11 points to timer 
 .global _start 
 	#global constants for device addresses and interrupt handlers 
 	.equ ADDR_VGA, 0x08000000 
 	.equ ADDR_CHAR, 0x09000000 
 	.equ BUTTON, 0xFF200050 
 	.equ IRQ_DEV, 0x02
 	.equ TIMER, 0xFF202000 
 	.equ PERIOD, 200000000 
	.equ MENU, 0x01
	.equ Q1, 0x02
 
 
 _start: 
	#initialise pointers to device address and constants 
 	call init
 	#draw the menu on vga 
 	call drawMenu
	mov r13, r2
 loop: 
 	br loop 
 	 
 init: 
 	movia r8, ADDR_VGA 
 	movia r9, ADDR_CHAR 
 	movia r10, BUTTON 
 	movia r11, TIMER 
	
 
 	#clear edge capture of button to avoid unecessary interrupts
	movia r12, 0xFFFFFFFF
 	stwio r12, 12(r10)
	#enable device interrupts
	movi r12, 0x1
	stwio r12, 8(r10)
 	#clear timeout bit of timer 
 	stwio r0, 0(r11)
	#load in first half of period
	movui r12, %lo(PERIOD)
	stwio r12, 8(r11)
	#load in second half of period
	movui r12, %hi(PERIOD)
	stwio r12, 12(r11)
	#enable interrupts for devices
	movi r12, IRQ_DEV
	wrctl ctl3, r12
	
	#enable processor interrupts
	movia r12, 0x1
	wrctl ctl0, r12
 ret 
 
 .section .exceptions, "ax"
 ISR:
	#serve button 0 if pressed
	rdctl et, ctl4
	andi et, et, 0x02
	bne et, r0, serveButton
 br exit
 
 serveButton:
	#acknowledge the interrupt
	movia et, 0xFFFFFFFF
	stwio et, 12(r8)
	#check what state we are in (menu or question)
	movia et, MENU
	beq r13, et, DRAWTEXT
	movia et, Q1
	beq r13, et, DRAWMENU
 br exit
 
 DRAWMENU:
	#call clear screen
	#display buffer screen for 2 seconds
	call drawBuffer
	#call clear screen
	#draw menu
	call drawMenu
	#store new state
	mov r13, r2
 br exit
 
 DRAWTEXT:
	#call clear screen
	#display buffer screen for 2 seconds
	call drawBuffer
	#call clear screen
	#draw text
	call drawText
	#store new state
	mov r13, r2
 br exit
 
 exit:
	addi ea, ea, -4
	eret
 
 
 #this subroutine draws a word on the VGA  
 #this can be davids drawline subroutine
 drawText: 
 	#r4 holds the color value of the text passed in as an argument to this subroutine 
 	movui r12, 0x43 
 	stbio r12, 3880(r9) 
 	movui r12, 0x52 
 	stbio r12, 3881(r9) 
 	movui r12, 0x41 
 	stbio r12, 3882(r9) 
 	movui r12, 0x50 
 	stbio r12, 3883(r9)
	movia r2, Q1
 ret 
 
 drawBuffer:
	#draw crap
	movui r12, 0x55
	stbio r12, 138(r9)
	#start timer, no continous, no interrupts
	movui r12, 0x4
	stwio r12, 4(r11)
	#only display buffer screen for a short period of time (2 seconds)
 timerOnePoll:
	ldwio r12, 0(r11)
	andi r12, r12, 0x1
	beq r12, r0, timerOnePoll
	#reset timeout bit
	stwio r0, 0(r11)
 ret

drawMenu:
	#return state in r2
	#menu text
	movui r12, 0x51
	stbio r12, 138(r9)
	movia r2, MENU
 ret