//Initial setup of the game created

//Since I am able to use version control, for this project I decided to progress gradually
//This means that I will implement the features as a checklist while I go

PImage[] backgrounds; //Array to store all the background images
PImage activeBackground; //Variable for the current background image

Target[] targets; //Array of Target objects to manage the several amount of shapes
int numTargets = 6;
int score = 0; //Implementing a player's score system
Timer gameTimer; //Implementing the timer

void setup() {
  size(400, 400);
  
  //Load the background images
  backgrounds = new PImage[3];
  backgrounds[0] = loadImage("background1.jpg");
  backgrounds[1] = loadImage("background2.jpg");
  backgrounds[2] = loadImage("background3.png");
  
  restartGame(); //Initialize the game
}

void draw() {
  //Display the current background
  if (activeBackground != null) {
    image(activeBackground, 0, 0, width, height);
  } else {
    background(225); //Fallback color if no background is set
  }
  
  //Display the timer
  gameTimer.display();

  //Stop the game if time is up (handled in the Timer class)
  if (!looping) {
    return;
  }
  
  //Display and update score
  textSize(20);
  fill(0);
  text("Score: " + score, 10, 30);
  
  //Update and draw each target
  for (Target t : targets) {
    t.update();
    t.display();
  }
}


void mousePressed() {
  if (looping) { //Allow interactions only if the game is still running
    for (int i = 0; i < numTargets; i++) {
      if (targets[i].isClicked(mouseX, mouseY)) {
        println("Target " + i + " destroyed!");
        targets[i].respawn(); // Respawn the target
        score++; // Increment score
      }
    }
  }
}

//Restart the game when R is pressed
void keyPressed() {
  if (key == 'R' || key == 'r') {
    restartGame();
  }
}

//Restart game logic
void restartGame() {
  score = 0; // Reset score
  gameTimer = new Timer(); // Restart the timer
  
  //Select a random background
  int randomIndex = int(random(backgrounds.length));
  activeBackground = backgrounds[randomIndex];
  
  //Initialize the targets
  targets = new Target[numTargets];
  for (int i = 0; i < numTargets; i++) {
    targets[i] = new Target();
  }
  loop(); //Restart the draw loop
}
