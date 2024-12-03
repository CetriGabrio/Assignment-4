//Initial setup of the game created

//Since I am able to use version control, for this project I decided to progress gradually
//This means that I will implement the features as a checklist while I go

//Spawn 6 targets so that always 6 of there are alive every frame
int numTargets = 6;

//Spawn positions of the targets
float[] xPositions = new float[numTargets];
float[] yPositions = new float[numTargets];

//Speed of the targets
float[] speeds = new float[numTargets];
boolean[] fromLeft = new boolean[numTargets]; 

void setup() {
  size(400, 400);
  
  //Initialize the targets with random attributes
  for (int i = 0; i < numTargets; i++) {
    fromLeft[i] = random(1) < 0.5; //Randomly decide if the target spawns from left or right
    xPositions[i] = fromLeft[i] ? -20 : width + 20; //Off-screen starting positions
    yPositions[i] = random(height); //Random y spawn position
    speeds[i] = random(2, 5); //Random speed
  }
}

void draw() {
  background(200);
  
  //Update the targets every frame
  for (int i = 0; i < numTargets; i++) {
    xPositions[i] += fromLeft[i] ? speeds[i] : -speeds[i];
    
    //Display the targets
    ellipse(xPositions[i], yPositions[i], 20, 20);
    
    //Reset the targets if they go off-screen and get destroyed
    if ((fromLeft[i] && xPositions[i] > width + 20) || (!fromLeft[i] && xPositions[i] < -20)) {
      fromLeft[i] = random(1) < 0.5;
      xPositions[i] = fromLeft[i] ? -20 : width + 20;
      yPositions[i] = random(height);
      speeds[i] = random(2, 5);
    }
  }
}
