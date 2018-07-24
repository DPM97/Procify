class BackButton {
  PVector myPos;
  float rad;
  float x;
  float y;
  float w;
  float h;
  int fillColor;
  String text;
  PImage back = loadImage("data/backButtonBackground.jpg");

  // constructor
  BackButton (float _x, float _y, float _w, float _h) {
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
    //fill(#ff0000);
    //rect(x, y, w, h);
    image(back, myPos.x, myPos.y);
  }

  //  check if mouse is over button
  boolean mouseOverMe() {
    return ((mouseX > x) && (mouseX < x+w) && (mouseY > y) && (mouseY < y+h));
  }
}
