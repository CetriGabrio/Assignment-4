//Initial setup of the game created

//Since I am able to use version control, for this project I decided to progress gradually
//This means that I will implement the features as a checklist while I go

Target[] targets; //Array of Target objects to manage the several amount of shapes
int numTargets = 6;

void setup() {
  size(400, 400);
  targets = new Target[numTargets];
  
  //Initialize the targets
  for (int i = 0; i < numTargets; i++) {
    targets[i] = new Target();
  }
}

void draw() {
  background(200);
  
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
    }
  }
}
