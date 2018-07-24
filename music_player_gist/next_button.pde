class NextButton {
  PVector myPos;
  float rad;
  float x;
  float y;
  float w;
  float h;
  int fillColor;
  String text;
  PImage next = loadImage("data/nextButtonBackground.jpg");

  // constructor
  NextButton (float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    myPos = new PVector(x, y);
    rad = 64;
    fillColor = 0x000000;
    noStroke();
  }


  // draw buttons
  void drawMe() {
    //fill(#00ff00);
    //rect(x, y, w, h);
    image(next, myPos.x, myPos.y);
  }

  //  check if mouse is over button
  boolean mouseOverMe() {
    return ((mouseX > x) && (mouseX < x+w) && (mouseY > y) && (mouseY < y+h));
  }
}
