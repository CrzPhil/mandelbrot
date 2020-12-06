Mandelbrot set = new Mandelbrot();

void setup() {
  size(1200, 1200);
  background(255);
}

void draw() {
  set.draw();
  set.createMatrix();
}
