#############################################################################
# The file with probably the bulkiest amount of code, containing the subroutines
# for drawing EACH individual question through repetitive calls of the lower-level
# subroutines in the included files
# 
# This may seem a lot of code but a lot of it is routine copy + pasting...
#
# In hindsight, a less code intrusive approach would be to make a general 
# subroutine that draws any inputted string of characters to the VGA...
# (Oh well!)
#
# Subroutines used...
# - drawMainMenu
# - drawLoadingScreen
# - Essentially a 'draw' for each individual question
# - drawGameOver
#############################################################################

.include "vga_screentemplate.s"

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

# Misc. Offset constants for specific questions
.equ Q1_ANS_OFFSET, 2*45
.equ Q2_ANS_OFFSET, 2*60
.equ Q4_ANS_OFFSET, 2*60
.equ Q5_ANS_OFFSET, 2*45
.equ Q7_ANS_OFFSET, 2*60
.equ Q8_ANS_OFFSET, 2*55
.equ Q9_ANS_OFFSET, 2*55
.equ Q10_ANS_OFFSET, 2*28
.equ Q11_ANS_OFFSET, 2*45
.equ Q12_ANS_OFFSET, 2*45
.equ Q13_ANS_OFFSET, 2*45
.equ Q14_ANS_OFFSET, 2*45
.equ Q15_ANS_OFFSET, 2*45

#############################################################################
# Void subroutine that draws in the Main Menu
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawMainMenu:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call clearScreen
	call drawRainbowBorder
	
	# Draw Title of Game
	movia r5, QUESTION_BOX_POS + 2*90
	add r5, r5, r8
	movui r4, RED
	call draw_A
	mov r5, r2
	movui r4, ORANGE
	call draw_S
	mov r5, r2
	movui r4, YELLOW
	call draw_S
	mov r5, r2
	movui r4, GREEN_YELLOW
	call draw_E
	mov r5, r2
	movui r4, GREEN
	call draw_M
	mov r5, r2
	movui r4, CYAN
	call draw_B
	mov r5, r2
	movui r4, DARK_CYAN
	call draw_L
	mov r5, r2
	movui r4, BLUE
	call draw_I
	mov r5, r2
	movui r4, PURPLE
	call draw_A
	
	# Draw description
	movia r5, QUESTION_BOX_POS + 1024*30
    add r5, r5, r8
	movui r4, WHITE
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_V
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_G
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_B
	mov r5, r2
	call draw_Y
	mov r5, r2
    call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, DARK_CYAN
	call draw_X
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_I
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4,PINK
	call draw_D
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_V
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_D
	mov r5, r2
	movui r4, WHITE
	call draw_ExclamationMark
 
    # Draw SW Instructions
    movia r5, QUESTION_BOX_POS + 1024*60
    add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_W
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	movui r4, GREEN
	call draw_0
	mov r5, r2
	movui r4, WHITE
	call draw_Dash
	mov r5, r2
	movui r4, GREEN
	call draw_3
	mov r5, r2
	movui r4, WHITE
	call draw_RightBracket
	mov r5, r2
	call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_ANSWER
	mov r5, r2
	
	# Draw KEY Instructions
    movia r5, QUESTION_BOX_POS + 1024*75
    add r5, r5, r8
	call draw_KEY
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	movui r4, RED
	call draw_0
	mov r5, r2
	movui r4, WHITE
	call draw_RightBracket
	mov r5, r2
	call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_E
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_ANSWER
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, ORANGE
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_START
	
	# Draw HEX 0-1 Instructions
    movia r5, QUESTION_BOX_POS + 1024*105
    add r5, r5, r8
	call draw_HEX
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	movui r4, CYAN
	call draw_0
	mov r5, r2
	movui r4, WHITE
	call draw_Dash
	mov r5, r2
	movui r4, CYAN
	call draw_1
	mov r5, r2
	movui r4, WHITE
	call draw_RightBracket
	mov r5, r2
	call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_CORRECT
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_ANSWER
	mov r5, r2
	call draw_S
	addi r5, r5, SPACE
	
	# Draw HEX 2-3 Instructions
    movia r5, QUESTION_BOX_POS + 1024*120
    add r5, r5, r8
	call draw_HEX
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	movui r4, CYAN
	call draw_2
	mov r5, r2
	movui r4, WHITE
	call draw_Dash
	mov r5, r2
	movui r4, CYAN
	call draw_3
	mov r5, r2
	movui r4, WHITE
	call draw_RightBracket
	mov r5, r2
	call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_CORRECT
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_ANSWER
	mov r5, r2
	call draw_S
	addi r5, r5, SPACE
	
	# Draw HEX 4-5 Instructions
    movia r5, QUESTION_BOX_POS + 1024*135
    add r5, r5, r8
	call draw_HEX
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	movui r4, CYAN
	call draw_4
	mov r5, r2
	movui r4, WHITE
	call draw_Dash
	mov r5, r2
	movui r4, CYAN
	call draw_5
	mov r5, r2
	movui r4, WHITE
	call draw_RightBracket
	mov r5, r2
	call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, YELLOW
	call draw_HIGH
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_SCORE
	mov r5, r2
	addi r5, r5, SPACE
	
	# Draw LEDR Instructions
    movia r5, QUESTION_BOX_POS + 1024*150
    add r5, r5, r8
	movui r4, WHITE
	call draw_L
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_T
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_L
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_T
	
	# Draw Press Instruction
    movia r5, QUESTION_BOX_POS + 1024*180 + 2*50
    add r5, r5, r8
	movui r4, WHITE
	call draw_PRESS
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_KEY
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	movui r4, RED
	call draw_0
	mov r5, r2
	movui r4, WHITE
	call draw_RightBracket
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_START
	mov r5, r2
	movui r4, WHITE
	call draw_ExclamationMark

	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in the loading screen
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawLoadingScreen:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call clearScreen
	call drawRainbowBorder
	
    # Draw a happy face
	movia r4, QUESTION_BOX_POS + 1024*70 + 2*103
	add r4, r4, r8
	call drawHappyFace
	
	# Draw "Now Loading"
    movia r5, QUESTION_BOX_POS + 1024*150 + 2*80
    add r5, r5, r8
	movui r4, ORANGE
	call draw_N
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_W
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_L
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_G
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_Period

	# Draw "Please wait warmly"
    movia r5, QUESTION_BOX_POS + 1024*165 + 2*50
    add r5, r5, r8
	movui r4, WHITE
	call draw_P
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_W
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_W
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_Y
	mov r5, r2
	call draw_ExclamationMark
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 1
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY2
#############################################################################
drawQuestion1:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, RED
	mov r5, r2
	call draw_1
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHAT
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	movui r4, WHITE
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_HEX
	mov r5, r2
	movui r4, WHITE
	call draw_A
	mov r5, r2
	call draw_DECIMAL
	mov r5, r2
	call draw_QuestionMark
	
	# Answers
	movia r5, TOP_LEFT_LINE2_POS + Q1_ANS_OFFSET
	add r5, r5, r8
	call draw_5
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_B
	mov r5, r2
	call draw_8
	
	movia r5, TOP_RIGHT_LINE2_POS + Q1_ANS_OFFSET
	add r5, r5, r8
	call draw_5
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_7
	
	movia r5, BOT_LEFT_LINE2_POS + Q1_ANS_OFFSET
	add r5, r5, r8
	call draw_6
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_B
	mov r5, r2
	call draw_7
	
	movia r5, BOT_RIGHT_LINE2_POS + Q1_ANS_OFFSET
	add r5, r5, r8
	call draw_8
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_9
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 2
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY2
#############################################################################
drawQuestion2:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, ORANGE
	mov r5, r2
	call draw_2
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE2_POS
	add r5, r5, r8
	call draw_HOW
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_M
	mov r5, r2
	call draw_ANY
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, PINK
	call draw_B
	mov r5, r2
	call draw_Y
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_ARE
	mov r5, r2
	addi r5, r5, SPACE

	call draw_NEED
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_STORE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THIS
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_C
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
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
	call draw_U
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_QuestionMark
	
	movui r4, CYAN
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_INT
	mov r5, r2
	addi r5, r5, SPACE
	call draw_A
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_CHA
	mov r5, r2
	call draw_R
	mov r5, r2
	addi r5, r5, SPACE
	call draw_B
	
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_INT
	mov r5, r2
	addi r5, r5, SPACE
	call draw_C
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q2_ANS_OFFSET
	add r5, r5, r8
	call draw_9
	
	movia r5, TOP_RIGHT_LINE2_POS + Q2_ANS_OFFSET
	add r5, r5, r8
	call draw_6
	
	movia r5, BOT_LEFT_LINE2_POS + Q2_ANS_OFFSET
	add r5, r5, r8
	call draw_1
	mov r5, r2
	call draw_2
	
	movia r5, BOT_RIGHT_LINE2_POS + Q2_ANS_OFFSET
	add r5, r5, r8
	call draw_4
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 3
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY3
#############################################################################
drawQuestion3:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, YELLOW
	mov r5, r2
	call draw_3
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHICH
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_O
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_FOLLOWING
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_INSTRUCTION
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_ARE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_VALID
	mov r5, r2
	movui r4, WHITE
	call draw_QuestionMark
	
	# Answers
	movia r5, TOP_LEFT_LINE2_POS
	add r5, r5, r8
	call draw_L
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_W
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_3
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_4
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	call draw_4
	mov r5, r2
	call draw_RightBracket
	
	movia r5, TOP_RIGHT_LINE2_POS
	add r5, r5, r8
	call draw_ADD
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_7
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_8
	
	movia r5, BOT_LEFT_LINE2_POS
	add r5, r5, r8
	call draw_MOV
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_5
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	
	movia r5, BOT_RIGHT_LINE2_POS
	add r5, r5, r8
	call draw_ORI
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_5
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_6
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_7
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 4
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY1
#############################################################################
drawQuestion4:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, GREEN_YELLOW
	mov r5, r2
	call draw_4
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_C
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_SUBROUTINE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_CALL
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_WITH
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_7
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_INT
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_G
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_P
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_Comma
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_HOW
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_M
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_H
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_W
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_L
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, DARK_CYAN
	call draw_S
	mov r5, r2
	call draw_P
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_CHA
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_G
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_B
	mov r5, r2
	call draw_Y
	mov r5, r2
	call draw_QuestionMark
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q4_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	
	movia r5, TOP_RIGHT_LINE2_POS + Q4_ANS_OFFSET
	add r5, r5, r8
	call draw_1
	mov r5, r2
	call draw_2
	
	movia r5, BOT_LEFT_LINE2_POS + Q4_ANS_OFFSET
	add r5, r5, r8
	call draw_3
	
	movia r5, BOT_RIGHT_LINE2_POS + Q4_ANS_OFFSET
	add r5, r5, r8
	call draw_7
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 5
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY0
#############################################################################

drawQuestion5:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, GREEN
	mov r5, r2
	call draw_5
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_PROGRAM
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_EXECUTE
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	addi r5, r5, SPACE
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_INSTRUCTION
	mov r5, r2
	call draw_Comma
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, PURPLE
	call draw_P
	mov r5, r2
	call draw_C
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_S
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_B
	mov r5, r2
	call draw_Y
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_8
	mov r5, r2
	movui r4, WHITE
	call draw_Comma
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_WHICH
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_INSTRUCTION
	
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_W
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_EXECUTE
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_QuestionMark
	mov r5, r2
	addi r5, r5, SPACE
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q5_ANS_OFFSET
	add r5, r5, r8
	call draw_N
	mov r5, r2
	call draw_AND
	
	movia r5, TOP_RIGHT_LINE2_POS + Q5_ANS_OFFSET 
	add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_I
	
	movia r5, BOT_LEFT_LINE2_POS + Q5_ANS_OFFSET
	add r5, r5, r8
	call draw_ADD
	mov r5, r2
	call draw_I
	
	movia r5, BOT_RIGHT_LINE2_POS + Q5_ANS_OFFSET
	add r5, r5, r8
	call draw_MOV
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_A
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 6
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY0
#############################################################################
drawQuestion6:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, CYAN
	mov r5, r2
	call draw_6
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHICH
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_O
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_FOLLOWING
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_INSTRUCTION
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_ARE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_VALID
	mov r5, r2
	movui r4, WHITE
	call draw_QuestionMark
	
	# Answers
	movia r5, TOP_LEFT_LINE2_POS
	add r5, r5, r8
	call draw_L
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_B
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_3
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_9
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	call draw_4
	mov r5, r2
	call draw_RightBracket
	
	movia r5, TOP_RIGHT_LINE2_POS
	add r5, r5, r8
	call draw_SUB
	mov r5, r2
	call draw_I
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_7
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_8
	
	movia r5, BOT_LEFT_LINE2_POS
	add r5, r5, r8
	call draw_MOV
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_3
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_3
	mov r5, r2
	call draw_3
	
	movia r5, BOT_RIGHT_LINE2_POS
	add r5, r5, r8
	call draw_AND
	mov r5, r2
	call draw_I
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 7
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY2
#############################################################################
drawQuestion7:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, DARK_CYAN
	mov r5, r2
	call draw_7
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE2_POS
	add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_P
	mov r5, r2
	call draw_P
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_HEX
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_VALUE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, ORANGE
	call draw_8
	mov r5, r2
	call draw_7
	mov r5, r2
	call draw_6
	mov r5, r2
	call draw_5
	mov r5, r2
	call draw_4
	mov r5, r2
	call draw_3
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_1
	mov r5, r2
	
	movui r4, WHITE
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_STORE
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_M
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_Y
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_ADDRESS
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	
	movui r4, WHITE
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_A
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, YELLOW
	call draw_W
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_D
	mov r5, r2
	movui r4, WHITE
	call draw_Comma
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_WHAT
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_VALUE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_ADDRESS
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_2
	mov r5, r2
	movui r4, WHITE
	call draw_QuestionMark
	mov r5, r2
	
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_LeftBracket
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, PINK
	call draw_L
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_E
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_RightBracket
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q7_ANS_OFFSET
	add r5, r5, r8
	call draw_8
	mov r5, r2
	call draw_7
	
	movia r5, TOP_RIGHT_LINE2_POS + Q7_ANS_OFFSET
	add r5, r5, r8
	call draw_2
	mov r5, r2
	call draw_1
	
	movia r5, BOT_LEFT_LINE2_POS + Q7_ANS_OFFSET
	add r5, r5, r8
	call draw_6
	mov r5, r2
	call draw_5
	
	movia r5, BOT_RIGHT_LINE2_POS + Q7_ANS_OFFSET
	add r5, r5, r8
	call draw_5
	mov r5, r2
	call draw_6
	
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 8
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY3
#############################################################################
drawQuestion8:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, BLUE
	mov r5, r2
	call draw_8
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHAT
	addi r5, r5, SPACE
	
	movui r4, YELLOW
	call draw_DECIMAL
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_VALUE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, DARK_CYAN
	call draw_E
	mov r5, r2
	call draw_Q
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_L
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_T
	mov r5, r2
	call draw_O
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_F
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_VALUE
	mov r5, r2
	call draw_Colon
	
	movui r4, GREEN
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q8_ANS_OFFSET
	add r5, r5, r8
	call draw_7
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_0
	
	movia r5, TOP_RIGHT_LINE2_POS + Q8_ANS_OFFSET
	add r5, r5, r8
	call draw_6
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_0
	
	movia r5, BOT_LEFT_LINE2_POS + Q8_ANS_OFFSET
	add r5, r5, r8
	call draw_6
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_5
	
	movia r5, BOT_RIGHT_LINE2_POS + Q8_ANS_OFFSET
	add r5, r5, r8
	call draw_7
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_5
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 9
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY2
#############################################################################
drawQuestion9:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, PURPLE
	mov r5, r2
	call draw_9
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE2_POS
	add r5, r5, r8
	call draw_O
	mov r5, r2
	call draw_N
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_INT
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_P
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_Period
	mov r5, r2
	call draw_Period

	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	movui r4, ORANGE
	call draw_1
	mov r5, r2
	call draw_Period
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_CTL
	mov r5, r2
	call draw_1
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_C
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_P
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_CTL
	mov r5, r2
	call draw_0
	mov r5, r2
	addi r5, r5, SPACE
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	movui r4, ORANGE
	call draw_2
	mov r5, r2
	call draw_Period
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, PURPLE
	call draw_P
	mov r5, r2
	call draw_C
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_R
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_ADDRESS
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	movui r4, ORANGE
	call draw_3
	mov r5, r2
	call draw_Period
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_CTL
	mov r5, r2
	call draw_0
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_1
	
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_WHICH
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_STATEMENT
    mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_T
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_E
	mov r5, r2
	movui r4, WHITE
	call draw_QuestionMark
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q9_ANS_OFFSET
	add r5, r5, r8
	call draw_3
	
	movia r5, TOP_RIGHT_LINE2_POS + Q9_ANS_OFFSET
	add r5, r5, r8
	call draw_1
	
	movia r5, BOT_LEFT_LINE2_POS + Q9_ANS_OFFSET
	add r5, r5, r8
	call draw_2
	
	movia r5, BOT_RIGHT_LINE2_POS + Q9_ANS_OFFSET
	add r5, r5, r8
	call draw_N
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_E
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 10
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY2
#############################################################################
drawQuestion10:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, PINK
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE2_POS
	add r5, r5, r8
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_V
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_B
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, ORANGE
	call draw_3
	mov r5, r2
	movui r4, WHITE
	call draw_Comma
	mov r5, r2
	movui r4, ORANGE
	call draw_7
	mov r5, r2
    movui r4, WHITE
	call draw_Comma
	mov r5, r2
	movui r4, ORANGE
	call draw_2
	mov r5, r2
	call draw_0
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_7
	mov r5, r2
	call draw_Comma
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_W
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_D
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE

	call draw_FOLLOWING
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	
	movui r4, WHITE
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_INSTRUCTION
	mov r5, r2
    call draw_Colon
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, CYAN
	call draw_X
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_7
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_7
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_8
	
	movui r4, WHITE
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_WHAT
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_HEX
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_VALUE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_O
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_8
	mov r5, r2
	call draw_QuestionMark
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q10_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_8
	mov r5, r2
	call draw_4
	mov r5, r2
	
	movia r5, TOP_RIGHT_LINE2_POS + Q10_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_4
	mov r5, r2
	call draw_F
	mov r5, r2
	
	movia r5, BOT_LEFT_LINE2_POS + Q10_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_8
	mov r5, r2
	call draw_8
	mov r5, r2
	
	movia r5, BOT_RIGHT_LINE2_POS + Q10_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_2
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_4
	mov r5, r2
	call draw_8
	mov r5, r2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 11
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY0
#############################################################################
drawQuestion11:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, RED
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_1
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHICH
    mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_INSTRUCTION
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_C
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_B
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_U
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE

	call draw_C
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_K
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_REGISTER
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_VALUE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, PINK
	call draw_N
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_G
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_V
	mov r5, r2
	call draw_E
	mov r5, r2
	movui r4, WHITE
    call draw_QuestionMark
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q11_ANS_OFFSET
	add r5, r5, r8
	call draw_B
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_U
	
	movia r5, TOP_RIGHT_LINE2_POS + Q11_ANS_OFFSET
	add r5, r5, r8
	call draw_B
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_Q
	
	movia r5, BOT_LEFT_LINE2_POS + Q11_ANS_OFFSET
	add r5, r5, r8
	call draw_B
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_U
	
	movia r5, BOT_RIGHT_LINE2_POS + Q11_ANS_OFFSET
	add r5, r5, r8
	call draw_B
	mov r5, r2
	call draw_G
	mov r5, r2
	call draw_T
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 12
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY1
#############################################################################
drawQuestion12:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, ORANGE
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_2
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHAT
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, BLUE
	call draw_REGISTER
    mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_D
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_N
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_N
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_B
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_S
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_V
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_B
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_CALL
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_G
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_C
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	movui r4, WHITE
	call draw_SUBROUTINE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	movui r4, WHITE
	call draw_QuestionMark
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q12_ANS_OFFSET
	add r5, r5, r8
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_5
	
	movia r5, TOP_RIGHT_LINE2_POS + Q12_ANS_OFFSET 
	add r5, r5, r8
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_6
	
	movia r5, BOT_LEFT_LINE2_POS + Q12_ANS_OFFSET
	add r5, r5, r8
	call draw_R
	mov r5, r2
	call draw_8
	
	movia r5, BOT_RIGHT_LINE2_POS + Q12_ANS_OFFSET
	add r5, r5, r8
	call draw_R
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_2
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 13
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY0
#############################################################################
drawQuestion13:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, YELLOW
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_3
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHICH
    mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_INSTRUCTION
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_M
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_Y

	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_C
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_U
    mov r5, r2
	call draw_S
	mov r5, r2
	call draw_E
    mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, PURPLE
	call draw_S
	mov r5, r2
	call draw_I
    mov r5, r2
	call draw_G
	mov r5, r2
	call draw_N
    mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_E
	mov r5, r2
	call draw_X
	mov r5, r2
	call draw_T
    mov r5, r2
	call draw_E
	mov r5, r2
	call draw_N
    mov r5, r2
	call draw_S
	mov r5, r2
	call draw_I
    mov r5, r2
	call draw_O
	mov r5, r2
	call draw_N
    mov r5, r2
    call draw_QuestionMark
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q13_ANS_OFFSET
	add r5, r5, r8
	call draw_MOV
	
	movia r5, TOP_RIGHT_LINE2_POS + Q13_ANS_OFFSET 
	add r5, r5, r8
	call draw_L
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_W
	
	movia r5, BOT_LEFT_LINE2_POS + Q13_ANS_OFFSET
	add r5, r5, r8
	call draw_L
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_B
	mov r5, r2
	call draw_U
	
	movia r5, BOT_RIGHT_LINE2_POS + Q13_ANS_OFFSET
	add r5, r5, r8
	call draw_L
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_H
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 14
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY1
#############################################################################
drawQuestion14:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, GREEN_YELLOW
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_4
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	# Draw Question Text
	movia r5, QBOX_LINE2_POS
	add r5, r5, r8
	call draw_WHAT
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_VALUE
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_O
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, DARK_CYAN
	call draw_R
	mov r5, r2
	call draw_9
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_A
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_THE
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_INSTRUCTION
	mov r5, r2
	call draw_S
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_EXECUTE
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_QuestionMark
	
	movui r4, CYAN
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_I
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_9
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_Comma
	mov r5, r2
	movui r4, ORANGE
	call draw_A
	mov r5, r2
	call draw_B
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, CYAN
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_AND
	mov r5, r2
	call draw_I
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_R
	mov r5, r2
	call draw_9
	mov r5, r2
	call draw_Comma
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_7
	mov r5, r2
	call draw_Comma
	mov r5, r2
	movui r4, ORANGE
	call draw_0
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q14_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_F
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_F
	
	movia r5, TOP_RIGHT_LINE2_POS + Q14_ANS_OFFSET
	add r5, r5, r8
	call draw_A
	mov r5, r2
	call draw_B
	mov r5, r2
	call draw_C
	mov r5, r2
	call draw_D
	
	movia r5, BOT_LEFT_LINE2_POS + Q14_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_B
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_D
	
	movia r5, BOT_RIGHT_LINE2_POS + Q14_ANS_OFFSET
	add r5, r5, r8
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	mov r5, r2
	call draw_0
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in Question 15
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
# Correct Answer is KEY1
#############################################################################
drawQuestion15:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call drawBaseBackground
    call drawTextTemplate
	
	# Draw Question Number
	movui r4, GREEN
	mov r5, r2
	call draw_1
	mov r5, r2
	call draw_5
	movui r4, WHITE
	mov r5, r2
	call draw_Period
	
	movia r5, QBOX_LINE3_POS
	add r5, r5, r8
	call draw_WHICH
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
	call draw_NIOS2
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_INSTRUCTION
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_C
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_T
	
	movui r4, WHITE
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_B
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_U
	mov r5, r2
	call draw_S
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_SET
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, BLUE
	call draw_VALUE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_O
	mov r5, r2
	call draw_F
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_Y
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_REGISTER
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_0
	mov r5, r2
	movui r4, WHITE
	call draw_QuestionMark
	
	# Answers
	movui r4, WHITE
	movia r5, TOP_LEFT_LINE2_POS + Q15_ANS_OFFSET
	add r5, r5, r8
	call draw_MOV
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_A
	
	movia r5, TOP_RIGHT_LINE2_POS + Q15_ANS_OFFSET
	add r5, r5, r8
	call draw_ADD
	mov r5, r2
	call draw_I
	
	movia r5, BOT_LEFT_LINE2_POS + Q15_ANS_OFFSET
	add r5, r5, r8
	call draw_S
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_B
	
	movia r5, BOT_RIGHT_LINE2_POS + Q15_ANS_OFFSET
	add r5, r5, r8
	call draw_MOV
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

#############################################################################
# Void subroutine that draws in the Game Over Screen
# Does not accept arguments but will clobber parameter registers 'r4' - 'r7'
#############################################################################
drawGameOver:
	addi sp, sp, -4
    stw ra, 0(sp)
	
	call clearScreen
	call drawRainbowBorder
	
	# Draw Game Over Text
    movia r5, QUESTION_BOX_POS + 1024*30 + 2*94
    add r5, r5, r8
	movui r4, RED
	call draw_G
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_M
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_O
	mov r5, r2
	call draw_V
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_R
	
	movia r4, QUESTION_BOX_POS + 1024*70 + 2*18
	add r4, r4, r8
	call drawHappyFace
	
	movia r4, QUESTION_BOX_POS + 1024*70 + 2*103
	add r4, r4, r8
	call drawHappyFace
	
	movia r4, QUESTION_BOX_POS + 1024*70 + 2*188
	add r4, r4, r8
	call drawHappyFace
	
	# Draw misc. text 
    movia r5, QUESTION_BOX_POS + 1024*165 + 2*23
    add r5, r5, r8
	movui r4, WHITE
	call draw_D
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_D
	mov r5, r2
    addi r5, r5, SPACE
	
	call draw_Y
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_U
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_B
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_THE
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, YELLOW
	call draw_HIGH
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_SCORE
	mov r5, r2
	movui r4, WHITE
	call draw_QuestionMark
	
	# Draw Press Instruction
    movia r5, QUESTION_BOX_POS + 1024*180 + 2*45
    add r5, r5, r8
	movui r4, WHITE
	call draw_PRESS
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_KEY
	mov r5, r2
	call draw_LeftBracket
	mov r5, r2
	movui r4, RED
	call draw_0
	mov r5, r2
	movui r4, WHITE
	call draw_RightBracket
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_O
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_START
	mov r5, r2
	movui r4, WHITE
	call draw_ExclamationMark

	ldw ra, 0(sp)
	addi sp, sp, 4
ret
