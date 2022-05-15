int aX, aY, bX, bY, cX, cY, confirmX, confirmY; //Button coordinates
int selectWidth = 50;
int selectHeight = 50;
int confirmWidth = 85;
int confirmHeight = 50;

PImage img;

color selectBase, selectHighlight, confirmBase, confirmHighlight, backgroundColor;
boolean overA, overB, overC, overConfirm;
boolean aSelected, bSelected, cSelected, confirmSelected;


void setup() {
  size(1280, 720);
  backgroundColor = color(49, 49, 51);
  selectBase = color(100);
  selectHighlight = color(200);
  confirmBase = color(100);
  confirmHighlight = color(50, 200, 50);

  aX = bX = cX = width/2 - selectWidth/2;
  aY = height / 5;
  bY = aY + 2*selectHeight;
  cY = bY + 2*selectHeight;

  img = loadImage("test.png");
  img.resize(250, selectHeight);

  confirmX = aX - (confirmWidth - selectWidth)/2;
  confirmY = cY + 4*selectHeight;
  
  overA = overB = overC = overConfirm = false; //should actually be initialized with false but just in case
}

void draw() {
  updateMouseData();
  background(backgroundColor);

  //draw rectangles for buttons
  stroke(255);
  fill(backgroundColor);
  
  rect(10, 10, width - 20, height - 20); //just for nice looks
  
  //check if hovering and change fill color accordingly
  if(overA || aSelected)
    fill(selectHighlight);
  else
    fill(selectBase);
  rect(aX, aY, selectWidth, selectHeight);
  
  if(overB || bSelected)
    fill(selectHighlight);
  else
    fill(selectBase);
  rect(bX, bY, selectWidth, selectHeight);
  
  if(overC || cSelected)
    fill(selectHighlight);
  else
    fill(selectBase);
  rect(cX, cY, selectWidth, selectHeight);
  
  image(img, aX - width/3, aY);
  image(img, aX - width/3, bY);
  image(img, aX - width/3, cY);
  
  if(overConfirm || confirmSelected)
    fill(confirmHighlight);
  else
    fill(confirmBase);
  rect(confirmX, confirmY, confirmWidth, confirmHeight);
}

//heavily inspired by https://processing.org/examples/button.html
void updateMouseData() {
  //check for buttons a, b, c, and confirm button
  if(overRectButton(aX, aY, selectWidth, selectHeight)){
    overA = true;
    overB = overC = overConfirm = false;
  } else if(overRectButton(bX, bY, selectWidth, selectHeight)){
    overB = true;
    overA = overC = overConfirm = false;
  } else if(overRectButton(cX, cY, selectWidth, selectHeight)){
    overC = true;
    overA = overB = overConfirm = false;
  } else if(overRectButton(confirmX, confirmY, confirmWidth, confirmHeight)){
    overConfirm = true;
    overA = overB = overC = false;
  } else {
    overA = overB = overC = overConfirm = false;
  }
}

boolean overRectButton(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed(){
  if(overA){
    aSelected = true;
    bSelected = cSelected = confirmSelected = false;
  } else if(overB){
    bSelected = true;
    aSelected = cSelected = confirmSelected = false;
  } else if(overC){
    cSelected = true;
    aSelected = bSelected = confirmSelected = false;
  } else if(overConfirm){
    confirmSelected = true;
  } else {
    confirmSelected = false;
  }
}
