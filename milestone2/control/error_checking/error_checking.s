.section .text
#################################################################################################################################### 
#this main program is the core of our trivia game as it is #implemented to control the flow of the game, such as listening #for key presses and re-drawing the screen for the next question.

#In the beginning, the screen is cleared and the menu is drawn. 
#when a key is pressed, the state transitions to the first
#question.
#When a key is pressed in the future, the ISR compares the current
#state and then appropriately calls the appropriate drawAnswer
#subroutine which draws the answer on screen for a period of time
#before clearing the screen and calling the next question 
#(also the new state is stored in r13)
#
#for a short duration (as determined by timer) before erasing the text 
 	#r8 points to vga 
 	#r9 points to char buffer 
 	#r10 points to button 
 	#r11 points to timer

#################################################################################################################################### 
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
	.equ Q2, 0x03
	.equ Q3, 0x04
	.equ X_MAX, 318
	.equ Y_MAX, 237
	.equ STACK, 0x03FFFFFC
 
 
 _start: 
	#initialise pointers to device address and constants 
 	call init
	#clear screen initially
	call clearScreen
 	#draw the menu on vga 
 	call drawMenu
	#r13 holds the state of the transition
	mov r13, r2
 LOOP_START: 
 	br LOOP_START 
 	 
 init: 
 	movia r8, ADDR_VGA 
 	movia r9, ADDR_CHAR 
 	movia r10, BUTTON 
 	movia r11, TIMER
	movia sp, STACK
	
 
 	#clear edge capture of button to avoid unecessary interrupts
	movia r12, 0xFFFFFFFF
 	stwio r12, 12(r10)
	#enable button interrupts
	movi r12, 0xF
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
	bne et, r0, SERVE_BUTTON
 br EXIT
 
 SERVE_BUTTON:
	#acknowledge the interrupt
	movia et, 0xFFFFFFFF
	stwio et, 12(r10)
	#check what state we are in (menu or question)
	movia et, MENU
	beq r13, et, DRAWQ1
	movia et, Q1
	beq r13, et, DRAWANSWER1
	movia et, Q2
	beq r13, et, DRAWANSWER2
	movia et, Q3
	beq r13, et, DRAWANSWER3
	movia et, MENU
	beq r13, et, DRAWMENU
 br EXIT
 
 DRAWMENU:
	#call clear screen
	call clearScreen
	#display buffer screen for 2 seconds
	call drawBuffer
	#call clear screen
	call clearScreen
	#draw menu
	call drawMenu
	#store new state
	mov r13, r2
 br EXIT

DRAWQ1:
	#call clear screen
	#draw Q1
	call drawQuestion1
	#store the new state
	mov r13, r2
br EXIT
 
DRAWANSWER1:
	#call clear screen
	call clearScreen
	#draw answer for question 1
	call drawAnswer1
	#store new state
	mov r13, r2
br EXIT

DRAWANSWER2:
	#call clear screen
	call clearScreen
	#display question 2
	call drawAnswer2
	#store new state
	mov r13, r2
br EXIT

DRAWANSWER3:
	#call clear screen
	call clearScreen
	#display answer for question 2
	call drawAnswer3
	#store new state
	mov r13, r2
br EXIT
 
EXIT:
	addi ea, ea, -4
	eret
 
 
drawMenu:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#return state in r2
	#menu text
	movui r4, 0x780F
	movia r5, 1024*100 + 2*40
	add r5, r5, r8
	call draw_A
	movia r2, MENU
	
	ldw ra, 0(sp)
	addi sp, sp, 4
 ret


 #this subroutine draws a word on the VGA  
 #this can be davids drawline subroutine
 drawQuestion1: 
 	#r4 holds the color value of the text passed in as an argument to this subroutine
	addi sp, sp, -4
	stw ra, 0(sp)
	
 	movui r4, 0xF100
	movia r5, 1024*100 + 2*40
	add r5, r5, r8
	call draw_B
	movia r2, Q1
	
	ldw ra, 0(sp)
	addi sp, sp, 4
 ret

drawAnswer1:
	#say for question 1, button 0 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get values of button pressed and store in r12
	ldwio r12, 0(r10)
	andi r12, r12, 0x1
	#draw incorrect answer (draw no for now, until later on)
	beq r12, r0, INCORRECT_ANSWER_1
	#draw correct answer (draw yes for now, until later on)
	bne r12, r0, CORRECT_ANSWER_1
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
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret
	 
 
drawAnswer2:
	#save stack
	addi sp, sp, -4
	stw ra, 0(sp)

	#some question goes here
	movia r2, Q2

	#load from stack
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer3:
ret

 drawLoading:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#draw crap
	movui r4, 0xFD20
	movia r5, 1024*100 + 2*40
	add r5, r5, r8
	call draw_C
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
	
	ldw ra, 0(sp)
	addi sp, sp, 4
 ret
