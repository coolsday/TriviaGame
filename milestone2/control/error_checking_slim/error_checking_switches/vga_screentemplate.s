#############################################################################
# Separate subroutines that make use of the lower-level subroutines to draw
# templates for the backgrounds used in the VGA game
#
# Subroutines used...
# - drawRainbowBorder
# - drawBaseBackground
# - drawTextTemplate
# - clearScreen
# - fillQABoxes
# - drawHappyFace
# - drawSadFace
# - drawCorrectAnswer
# - drawIncorrectAnswer
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

.equ FACE_SIZE, 70
.equ EYE_SIZE, 10

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
	
	# SW 3
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE1_POS
	add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_W
	
	mov r5, r2
	movui r4, RED
	call draw_3
	
	mov r5, r2
	movui r4, WHITE
	call draw_Colon
	
	# SW 2
	movia r5, BOT_LEFT_LINE1_POS
	add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_W
	
	mov r5, r2
	movui r4, CYAN
	call draw_2
	
	mov r5, r2
	movui r4, WHITE
	call draw_Colon
	
	# SW 1
	movia r5, TOP_RIGHT_LINE1_POS
	add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_W
	
	mov r5, r2
	movui r4, GREEN
	call draw_1
	
	mov r5, r2
	movui r4, WHITE
	call draw_Colon
	
	# SW 0
	movia r5, BOT_RIGHT_LINE1_POS
	add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_W
	
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
# Void subroutine that fills the Q&A Boxes with an inputted colour,
# will clobber parameter registers 'r4' - 'r7'
#############################################################################
fillQABoxes:
	addi sp, sp, -4
	stw ra, 0(sp)
	
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
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that accepts a starting location and draws a 70x70 pixel 
# happy face making use of 'fillRect', will clobber registers 'r4' - 'r7'
#############################################################################
drawHappyFace:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r4 # Save parameter value because it WILL get clobbered
	
	# Draw the face background
	movui r4, YELLOW
	mov r5, r16
    movui r6, FACE_SIZE
    movui r7, FACE_SIZE
    call fillRectangle
	
	# Draw the eyes
	movui r4, WHITE
	movia r5, 1024*10 + 2*15
	add r5, r5, r16
	movui r6, EYE_SIZE
	movui r7, EYE_SIZE
	call fillRectangle
	
	movia r5, 1024*10 + 2*45
	add r5, r5, r16
	movui r6, EYE_SIZE
	movui r7, EYE_SIZE
	call fillRectangle
	
	movui r4, BLACK
	movia r5, 1024*13 + 2*18
	add r5, r5, r16
	movui r6, 4
	movui r7, 4
	call fillRectangle
	
	movia r5, 1024*13 + 2*48
	add r5, r5, r16
	movui r6, 4
	movui r7, 4
	call fillRectangle
	
	# Draw the mouth
	movia r5, 1024*45 + 2*15
	add r5, r5, r16
	movui r6, 5
	movui r7, 10
	call fillRectangle
	
    movia r5, 1024*45 + 2*50
	add r5, r5, r16
	movui r6, 5
	movui r7, 10
	call fillRectangle
	
	movia r5, 1024*53 + 2*18
	add r5, r5, r16
	movui r6, 34
	movui r7, 5
	call fillRectangle
	
	# Draw the blush
	movui r4, 0xFD6F
	movia r5, 1024*30 + 2*8
	add r5, r5, r16
	movui r6, 8
	movui r7, 8
	call fillRectangle
	
	movia r5, 1024*30 + 2*54
	add r5, r5, r16
	movui r6, 8
	movui r7, 8
	call fillRectangle
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################
# Void subroutine that accepts a starting location and draws a 70x70 pixel 
# happy face making use of 'fillRect', will clobber registers 'r4' - 'r7'
#############################################################################
drawSadFace:
	addi sp, sp, -8
	stw ra, 0(sp)
	stw r16, 4(sp)
	
	mov r16, r4 # Save parameter value because it WILL get clobbered
	
	# Draw the face background
	movui r4, YELLOW
	mov r5, r16
    movui r6, FACE_SIZE
    movui r7, FACE_SIZE
    call fillRectangle
	
	# Draw the eyes
	movui r4, WHITE
	movia r5, 1024*10 + 2*15
	add r5, r5, r16
	movui r6, EYE_SIZE
	movui r7, EYE_SIZE
	call fillRectangle
	
	movia r5, 1024*10 + 2*45
	add r5, r5, r16
	movui r6, EYE_SIZE
	movui r7, EYE_SIZE
	call fillRectangle
	
	movui r4, BLACK
	movia r5, 1024*13 + 2*18
	add r5, r5, r16
	movui r6, 4
	movui r7, 4
	call fillRectangle
	
	movia r5, 1024*13 + 2*48
	add r5, r5, r16
	movui r6, 4
	movui r7, 4
	call fillRectangle
	
	# Draw the mouth
	movia r5, 1024*45 + 2*15
	add r5, r5, r16
	movui r6, 5
	movui r7, 10
	call fillRectangle
	
    movia r5, 1024*45 + 2*50
	add r5, r5, r16
	movui r6, 5
	movui r7, 10
	call fillRectangle
	
	movia r5, 1024*43 + 2*18
	add r5, r5, r16
	movui r6, 34
	movui r7, 5
	call fillRectangle
	
	# Draw the blush
	movui r4, 0xFD6F
	movia r5, 1024*30 + 2*8
	add r5, r5, r16
	movui r6, 8
	movui r7, 8
	call fillRectangle
	
	movia r5, 1024*30 + 2*54
	add r5, r5, r16
	movui r6, 8
	movui r7, 8
	call fillRectangle
	
	# Draw stream of tears
	movui r4, 0x5FF
	movia r5, 1024*17 + 2*19
	add r5, r5, r16
	movui r6, 2
	movui r7, 4
	call fillRectangle
	
	movia r5, 1024*25 + 2*19
	add r5, r5, r16
	movui r6, 2
	movui r7, 4
	call fillRectangle
	
	movia r5, 1024*33 + 2*19
	add r5, r5, r16
	movui r6, 2
	movui r7, 4
	call fillRectangle
	
	movia r5, 1024*19 + 2*49
	add r5, r5, r16
	movui r6, 2
	movui r7, 4
	call fillRectangle
	
	movia r5, 1024*27 + 2*49
	add r5, r5, r16
	movui r6, 2
	movui r7, 4
	call fillRectangle
	
	movia r5, 1024*35 + 2*49
	add r5, r5, r16
	movui r6, 2
	movui r7, 4
	call fillRectangle
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################
# Void subroutine that draws in the screen indicating a correct answer
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawCorrectAnswer:
	addi sp, sp, -8
    stw ra, 0(sp)
	stw r16, 4(sp)
    
	# Draw in the border
	call drawBaseBackground
	
	# Determine which box to highlight
	movui r4, GREEN
	movui r6, CHOICE_BOX_WIDTH - 2
    movui r7, CHOICE_BOX_HEIGHT - 2
	
    movui r16, 8
	beq r14, r16, FILLCORRECT_TOPLEFT
	movui r16, 4
	beq r14, r16, FILLCORRECT_BOTLEFT
	movui r16, 2
	beq r14, r16, FILLCORRECT_TOPRIGHT
	movui r16, 1
	beq r14, r16, FILLCORRECT_BOTRIGHT
	
	FILLCORRECT_ALLBOXES:
	call fillQABoxes
	br FILLCORRECT_END
	
	FILLCORRECT_TOPLEFT: 
	movia r5, TOP_LEFT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLCORRECT_END
	
	FILLCORRECT_BOTLEFT: 
	movia r5, BOT_LEFT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLCORRECT_END
	
	FILLCORRECT_TOPRIGHT: 
	movia r5, TOP_RIGHT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLCORRECT_END
	
	FILLCORRECT_BOTRIGHT: 
	movia r5, BOT_RIGHT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLCORRECT_END
	
	FILLCORRECT_END:
	movia r4, QUESTION_BOX_POS + 1024*15 + 2*18
	add r4, r4, r8
	call drawHappyFace
	
	movia r4, QUESTION_BOX_POS + 1024*15 + 2*188
	add r4, r4, r8
	call drawHappyFace
	
	movia r5, QBOX_LINE3_POS + 2*96
	add r5, r5, r8
	movui r4, GREEN
	call draw_CORRECT
	mov r5, r2
	call draw_ExclamationMark
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret

#############################################################################
# Void subroutine that draws in the screen indicating a correct answer
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawIncorrectAnswer:
	addi sp, sp, -8
    stw ra, 0(sp)
    stw r16, 4(sp)
	
	# Draw in the border
	call drawBaseBackground
	
	# Determine which box to highlight
	movui r4, RED
	movui r6, CHOICE_BOX_WIDTH - 2
    movui r7, CHOICE_BOX_HEIGHT - 2
	
    movui r16, 8
	beq r14, r16, FILLINCORRECT_TOPLEFT
	movui r16, 4
	beq r14, r16, FILLINCORRECT_BOTLEFT
	movui r16, 2
	beq r14, r16, FILLINCORRECT_TOPRIGHT
	movui r16, 1
	beq r14, r16, FILLINCORRECT_BOTRIGHT
	
	FILLINCORRECT_ALLBOXES:
	call fillQABoxes
	br FILLINCORRECT_END
	
	FILLINCORRECT_TOPLEFT: 
	movia r5, TOP_LEFT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLINCORRECT_END
	
	FILLINCORRECT_BOTLEFT: 
	movia r5, BOT_LEFT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLINCORRECT_END
	
	FILLINCORRECT_TOPRIGHT: 
	movia r5, TOP_RIGHT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLINCORRECT_END
	
	FILLINCORRECT_BOTRIGHT: 
	movia r5, BOT_RIGHT_BOX_POS
    add r5, r5, r8
    addi r5, r5, ADJ_DIAGONAL_PIXEL
    call fillRectangle
	br FILLINCORRECT_END
	
	FILLINCORRECT_END:
	movia r4, QUESTION_BOX_POS + 1024*15 + 2*18
	add r4, r4, r8
	call drawSadFace
	
	movia r4, QUESTION_BOX_POS + 1024*15 + 2*188
	add r4, r4, r8
	call drawSadFace
	
	movia r5, QBOX_LINE3_POS + 2*88
	add r5, r5, r8
	movui r4, RED
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_CORRECT
	mov r5, r2
	call draw_ExclamationMark
	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
ret
