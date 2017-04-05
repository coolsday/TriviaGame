.section .text
###################################
#This program tests audio files 
###################################
.global _start

#include wav file
TEST:
.incbin "test.wav"

_start:
loop:
br loop
