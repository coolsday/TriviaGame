.section .text
###################################
#This program tests audio files 
###################################
.global _start

#include wav file
SOUND:
.incbin "test.wav"

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
	movia r8, NEWSOUND
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

	#scale 8 bit sound data to 32 bits (word)
	slli r14, r14, 24
	#store 32 bit into NEWSOUND
	stw r14, 0(r8)
	addi r8, r8, 4
	stw r14, 0(r8)

	#counter keeps tracks of bytes serviced
	mov r10, r0
	addi r9, r9, 44
LOOP:
	#end of data reached when counter (r10) > size of data (66569)
	bgt r10, r13, DONE_PARSE
	#get first byte
	ldb r14, 0(r9)
	#go to next byte
	addi r9, r9, 1
	#scale byte to word
	slli r14, r14, 24
	#store this word into NEWSOUND
	stw r14, 0(r8)
	#go to next word
	addi r8, r8, 4
	#increment counter
	addi r10, r10, 1
br LOOP

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
	
	ldwio r2, 4(r12)
	andhi r3, r2, 0xFF00 
	beq r3, r0, EXIT
	andhi r3, r2, 0xff
	beq r3, r0, EXIT

	ldw r20, 0(r15)
	ldw r21, 0(r16)
	stwio r21, 8(r12)
	stwio r20, 12(r12)
	
	addi r15, r15, 4
	addi r16, r16, 4
	#bne r30, r21, SERVE_AUDIO_CODEC
	
br SERVE_AUDIO_CODEC

EXIT:
	addi ea, ea, -4
	eret

