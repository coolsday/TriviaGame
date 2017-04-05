.section .text
###################################
#This program tests audio files 
###################################
.global _start

.include "vga_questions.s"
#include wav file
SOUND:
.incbin "test.wav"

#global constants for stuff used
.equ VGA_ADDRESS, 0x80000000

_start:
	#initialise vga pointer
	movia r8, VGA_ADDRESS
	#get starting location of sound file
	movia r9, SOUND
	#get file format of sound file
	ldw r10, 8(r9)
	#get bits/sample of sound file
	ldh r11, 34(r9)
	#get data header of sound file
	ldw r12, 36(r9)
	#get data size in bytes 
	ldw r13, 40(r9)
	#get first 1 bits of data
	ldb r14, 44(r9)
loop:
br loop



