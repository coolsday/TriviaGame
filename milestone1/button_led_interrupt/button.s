 .section .text 
 #this unit test tests pushbutton interrupts on leds. A button press either turns a led on or off. 
 .global _start 
 
 
 #declear constants to point to pushbuttons and leds addresses 
 .equ BUTTON, 0xFF200050 
 .equ LED, 0xFF200000 
 .equ IRQ, 0x02 
 
 
 _start: 
 	#get addresses of buttons and leds 
 	movia r8, BUTTON 
 	movia r9, LED 
 
 
 	#led 0 is initially off 
 	mov r10, r0 
 	stwio r10, 0(r9) 
 
 
 	#set interrupts for only button 0 
 	movi r2, 0x1 
 	stwio r2, 8(r8) 
 	#clear edge capture register to prevent unexpected interrupts
	movia r2, 0xFFFFFFFF
 	stwio r2, 12(r8) 
 	#enable interrupt for buttons 
 	movi r2, IRQ 
 	wrctl ctl3, r2 
 
 
 	#enable processor interrupt 
 	movia r2, 0x1 
 	wrctl ctl0, r2 
 LOOP: 
 	br LOOP 
 
 
 .section .exceptions, "ax" 
 ISR: 
 	#check for interrupt from button 0 
 	rdctl et, ctl4 
 	andi et, et, 0x02 
 	bne et, r0, serveLED 
 
 
 	br exit 
 
 
 serveLED: 
 	#acknowledge button interrupt 
	movia et, 0xFFFFFFFF
 	stwio et, 12(r8) 
 
 
 	#turn led on/off 
 	xori r10, r10, 0x1 
 	stwio r10, 0(r9) 
 
 
 	br exit 
 
 
 exit: 
 	addi ea, ea, -4 
 	eret  
