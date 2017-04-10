# Store high score / # correct answers / # wrong answers in memory
# load wav file into memory
.section .data
NUM_A_CORRECT: .word 0
NUM_A_INCORRECT: .word 0
HIGH_SCORE: .word 0
WAV_FILE: .incbin "test3.wav" 
TETRIS: 
	.align 2
	.skip 1881600 

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
	#r12 is a temporary register
 	#r13 stores state of transition
 	#r14 stores the data from switches
	#r15 points to the switches
 	#r16 stores the state of the interrupt using active high convention
####################################################################################################################################

 .global _start 
 
 	.include "vga_questions.s"
    .include "seven_seg.s"
	
###############################################################################
# Global constants for device addresses and interrupt handlers 
###############################################################################

    # Device address values
 	.equ ADDR_VGA, 0x08000000 
 	.equ ADDR_CHAR, 0x09000000 
	.equ ADDR_7SEG1, 0xFF200020
    .equ ADDR_7SEG2, 0xFF200030
 	.equ SWITCHES, 0xFF200040
 	.equ BUTTON, 0xFF200050 
 	.equ IRQ_DEV, 0x02
 	.equ TIMER, 0xFF202000 
 	.equ AUDIO_CODEC, 0xFF203040

 	#sound length values
 	.equ SOUND_LENGTH, 470400 #tetris
	
	# Constants for establishing timer periods
	.equ POINT_FIVE_SECONDS, 50000000 
 	.equ TWO_SECONDS, 200000000 
	.equ FIVE_SECONDS, 500000000 
	
	# Constants for the states
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
	
	# Misc. constants
	.equ X_MAX, 318
	.equ Y_MAX, 237
	.equ STACK, 0x03FFFFFC
 
 
 _start: 
 	#extract 32 bit samples from wav file
 	call extractSamples
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
<<<<<<< HEAD
	wrctl ctl3, r0 #######################################################################
=======
	wrctl ctl3, r0 
>>>>>>> added working soundfiles
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

###############################################################################
# Subroutine that initializes all devices used in the project and extracts samples from 16 bit wav file
###############################################################################
extractSamples:
	#get starting location of sound file
	movia r8, WAV_FILE
	#get location of newsound
	movia r12, TETRIS
	#move r8 to data section of sound file
	addi r8, r8, 44

	#each sample, is 2 bytes; therefore, total increments is 940,800 bytes/2 bytes
	movia r11, 470400
	#movia r11, 663399
	#counter keeps tracks of bytes serviced
	mov r10, r0
EXTRACT:
	#end of data reached when counter (r10) > size of data (470400)
	bgt r10, r11, DONE_PARSE
	#get first 2 bytes
	ldh at, 0(r8)
	#go to next 2 bytes
	addi r8, r8, 2
	#scale halfword to word
	slli at, at, 16
	#store this word into NEWSOUND
	stw at, 0(r12)
	#go to next word
	addi r12, r12, 4
	#increment counter
	addi r10, r10, 1
br EXTRACT

DONE_PARSE:
ret

 init: 
	movia r8, ADDR_VGA 
 	movia r9, ADDR_CHAR 
 	movia r10, BUTTON 
 	movia r11, TIMER
 	movia r15, SWITCHES
	movia sp, STACK
	
    addi sp, sp, -4
	stw ra, 0(sp)
	
	# Set ALL HEX displays to 0
	call clearHex0to3
	call clearHex4to5
	
	mov r16, r0
 	# Clear edge capture of button to avoid unecessary interrupts
	movia r12, 0xFFFFFFFF
 	stwio r12, 12(r10)
	
	# Enable button interrupts for 1 button
	movi r12, 0x1
	stwio r12, 8(r10)
	
 	# Clear timeout bit of timer 
 	stwio r0, 0(r11)
	
	# Enable interrupts for devices
	movi r12, IRQ_DEV
	wrctl ctl3, r12
	
	ldw ra, 0(sp)
	addi sp, sp, 4
 ret 

 DRAWMENU:
	#clear screen
	call clearScreen
	#display menu
	#reset Q/A correct/incorrect for new game
	movia r12, NUM_A_INCORRECT
	stw r0, 0(r12)
	movia r12, NUM_A_CORRECT
	stw r0, 0(r12)
	call clearHex0to3
	call drawMainMenu
	#initialise audio codec, poll for some time to play main theme before exiting
	#play main theme for a few seconds
	call playMainTheme
br LOOP_END

playMainTheme:
	#save any used register on stack
	addi sp, sp, -28
	stw ra, 0(sp)
	stw r8, 4(sp)
	stw r9, 8(sp)
	stw r10, 12(sp)
	stw r11, 16(sp)
	stw r12, 20(sp)
	stw r13, 24(sp)

	#use r8 for audio codec address
	movia r8, AUDIO_CODEC
	#r9 for temp var #1
	mov r9, r0
	#r10 for temp var #2
	mov r10, r0
	#r11 for length of sound
	movia r11, SOUND_LENGTH
	#r12 for temp var #3
	mov r12, r0
	#r13 for location of sound samples
	movia r13, TETRIS

	#use at as counter for sound file
	mov at, r0

POLL_AUDIO_CODEC:
	#keep polling for write space if full
	ldwio r9, 4(r8)
	andhi r10, r9, 0xff
	beq r10, r0, POLL_AUDIO_CODEC
	#stop playing audio when over
	bgt r10, r11, DONE_PLAYING

	ldw r12, 0(r13)
	stwio r12, 8(r8)
	stwio r12, 12(r8)
	
	addi r13, r13, 4
	#increment at
	addi at, at, 1
	
	#bne r30, r21, SERVE_AUDIO_CODEC
	
br POLL_AUDIO_CODEC

DONE_PLAYING:
	#load from stack
	ldw ra, 0(sp)
	ldw r8, 4(sp)
	ldw r9, 8(sp)
	ldw r10, 12(sp)
	ldw r11, 16(sp)
	ldw r12, 20(sp)
	ldw r13, 24(sp)
	addi sp, sp, 28
ret

 
 DRAWQ1:
 	#clear screen
 	call clearScreen
 	#loading screen
 	call drawLoadingScreen
<<<<<<< HEAD
=======
	movia r4, FIVE_SECONDS
>>>>>>> added working soundfiles
	call timerOnePoll
 	#clear screen
 	call clearScreen
 	#display Q1
 	call drawQuestion1
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
<<<<<<< HEAD
=======
	movia r4, POINT_FIVE_SECONDS
>>>>>>> added working soundfiles
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
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
	movia r4, TWO_SECONDS
	call timerOnePoll
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret


<<<<<<< HEAD
 
 timerOnePoll:
	#start timer, no continous, no interrupts
=======
######################################################################
# Void subroutine that polls the timer for a certain amount of time
# defined by the # of clock cycles that is passed into r4
######################################################################
 timerOnePoll:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
    
	# Set period of timer
	andi r16, r4, 0x0000FFFF
	stwio r16, 8(r11) # Low period
	movia r16, 0xFFFF0000
	and r16, r16, r4
	srli r16, r16, 16 
	stwio r16, 12(r11) # High period
	
	# Start timer, no continous, no interrupts
>>>>>>> added working soundfiles
	movui r12, 0x4
	stwio r12, 4(r11)
 POLL:
	ldwio r12, 0(r11)
	andi r12, r12, 0x1
	beq r12, r0, POLL
	
	# Reset timeout bit
	stwio r0, 0(r11)
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

######################################################################
# Answers for the questions 
######################################################################
INCORRECTANSWER:
	addi sp, sp, -16
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r18, 12(sp)
	
	# Increment HEX 2-3 (Incorrect Answers)
	movia r16, NUM_A_INCORRECT
	ldw r17, 0(r16)
	addi r17, r17, 1
	movui r18, 9
	
	# If the number is double digits, handle the HEX display a bit differently
	bgt r17, r18, HEX2TO3_DOUBLE_DIGITS
	
	# Single Digit case
	mov r4, r17
	call convertValueToHexLights
	mov r4, r2
	movui r5, 2
	call writeHex0to3
	br HEX2TO3_REST
	
	# Double Digit case
HEX2TO3_DOUBLE_DIGITS:
    subi r18, r17, 10
	mov r4, r18
	call convertValueToHexLights
	mov r4, r2
	movui r5, 2
	call writeHex0to3
	
	movui r4, 1
	call convertValueToHexLights
	mov r4, r2
	movui r5, 3
	call writeHex0to3

HEX2TO3_REST:
	stw r17, 0(r16) # Store the new value of incorrect answers
	
	# Draw screen for incorrect answer
	call drawIncorrectAnswer

	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r18, 12(sp)
	addi sp, sp, 16

	# Go back to the subroutine that called it
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
	addi sp, sp, -20
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	
	# Increment HEX 2-3 (Incorrect Answers)
	movia r16, NUM_A_CORRECT
	ldw r17, 0(r16)
	addi r17, r17, 1
	movui r18, 9
	
	# If the number is double digits, handle the HEX display a bit differently
	bgt r17, r18, HEX0TO1_DOUBLE_DIGITS
	
	# Single Digit case
	mov r4, r17
	call convertValueToHexLights
	mov r4, r2
	movui r5, 0
	call writeHex0to3
	br HEX0TO1_REST
	
	# Double Digit case
HEX0TO1_DOUBLE_DIGITS:
    subi r18, r17, 10
	mov r4, r18
	call convertValueToHexLights
	mov r4, r2
	movui r5, 0
	call writeHex0to3
	
	movui r4, 1
	call convertValueToHexLights
	mov r4, r2
	movui r5, 1
	call writeHex0to3

HEX0TO1_REST:
    stw r17, 0(r16) # Store the new value of correct answers
	
    # Now check if we have achieved a high score
    movia r16, HIGH_SCORE
	ldw r19, 0(r16)
	bge r19, r17, HEX4TO5_REST
	
	# If current score > high score, update the high score
	mov r19, r17
	movui r18, 9
	
	# If the number is double digits, handle the HEX display a bit differently
	bgt r19, r18, HEX4TO5_DOUBLE_DIGITS
	
	# Single Digit case
	mov r4, r19
	call convertValueToHexLights
	mov r4, r2
	movui r5, 4
	call writeHex4to5
	br HEX4TO5_REST
	
	# Double Digit case
HEX4TO5_DOUBLE_DIGITS:
    subi r18, r19, 10
	mov r4, r18
	call convertValueToHexLights
	mov r4, r2
	movui r5, 4
	call writeHex4to5
	
	movui r4, 1
	call convertValueToHexLights
	mov r4, r2
	movui r5, 5
	call writeHex4to5
	
HEX4TO5_REST:
	stw r19, 0(r16)
	
	# Draw screen for correct answer
	call drawCorrectAnswer

	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	addi sp, sp, 20

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