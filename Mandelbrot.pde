float coordx = -1.5;  // Default coordinates for best effect
float coordx2 = -1.5;
float coordy = 1.5;
float coordy2 = 1.5;
float hue;
float saturation;
float value;
boolean keepColour = false;

class Mandelbrot {
  Mandelbrot() {
  }
  void draw() {
    pixelDensity(1);
    loadPixels();

    createMatrix();

    updatePixels();
  }

  void createMatrix() {
    int iterations = 100; // This is the maximum amount of iterations that the numbers run through, to see if they tend towards infinity or not

    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {  // Two for loops so it applies for all the pixels in the screen

        float a = map(x, 0, width, coordx, coordy);  // Re-maps one of the pixels of coordiantes (x, y) to a number in the range of our coordinates
        float b = map(y, 0, height, coordx2, coordy2); 

        float complexA = a;  // Store the original value of a and b in a new float
        float complexB = b;

        float n = 0; // Declared outside of for-loop because it is needed in this scope afterwards

        for (n=0; n<iterations; n++) {

          float real = a*a - b*b; // This is the 'real' component of the complex number c || c^2 = (a + bi) * (a + bi) -> c^2 = a^2 - b^2 + 2abi
          float imaginary = 2 * a * b; // This is the imaginary component of the complex number c

          a = real + complexA;  // add the original value of a and b to the real/imaginary component for the next loop
          b = imaginary + complexB; 

          if (abs(real+imaginary) > 60) {  // abs() takes the absolute value of a number (so if it's -2, the absolute value |-2| is 2)
            break;                         // if that number tends towards infinity (here represented by 60, the for-loop breaks.
          }
        }
        
        // Color Segment of the code

        if (key == 'c')
          keepColour = true;
          
        if (key == 'v')
          keepColour = false;
          
        if (keepColour == true) {
          colorMode(HSB, 100);
          hue = (255*n / iterations);
          if (n % 2 == 0) {
            saturation = 255; // even numbers darker
          } else {
            saturation = 50; // odd numbers brighter -> striped effect
          }
          value = 255;

          if (n < iterations) 
            value = 255;
          else
            value = 0;
        } 
        else {
          colorMode(RGB, 255);
          hue = map(n, 0, iterations, 0, 255);
          saturation = map(n, 0, iterations, 0, 255);
          value = map(n, 0, iterations, 0, 255);
        }
        color brightness = color(hue, saturation, value);  // Background color, any pixel not within the mandelbrot set 

        if (n == iterations) {
          brightness = color(0, 0, 0);  // All values that do not tend to infinity are colored black (within the iterations) (meaning pixels within the set)
        }

        pixels[(x+y*width)] = brightness;
      }
    }
  }
}

void keyPressed() {  // This part  is for zooming into the set
  if (key == 'z' && coordx < 0 && coordy > -1.25) {  // zooms in 
    coordx = coordx + 0.125;
    coordx2 = coordx2 + 0.125;
    coordy = coordy - 0.125;
    coordy2 = coordy2 - 0.125;
  }
  if (key == 'x' && coordx <= 0) {  //zooms out
    coordx = coordx - 0.125;
    coordy = coordy + 0.125;
    coordx2 = coordx2 - 0.125;
    coordy2 = coordy2 + 0.125;
  }
  if (key == 'a') {  // moves left
    coordx = coordx - 0.125;
    coordy = coordy - 0.125;
  }
  if (key == 'd') {  // moves right
    coordx = coordx + 0.125;
    coordy = coordy + 0.125;
  }
  if (key == 'w') {  // moves up
    coordx2 = coordx2 - 0.125;
    coordy2 = coordy2 - 0.125;
  }
  if (key == 's') {  // moves down
    coordx2 = coordx2 + 0.125;
    coordy2 = coordy2 + 0.125;
  }

  println("x: " + coordx + " || y: " + coordy);
  println("x2: " + coordx2 + " || y2: " + coordy2);
}
