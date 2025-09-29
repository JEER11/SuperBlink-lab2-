#include "header.h"
#include <stdint.h>

// Memory map addresses
#define GPIO_CTRL_ADDR 0x10012000
#define MTIME_ADDR 0x0200BFF8
#define MTIME_FREQUENCY 33

// GPIO register offsets
#define GPIO_OUTPUT_EN  0x008
#define GPIO_OUTPUT_VAL 0x00C
#define GPIO_INPUT_VAL  0x000

// Register access macros
#define GPIO_REG(offset) (*((volatile uint32_t*)(GPIO_CTRL_ADDR + offset)))
#define MTIME_REG (*((volatile uint64_t*)MTIME_ADDR))

void setupGPIO() {
    // Enable output for RGB LED pins
    GPIO_REG(GPIO_OUTPUT_EN) |= (RED_LED | BLUE_LED | GREEN_LED);
    
    // Clear all LEDs initially
    GPIO_REG(GPIO_OUTPUT_VAL) &= ~(RED_LED | BLUE_LED | GREEN_LED);
}

int setLED(int color, int state) {
    // Validate color parameter
    if (color != RED_LED && color != BLUE_LED && color != GREEN_LED) {
        return -1; // Invalid color
    }
    
    if (state == ON) {
        // Turn on LED
        GPIO_REG(GPIO_OUTPUT_VAL) |= color;
    } else {
        // Turn off LED
        GPIO_REG(GPIO_OUTPUT_VAL) &= ~color;
    }
    
    return 0; // Success
}

void delay(int milliseconds) {
    // Get current time
    uint64_t start_time = MTIME_REG;
    
    // Calculate target time (convert milliseconds to timer ticks)
    uint64_t delay_ticks = (uint64_t)milliseconds * MTIME_FREQUENCY;
    uint64_t target_time = start_time + delay_ticks;
    
    // Wait until target time is reached
    while (MTIME_REG < target_time) {
        // Busy wait
    }
}