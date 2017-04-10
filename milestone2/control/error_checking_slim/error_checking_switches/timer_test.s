# r20 - stores a flag variable that dictates if we are in a timed question
# r21 - counter that dictates how many LEDs are lit

.equ ADDR_REDLEDS, 0xFF200000

LOOP_START:
    # If we are not in a question state then don't bother enabling timer
	beq r20, r0, TIMED_REST

# Reenable interrupts 
RE_POLL:
    movia r12, 1
	wrctl ctl0, r12

# Polling loop that stops when either a push button interrupt occurs or timer has timed out
TIMED_Q:
	ldwio r12, 0(r11)
	andi r12, r12, 0x1
	bne r16, r0, LOOP_MID
	beq r12, r0, TIMED_Q
	
    # If we have timed out, disable interrupts for a while and update LEDs
	wrctl ctl0, r0 

	# Reset timeout bit
	stwio r0, 0(r11)
	
	call updateLEDs

	# If all the LEDs are not lit then we have ran out of time
	beq r21, r0, NO_TIME

# If there are still LEDs left, then we still have time so we reset the timer and loop again	
STILL_TIME:
	# Set period of timer
	movia r16, 200000000 
	stwio r16, 8(r11) # Low period
	movia r16, 0xFFFF0000
	and r16, r16, r4
	srli r16, r16, 16 
	stwio r16, 12(r11) # High period
	
	# Start timer, no continous, no interrupts
	movui r12, 0x4
	stwio r12, 4(r11)
br RE_POLL

NO_TIME:
    # Change state as IF an interrupt occured
	addi r13, r13, 1
    movia r16, 1
    mov r14, r0 # Record a default incorrect answer 

TIMED_REST:
	beq r16, r0, LOOP_START

LOOP_MID:
	mov r20, r0  # Temporarily disable timed question functionality
 	wrctl ctl0, r0
	wrctl ctl3, r0 	
	

######################################################################
# Void subroutine that decrements the counter dictated by LEDs
# Does not accept parameters but will clobber registers 'r4' - 'r7'
######################################################################
updateLEDS:
    addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
    stw r17, 8(sp)
    
    # Update counter
    subi r21, r21, 1
    
    # Update LEDs
    movui r16, 1
    sll r16, r16, r21
    movia r17, ADDR_REDLEDS
    stwio r16, 0(r17)
    
    ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12    
ret

######################################################################
# Void subroutine that prepares the LEDs/Timer for tracking time elapsed
# Does not accept parameters but will clobber registers 'r4' - 'r7'
######################################################################
initTimedQuestion:
    addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
    stw r17, 8(sp)

	# Set LEDs counter to 9
    movia r17, 0x1FF
    movia r16, ADDR_REDLEDS
    stwio r17, 0(r16)
    movui r21, 10	
    
    # Set period of timer
	movia r16, 200000000 
	stwio r16, 8(r11) # Low period
	movia r16, 0xFFFF0000
	and r16, r16, r4
	srli r16, r16, 16 
	stwio r16, 12(r11) # High period
	
	# Start timer, no continous, no interrupts
	movui r12, 0x4
	stwio r12, 4(r11)
    movui r20, 1

	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12
ret
	
