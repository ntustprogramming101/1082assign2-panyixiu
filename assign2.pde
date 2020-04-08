



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

int soldierSpeed,floorS;
int soldierWidth = 40;
int grid = 80;
int x = grid*4;
int y = grid;
int cabbageX,cabbageY;
int life = 2;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

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
  
  floorS = (floor(random(4))+1)*80+80; //soldier's Y position
  soldierSpeed = 0;
}

void draw() {
	// Game Start
  switch( gameState ){
    case GAME_START:
        image(title,0,0);
        image(startNormal, 248,360);
        
        
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
        
        //2 lives
        image ( lifeImg ,10 ,10);
        image ( lifeImg ,80 ,10);
        
        //groundhog
        image ( groundhog , x ,y);
        
        //groundhog range
        if( x <=0){
          x=0;
        }
        if( x >= width-80){
          x=width-80;
        }
        if( y >= height-80){
          y = height-80;
        }
        
        //touch soldier
        if( x+80 > soldierSpeed - soldierWidth && x < soldierSpeed - soldierWidth+80 && y < floorS+80 && y+80 > floorS ){
          life -= 1;
          x = grid*4;
          y = grid;
        }
        if( life == 0){
          gameState = GAME_LOSE;
        }
        //touch cabbage
        if( x+80 > cabbageX && x < cabbageX+80 && y < cabbageY+80 && y+80 > cabbageY ){
          life +=1;
          cabbageX = cabbageY =640;
        }
        
        //sun
        fill(255,255,0);
        ellipse(640-50,50,130,130);  
        fill(253,184,19);
        ellipse(640-50,50,120,120);
        
        soldierSpeed += 6; // x=x+6
        soldierSpeed %= 900;
        
        //Soldier's position
        image(soldier,soldierSpeed - soldierWidth ,floorS);
        
       //cabbage
        image(cabbage, cabbageX, cabbageY);
       
		// Game Lose
    case GAME_LOSE:
    
  }
}

void keyPressed(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        y -= grid;
        break;
      case DOWN:
        y += grid;
        break;
      case LEFT:
        x -= grid;
        break;
      case RIGHT:
        x += grid;
        break;
    }
  }
}

void keyReleased(){

}
