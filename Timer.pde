//Added a countdown timer so that the player knows when the game is about to end
//This also helps the player focus to achieve the points they require to win

//This timer uses frameCount

class Timer {
  int totalTime;  //Total time for the timer in seconds
  int startFrame; //Frame when the timer starts

  //Constructor to initialize the timer
  Timer(int totalTime) {
    this.totalTime = totalTime;
    this.startFrame = frameCount; //Store the starting frame count
  }

  //Calculate the remaining time based on frameCount
  int getRemainingTime() {
    int elapsedFrames = frameCount - startFrame; //Frames elapsed since the timer started
    int elapsedTime = int(elapsedFrames / frameRate); //Convert frames to seconds
    return totalTime - elapsedTime;
  }

  //Check if the timer has reached the end
  boolean isTimeUp() {
    return getRemainingTime() <= 0;
  }

  //Display the timer in the bottom right corner of the canva
  void display() {
    int remainingTime = getRemainingTime();
    textSize(20);
    fill(0);
    if (remainingTime >= 0) {
      text("Time: " + remainingTime, width - 100, height - 20);
    } else {
      text("Game Over", width / 2 - 75, height / 2);
    }
  }
}
