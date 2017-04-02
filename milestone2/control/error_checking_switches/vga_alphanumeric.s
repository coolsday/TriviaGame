#############################################################################
# Separate subroutines used to draw alphanumeric characters, they accept a colour and
# starting position and return the location of where to draw the next
# adjacent letter/number
#
# r4 stores the pixel color
# r5 stores the starting location of letter (top-left)
# r2 returns the next convinient location of the next letter to draw
#
# Subroutines used...
# - Pretty much 1 subroutine for EACH letter and number (I'm not writing each one)
# - draw_ExclamationMark 
# - draw_QuestionMark
# - draw_Period
# - draw_Colon
# - draw_Comma
# - draw_LeftBracket
# - draw_RightBracket
# - draw_KEY
# - draw_QUESTION
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
