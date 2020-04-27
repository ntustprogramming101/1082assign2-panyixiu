
PImage bg;
PImage cabbage;
PImage gameover;
PImage groundhog;
PImage groundhogD;
PImage groundhogL;
PImage groundhogR;
PImage lifeImg;
PImage restartHovered;
PImage restartNormal;
PImage startHovered;
PImage startNormal;
PImage soil;
PImage soldier;
PImage title;

final int GRID = 80;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 360+60;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 248+144;

int soldierSpeed,soldierY;
int soldierWidth = 40;


int cabbageX,cabbageY;
int life = 2;
int lifeX = 10; 
int lifeY = 10;
int lifeSpacing = 70;
int actionFrame;  //groundhog's moving frame

float groundhogX = GRID*4; 
float groundhogY = GRID;
float groundhogLestX, groundhogLestY;
float lastTime; //time when the groundhog finished moving

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int gameState = 0;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogD = loadImage("img/groundhogDown.png");
  groundhog = loadImage("img/groundhogIdle.png");
  groundhogL = loadImage("img/groundhogLeft.png");
  groundhogR = loadImage("img/groundhogRight.png");
  soil = loadImage("img/soil.png");
  lifeImg = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  
  //cabbage position
  cabbageX = floor(random(0,8))*80;
  cabbageY = (floor(random(0,4))+2)*80;
  
  soldierY = (floor(random(4))+1)*80+80; //soldier's Y position
  soldierSpeed = 3;
  
  
  gameState = GAME_START;
  
}

void draw() {
  
	// Game Start
  switch( gameState ){
    
    case GAME_START:
        image(title,0,0);
        image(startNormal, 248,360);
        //mouse action
        if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT 
        && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
          if(mousePressed){
            gameState = GAME_RUN;
           }else{
            image(startHovered,248,360);
           
          }
        }
        break;
        
    // Game Run
    case GAME_RUN:
    
        //background
        background(bg); 
      
        //soil
        image ( soil ,0 ,160); 
        
        //grass
        colorMode(RGB);
        fill(124,204,25);
        noStroke();
        rect(0,145,640,15);
        
        //sun
        fill(255,255,0);
        ellipse(640-50,50,130,130);  
        fill(253,184,19);
        ellipse(640-50,50,120,120);
        
        //lives
        for(int i = 0 ; i < life ; i++ ){
          lifeX = 10 + i*lifeSpacing;
          image(lifeImg,lifeX,lifeY);
        }
        
        //groundhog range
        if( groundhogX <=0){
          groundhogX=0;
        }
        if( groundhogX >= width-80){
          groundhogX=width-80;
        }
        if( groundhogY >= height-80){
          groundhogY = height-80;
        }
        
        //groundhog action
        if (downPressed == false && leftPressed == false && rightPressed == false) {
          image(groundhog, groundhogX, groundhogY);
        }
        
        if (downPressed) {
          actionFrame++;
          if (actionFrame > 0 && actionFrame < 15) {
            groundhogY += GRID / 15.0;
            image(groundhogD, groundhogX, groundhogY);
          } else {
            groundhogY = groundhogLestY + GRID;
            downPressed = false;
          }
        }
        //draw the groundhogLeft image between 1-14 frames
        if (leftPressed) {
          actionFrame++;
          if (actionFrame > 0 && actionFrame < 15) {
            groundhogX -= GRID / 15.0;
            image(groundhogL, groundhogX, groundhogY);
          } else {
            groundhogX = groundhogLestX - GRID;
            leftPressed = false;
          }
        }
        //draw the groundhogRight image between 1-14 frames
        if (rightPressed) {
          actionFrame++;
          if (actionFrame > 0 && actionFrame < 15) {
            groundhogX += GRID / 15.0;
            image(groundhogR, groundhogX, groundhogY);
          } else {
            groundhogX = groundhogLestX + GRID;
            rightPressed = false;
          }
        }
        
        //touch soldier
        if( groundhogX+80 > soldierSpeed - soldierWidth && groundhogX < soldierSpeed - soldierWidth+80 && groundhogY < soldierY+80 && groundhogY+80 > soldierY ){
          life -= 1;
          groundhogX = GRID*4;
          groundhogY = GRID;
        }
        if( life == 0){
          gameState = GAME_LOSE;
        }
        //touch cabbage
        if( groundhogX+80 > cabbageX && groundhogX < cabbageX+80 && groundhogY < cabbageY+80 && groundhogY+80 > cabbageY ){
          life +=1;
          cabbageX = cabbageY =640;
        }
        
        soldierSpeed += 6; // x=x+6
        //soldierSpeed %= 800;
        
        //Soldier's position
        image(soldier,soldierSpeed - soldierWidth ,soldierY);
        if(soldierSpeed - soldierWidth >= 800){
          soldierSpeed =-50;
          soldierY = (floor(random(4))+1)*80+80; //soldier's Y position
        }
        
       //cabbage
        image(cabbage, cabbageX, cabbageY);
        
        if(life == 0){
          gameState = 2;
        }
        break;
       
		// Game Lose
    case GAME_LOSE:
      image(gameover,0,0);
      image(restartNormal,BUTTON_LEFT,BUTTON_TOP);
      
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT &&
      mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered,BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed){
          downPressed =false;
          leftPressed = false;
          rightPressed = false;
          soldierSpeed = 0;
          soldierY = floor(random(4))*GRID + GRID*2;
          soldierSpeed = 3;
          cabbageX = floor(random(8))*GRID;
          cabbageY = floor(random(4))*GRID + GRID*2;
          life = 2;
          groundhogX = GRID*4;
          groundhogY = GRID;
          
          
          gameState = 0;
        }
      }
        break;
        
      default:
  }
    
}

void keyPressed(){
  float newTime = millis(); //time when the groundhog started moving
  if (key == CODED) {
    switch (keyCode) {
      
      case DOWN:
        if (newTime - lastTime > 250) {
          downPressed = true;
          actionFrame = 0;
          groundhogLestY = groundhogY;
          lastTime = newTime;
        }
        break;
      case LEFT:
        if (newTime - lastTime > 250) {
          leftPressed = true;
          actionFrame = 0;
          groundhogLestX = groundhogX;
          lastTime = newTime;
        }
        break;
      case RIGHT:
        if (newTime - lastTime > 250) {
          rightPressed = true;
          actionFrame = 0;
          groundhogLestX = groundhogX;
          lastTime = newTime;
        break;
        }
    }
  }
}
