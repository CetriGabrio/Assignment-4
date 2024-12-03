//Initial setup of the game created

//Since I am able to use version control, for this project I decided to progress gradually
//This means that I will implement the features as a checklist while I go

PImage backgroundArt1, backgroundArt2, backgroundArt3; //I am using pixel art images as background for my game
PImage currentBackground;  //Variable to store the current background

Target[] targets; //Array of Target objects to manage the several amount of shapes
int numTargets = 6;
int score = 0; //Implementing a player's score system
Timer gameTimer; //Implementing the timer

void setup() {
  size(400, 400);
  
  backgroundArt1 = loadImage("background1.jpg");  // Load the background image
  backgroundArt2 = loadImage("background2.jpg");  // Load the background image
  backgroundArt3 = loadImage("background3.png");  // Load the background image

  // Randomly select one of the background images
  int randomChoice = int(random(3));  // Generates a random number between 0 and 2
  
  // Assign the randomly selected background to the currentBackground variable
  if (randomChoice == 0) {
    currentBackground = backgroundArt1;
  } else if (randomChoice == 1) {
    currentBackground = backgroundArt2;
  } else {
    currentBackground = backgroundArt3;
  }
    
  targets = new Target[numTargets];
  gameTimer = new Timer(); //Initialize the timer
  
  //Initialize the targets
  for (int i = 0; i < numTargets; i++) {
    targets[i] = new Target();
  }
  
  restartGame(); //Initialize the game
}

void draw() {
  background(225);
  
  //Display the background pixel art
  image(currentBackground, 0, 0, width, height);  //Set the image to cover the entire window
  
  //Display and update score with text
  textSize(25);
  fill(0);
  text("Score: " + score, 10, 30);
  
  //Display the timer
  gameTimer.display();
  
  //Stop the game if timer reaches 0
  if (!looping) {
    return;
  }

  //Update and draw each target
  for (Target t : targets) {
    t.update();
    t.display();
  }
}

//Check if a target is clicked. If it is, get destroyed
void mousePressed() {
  for (int i = 0; i < numTargets; i++) {
    if (targets[i].isClicked(mouseX, mouseY)) {
      println("Target " + i + " destroyed!"); //Debugging tool to make sure everything works as intended
      targets[i].respawn(); //Respawn the target so that always 6 are alive
      score++; //Increment score every time a target is destroyed
    }
  }
}

//Restart the game when the R key is pressed
void keyPressed() {
  if (key == 'R' || key == 'r') {
    restartGame();
  }
}

//Restarting the whole game logic
void restartGame() {
  score = 0; //Reset the score to 0
  gameTimer = new Timer(); //Restart the timer at 60 seconds

  //Initialize the targets
  targets = new Target[numTargets];
  for (int i = 0; i < numTargets; i++) {
    targets[i] = new Target();
  }
  loop(); //Restart the draw loop
}
