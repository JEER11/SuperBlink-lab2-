#include <stdio.h>
#include "header.h"
int main()
{
    int error = 0;
    int ledNum = 0;
    int colors[NUM_LEDS] = {GREEN_LED, BLUE_LED, RED_LED};
    setupGPIO();
    while(!error)
    {
        setLED(colors[ledNum], ON);
        delay(DELAY);
        error = setLED(colors[ledNum], OFF);
        delay(DELAY);
        ledNum++;
        if(ledNum >= NUM_LEDS)
            ledNum = 0;
    }
    return 0;
}

