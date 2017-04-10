.section .text

.global _start

#include wav file
SOUND:
.incbin "kat.wav" #tetris

NEWSOUND:
.align 2
#.skip 2653596 #SM
#.skip 1881600 #tetris
.skip 23388288 #kat

#global constants for stuff used
.equ AUDIO_CODEC, 0xFF203040
#.equ SOUND_LENGTH, 663399
#.equ SOUND_LENGTH, 470400 #tetris
.equ SOUND_LENGTH, 5847072 #kat

_start:
	#get location of audio codec
	movia r9, AUDIO_CODEC
	#get starting location of sound file
	movia r8, SOUND
	#get location of newsound
	movia r12, NEWSOUND
	#r14 stores the length in bytes of sound file (total # bytes in file/2)
	movia r14, SOUND_LENGTH
	#move r8 to data section of sound file
	addi r8, r8, 44

	#each sample, is 2 bytes; therefore, total increments is 940,800 bytes/2 bytes
	#movia r11, 470400 #tetris
 	#movia r11, 663399
	#kat
	movia r11, 5847072
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

DONE_PARSE:
#move r12 back to start of newsound
	movia at, 23388288
	sub r12, r12, at 
	#use r10 as counter for sound file
	mov r10, r0


POLL_AUDIO_CODEC:
	#keep polling for write space if full
	ldwio r2, 4(r9)
	andhi r3, r2, 0xff
	beq r3, r0, POLL_AUDIO_CODEC
	#stop playing audio when over
	bgt r10, r14, EXIT

	ldw r20, 0(r12)
	stwio r20, 8(r9)
	stwio r20, 12(r9)
	
	addi r12, r12, 4
	#increment r10
	addi r10, r10, 1
	
	#bne r30, r21, SERVE_AUDIO_CODEC
	
br POLL_AUDIO_CODEC

EXIT:
br EXIT
	