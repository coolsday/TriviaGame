.global _start

# Define constants
.equ ADDR_VGA, 0x08000000
.equ X_MAX, 318
.equ Y_MAX, 237

# Test program for testing drawing subroutines before adding them to project
_start:
  movia r8, ADDR_VGA
  
  
  
  call clearScreen

  movui r4, 0xFFFF
  movia r5, 1024*100
  add r5, r5, r8
  movui r6, 20
  
  call draw_A
  
  mov r5, r2
  movui r4, 0x001E
  call draw_B
  
  mov r5, r2
  movui r4, 0xFF00
  call draw_C
  
  mov r5, r2
  movui r4, 0x1F00
  call draw_D
  
  mov r5, r2
  movui r4, 0xF100
  call draw_E
  
  mov r5, r2
  movui r4, 0x00FF
  call draw_F
  
  mov r5, r2
  movui r4, 0xF00F
  call draw_G
  
LOOPY:
  br LOOPY

# Accepts a colour, starting pixel address, and length 'l'
# to draw a horizontal line, from left to right
# returns the address of the pixel BELOW 
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

# Accepts a colour, starting pixel address, and length 'l'
# to draw a vertical line, from top to bottom
# returns the address of the RIGHT pixel
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

# Void subroutine that clears the screen by colouring every pixel black
clearScreen:
	addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	
	# Initialize calls of drawHline 
	movui r4, 0x0000
	mov r5, r8
	movui r6, X_MAX
	
	mov r16, r0
	movui r17, Y_MAX
	
# Loop through each row of pixels and colour it black	
CLEAR_LOOPY:
	bgt r16, r17, CLEAR_DONE
	call drawHline
	mov r5, r2 
	addi r16, r16, 1
    br CLEAR_LOOPY
	
CLEAR_DONE:	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12
ret

# Subroutine that draws letter A in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at
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
  
  
# Subroutine that draws letter B in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at  
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

# Subroutine that draws letter C in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at  
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

# Subroutine that draws letter D in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at  
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

# Subroutine that draws letter E in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at  
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

# Subroutine that draws letter F in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at  
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

# Subroutine that draws letter G in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at  
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

# Subroutine that draws letter B in a certain color,
# at a specified position, returns address of an adjacent
# pixel to draw another letter at  
# draw_C:
	# addi sp, sp, -8
	# stw ra, 0(sp)
	# stw r16, 4(sp)
	# mov r16, r5 # Store starting position because 'r5' will get mass-clobbered
	# addi r2, r16, 2*10	
	# ldw ra, 0(sp)
	# ldw r16, 4(sp)
	# addi sp, sp, 8
# ret