#include <Metro.h>
// NeoPixel Ring simple sketch (c) 2013 Shae Erisson
// released under the GPLv3 license to match the rest of the AdaFruit NeoPixel library

#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

// Which pin on the Arduino is connected to the NeoPixels?
// On a Trinket or Gemma we suggest changing this to 1
#define PIN            6

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS      88

uint32_t hour = 3600000; // 3600000 milliseconds in an hour 
Metro interval12hours = Metro(12*hour); 

// When we setup the NeoPixel library, we tell it how many pixels, and which pin to use to send signals.
// Note that for older NeoPixel strips you might need to change the third parameter--see the strandtest
// example for more information on possible values.
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

int delayval = 50; // delay for half a second

uint8_t current_color;

uint32_t plantColor(Adafruit_NeoPixel* pixels, uint8_t c) {
  switch(c) {
    // red
    case 0:
      return pixels->Color(255, 0, 0);
    // blue
    case 1:
      return pixels->Color(0, 0, 255);
    default:
      return pixels->Color(0, 255, 0);
   }
}

void setColor(Adafruit_NeoPixel* pixels, uint8_t c, int delayval) {
  for(int i=0;i<NUMPIXELS;i++){
    pixels->setPixelColor(i, plantColor(pixels, c));
    pixels->show();
    delay(delayval);
  }
}

void setup() {
  // This is for Trinket 5V 16MHz, you can remove these three lines if you are not using a Trinket
#if defined (__AVR_ATtiny85__)
  if (F_CPU == 16000000) clock_prescale_set(clock_div_1);
#endif
  // End of trinket special code
  current_color = 1;
  pixels.begin(); // This initializes the NeoPixel library.
  setColor(&pixels, current_color, delayval);
}

void loop() {
  if (interval12hours .check()) {
    switch(current_color) {
      case 0:
        current_color = 1; // blue
        setColor(&pixels, current_color, delayval);
        break;
      case 1:
        current_color = 0;
        setColor(&pixels, current_color, delayval);
        break;
    }
  }
}
