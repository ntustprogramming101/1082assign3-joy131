final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24, life, cabbage;
PImage soil0, soil1, soil2, soil3, soil4, soil5;

PImage groundhogIdle, groundhogDown, groundhogLeft,groundhogRight;
final int hogStartPositionX = 320;
final int hogStartPositionY = 80;
int hogX, hogY;
int hogUp, hogDown, hogLeft, hogRight;

int soilHeight=80, soilwidth=80;
int y  = 80;
int LifeCount =5;
PImage stone1, stone2;

PImage soldier;
int soldierX; //soldier position X
int soldierY; // soldier position Y


int[][] template_17_24 = 
{{0,1,2,0,1,2,0,1},
 {1,2,0,1,2,0,1,2},
 {2,0,1,2,0,1,2,0},
};


// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed =false;
boolean rightPressed =false;

int movehogUP = 0;
int movehogDOWN = 0;
int movehogLEFT = 0;
int movehogRIGHT = 0;

boolean rectOver = false;

//hog not moving
boolean allZero(){
  if(movehogUP == 0 && movehogDOWN == 0 && movehogLEFT == 0 && movehogRIGHT == 0){
    return true;
  }
  return false;
}
void zero(){
  movehogUP = 0;
  movehogDOWN = 0;
  movehogLEFT = 0;
  movehogRIGHT = 0;
}

void RunDraw()
{
//------CALCULATIONS ------//



   //moving 15 frames 
  if (movehogDOWN>0){
    hogY +=80.0/15.0;
  }  else if (movehogLEFT>0){
    hogX -=80.0/15.0;
  }  else if (movehogRIGHT>0){
    hogX +=80.0/15.0;
  }
  
 
  if(movehogDOWN > 0) movehogDOWN--;
  if(movehogLEFT > 0) movehogLEFT--;
  if(movehogRIGHT > 0) movehogRIGHT--;
  
  //hog boundary
    if(hogX>560 ){
    hogX=560;
   }
    if(hogX<0){
      hogX=0;
   }
   if(hogY>2000){
    hogY=2000;
  }
  if(hogY<80){
    hogY=80;
  }
  
  
}
  
void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");

}

void GameRunSetup(){
    soldierX = 0; //soldier


    hogX=hogStartPositionX;
    hogY=hogStartPositionY;
   int y_soldierCase= int(random(0,3.99)); //between 0,1,2,3 (soil)
   soldierY = 160 + y_soldierCase*80; //160 is sky + random * 1 box(80)
   
   
}








void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
        GameRunSetup();
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

    RunDraw();
		// Background
		image(bg, 0, 0);
    
    int downcam = 0;
    
    
    if(hogY<=1680){
      downcam = hogY;
    }else {
      downcam = 1680;
    }
    
    translate(0, -downcam+80);


    //cameraOffsetY = hogY;
		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50-80+downcam,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);


 
  
		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		image(soil8x24, 0, 160);

    //soil 1
    for(int i=0; i<width ; i+=soilwidth){ 
      for(int y=480; y<soilHeight*10; y+=soilHeight){

      image(soil1,i,y);
      }
    }
    
    //soil 2
     for(int i=0; i<width ; i+=soilwidth){ 
      for(int y=800; y<soilHeight*14; y+=soilHeight){

      image(soil2,i,y);
      }
    }
    
    //soil 3
    for(int i=0; i<width ; i+=soilwidth){ 
      for(int y=1120; y<soilHeight*18; y+=soilHeight){

      image(soil3,i,y);
      }
    }
    
    //soil 4
    for(int i=0; i<width ; i+=soilwidth){ 
      for(int y=1440; y<soilHeight*22; y+=soilHeight){

      image(soil4,i,y);
      }
    }
    
    //soil 5
    for(int i=0; i<width ; i+=soilwidth){ 
      for(int y=1760; y<soilHeight*26; y+=soilHeight){

      image(soil5,i,y);
      }
    }
      

  //1-8 stone
  
  for(int i=0; i<8; i++){
    int y=80 * i + 160;
    image(stone1,i*80,y);
  }
    
  //9-16 stone
  
  //x = 0
   for(int i=0; i<4; i++){
    int y=160*i+880;
    image(stone1,i*160,y);
  }
   for(int i=0; i<6; i++){
    int y=80*i+960;
    image(stone1,i*80,y);
  }
  for(int i=0; i<2; i++){
    int y=160*i+1200;
    image(stone1,i*160,y);
  }
    for(int i=0; i<2; i++){
    int y=80*i+1280;
    image(stone1,i*80,y);
    }
    
    //x=1 (80*1)
     for(int i=0; i<2; i++){
    int y=160*i+1120;
    image(stone1,i*160+80,y);
    }
    for(int i=0; i<4; i++){
    int y=160*i+800;
    image(stone1,i*160+80,y);
  }
   // x=2(80*2)
    
      for(int i=0; i<6; i++){
    int y=80*i+800;
    image(stone1,i*80+160,y);
  }
  
  //x = 4(80*4)
    for(int i=0; i<2; i++){
    int y=160*i+880;
    image(stone1,i*160+320,y);
  }
    
    // x=5 (80*5)
    for(int i=0; i<2; i++){
    int y=160*i+800;
    image(stone1,i*160+400,y);
  }
   
   //x=6 (80)
    for(int i=0; i<2; i++){
    int y=80*i+800;
    image(stone1,i*80+480,y);
  }
  
  //17-24 stone
   
   for(int i = 0; i<8; i++){
     for(int j = 0; j<8; j++){
       int picture_state = template_17_24[j%3][i];
       switch(picture_state){
         case 0:
         break;
         case 1:
         image(stone1,i*80,j*80+1440);
         break;
         case 2:
         image(stone2,i*80,j*80+1440);
         image(stone1,i*80,j*80+1440);
         break;
       }
     }
   }

    


		// Player
   //hog
  if(allZero())image (groundhogIdle , hogX , hogY);
  if(movehogUP > 0)image (groundhogIdle , hogX , hogY);
  if(movehogDOWN > 0)image (groundhogDown , hogX , hogY);
  if(movehogLEFT > 0)image (groundhogLeft , hogX , hogY);
  if(movehogRIGHT > 0)image (groundhogRight , hogX , hogY);
		// Health UI
    
    for(int i=0; i < LifeCount ; i++){  
    image (life , 10 + i * 70, 10-80+downcam);
  }  
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void mousePressed() {
  if (rectOver  && (gameState == GAME_START || gameState == GAME_OVER)) {
    GameRunSetup();
    gameState = GAME_RUN;
  }
}
    
    
void keyPressed(){
	// Add your moving input code here

if (key == CODED && gameState == GAME_RUN && allZero() ) {
      zero();
      switch( keyCode )
      {
       
        case DOWN:
         downPressed = true;
         movehogDOWN = 15;
          break;
        case LEFT :
        leftPressed = true;
        movehogLEFT = 15;
          break;
        case RIGHT:
        rightPressed = true;
        movehogRIGHT = 15;
        break;     

      }
    }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased() {
  if (key == CODED) {
      switch( keyCode )
      { 
        case UP :
        upPressed = false;
        break;
        case DOWN :
        downPressed = false;
        break;
        case LEFT :
        leftPressed = false;
        break;
        case RIGHT :
        rightPressed = false ;
        break;
      }
    }
  }
