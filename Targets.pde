//To keep the code more organized, I created a separate class to manage the targets

//Set variables for the spawn, speed and size for the targets
class Target {
  float x, y, speed;
  boolean fromLeft;
  float radius = 20;
  
  //Constructor to initialize the targets
  Target() {
    respawn();
  }
  
  //Update the target's position every frame
  void update() {
    x += fromLeft ? speed : -speed;
    if ((fromLeft && x > width + radius) || (!fromLeft && x < -radius)) {
      respawn(); //Respawn the target when it gets destroyed
    }
  }
  
  //Display the targets
  void display() {
    ellipse(x, y, radius, radius);
  }
  
  //Check if the targets are clicked
  boolean isClicked(float mouseX, float mouseY) {
    return dist(mouseX, mouseY, x, y) < radius / 2;
  }
  
  //Respawn the targets outside the screen with random attributes
  void respawn() {
    fromLeft = random(1) < 0.5;
    x = fromLeft ? -radius : width + radius;
    y = random(height);
    speed = random(2, 5);
  }
}
