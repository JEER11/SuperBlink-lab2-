.section .text
.include "memoryMap.inc"
.include "GPIO.inc"

.global setupGPIO
.global setLED
.global delay

# setupGPIO function - Initialize GPIO for LED control
setupGPIO:
    # Load GPIO base address
    li t0, GPIO_CTRL_ADDR
    
    # Enable output for RGB LED pins
    li t1, GPIO_RGB_PINS
    sw t1, GPIO_OUTPUT_EN(t0)
    
    # Clear all LEDs initially
    li t1, 0
    sw t1, GPIO_OUTPUT_VAL(t0)
    
    ret

# setLED function - Control individual LED
# Parameters: a0 = color (LED pin mask), a1 = state (ON/OFF)
# Returns: 0 on success, error code on failure
setLED:
    # Load GPIO base address
    li t0, GPIO_CTRL_ADDR
    
    # Read current output value
    lw t1, GPIO_OUTPUT_VAL(t0)
    
    # Check if state is ON (1) or OFF (0)
    beqz a1, led_off
    
led_on:
    # Turn on LED - set the bit
    or t1, t1, a0
    j led_write
    
led_off:
    # Turn off LED - clear the bit
    not t2, a0
    and t1, t1, t2
    
led_write:
    # Write back the modified value
    sw t1, GPIO_OUTPUT_VAL(t0)
    
    # Return 0 (success)
    li a0, 0
    ret

# delay function - Simple delay loop
# Parameter: a0 = milliseconds to delay
delay:
    # Load MTIME frequency
    li t0, MTIME_FREQUENCY
    mul t0, t0, a0      # Convert milliseconds to cycles
    li t1, 1000
    div t0, t0, t1      # t0 = cycles needed
    
    # Load current MTIME
    li t1, MTIME
    lw t2, 0(t1)        # Current time
    add t0, t0, t2      # Target time = current + delay
    
delay_loop:
    lw t2, 0(t1)        # Read current time
    blt t2, t0, delay_loop  # Continue if current < target
    
    ret