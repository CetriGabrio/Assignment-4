//New class for the start screen

//This screen will pop up at the beginning
//There will be a short explanation of the game
//Explains hot to start the game

class StartScreen {
  PImage startImage; //Variable to hold the start screen image

  StartScreen() {
    //Load the start screen image
    startImage = loadImage("start.png");
  }

  void display() {
    if (startImage != null) {
      image(startImage, width - startImage.width, height / 2 - startImage.height / 2); //Draw the image covering the whole canvas
    } else {
      background(50); //Just a precaution in case the image doesn't load
    }
  }
}
