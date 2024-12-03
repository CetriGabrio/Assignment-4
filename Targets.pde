//To keep the code more organized, I created a separate class to manage the targets

//Implementation log #3 - using PVector

//Here I am updating the Movement and Position of the targets to use PVector
class Target {
  PVector position; //Position of targets
  PVector velocity; //Velocity of targets
  float radius = 20; //Size of targets
  float baseSpeed = 20.0 / 60.0; //Base velocity per frame (10 pixels per second)

  //Constructor to initialize the target
  Target() {
    respawn();
  }

  //Update the target's position every frame
  void update() {
    position.add(velocity); //Update position using velocity
    
    //Check if the target has moved off-screen and destroy
    if ((velocity.x > 0 && position.x > width + radius) || 
        (velocity.x < 0 && position.x < -radius)) {
      respawn(); //Respawn the target when it gets destroyed
    }
  }

  //Display the targets
  void display() {
    ellipse(position.x, position.y, radius, radius);
  }

  //Check if the targets are clicked
  boolean isClicked(float mouseX, float mouseY) {
    return dist(mouseX, mouseY, position.x, position.y) < radius / 2;
  }

  //Respawn the targets outside the screen with random attributes
  void respawn() {
    float startX = random(1) < 0.5 ? -radius : width + radius; //Starting position outside of the screen
    float directionX = startX < 0 ? 1 : -1; //Movement direction

    position = new PVector(startX, random(height)); //Set starting position at random height
    velocity = new PVector(directionX * baseSpeed * random(1, 2), 0); //Base speed
  }
}
