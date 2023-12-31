import java.io.*; //Pure Java Library
//
//Library: use Sketch / Import Library / Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
File musicFolder; //Class for java.io.* library
Minim minim; //creates object to access all functions
int numberOfSongs = 8; //Number of Files in Folder, OS to count
int numberOfSoundEffects = 4; //Number of Files in Folder, OS to count
AudioPlayer[] song = new AudioPlayer[ numberOfSongs ]; //creates "Play List" variable holding extensions WAV, AIFF, AU, SND, and MP3
AudioPlayer[] soundEffect = new AudioPlayer[ numberOfSoundEffects ]; //Playlist for Sound Effects
AudioMetaData[] songMetaData = new AudioMetaData[ numberOfSongs ]; //Stores everything from PlayList Properties TAB (.mp3)
PFont generalFont;
color purple = #2C08FF;
//
void setup() {
  size(600, 400);
  //Display Algorithm
  minim = new Minim(this); //load from data directory, loadFile should also load from project folder, like loadImage
  String Ring = "Your_Phone_Ringing_-_Funny_Asian-650683.mp3";
  String extension = ".mp3";
  String pathway = "../"; //Relative Path
  String path = sketchPath( pathway + Ring ); //Absolute Path
  // See: https://poanchen.github.io/blog/2016/11/15/how-to-add-background-music-in-processing-3.0
  println(path);
   song[0] = minim.loadFile( path );
  songMetaData[0] = song[0].getMetaData();
  generalFont = createFont ("Harrington", 55); //Must also Tools / Create Font / Find Font / Do Not Press "OK"
    //song[0].loop(0);
  //
  //Meta Data Println Testing
  //For Prototyping, print all information to the console first
  //Verifying Meta Data, 18 println's 
  //Repeat: println("?", songMetaData1.?() );
} //End setup
//
void draw() {
  //Note: Looping Function
  //Note: logical operators could be nested IFs
  if ( song[0].isLooping() && song[0].loopCount()!=-1 ) println("There are", song[0].loopCount(), "loops left.");
  if ( song[0].isLooping() && song[0].loopCount()==-1 ) println("Looping Infinitely");
  if ( song[0].isPlaying() && !song[0].isLooping() ) println("Play Once");
  //
  //Debugging Fast Forward and Fast Rewind
  //println( "Song Position", song1.position(), "Song Length", song1.length() );
  //
  // songMetaData1.title()
   // Draw a square
  float x = 100;  // X-coordinate of the top-left corner
  float y = 150;  // Y-coordinate of the top-left corner
  float sideLength = 200;  // Length of each side
  rect(x, y, sideLength, sideLength);
  rect(width*1/4, height*0, width*3/10, height*2/20); //mistake
  fill(purple); //Ink
  textAlign (CENTER, CENTER); //Align X&Y, see Processing.org / Reference
  //Values: [LEFT | CENTER | RIGHT] & [TOP | CENTER | BOTTOM | BASELINE]
  int size = 10; //Change this font size
  textFont(generalFont, size); //Change the number until it fits, largest font size
    text(songMetaData[0].title(), width*1/4, height*0, width*1/2, height*3/10);
  fill(255); //Reset to white for rest of the program
} //End draw
//
void keyPressed() {
    if ( key=='P' || key=='p' ) song[0].play(); //Parameter is milli-seconds from start of audio file to start playing (illustrate with examples)
  //.play() includes .rewind()
  //
  if ( key>='1' || key<='9' ) { //Loop Button, previous (key=='1' || key=='9')
    //Note: "9" is assumed to be massive! "Simulate Infinite"
    String keystr = String.valueOf(key);
    //println(keystr);
    int loopNum = int(keystr); //Java, strongly formatted need casting
       song[0].loop(loopNum); //Parameter is number of repeats
    //
  }
    if ( key=='L' || key=='l' ) song[0].loop(); //Infinite Loop, no parameter OR -1
  //
  if ( key=='M' || key=='m' ) { //MUTE Button
    //MUTE Behaviour: stops electricty to speakers, does not stop file
    //NOTE: MUTE has NO built-in PUASE button, NO built-in rewind button
    //ERROR: if song near end of file, user will not know song is at the end
    //Known ERROR: once song plays, MUTE acts like it doesn't work
        if ( song[0].isMuted() ) {
      //ERROR: song might not be playing
      //CATCH: ask .isPlaying() or !.isPlaying()
            song[0].unmute();
    } else {
      //Possible ERROR: Might rewind the song
           song[0].mute();
    }
  } //End MUTE
  //
  //Possible ERROR: FF rewinds to parameter milliseconds from SONG Start
  //Possible ERROR: FR rewinds to parameter milliseconds from SONG Start
  //How does this get to be a true ff and fr button
  //Actual .skip() allows for varaible ff & fr using .position()+-
    if ( key=='F' || key=='f' ) song[0].skip( 0 ); //SKIP forward 1 second (1000 milliseconds)
  if ( key=='R' || key=='r' ) song[0].skip( 1000 ); //SKIP  backawrds 1 second, notice negative, (-1000 milliseconds)
  //
  //Simple STOP Behaviour: ask if .playing() & .pause() & .rewind(), or .rewind()
  if ( key=='S' | key=='s' ) {
        if ( song[0].isPlaying() ) {
      song[0].pause(); //auto .rewind()
    } else {
            song[0].rewind(); //Not Necessary
    }
  }
  //
  //Simple Pause Behaviour: .pause() & hold .position(), then PLAY
  if ( key=='Y' | key=='y' ) {
        if ( song[0].isPlaying()==true ) {
      song[0].pause(); //auto .rewind()
    } else {
            song[0].play(); //ERROR, doesn't play
    }
  }
} //End keyPressed
//
void mousePressed() {
} //End mousePressed
//
//End MAIN Program
