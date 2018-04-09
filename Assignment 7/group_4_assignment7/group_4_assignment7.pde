Trajectory mass1;
Target target1;
Button continueButton;
Button quitButton;
Button resetButton;
Button endButton;
PImage court;


float x,y,xo,yo,vxo,vyo,t,targetX,targetY;
int gameState,prevState,playerNum,score1,score2;
void setup(){
  gameState = 4;
  xo = 10;
  yo = 490;
  vxo = 10;
  vyo = 10;
  x=0;
  score1 = 0;
  score2 = 0;
  targetX = 475;
  targetY = 300;
  playerNum = 1;
  size(500,500);
  background(95);
  mass1 = new Trajectory(0,250,xo,yo,10,10,targetX,targetY);
  target1 = new Target(targetX,targetY);
  continueButton = new Button(200,200,110,20,"Click to Continue");
  quitButton = new Button(200,300,100,20,"Click to Quit");
  resetButton = new Button(200,350,120,20,"Click to Play Again");
  endButton = new Button(200,300,100,20,"Click to Quit");
  court = loadImage("basketball_court.jpg");
}

void draw(){
  
  
  
  if (gameState == 0) {
    background(court);
    target1.displayTarget();
  }
  
  
  if (gameState == 1) {
    background(court);
    line(xo,yo,mouseX,mouseY); 
  } 
  if (gameState == 2){
    background(court);
    t+=.5;
    mass1.displayProjectile();
    y = mass1.moveProjectile(t);
    target1.displayTarget();
    
    if (mass1.checkTarget()){
      gameState = 0;
      if (playerNum == 1){
        score1++;
      }
      if (playerNum == 2){
        score2++;
      }
    }
    
    if (mass1.checkMiss()){
      gameState = 0;
    }
  }
  
  if(gameState == 3){
    background(court);
    continueButton.showButton();
    quitButton.showButton();
  }
  
  if (gameState==4){
    background(12,123,21);
    textSize(10);
    text("Instructions", 10, 30); 
    text("1: Player 1 will use the arrow keys to move the target in any direction.", 10, 60); 
    text("   Once you have selected a place hit the ENTER button.", 10, 90); 
    text("2: Now Player 2 will use the Mouse or trackpad to aim.", 10, 120); 
    text("   One you are done aiming click to shoot", 10, 150); 
    text("3: Once you have shot the roles for each player switch. If your shot is good, your score will go up.", 10, 180);
    text("4: First to 5 points wins!", 10, 210); 
    text("5: Press the 'P' button at any time to pause the game", 10, 240); 
    text("6: Press the 'S' to start the game!", 10, 270); 

    
    
    //fill(0, 102, 153);
  }
 
   if (gameState != 4){
    rectMode(CORNER);
    fill(color(#D3D3D3));
    rect(0,0,499,25);
    fill(color(#FFFFFF));
    rect(0,25,499,2);
    fill(0);
    textSize(20);
   
    if (playerNum == 1){
      text("Player 1",15,20);
      text(score1,460,20);
    }
    if (playerNum == 2){
      text("Player 2",15,20);
      text(score2,460,20);
    }
    text("Score: ",400,20);
    
    textSize(10);
  }
  
  if (score1 > 4){
    gameState  = 5;
    textSize(50);
    text("Player 1 Wins!",30,250);
    textSize(10);
    
  }
  
  if (score2 > 4){
    gameState  = 5;
    textSize(50);
    text("Player 2 Wins!",30,250);
    textSize(10);
  }
  
  if (gameState == 5){
    resetButton.showButton();
    endButton.showButton();
  }
 
  
  target1.displayTarget();
}


void mousePressed(){
  if (gameState == 1){
    float theta = atan((yo-mouseY)/(mouseX-xo));
    vxo = abs(mouseX-xo)*.1*cos(theta)*.9;
    vyo = abs(yo-mouseY)*.1*sin(theta)*.9;
    mass1 = new Trajectory(xo,yo,xo,yo,vxo,vyo,targetX,targetY);
    t=0;
    x=0;
    gameState = 2;
  }
  
  
  if (gameState == 3){
    if (continueButton.checkPress()){
      gameState = prevState;
      if (prevState ==3){
        gameState =0;
      }
    }
    
    if (quitButton.checkPress()){
      exit();
     
    }
  }
  
  if (gameState == 5){
    if (resetButton.checkPress()){
      score1 = 0;
      score2 = 0;
      playerNum = 1;
      gameState = 0;
    }
    if (endButton.checkPress()){
      exit();
     
    }
  }
   
    }


void keyPressed(){
  if (gameState == 0){
    if (key == CODED){
      if (keyCode == UP){
        if (targetY > 10){
          targetY-=5;
          target1 = new Target(targetX,targetY);
        }
      }
      if (keyCode == DOWN){
        if (targetY < 490){
          targetY+=5;
          target1 = new Target(targetX,targetY);
        }
      }
    }
    if (key == ENTER || key == RETURN){
        gameState =1;
        if (playerNum == 1){
          playerNum = 2;
        }
        else{
          playerNum = 1;
        }
      }
  }
  
  if (key == 'p'){
    prevState = gameState;
    gameState = 3;
  }
  
  if (key == 's'){
    gameState = 0;
  }
  
}
