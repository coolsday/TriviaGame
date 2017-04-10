#############################################################################
# Separate subroutines that handle the seven-segment HEX displays
# 
# Subroutines used...
# - clearHex0to3
# - clearHex4to5
# - writeHex0to3
# - writeHex4to5
# - convertValueToHexLights
#############################################################################

# Address of seven-segs
.equ ADDR_7SEG1, 0xFF200020
.equ ADDR_7SEG2, 0xFF200030

# Helpful constants
.equ BIT_DISTANCE_TO_NEXT_HEX, 8

######################################################################
# Void subroutine that sets HEX 0-3 values to 0, does not accept any
# parameters but may clobber registers 'r4' - 'r7'
######################################################################
clearHex0to3:
    addi sp, sp, -4
	stw ra, 0(sp)
	
	# Set ALL HEX segments to 0
	movui r4, 0
	call convertValueToHexLights
	mov r4, r2
	movui r5, 0
    call writeHex0to3
	movui r5, 1
    call writeHex0to3
	movui r5, 2
    call writeHex0to3
	movui r5, 3
    call writeHex0to3
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret

######################################################################
# Void subroutine that sets HEX 4-5 values to 0, does not accept any
# parameters but may clobber registers 'r4' - 'r7'
######################################################################
clearHex4to5:
    addi sp, sp, -4
	stw ra, 0(sp)
	
	# Set ALL HEX segments to 0
	movui r4, 0
	call convertValueToHexLights
	mov r4, r2
	movui r5, 4
    call writeHex4to5
	movui r5, 5
    call writeHex4to5
	
	ldw ra, 0(sp)
	addi sp, sp, 4
ret
 
######################################################################
# Void subroutine writes a passed in 7-bit segment configuration (r4) 
# which highlights segments to form a HEX number
# into a passed in HEX display (r5) <- ranging from 0-3
######################################################################
 writeHex0to3:
	addi sp, sp, -20
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r18, 12(sp)
	ldw r19, 16(sp)
    
	# Determine which HEX display to write to
	movia r17, ADDR_7SEG1
	muli r5, r5, BIT_DISTANCE_TO_NEXT_HEX # HEX0 <-> HEX1 are 8 bits apart
	sll r19, r4, r5 
	
	# Update the needed HEX bits while preserving the values of the others
	movia r18, 0b1111111 # Helper constant for preserving bits
	sll r18, r18, r5
	nor r18, r18, r0
	ldwio r16, 0(r17)
    and r18, r16, r18
	or r18, r19, r18
	stwio r18, 0(r17)

	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	addi sp, sp, 20
 ret
 
######################################################################
# Void subroutine writes a passed in 7-bit segment configuration (r4) 
# which highlights segments to form a HEX number
# into a passed in HEX display (r5) <- ranging from 4-5
######################################################################
 writeHex4to5:
	addi sp, sp, -20
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r18, 12(sp)
	ldw r19, 16(sp)
    
	# Determine which HEX display to write to
	movia r17, ADDR_7SEG2
	subi r5, r5, 4 
	muli r5, r5, BIT_DISTANCE_TO_NEXT_HEX # HEX4 <-> HEX5 are 8 bits apart
	sll r19, r4, r5 
	
	# Update the needed HEX bits while preserving the values of the others
	movia r18, 0b1111111 # Helper constant for preserving bits
	sll r18, r18, r5
	nor r18, r18, r0
	ldwio r16, 0(r17)
    and r18, r16, r18
	or r18, r19, r18
	stwio r18, 0(r17)

	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	addi sp, sp, 20
 ret
 
######################################################################
# Subroutine that accepts a HEX value (0-9) and outputs a 7-bit value
# dictating the segment values that light up to form the HEX value
######################################################################
 convertValueToHexLights:
	addi sp, sp, -12
	stw ra, 0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
    
	# Determine which number to convert
	beq r4, r0, CONVERT_0
	movui r16, 1
	beq r4, r16, CONVERT_1
	movui r16, 2
	beq r4, r16, CONVERT_2
	movui r16, 3
	beq r4, r16, CONVERT_3
	movui r16, 4
	beq r4, r16, CONVERT_4
	movui r16, 5
	beq r4, r16, CONVERT_5
	movui r16, 6
	beq r4, r16, CONVERT_6
	movui r16, 7
	beq r4, r16, CONVERT_7
	movui r16, 8
	beq r4, r16, CONVERT_8
	movui r16, 9
	beq r4, r16, CONVERT_9
	
CONVERT_9:
	movui r2, 0b1101111
	br CONVERT_DONE
	
CONVERT_8:
	movui r2, 0b1111111
	br CONVERT_DONE

CONVERT_7:
	movui r2, 0b0000111
	br CONVERT_DONE
	
CONVERT_6:
	movui r2, 0b1111101
	br CONVERT_DONE

CONVERT_5:
	movui r2, 0b1101101
	br CONVERT_DONE

CONVERT_4:
	movui r2, 0b1100110
	br CONVERT_DONE
	
CONVERT_3:
	movui r2, 0b1001111
	br CONVERT_DONE
	
CONVERT_2:
	movui r2, 0b1011011
	br CONVERT_DONE
	
CONVERT_1:
	movui r2, 0b0000110
	br CONVERT_DONE
	
CONVERT_0:
	movui r2, 0b0111111
	br CONVERT_DONE
	
CONVERT_DONE:	
	ldw ra, 0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	addi sp, sp, 12
 ret