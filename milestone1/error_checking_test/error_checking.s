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
	.equ IRQ_BUTTON, 0x02
	.equ TIMER, 0xFF202000
	.equ PERIOD, 200000000
	.equ IRQ_TIMER, 0x01

_start:
	#initialise pointers to device address and constants
	call init
	#draw a text on vga
	call drawText
loop:
	br loop
	
init:
	movia r8, ADDR_VGA
	movia r9, ADDR_CHAR
	movia r10, BUTTON
	movia r11, TIMER

	#clear edge capture of button to avoid unecessary interrupts
	stwio r0, 12(r10)
	#clear timeout bit of timer
	stwio r0, 0(r11)
ret

#this subroutine draws a word on the VGA 
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
ret