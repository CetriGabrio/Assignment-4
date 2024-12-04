//Class for controlling the targets

//Targets are spawning, moving and accelerating with PVector
//This solves my Impleentation Log #3

class Target {
  PVector position; //Position of targets
  PVector velocity; //Velocity of targets
  PVector acceleration; //Acceleration of targets
  float radius; //Size of targets
  float baseSpeed = 20.0 / 60.0; //Base velocity per frame (20 pixels per second)
  float maxSpeed; //Maximum velocity

  //Constructor to initialize the target
  Target() {
    maxSpeed = baseSpeed * 5; //Setting the max speed of targets as 5x their base speed
    respawn();
  }

  //Update the target's position every frame
  void update() {
    velocity.add(acceleration); //Increase the velocity by acceleration
    velocity.limit(maxSpeed); //Cap the velocity to the max speed
    position.add(velocity); //Update position using velocity
    
    //Check if the target has moved off-screen and, in case, destroy it
    if ((velocity.x > 0 && position.x > width + radius) || 
        (velocity.x < 0 && position.x < -radius)) {
      respawn(); //Respawn the target when it gets destroyed
    }
  }

  //Display the targets
  void display() {
    
    //Here I am adding an hovering function that will create a stroke around the target when the mouse is hovering it
    //Essential to make sure that the mouse is enclosed between the target's hitbox
    //It solves my Implementation Log #2
    
    //Check if the mouse is hovering over the target
    boolean isHovered = isHovered(mouseX, mouseY);

    //visuals
    //Trying to recreate realistic circular looking targets
    int numRings = 5; //Number of concentric circles
    float ringStep = radius / numRings; //Width of each ring
    
    //Draw the outermost ring without a stroke
    if (isHovered) {
      stroke(255, 0, 0); //Red stroke if the target is being hovered
      strokeWeight(3);
    } else {
      noStroke(); //No stroke otherwise
    }
    fill(255); //Outer ring color (white)
    ellipse(position.x, position.y, radius, radius); //Outer ring
  
    //Draw the inner rings without a stroke
    noStroke();
    for (int i = 1; i < numRings; i++) { //Start from the second ring
      if (i % 2 == 0) {
        fill(255); //White for even rings
      } else {
        fill(0); //Black for odd rings
      }
      ellipse(position.x, position.y, radius - i * ringStep, radius - i * ringStep);
    }

    //Add a red bullseye in the center
    fill(255, 0, 0);
    ellipse(position.x, position.y, ringStep, ringStep);
  }

  //Check if the target is clicked
  boolean isClicked(float mouseX, float mouseY) {
    return dist(mouseX, mouseY, position.x, position.y) < radius / 2;
  }
  
  // Check if the target is hovered
  boolean isHovered(float mouseX, float mouseY) {
  return dist(mouseX, mouseY, position.x, position.y) < radius / 2;
  }


  //Respawn the targets outside the screen with random attributes
  void respawn() {
    float startX = random(1) < 0.5 ? -radius : width + radius; //Starting position outside of the screen
    float directionX = startX < 0 ? 1 : -1; //Movement direction
    
    radius = random(20, 50); //Ensure targets keep spawning with random sizes
    position = new PVector(startX, random(50, 390)); //Set starting position at a constrained height to not everlap with the text
    velocity = new PVector(directionX * baseSpeed * random(1, 2), 0); //Base speed
    acceleration = new PVector(directionX * (baseSpeed / 60), 0); //Gradual acceleration
  }
}
