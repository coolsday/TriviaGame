#############################################################################
# The file with probably the bulkiest amount of code, containing the subroutines
# for drawing EACH individual question through repetitive calls of the lower-level
# subroutines in the included files
# 
# This may seem a lot of code but a lot of it is routine copy + pasting...
#
# In hindsight, a less code intrusive approach would be to make a general 
# subroutine that draws any inputted string of characters to the VGA...
# (Although by hard-coding all of the letters, I'm free to set specific words to specific colours,
# which is the ONE redeeming factor!)
#
# Subroutines used...
# - Essentially a 'draw' for each individual question
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
	call draw_W
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_T
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
	call draw_H
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_X
	mov r5, r2
	movui r4, WHITE
	call draw_A
	mov r5, r2
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
	call draw_H
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_W
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_M
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_Y
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
	
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
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
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_S
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
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_T
	mov r5, r2
	addi r5, r5, SPACE
	call draw_A
	
	movia r5, QBOX_LINE5_POS
	add r5, r5, r8
	call draw_C
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	addi r5, r5, SPACE
	call draw_B
	
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_T
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
	addi r5, r5, SPACE
	
	call draw_O
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
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
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
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
	addi r5, r5, SPACE
	
	movui r4, WHITE
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
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
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, RED
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
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
	call draw_A
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_D
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
	call draw_M
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_V
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
	call draw_O
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_I
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

#################################################################################################################################
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
	call draw_S
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_B
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
	addi r5, r5, SPACE
	
	call draw_I
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_C
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_L
	mov r5, r2
	call draw_E
	mov r5, r2
	call draw_D
	mov r5, r2
	addi r5, r5, SPACE
	
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
	call draw_W
	mov r5, r2
	call draw_I
	mov r5, r2
	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
	call draw_7
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, WHITE
	call draw_I
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_T
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
	call draw_H
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_W
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
	call draw_C
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_A
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
	addi r5, r5, SPACE
	
	movui r4, WHITE
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
	addi r5, r5, SPACE
	
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
	addi r5, r5, SPACE
	
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
	
	movia r5, QBOX_LINE6_POS
	add r5, r5, r8
	call draw_W
	mov r5, r2
	call draw_A
	mov r5, r2
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
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
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_D
	
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
	call draw_A
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_D
	mov r5, r2
	call draw_I
	
	movia r5, BOT_RIGHT_LINE2_POS + Q5_ANS_OFFSET
	add r5, r5, r8
	call draw_M
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_V
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
	addi r5, r5, SPACE
	
	call draw_O
	mov r5, r2
	call draw_F
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_T
	mov r5, r2
	call draw_H
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
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
	addi r5, r5, SPACE
	
	movui r4, GREEN_YELLOW
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
	addi r5, r5, SPACE
	
	movui r4, WHITE
	movia r5, QBOX_LINE4_POS
	add r5, r5, r8
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
	call draw_S
	mov r5, r2
	addi r5, r5, SPACE
	
	call draw_A
	mov r5, r2
	call draw_R
	mov r5, r2
	call draw_E
	mov r5, r2
	addi r5, r5, SPACE
	
	movui r4, GREEN
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
	call draw_S
	mov r5, r2
	call draw_U
	mov r5, r2
	call draw_B
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
	call draw_M
	mov r5, r2
	call draw_O
	mov r5, r2
	call draw_V
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
	call draw_A
	mov r5, r2
	call draw_N
	mov r5, r2
	call draw_D
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
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

