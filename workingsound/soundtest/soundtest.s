.section .text
###################################
#This program tests audio files 
###################################
.global _start

#include wav file
SOUND:
.incbin "test3.wav"

#our new music storage for 32 bit/sample sound data
NEWSOUND:
.align 2
.skip 266276

#global constants for stuff used
.equ VGA_ADDRESS, 0x80000000
.equ AUDIO_CODEC, 0xFF203040

_start:
	#get starting location of sound file
	movia r9, SOUND
	#get starting location of NEWSOUND
	movia r8, SOUND
	movia r15, NEWSOUND
	movia r16, NEWSOUND
	addi r16, r16, 4
	#get location of audio codec
	movia r12, AUDIO_CODEC
	#get bits/sample of sound file
	ldh r11, 34(r9)
	#get data size in bytes 
	ldw r13, 40(r9)
	#get first 1 bits of data
	ldb r14, 44(r9)

	#mov r9 to data
	addi r9, r9, 44



DONE_PARSE:

	#activate write interrupts for audio codec
	movui r3, 0x2
	stwio r3, 0(r12)
	#enable ctl3
	movui r3, 0x40 
	wrctl ctl3, r3
	#enable pie bit
	movui r3, 0x1
	wrctl ctl0, r3


loop:

 
#addi r15, r15, 4

br loop

.section .exceptions, "ax"
ISR:
	#check if audio codec caused interrupt
	#mov r20, r0
	#movui r21, 60000
	rdctl et, ctl4
	andi et, et, 0x40
	bne et, r0, SERVE_AUDIO_CODEC

br EXIT

SERVE_AUDIO_CODEC:
	#write something to both left and right channels

	ldw r20, 0(r9)
	stwio r20, 8(r12)
	stwio r20, 12(r12)
	
	addi r9, r9, 4
	#bne r30, r21, SERVE_AUDIO_CODEC
	
br EXIT

EXIT:
	addi ea, ea, -4
	eret

