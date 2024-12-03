//To keep the code more organized, I created a separate class to manage the targets

//Implementation log #3 - using PVector

//Here I am updating the Movement and Position of the targets to use PVector
//Update: I also added acceleration so that targets start at a base speed and gradually gain speed while they move
class Target {
  PVector position; //Position of targets
  PVector velocity; //Velocity of targets
  PVector acceleration; //Acceleration of targets
  float radius = 20; //Size of targets
  float baseSpeed = 20.0 / 60.0; //Base velocity per frame (20 pixels per second)
  float maxSpeed; //Maximum velocity
  float size; //Size of targets

  //Constructor to initialize the target
  Target() {
    size = random(15, 40); //Random size between 15 and 40 pixels
    maxSpeed = baseSpeed * 5; //Setting the max speed of targets as 5x their base speed
    respawn();
  }

  //Update the target's position every frame
  void update() {
    velocity.add(acceleration); //Increase the velocity by acceleration
    velocity.limit(maxSpeed); //Cap the velocity to max speed
    position.add(velocity); //Update position using velocity
    
    //Check if the target has moved off-screen and destroy
    if ((velocity.x > 0 && position.x > width + radius) || 
        (velocity.x < 0 && position.x < -radius)) {
      respawn(); //Respawn the target when it gets destroyed
    }
  }

  //Display the targets
  void display() {
    ellipse(position.x, position.y, size, size);
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
    acceleration = new PVector(directionX * (baseSpeed / 60), 0); //Gradual acceleration
  }
}
