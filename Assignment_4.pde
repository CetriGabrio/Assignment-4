//Welcome to my super incredible FPS training game
//Made by Gabriele Ilacqua

//In this game, you can play alone or challenge your friends
//You have to click the targets to destroy them and obtain 1 point
//The goal is to obtain 60 points in 60 seconds
//But attention, if you miss the target, you will lose 1 point every time
//Who will win this EPIC challenge???

/////////////////////////////////////////////////////
/////////////////////SOURCES/////////////////////////
/////////////////////////////////////////////////////
//Thank you to all the talented artists who alloweded me to use their creations for my project

//backgrounds
//1: https://www.creativefabrica.com/product/japan-cityscape-at-night-pixel-art/
//2: https://www.creativefabrica.com/product/japan-cityscape-at-night-pixel-art-4/
//3: https://wallpaperaccess.com/japanese-pixel-art

//sounds
//POP: https://pixabay.com/sound-effects/search/pop/ (@freesound_community)
//SWING: https://pixabay.com/it/sound-effects/search/miss/ (@floraphonic)

//(All the other screens were created by me, so @ME)


/////////////////////////////////////////////////////
///////////////////VARIABLES/////////////////////////
/////////////////////////////////////////////////////

//Background images
PImage[] backgrounds; //Array to store all the background images
PImage activeBackground; //Variable only for the current background image

//Targets
Target[] targets; //Array of Target objects to manage the several amount of shapes
int numTargets = 6;
int score = 0; //Implementing the player's score system
Timer gameTimer; //Implementing the timer

//Sounds
import processing.sound.*;
SoundFile targetSound; //POP sound
SoundFile missSound; //Swing sound

//Startscreen
StartScreen startScreen;
boolean isStartScreen = true; //Game starts with the start screen

//Setupppp
void setup() {
  size(400, 400);
  
  //Load the 3 background images
  backgrounds = new PImage[3];
  backgrounds[0] = loadImage("background1.jpg");
  backgrounds[1] = loadImage("background2.jpg");
  backgrounds[2] = loadImage("background3.png");
  
  targetSound = new SoundFile(this, "pop.mp3"); //POP sound
  missSound = new SoundFile(this, "miss.mp3");  //SWING sound

  startScreen = new StartScreen(); //Initialize start screen
  restartGame(); //Initialize the game
}

//Updateeee
void draw() {
     if (isStartScreen) {
      startScreen.display(); //Display the start screen
     } else {
       
    //Display the current background (one of the three options)
    if (activeBackground != null) {
      image(activeBackground, 0, 0, width, height); //Background adjusted to cover the whole canvas
    } else {
      background(225); //Just a precaution in case the background images stop working
    }
  
    //Just a white rectangle at the top to make the text more visible
    fill(242, 242, 242, 104);
    rect(0, 0, width, 39);
    
    //Display the timer
    gameTimer.display();
  
    //Stop the game if time is up
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
}

//CLICKKK
void mousePressed() {
  if (looping) { //Loop to allow interactions only if the game is still running
      boolean hitTarget = false; //Track if a target was hit

    for (int i = 0; i < numTargets; i++) {
      if (targets[i].isClicked(mouseX, mouseY)) {
        println("Target " + i + " destroyed!");
        targets[i].respawn(); //Respawn the target
        targetSound.play(); //Play the pop sound
        score++; //Increment score by 1
        hitTarget = true;  //Mark that a target was hit
      }
    }
    
      //If the player clicks but miss the target, decrement their score by 1 point
      if (!hitTarget) {
        //println("Missed! Losing 1 point."); //Debugging tool to ensure everything is working as intended
        missSound.play();  //Play the miss sound
        score = max(0, score - 1); //Ensure score does not go below 0
    }
  }
}

//Start the game when S is pressed
//Restart the game when R is pressed
void keyPressed() {
  if (isStartScreen) {
    if (key == 'S' || key == 's') {
      isStartScreen = false; //Exit the start screen
      restartGame();  //Initialize the game
    }
  } else if (key == 'R' || key == 'r') {
    restartGame(); //Restart the game if already in progress
  }
}

//Restart game logic
void restartGame() {
  score = 0; //Reset score
  gameTimer = new Timer(); //Reset the timer
  
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
