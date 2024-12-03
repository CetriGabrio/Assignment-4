//Added a countdown timer so that the player knows when the game is about to end
//This also helps the player focus to achieve the points they require to win

//This timer uses millis() and it is related to my implementation log #2

class Timer {
  int totalTime = 60;  //Total time for the timer in seconds
  int startTime; //Start time in milliseconds

  //Constructor to initialize the timer
  Timer() {
    startTime = millis(); //Start time
  }

  //Display the timer at the top-right corner
  void display() {
    //Calculate the elapsed time
    int elapsedTime = (millis() - startTime) / 1000;

    //Calculate the remaining time
    int remainingTime = totalTime - elapsedTime;

    //Display and update the timer with text
    textSize(25);
    fill(0);
    if (remainingTime >= 0) {
      //Position the timer at the top-right corner
      text("Time: " + remainingTime, width - 100, height - 370);
    } else {
      //Win condition - display either the win or lose message based on the score
      if (score >= 60) {
        text("You Won", width / 2 - 75, height / 2);
      } else {
        text("Game Over", width / 2 - 75, height / 2);
      }
      
      //Player can restart the game by pressing the R key
      //No need to restart the whole program to restart the game
      textSize(20);
      text("Press R to Restart", width / 2 - 80, height / 2 + 40);
      noLoop(); // Stop
    }
  }
}
