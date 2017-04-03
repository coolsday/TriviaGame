#############################################################################
# Separate subroutines used to draw alphanumeric characters/small words, 
# they accept a colour and starting position and return the location of where 
# to draw the next adjacent letter/number
#
# Think of this file as a dictionary of characters/words I can use!
#
# r4 stores the pixel color
# r5 stores the starting location of letter (top-left)
# r2 returns the next convinient location of the next letter to draw
#
# Subroutines used...
# - Pretty much 1 subroutine for EACH letter and number (I'm not writing each one)
# - Drawing Symbols:           ! . ? , : ( )
# - Drawing Common Words:      KEY, QUESTION, WHAT, WHICH, INSTRUCTION, NIOS2,
#                              INT, HOW, AND, PROGRAM, EXECUTE, THE, ARE,
#                              VALID, FOLLOWING, HEX, ADD, MOV, VALUE, STORE,
#                              ADDRESS, SUBROUTINE, CALL, DECIMAL, CTL, STATEMENT,
#                              REGISTER, SET, ANY, 000, THIS, NEED, WITH
#############################################################################

.include "vga_basicdraw.s"

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

#############################################################################
 
draw_D:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*2 + 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_E:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 8
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 6
	addi r5, r16, 1024*2
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
 
draw_F:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 8
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2 
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

draw_G:
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
	
	movui r6, 4
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_H:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 2*6 
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

draw_I:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 6
	addi r5, r16, 1024*2 + 2*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_J:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 8
	addi r5, r16, 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*6
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 4
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_K:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_L:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 6
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_M:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 2*8
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*2 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*12	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_N:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*2 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_O:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	addi r5, r16, 1024*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*2 + 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 4
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_P:
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
	
	movui r6, 2
	addi r5, r16, 1024*2 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_Q:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 8
	addi r5, r16, 1024*2 + 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 6
	addi r5, r16, 1024*2
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 4
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_R:
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
	
	movui r6, 2
	addi r5, r16, 1024*2 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_S:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 4
	addi r5, r16, 1024*4 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*2
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

draw_T:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 8
	addi r5, r16, 1024*2 + 2*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_U:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline

	addi r5, r16, 2*6
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 4
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_V:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 8
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline

	addi r5, r16, 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_W:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 8
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline

	addi r5, r16, 2*8
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*12	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_X:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 4
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline

	addi r5, r16, 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*6
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*6 + 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*4 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_Y:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline

	addi r5, r16, 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*4 + 2*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_Z:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 8
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*6 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2 + 2*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*10	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_0:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	addi r5, r16, 1024*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r5, r16, 1024*2 + 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_1:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 4
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline

	movui r6, 6	
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*2 + 2*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_2:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*4
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_3:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2 + 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 4
	addi r5, r16, 1024*4 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_4:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 10
	addi r5, r16, 2*4 
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*4 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_5:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_6:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*4
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_7:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 8
	addi r5, r16, 1024*2 + 2*4
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_8:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 10
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline

	addi r5, r16, 2*4
	call drawVline
	mov r5, r2
	call drawVline
    
	movui r6, 2
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
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_9:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4
	call drawHline
	mov r5, r2
	call drawHline

	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*2 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_ExclamationMark:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 6
	mov r5, r16
	call drawVline
	mov r5, r2
	call drawVline
	
	movui r6, 2
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*4	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_QuestionMark:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 4
	mov r5, r16
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*4
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 2
	addi r5, r16, 1024*2 + 2*4
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*8	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_Period:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 2
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*4	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_Colon:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 2
	addi r5, r16, 1024*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*6
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r2, r16, 2*4	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_Comma:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 2
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*10 + 2*1
	sthio r4, 0(r5)
	
	addi r5, r16, 1024*11
	sthio r4, 0(r5)
	
	addi r2, r16, 2*4	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_LeftBracket:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 2
	addi r5, r16, 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8 + 2*2
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 6
	addi r5, r16, 1024*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*6	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_RightBracket:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	
	movui r6, 2
	call drawHline
	mov r5, r2
	call drawHline
	
	addi r5, r16, 1024*8
	call drawHline
	mov r5, r2
	call drawHline
	
	movui r6, 6
	addi r5, r16, 1024*2 + 2*2
	call drawVline
	mov r5, r2
	call drawVline
	
	addi r2, r16, 2*6	
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################

draw_KEY:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_K
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_Y
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_QUESTION:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_Q
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_N
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_WHAT:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_W
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_T
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_WHICH:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_W
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_H
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_INSTRUCTION:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_N
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_NIOS2:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_N
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_2
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_INT:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_T
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_HOW:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_H
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_W
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_AND:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_D
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_PROGRAM:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_P
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_G
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_M
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_EXECUTE:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_E
	mov r5, r2
	call draw_X
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_E
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_THE:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_E
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_ARE:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_VALID:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_V
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_D
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_FOLLOWING:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_F
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_W
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_G
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_HEX:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_H
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_X
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_ADD:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_A
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_D
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_MOV:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_M
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_V
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_VALUE:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_V
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_E
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_STORE:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_S
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_ADDRESS:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_ADD
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_S
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_SUBROUTINE:	
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_SUB
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_E
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_CALL:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_C
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_L
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_DECIMAL:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_D
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_L
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_CTL:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_C
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_L
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_STATEMENT:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_S
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_T
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_REGISTER:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_G
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_SET:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_T
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_ANY:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_Y
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_000:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_THIS:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_NEED:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_N
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	

#############################################################################

draw_CHA:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_C
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_A
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_SUB:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_S
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_B
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_ORI:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_I
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################

draw_WITH:
	addi sp, sp, -4
	stw ra, 0(sp)

	call draw_W
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret	
