.global _start
.include "vga_questions.s"

# Device constants
.equ ADDR_VGA, 0x08000000

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

# Parameters of objects drawn in for the background
.equ CHOICE_BOX_WIDTH, 135
.equ CHOICE_BOX_HEIGHT, 40
.equ QUESTION_BOX_WIDTH, 280
.equ QUESTION_BOX_HEIGHT, 100

.equ TOP_LEFT_BOX_POS, 1024*132 + 2*20
.equ BOT_LEFT_BOX_POS, 1024*180 + 2*20
.equ TOP_RIGHT_BOX_POS, 1024*132 + 2*165
.equ BOT_RIGHT_BOX_POS, 1024*180 + 2*165
.equ QUESTION_BOX_POS, 1024*18 + 2*20

#############################################################################
# Test program for testing drawing subroutines before adding them to project
#############################################################################

_start:
	movia r8, ADDR_VGA
 
	call clearScreen
	call drawQuestion3
		  
LOOPY:
	br LOOPY
