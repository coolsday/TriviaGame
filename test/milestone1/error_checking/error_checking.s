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
	bne et, r0, SERVE_BUTTON
 br EXIT
 
 SERVE_BUTTON:
	#acknowledge the interrupt
	movia et, 0xFFFFFFFF
	stwio et, 12(r10)
	#check what state we are in (menu or question)
	movia et, MENU
	beq r13, et, DRAWTEXT
	movia et, Q1
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
 
 DRAWTEXT:
	#call clear screen
	call clearScreen
	#display buffer screen for 2 seconds
	call drawBuffer
	#call clear screen
	call clearScreen
	#draw text
	call drawText
	#store new state
	mov r13, r2
 br EXIT
 
 EXIT:
	addi ea, ea, -4
	eret
 
 
 #this subroutine draws a word on the VGA  
 #this can be davids drawline subroutine
 drawText: 
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
 
 drawBuffer:
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

 # Accepts a colour, starting pixel address, and length 'l'
# to draw a horizontal line, from left to right
# returns the address of the pixel BELOW 
drawHline:
	addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	
	mov r16, r0
	mov r17, r5
	
# Loop through each individual pixel and draw it	
HLINE_LOOPY: 
	bge r16, r6, HLINE_DONE		
    sthio r4, 0(r17)
	addi r17, r17, 2 # Shift to next pixel
	addi r16, r16, 1
	br HLINE_LOOPY
	
HLINE_DONE:	
	ldw ra, 0(sp)
    ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12
	addi r2, r5, 1024
ret

# Accepts a colour, starting pixel address, and length 'l'
# to draw a vertical line, from top to bottom
# returns the address of the RIGHT pixel
drawVline:
	addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	
	mov r16, r0
	mov r17, r5
	
# Loop through each individual pixel and draw it	
VLINE_LOOPY: 
	bge r16, r6, VLINE_DONE		
    sthio r4, 0(r17)
	addi r17, r17, 1024 # Shift to next pixel
	addi r16, r16, 1
	br VLINE_LOOPY
	
VLINE_DONE:	
	ldw ra, 0(sp)
    ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12
	addi r2, r5, 2
ret

# Void subroutine that clears the screen by colouring every pixel black
clearScreen:
	addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	
	# Initialize calls of drawHline 
	movui r4, 0x0000
	mov r5, r8
	movui r6, X_MAX
	
	mov r16, r0
	movui r17, Y_MAX
	
# Loop through each row of pixels and colour it black	
CLEAR_LOOPY:
	bgt r16, r17, CLEAR_DONE
	call drawHline
	mov r5, r2 
	addi r16, r16, 1
    br CLEAR_LOOPY
	
CLEAR_DONE:	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12
ret

#############################################################################

# Separate subroutines used to draw alphanumeric characters, they accept a colour and
# starting position and return the location of where to draw the next
# adjacent letter/number

# r4 stores the pixel color
# r5 stores the starting location of letter (top-left)
# r2 returns the next convinient location of the next letter to draw
#############################################################################

draw_A:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 4
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 8
	addi r5, r16, 1024*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*2 + 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 4
	addi r5, r16, 1024*4 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
    addi r2, r16, 2*10
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret
  
  
#############################################################################

draw_B:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 4
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*4 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*2 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################
 
draw_C:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret