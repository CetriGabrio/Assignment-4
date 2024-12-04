class Timer {
  int totalTime = 60;  //Total time for the timer in seconds
  int startTime; //Start time in milliseconds
  PImage youWonImg;  //Image for "You Won"
  PImage gameOverImg; //Image for "Game Over"

  //Constructor to initialize the timer and load images
  Timer() {
    startTime = millis(); //Start time
    youWonImg = loadImage("youwon.png");
    gameOverImg = loadImage("youlost.png"); 
  }

  //Display the timer at the top-right corner
  void display() {
    //Calculate the elapsed time
    int elapsedTime = (millis() - startTime) / 1000;

    //Calculate the remaining time
    int remainingTime = totalTime - elapsedTime;

    //Display the timer with text if the game is still ongoing
    textSize(25);
    fill(0);
    if (remainingTime >= 0) {
      //Display the timer at the top-right corner
      text("Time: " + remainingTime, width - 100, height - 370);
    } else {
    
    if (score >= 60) {
      //Display the "You Won" image covering the whole canva
      image(youWonImg, width - youWonImg.width , height / 2 - youWonImg.height / 2);
    } else {
      //Display the "Game Over" image covering the whole canva
      image(gameOverImg, width - gameOverImg.width, height / 2 - gameOverImg.height / 2);
    }

      noLoop(); //Stop the game loop when time is up
    }
  }
}
