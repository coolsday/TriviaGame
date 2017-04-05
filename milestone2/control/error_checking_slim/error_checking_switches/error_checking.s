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
 	#r15 points to the switches

 	#r13 stores state of transition
 	#r14 stores the data from switches
 	#r16 stores the state of the interrupt using active high convention
####################################################################################################################################

 .global _start 
 
 	.include "vga_questions.s"

 	#global constants for device addresses and interrupt handlers 
 	.equ ADDR_VGA, 0x08000000 
 	.equ ADDR_CHAR, 0x09000000 
 	.equ SWITCHES, 0xFF200040
 	.equ BUTTON, 0xFF200050 
 	.equ IRQ_DEV, 0x02
 	.equ TIMER, 0xFF202000 
 	.equ PERIOD, 200000000 
	.equ START, 0x01
	.equ Q1, 0x02
	.equ A1, 0x03
	.equ A2, 0x04
	.equ A3, 0x05
	.equ A4, 0x06
	.equ A5, 0x07 
	.equ A6, 0x08 
	.equ A7, 0x09 
	.equ A8, 0x10 
	.equ A9, 0x11
	.equ A10, 0x12
	.equ A11, 0x13
	.equ A12, 0x14
	.equ A13, 0x15
	.equ A14, 0x16
	.equ A15, 0x17
	.equ X_MAX, 318
	.equ Y_MAX, 237
	.equ STACK, 0x03FFFFFC
 
 
 _start: 
	#initialise pointers to device address and constants 
 	call init
	#clear screen initially
	call clearScreen
 	#draw the menu on vga 
 	call drawMainMenu
	#r13 holds the initial state of the transition which is the menu or starting screen
	movia r13, START
	#enable processor interrupts
	movia at, 0x1
	wrctl ctl0, at 
	#MAIN PROGRAM
 LOOP_START:
 	#transition to next state if button pressed or interrupt had happened
 	beq r16, r0, LOOP_START
 	#disable external interrupts before drawing
 	wrctl ctl0, r0
	wrctl ctl3, r0 #######################################################################
 	#draw the screen according to state value
 	movia at, START
	beq r13, at, DRAWMENU
	movia at, Q1
 	beq r13, at, DRAWQ1
 	movia at, A1
 	beq r13, at, DRAWANSWER1
 	movia at, A2
 	beq r13, at, DRAWANSWER2 
 	movia at, A3
 	beq r13, at, DRAWANSWER3
 	movia at, A4
 	beq r13, at, DRAWANSWER4
 	movia at, A5
 	beq r13, at, DRAWANSWER5
 	movia at, A6
 	beq r13, at, DRAWANSWER6
 	movia at, A7
 	beq r13, at, DRAWANSWER7
 	movia at, A8
 	beq r13, at, DRAWANSWER8
 	movia at, A9
 	beq r13, at, DRAWANSWER9
 	movia at, A10
 	beq r13, at, DRAWANSWER10
 	movia at, A11
 	beq r13, at, DRAWANSWER11
 	movia at, A12
 	beq r13, at, DRAWANSWER12
 	movia at, A13
 	beq r13, at, DRAWANSWER13
 	movia at, A14
 	beq r13, at, DRAWANSWER14
 	movia at, A15
 	beq r13, at, DRAWANSWER15
 LOOP_END: 
 	#reset state of interrupt (r16) to 0
	#clear edge capture of button to avoid unecessary interrupts
 	mov r16, r0
	movia r12, 0xFFFFFFFF
 	stwio r12, 12(r10)
 	#enable external processor interrupts
	movi at, IRQ_DEV
	wrctl ctl3, at
 	movia at, 0x1
 	wrctl ctl0, at
	
	
 br LOOP_START

	 
 init: 
 	movia r8, ADDR_VGA 
 	movia r9, ADDR_CHAR 
 	movia r10, BUTTON 
 	movia r11, TIMER
 	movia r15, SWITCHES
	movia sp, STACK
	
	mov r16, r0
 	#clear edge capture of button to avoid unecessary interrupts
	movia r12, 0xFFFFFFFF
 	stwio r12, 12(r10)
	#enable button interrupts for 1 button
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
 ret 

 DRAWMENU:
	#clear screen
	call clearScreen
	#display menu
	call drawMainMenu
br LOOP_END
 
 DRAWQ1:
 	#clear screen
 	call clearScreen
 	#loading screen
 	call drawLoadingScreen
	call timerOnePoll
 	#clear screen
 	call clearScreen
 	#display Q1
 	call drawQuestion1
	call timerOnePoll
 br LOOP_END

 DRAWANSWER1:
 	#clear screen
 	call clearScreen
 	#display answer for Q1
 	call drawAnswer1
 	#clear screen
 	call clearScreen
 	#display Q2
 	call drawQuestion2
	call timerOnePoll
 br LOOP_END

 DRAWANSWER2:
 	#clear screen
 	call clearScreen
 	#display answer for Q2
 	call drawAnswer2
 	#clear screen
 	call clearScreen
 	#display Q3
 	call drawQuestion3
	call timerOnePoll
 br LOOP_END

 DRAWANSWER3:
 	#clear screen
 	call clearScreen
 	#display answer for Q3
 	call drawAnswer3
 	#clear screen
 	call clearScreen
 	#display Q4
 	call drawQuestion4
	call timerOnePoll
 br LOOP_END

 DRAWANSWER4:
 	#clear screen
 	call clearScreen
 	#display answer for Q4
 	call drawAnswer4
 	#clear screen
 	call clearScreen
 	#display Q5
 	call drawQuestion5
	call timerOnePoll
 br LOOP_END

DRAWANSWER5:
 	#clear screen
 	call clearScreen
 	#display answer for Q5
 	call drawAnswer5
 	#clear screen
 	call clearScreen
 	#display Q6
 	call drawQuestion6
	call timerOnePoll
 br LOOP_END

DRAWANSWER6:
 	#clear screen
 	call clearScreen
 	#display answer for Q6
 	call drawAnswer6
 	#clear screen
 	call clearScreen
 	#display Q7
 	call drawQuestion7
	call timerOnePoll
 br LOOP_END

DRAWANSWER7:
 	#clear screen
 	call clearScreen
 	#display answer for Q7
 	call drawAnswer7
 	#clear screen
 	call clearScreen
 	#display Q8
 	call drawQuestion8
	call timerOnePoll
 br LOOP_END

DRAWANSWER8:
 	#clear screen
 	call clearScreen
 	#display answer for Q8
 	call drawAnswer8
 	#clear screen
 	call clearScreen
 	#display Q9
 	call drawQuestion9
	call timerOnePoll
 br LOOP_END

 DRAWANSWER9:
 	#clear screen
 	call clearScreen
 	#display answer for Q9
 	call drawAnswer9
 	#clear screen
 	call clearScreen
 	#display Q10
 	call drawQuestion10
	call timerOnePoll
 br LOOP_END

DRAWANSWER10:
 	#clear screen
 	call clearScreen
 	#display answer for Q10
 	call drawAnswer10
 	#clear screen
 	call clearScreen
 	#display Q11
 	call drawQuestion11
	call timerOnePoll
 br LOOP_END

DRAWANSWER11:
 	#clear screen
 	call clearScreen
 	#display answer for Q11
 	call drawAnswer11
 	#clear screen
 	call clearScreen
 	#display Q12
 	call drawQuestion12
	call timerOnePoll
 br LOOP_END

DRAWANSWER12:
 	#clear screen
 	call clearScreen
 	#display answer for Q12
 	call drawAnswer12
 	#clear screen
 	call clearScreen
 	#display Q13
 	call drawQuestion13
	call timerOnePoll
 br LOOP_END

DRAWANSWER13:
 	#clear screen
 	call clearScreen
 	#display answer for Q13
 	call drawAnswer13
 	#clear screen
 	call clearScreen
 	#display Q14
 	call drawQuestion14
	call timerOnePoll
 br LOOP_END

DRAWANSWER14:
 	#clear screen
 	call clearScreen
 	#display answer for Q14
 	call drawAnswer14
 	#clear screen
 	call clearScreen
 	#display Q15
 	call drawQuestion15
	call timerOnePoll
 br LOOP_END


 DRAWANSWER15:
 	#clear screen
 	call clearScreen
 	#display answer for Q15
 	call drawAnswer15
 	#clear screen
 	call clearScreen
 	#display Game Over Screen
 	call drawGameOver
	call timerOnePoll
 br LOOP_END


 ##############################################
 #ISR
 ##############################################
 
 .section .exceptions, "ax"
 ISR:
	#serve button 0 if pressed
	rdctl et, ctl4
	andi et, et, 0x02
	bne et, r0, SERVE_BUTTON
 br EXIT
 
 SERVE_BUTTON:
 	#read in switch value
 	ldwio r14, 0(r15)
	andi r14, r14, 0xF #Get only SW 0-3
 	#store the state of the interrupt (1 if on/ 0 if off)
 	movi r16, 1
	#acknowledge the interrupt
	movia et, 0xFFFFFFFF
	stwio et, 12(r10)
	#check what state we are in (menu or question)
	movia et, START
	beq r13, et, MENU
	movia et, Q1
	beq r13, et, QUESTION1
	movia et, A1
	beq r13, et, ANSWER1
	movia et, A2
	beq r13, et, ANSWER2
	movia et, A3
	beq r13, et, ANSWER3
	movia et, A4
	beq r13, et, ANSWER4 
	movia et, A5
	beq r13, et, ANSWER5 
	movia et, A6
	beq r13, et, ANSWER6 
	movia et, A7
	beq r13, et, ANSWER7
	movia et, A8
	beq r13, et, ANSWER8 
	movia et, A9
	beq r13, et, ANSWER9 
	movia et, A10
	beq r13, et, ANSWER10 
	movia et, A11
	beq r13, et, ANSWER11 
	movia et, A12
	beq r13, et, ANSWER12 
	movia et, A13
	beq r13, et, ANSWER13 
	movia et, A14
	beq r13, et, ANSWER14
	movia et, A15
	beq r13, et, ANSWER15 
 br EXIT
 
MENU:
	#store the state of Q1
	movia r13, Q1
br EXIT

QUESTION1:
	#store the new state
	movia r13, A1 #
br EXIT
 
ANSWER1:
	#store new state
	movia r13, A2
br EXIT

ANSWER2:
	#store new state
	movia r13, A3
br EXIT

ANSWER3:
	#store new state
	movia r13, A4
br EXIT

ANSWER4:
	#store new state
	movia r13, A5
br EXIT

ANSWER5:
	#store new state
	movia r13, A6
br EXIT

ANSWER6:
	#store new state
	movia r13, A7
br EXIT

ANSWER7:
	#store new state
	movia r13, A8
br EXIT

ANSWER8:
	#store new state
	movia r13, A9
br EXIT

ANSWER9:
	#store new state
	movia r13, A10
br EXIT

ANSWER10:
	#store new state
	movia r13, A11
br EXIT

ANSWER11:
	#store new state
	movia r13, A12
br EXIT

ANSWER12:
	#store new state
	movia r13, A13
br EXIT

ANSWER13:
	#store new state
	movia r13, A14
br EXIT

ANSWER14:
	#store new state
	movia r13, A15
br EXIT

ANSWER15:
	#store new state
	movia r13, START
br EXIT
 
EXIT:
	addi ea, ea, -4
	eret
 

.section .text
################################################
#the draw functions are void - they dont return anything or accept anything
################################################

#testing subroutines used to model control flow of program
#r14 used to store the value of buttons before we clear the edge capture register to aknowledge the interrupt
drawAnswer1:
	#for question 1, switch 2 (on) is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#determine if switch 2 is on (value = 0x8)
	movi r4, 4
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT1:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret
 
drawAnswer2:
	#for question 2, button 2 (value = 0x8) is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 2 (1 if on/0 if off)
	movi r4, 4
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT2:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer3:
	#for question 3, switch 3 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 3 (1 if on/ 0 if off)
	movui r4, 8
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT3:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer4:
	#for question 4, switch 1 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 1 (1 if on/ 0 if off)
	movui r4, 2
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT4:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer5:
	#for question 5, switch 0 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 0 (1 if on/ 0 if off)
	movui r4, 1
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT5:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer6:
	#for question 6, switch 0 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 0 (1 if on/ 0 if off)
	movui r4, 1
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT6:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer7:
	#for question 7, switch 2 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 2 (1 if on/ 0 if off)
	movui r4, 4
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT7:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer8:
	#for question 8, switch 3 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 3 (1 if on/ 0 if off)
	movui r4, 8
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT8:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer9:
	#for question 9, switch 2 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 2 (1 if on/ 0 if off)
	movui r4, 4
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT9:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer10:
	#for question 10, switch 2 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 2 (1 if on/ 0 if off)
	movui r4, 4
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT10:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer11:
	#for question 11, switch 0 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 0 (1 if on/ 0 if off)
	movui r4, 1
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT11:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer12:
	#for question 12, switch 1 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 1 (1 if on/ 0 if off)
	movui r4, 2
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT12:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer13:
	#for question 13, switch 0 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 0 (1 if on/ 0 if off)
	movui r4, 1
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT13:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer14:
	#for question 14, switch 1 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 1 (1 if on/ 0 if off)
	movui r4, 2
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT14:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

drawAnswer15:
	#for question 15, switch 1 is correct
	addi sp, sp, -4
	stw ra, 0(sp)
	
	#get state of switch 1 (1 if on/ 0 if off)
	movui r4, 2
	#draw incorrect answer (draw no for now, until later on)
	beq r14, r4, CORRECTANSWER
	#draw correct answer (draw yes for now, until later on)
	bne r14, r4, INCORRECTANSWER
WAIT15:
	#only display buffer screen for a short period of time (2 seconds)
	#display this screen for 2 seconds
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret


 
 timerOnePoll:
	#start timer, no continous, no interrupts
	movui r12, 0x4
	stwio r12, 4(r11)
 POLL:
	ldwio r12, 0(r11)
	andi r12, r12, 0x1
	beq r12, r0, POLL
	#reset timeout bit
	stwio r0, 0(r11)
ret

######################################################################
#Answers for the questions 
######################################################################
INCORRECTANSWER:
	addi sp, sp, -4
	stw ra, 0(sp)
	movui r4, 0xF100
	movia r5, 1024*100 + 2*40
	add r5, r5, r8

	# Drsw screen for incorrect answer
	call drawIncorrectAnswer

	ldw ra, 0(sp)
	addi sp, sp, 4

	#go back to the subroutine that called it
	movia et, A1
	beq r13, et, WAIT1
	movia et, A2
	beq r13, et, WAIT2
	movia et, A3
	beq r13, et, WAIT3
	movia et, A4
	beq r13, et, WAIT4
	movia et, A5
	beq r13, et, WAIT5
	movia et, A6
	beq r13, et, WAIT6
	movia et, A7
	beq r13, et, WAIT7
	movia et, A8
	beq r13, et, WAIT8
	movia et, A9
	beq r13, et, WAIT9
	movia et, A10
	beq r13, et, WAIT10
	movia et, A11
	beq r13, et, WAIT11
	movia et, A12
	beq r13, et, WAIT12
	movia et, A13
	beq r13, et, WAIT13
	movia et, A14
	beq r13, et, WAIT14
	movia et, A15
	beq r13, et, WAIT15
	#pray for this not to happen 
br LOOP_END

CORRECTANSWER:
	addi sp, sp, -4
	stw ra, 0(sp)
	movui r4, 0x780F
	movia r5, 1024*100 + 2*40
	add r5, r5, r8

	# Draw screen for correct answer
	call drawCorrectAnswer

	ldw ra, 0(sp)
	addi sp, sp, 4

	#go back to the subroutine that called it
	movia et, A1
	beq r13, et, WAIT1
	movia et, A2
	beq r13, et, WAIT2
	movia et, A3
	beq r13, et, WAIT3
	movia et, A4
	beq r13, et, WAIT4
	movia et, A5
	beq r13, et, WAIT5
	movia et, A6
	beq r13, et, WAIT6
	movia et, A7
	beq r13, et, WAIT7
	movia et, A8
	beq r13, et, WAIT8
	movia et, A9
	beq r13, et, WAIT9
	movia et, A10
	beq r13, et, WAIT10
	movia et, A11
	beq r13, et, WAIT11
	movia et, A12
	beq r13, et, WAIT12
	movia et, A13
	beq r13, et, WAIT13
	movia et, A14
	beq r13, et, WAIT14
	movia et, A15
	beq r13, et, WAIT15
	#pray for this not to happen 
br LOOP_END