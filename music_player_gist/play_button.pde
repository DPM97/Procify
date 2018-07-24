class PlayButton {
  PVector myPos;
  float rad;
  float x;
  float y;
  float w;
  float h;
  int fillColor;
  String text;
  PImage play = loadImage("data/newPlayBackground.jpg");
  PImage pause = loadImage("data/newPauseBackground.jpg");


  // constructor
  PlayButton (float _x, float _y, float _w, float _h) {
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
    if (songStopped == false) {
      image(pause, myPos.x, myPos.y + 36);
    } else if (songStopped == true) {
      image(play, myPos.x, myPos.y + 36);
    }
  }


  //  check if mouse is over button
  boolean mouseOverMe() {
    return ((mouseX > x) && (mouseX < x+w) && (mouseY > y) && (mouseY < y+h));
  }
}
