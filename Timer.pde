//Added a countdown timer so that the player knows when the game is about to end
//This also helps the player focus to achieve the points they require to win

//This timer uses millis() and it is related to my implementation log #2

class Timer {
  int totalTime = 1;  //Total time for the timer in seconds
  int startTime; //Start time in milliseconds

  //Constructor to initialize the timer
  Timer() {
    startTime = millis(); //Start time
  }

  //Display the timer at the bottom-right corner
  void display() {
    //Calculate the elapsed time
    int elapsedTime = (millis() - startTime) / 1000;

    //Calculate the remaining time
    int remainingTime = totalTime - elapsedTime;

    //Display and update the timer with text
    textSize(25);
    fill(0);
    if (remainingTime >= 0) {
      text("Time: " + remainingTime, width - 100, height - 370);
    } else {
      text("Game Over", width / 2 - 50, height / 2);
      noLoop(); //Stop and restart when the game ends
    }
  }
}
