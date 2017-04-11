.section .text
###################################
#This program tests audio files 
###################################
.global _start

#include wav file
SOUND:
#.incbin "test3.wav" #tetris
.incbin "mainTheme.wav"

NEWSOUND:
.align 2
#.skip 2653596
#.skip 1881600 #total data * 2
.skip 2219340

#global constants for stuff used
.equ AUDIO_CODEC, 0xFF203040
#.equ SOUND_LENGTH, 663399
#.equ SOUND_LENGTH, 470400 #total data/2 #tetris
.equ SOUND_LENGTH, 554835

_start:
	#get location of audio codec
	movia r9, AUDIO_CODEC
	#get starting location of sound file
	movia r8, SOUND
	#get location of newsound
	movia r12, NEWSOUND
	#r14 stores the length in bytes of sound file (total # bytes in file/4)
	movia r14, SOUND_LENGTH
	#move r8 to data section of sound file
	addi r8, r8, 44

	#each sample, is 2 bytes; therefore, total increments is 940,800 bytes/2 bytes
	movia r11, SOUND_LENGTH
	#movia r11, 663399
	#counter keeps tracks of bytes serviced
	mov r10, r0
LOOP:
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
br LOOP

# 00001 -> 1
# 00010 -> 2

# 00111 -> 7
# 11100 -> 28
DONE_PARSE:
	#move r12 back to start of newsound
	movia at, 2219340
	sub r12, r12, at 
	#use r10 as counter for sound file
	mov r10, r0
	#activate write interrupts for audio codec
	movui r3, 0x2
	stwio r3, 0(r9)
	#enable ctl3
	movui r3, 0x40 
	wrctl ctl3, r3
	#enable pie bit
	movui r3, 0x1
	wrctl ctl0, r3
	
loop:
#main loop awaiting interrupts from audio codec
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
	#stop audio codec when end of sound file reached
	bgt r10, r14, STOP 
	#ldwio r2, 4(r12)
	#andhi r3, r2, 0xFF00 
	#beq r3, r0, EXIT
	#andhi r3, r2, 0xff
	#beq r3, r0, EXIT

	ldw r20, 0(r12)
	stwio r20, 8(r9)
	stwio r20, 12(r9)
	
	addi r12, r12, 4
	#increment r10
	addi r10, r10, 1
	
	#bne r30, r21, SERVE_AUDIO_CODEC
	
br EXIT

STOP:
	#clear write interrupts for audio codec
	stwio r0, 0(r9)
br EXIT

EXIT:
	addi ea, ea, -4
	eret
