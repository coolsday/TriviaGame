#############################################################################
# Separate subroutines used for drawing basic lines/shapes of different
# colours, these will be the base functions used for drawing
# our desired text/background on the VGA
#
# Subroutines used...
# - drawHline
# - drawVline
# - drawRectangle
# - fillRectangle
#############################################################################

#############################################################################
# Accepts a colour, starting pixel address, and length 'l'
# to draw a horizontal line, from left to right
# returns the address of the pixel BELOW
############################################################################# 
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

#############################################################################
# Accepts a colour, starting pixel address, and length 'l'
# to draw a vertical line, from top to bottom
# returns the address of the RIGHT pixel
#############################################################################
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

#############################################################################
# Void subroutine that draws a rectangle (unfilled) of a certain colour
# at a starting position (top-left corner) with width (x) and length (y)
#############################################################################
drawRectangle:
	addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	
	mov r16, r5
	
	# Border of rectangle consists of 4 lines
	call drawHline # Top side
	
	muli r17, r7, 1024 
	subi r17, r17, 1024
	add r5, r16, r17
	call drawHline # Bottom side
	
	mov r5, r16
	mov r17, r6
	mov r6, r7 # We need 'length' parameter to draw vertical lines
	call drawVline 
	
	muli r17, r17, 2
	subi r17, r17, 2
    add r5, r16, r17
	call drawVline # Bottom side
	
	ldw ra, 0(sp)
    ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12
ret

#############################################################################
# Void subroutine that draws a rectangle (filled) of a certain colour
# at a starting position (top-left corner) with width (x) and length (y)
#############################################################################
fillRectangle:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r0
	
# Treat rectangle as a loop through several horizontal lines of width (x)
RECT_LOOPY:
	bge r16, r7, RECT_DONE
	call drawHline
	mov r5, r2 
	addi r16, r16, 1
    br RECT_LOOPY
	
RECT_DONE:	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret
