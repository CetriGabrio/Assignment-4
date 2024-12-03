//Initial setup of the game created

//Since I am able to use version control, for this project I decided to progress gradually
//This means that I will implement the features as a checklist while I go

// targets can get destroyed when the players click them

//Spawn 6 targets so that always 6 of there are alive every frame
int numTargets = 6;

//Spawn positions of the targets
float[] xPositions = new float[numTargets];
float[] yPositions = new float[numTargets];

//Speed of the targets
float[] speeds = new float[numTargets];
boolean[] fromLeft = new boolean[numTargets];

//Life of the targets
boolean[] alive = new boolean[numTargets]; // Tracks if the target is still active
float targetRadius = 20;

void setup() {
  size(400, 400);
  
  //Initialize the targets with full health
  for (int i = 0; i < numTargets; i++) {
    spawnTarget(i);
    alive[i] = true;
  }
}

void draw() {
  background(200);
  
  //Update the targets every frame
  for (int i = 0; i < numTargets; i++) {
    if (alive[i]) {
      //Move the targets if they are alive
      xPositions[i] += fromLeft[i] ? speeds[i] : -speeds[i];
      
      //Display the targets
      ellipse(xPositions[i], yPositions[i], targetRadius, targetRadius);
      
      //Destroy and reset the targets if they reach the end of the screen while alive
      if ((fromLeft[i] && xPositions[i] > width + targetRadius) || (!fromLeft[i] && xPositions[i] < -targetRadius)) {
        spawnTarget(i);
      }
    }
  }
}

//Respawn the targets at a random position and speed
void spawnTarget(int i) {
  fromLeft[i] = random(1) < 0.5; //Randomly decide if the target spawns from left or right
  xPositions[i] = fromLeft[i] ? -targetRadius : width + targetRadius; //Off-screen starting positions
  yPositions[i] = random(height); //Random y spawn position
  speeds[i] = random(2, 5); //Random speed
  alive[i] = true; //Full health
}

//Check if a target is clicked. If it is, get destroyed
void mousePressed() {
  for (int i = 0; i < numTargets; i++) {
    if (alive[i]) {
      float distance = dist(mouseX, mouseY, xPositions[i], yPositions[i]);
      if (distance < targetRadius / 2) { //Check if the click is within the target hitbox
        alive[i] = false; //Destroy the target
        println("Target " + i + " destroyed!"); //Debugging tool to make sure everything works as intended
      }
    }
  }
}
