import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioInput input;
FFT transformWave;


boolean songStopped = true;

BackButton backbutton;
NextButton nextbutton;
PlayButton playbutton;

String[] fileNames;

// creates a string for all files in the directory


// loads everything
void setup() {
  size(800, 600);
  background(0xffffff);

  PImage title = loadImage("data/titleBackground.jpg");
  image(title, 270, 0);

  textAlign(CENTER);
  fill(0x000000);
  text("Press Space to Buffer", 400, 590);

  minim = new Minim(this);

// tells the computer what to use to draw the "wave"
  input = minim.getLineIn();
  transformWave = new FFT(input.bufferSize(), input.sampleRate());

// get a random name out of all of the files
  fileNames = listFileNames("/Users/DylanMaloy/Desktop/Code/Homework/music_player/songs/");
  int index = floor(random(fileNames.length));
  println("in main " + fileNames[index]);
  player = minim.loadFile("songs/" + fileNames[index]);
  String songPlaying = fileNames[index];

// initialize the buttons
  backbutton = new BackButton(0, 0, 270, 800);
  playbutton = new PlayButton(270, 0, 270, 800);
  nextbutton = new NextButton(530, 0, 270, 800);

// get rid of the .mp3
  drawName(songPlaying.replaceAll(".mp3", " "));
}


// draws stuff every 1/60th of a second (buttons, visualizer, progress bar)
void draw() {
  drawButtons();
  visualize();
  drawProgress();
}

// puts all the hardcoded colors and draws all the circles from the data given in setup to draw a wave
void visualize() {
  transformWave.forward(input.mix) ;
  hardCode();
}

// draws buttons
void drawButtons() {
  backbutton.drawMe();
  nextbutton.drawMe();
  playbutton.drawMe();
}

// creates the progress bar using stuff that minim provides and some lines - along with the time on each side
void drawProgress() {
  float x = map(player.position(), 400, player.length(), 300, 500);
  stroke(0);
  strokeWeight (2);
  line(x, 380, x, 400);
  line(300, 390, 500, 390);
  fill(#000000);
  text(player.position()/1000, 285, 395);
  text(player.length()/1000, 515, 395);
}

// draws the song name at the top
void drawName(String songName) {
  fill(0x000000);
  textAlign(CENTER);
  text(songName, 400, 18);
}

// takes all of the files in the song directory and spits back their names so that we can run them (chooses one randomly after)
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    println("working");
    return names;
  } else {
    // If it's not a directory
    println("no directory");
    return null;
  }
}

// makes the buttons work when mouse is pressed and changes the state of the player accordingly
void mousePressed() {
  if (songStopped == true && playbutton.mouseOverMe()) {
    playSong();
    songStopped = false;
  } else if (songStopped == false && playbutton.mouseOverMe()) {
    stopSong();
    songStopped = true;
  } else if (nextbutton.mouseOverMe()) {
    skipSong();
    songStopped = false;
  } else if (backbutton.mouseOverMe()) {
    rewindSong();
    songStopped = false;
  }
}

// just for buffer (press space to buffer)
void keyPressed() {
  bufferSong();
}

// play function - pretty straght forwqard considering minim does most of it for you
void playSong() {
  if (playbutton.mouseOverMe()) {
    player.play();
    println("playing");
  }
}

// same as play just with player.pause();
void stopSong() {
  if (playbutton.mouseOverMe()) {
    player.pause();
    println("paused");
  }
}

// pauses current song, loads a new random song, and plays the song that was just loaded - also changes the song name title at the top.
void skipSong() {
  player.pause();
  int index = floor(random(fileNames.length));
  player = minim.loadFile("songs/" + fileNames[index]);
  println("chose song");
  player.play();
  String newSong = fileNames[index];
  fill(0x000000);
  PImage title = loadImage("data/titleBackground.jpg");
  image(title, 270, 0);
  text(newSong.replaceAll(".mp3", " "), 400, 18);
  println("skipped song");
}

// rewinds the song
void rewindSong() {
  player.rewind();
  player.play();
  println("rewinded");
}

// buffers the song in 1 sec incriments when the space bar is pressed
void bufferSong() {
  if (key == ' ') {
    player.skip(1000);
    println("scrubbing");
  }
}


// don't pay attention to this... pretty much doing the colors for the visualizer manually because no matter how hard I try to interpolate it I can't figure out how to. - also just creates a for loop using specsize given in minim.
void hardCode() {
  for (int i = 0; i < transformWave.specSize(); i++) {
    noStroke();
    if (i < 10) {
      fill(#00111a);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 3);
    } else if (i < 30) {
      fill(#002233);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 9);
    } else if (i < 80) {
      fill(#00334d);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 9);
    } else if (i < 130) {
      fill(#004466);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 7);
    } else if (i < 170) {
      fill(#005580);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 7);
    } else if (i < 230) {
      fill(#006699);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 7);
    } else if (i < 250) {
      fill(#0077b3);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 20);
    } else if (i < 280) {
      fill(#0088cc);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 20);
    } else if (i < 300) {
      fill(#0099e6);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 25);
    } else if (i < 350) {
      fill(#00aaff);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 25);
    } else if (i > 350) {
      fill(#1ab2ff);
      ellipse(i*2, 600, 6, transformWave.getBand(i) * 25);
    }
  }
}
