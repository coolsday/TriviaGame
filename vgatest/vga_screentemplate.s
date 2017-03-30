#############################################################################
# Separate subroutines that make use of the lower-level subroutines to draw
# templates for the backgrounds used in the VGA game
#
# Subroutines used...
# - drawRainbowBorder
# - drawBaseBackground
# - drawTextTemplate
# - clearScreen
# - clearQABoxes
#############################################################################

.include "vga_alphanumeric.s"

# Screen-size constants
.equ X_MAX, 319
.equ Y_MAX, 238

# Colour constants
.equ RED, 0xF800
.equ ORANGE, 0xFD20
.equ YELLOW, 0xFFE0
.equ GREEN_YELLOW, 0xAFE5
.equ GREEN, 0x07E0
.equ CYAN, 0x07FF
.equ DARK_CYAN, 0x03FF
.equ BLUE, 0x001F
.equ PURPLE, 0x781F
.equ PINK, 0xF81F
.equ WHITE, 0xFFFF
.equ BLACK, 0x0000

# Location constants of objects drawn in for the background
.equ CHOICE_BOX_WIDTH, 135
.equ CHOICE_BOX_HEIGHT, 40
.equ QUESTION_BOX_WIDTH, 280
.equ QUESTION_BOX_HEIGHT, 100

.equ TOP_LEFT_BOX_POS, 1024*132 + 2*20
.equ BOT_LEFT_BOX_POS, 1024*180 + 2*20
.equ TOP_RIGHT_BOX_POS, 1024*132 + 2*165
.equ BOT_RIGHT_BOX_POS, 1024*180 + 2*165
.equ QUESTION_BOX_POS, 1024*18 + 2*20

# Offset locations for text
.equ QBOX_LINE1_POS, 1024*25 + 2*25
.equ QBOX_LINE2_POS, 1024*40 + 2*25
.equ QBOX_LINE3_POS, 1024*55 + 2*25
.equ QBOX_LINE4_POS, 1024*70 + 2*25
.equ QBOX_LINE5_POS, 1024*85 + 2*25
.equ QBOX_LINE6_POS, 1024*100 + 2*25

.equ TOP_LEFT_LINE1_POS, 1024*139 + 2*25
.equ TOP_LEFT_LINE2_POS, 1024*154 + 2*25
.equ BOT_LEFT_LINE1_POS, 1024*187 + 2*25
.equ BOT_LEFT_LINE2_POS, 1024*202 + 2*25
.equ TOP_RIGHT_LINE1_POS, 1024*139 + 2*170
.equ TOP_RIGHT_LINE2_POS, 1024*154 + 2*170
.equ BOT_RIGHT_LINE1_POS, 1024*187 + 2*170
.equ BOT_RIGHT_LINE2_POS, 1024*202 + 2*170

# Other helpful location constants
.equ ADJ_DIAGONAL_PIXEL, 1024*1 + 2*1
.equ SPACE, 2*4

#############################################################################
# Void subroutine that draws in the base background for each question
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawRainbowBorder:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	# The border simply consists of 10 unfilled rectangles
	# This can be done using a loop but I found it much easier to physically hard-code
	movui r4, RED
	mov r5, r8
	movui r6, X_MAX
	movui r7, Y_MAX
	call drawRectangle
	  
	movui r4, ORANGE
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL
	movui r6, X_MAX-2
	movui r7, Y_MAX-2
	call drawRectangle
	  
	movui r4, YELLOW
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*2
	movui r6, X_MAX-4
	movui r7, Y_MAX-4
	call drawRectangle
	  
	movui r4, GREEN_YELLOW
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*3
	movui r6, X_MAX-6
	movui r7, Y_MAX-6
	call drawRectangle
	  
	movui r4, GREEN
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*4
	movui r6, X_MAX-8
	movui r7, Y_MAX-8
	call drawRectangle
	  
	movui r4, CYAN
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*5
	movui r6, X_MAX-10
	movui r7, Y_MAX-10
	call drawRectangle
	  
	movui r4, DARK_CYAN
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*6
	movui r6, X_MAX-12
	movui r7, Y_MAX-12
	call drawRectangle
	  
	movui r4, BLUE
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*7
	movui r6, X_MAX-14
	movui r7, Y_MAX-14
	call drawRectangle
	  
	movui r4, PURPLE
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*8
	movui r6, X_MAX-16
	movui r7, Y_MAX-16
	call drawRectangle
	  
	movui r4, PINK
	mov r5, r8
	addi r5, r8, ADJ_DIAGONAL_PIXEL*9
	movui r6, X_MAX-18
	movui r7, Y_MAX-18
	call drawRectangle
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in the base background for each question
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawBaseBackground:
	addi sp, sp, -4
    stw ra, 0(sp)
    
	# Draw in the border
	call drawRainbowBorder
	
	# Draw in the boxes containing the questions/answers
	movui r4, BLUE
	movia r5, TOP_LEFT_BOX_POS
	add r5, r5, r8
    movui r6, CHOICE_BOX_WIDTH
	movui r7, CHOICE_BOX_HEIGHT
	call drawRectangle
	  
	movia r5, BOT_LEFT_BOX_POS
	add r5, r5, r8
	movui r6, CHOICE_BOX_WIDTH
	movui r7, CHOICE_BOX_HEIGHT
	call drawRectangle
	  
	movia r5, TOP_RIGHT_BOX_POS
	add r5, r5, r8
	movui r6, CHOICE_BOX_WIDTH
	movui r7, CHOICE_BOX_HEIGHT
	call drawRectangle
	  
	movia r5, BOT_RIGHT_BOX_POS
	add r5, r5, r8
	movui r6, CHOICE_BOX_WIDTH
	movui r7, CHOICE_BOX_HEIGHT
	call drawRectangle
	  
	movia r5, QUESTION_BOX_POS
	add r5, r5, r8
	movui r6, QUESTION_BOX_WIDTH
	movui r7, QUESTION_BOX_HEIGHT
	call drawRectangle
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Subroutine that draws in the common text (Question/Key) for each question,
# it conveniently returns the location of the "_" in 'Question _' so
# I can immediately draw the corresponding question number
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawTextTemplate:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	# KEY 3
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE1_POS
	add r5, r5, r8
	call draw_KEY
	
	mov r5, r2
	movui r4, RED
	call draw_3
	
	mov r5, r2
	movui r4, WHITE
	call draw_Colon
	
	# KEY 2
	movia r5, BOT_LEFT_LINE1_POS
	add r5, r5, r8
	call draw_KEY
	
	mov r5, r2
	movui r4, CYAN
	call draw_2
	
	mov r5, r2
	movui r4, WHITE
	call draw_Colon
	
	# KEY 1
	movia r5, TOP_RIGHT_LINE1_POS
	add r5, r5, r8
	call draw_KEY
	
	mov r5, r2
	movui r4, GREEN
	call draw_1
	
	mov r5, r2
	movui r4, WHITE
	call draw_Colon
	
	# KEY 0
	movia r5, BOT_RIGHT_LINE1_POS
	add r5, r5, r8
	call draw_KEY
	
	mov r5, r2
	movui r4, YELLOW
	call draw_0
	
	mov r5, r2
	movui r4, WHITE
	call draw_Colon
	
	# QUESTION
	movia r5, QBOX_LINE1_POS
	add r5, r5, r8
	call draw_QUESTION
	
	addi r2, r2, SPACE
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that clears the screen by colouring every pixel black
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
clearScreen:
	addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	
	# Initialize calls of drawHline 
	movui r4, BLACK
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

#############################################################################
# Void subroutine that clears only the Q&A Boxes by filling them with black
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
clearQABoxes:
	addi sp, sp, -4
	stw ra, 0(sp)
	
	# Initialize calls of 'fillRectangle'
	movui r4, BLACK
	
	# We make 5 calls to 'fillRectangle' to clear the 5 text boxes on the screen
	movia r5, TOP_LEFT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    movui r6, CHOICE_BOX_WIDTH - 2
    movui r7, CHOICE_BOX_HEIGHT - 2
    call fillRectangle
	
	movia r5, TOP_RIGHT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    movui r6, CHOICE_BOX_WIDTH - 2
    movui r7, CHOICE_BOX_HEIGHT - 2
    call fillRectangle
	
	movia r5, BOT_LEFT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    movui r6, CHOICE_BOX_WIDTH - 2
    movui r7, CHOICE_BOX_HEIGHT - 2
    call fillRectangle

	movia r5, BOT_RIGHT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    movui r6, CHOICE_BOX_WIDTH - 2
    movui r7, CHOICE_BOX_HEIGHT - 2
    call fillRectangle
	
	movia r5, QUESTION_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    movui r6, QUESTION_BOX_WIDTH - 2
    movui r7, QUESTION_BOX_HEIGHT - 2
    call fillRectangle
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret
