PImage gamebg,green, winimage,bg,red,ball,wall; //<>// //<>// //<>// //<>// //<>// //<>//
PImage img;
int scene = 1;
PFont f;


//Game opening
/*
 1=start
 2=block
 3=goal
 4=death
 5=key Piece
 6=door
 7=bounce pad
 8=block to invis
 9=invis to block
 u=up gravity;
 r=right gravity
 d=down gravity
 l=left gravity
 g=gate (key required)
 k=key (used to open gate)
 h=slow block
 */

Player p;
int u=10;
int r=11;
int d=12;
int l=13;
int g=14;
int k=15;
int h=16;
int hitboxCheck=2;
int[][][] level= 
  { 
  //lvl 4
   {{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2}, 
 {2, r, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, d, 2}, 
 {2, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 5, 2}, 
 {2, 5, 2, r, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, d, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, r, 5, 5, 5, 5, 5, 5, 5, 5, d, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 2, 2, 2, 2, 2, 2, 2, 5, 2, 5, 2, 5, 2},
 {2, 5, 2, 5, 2, 5, 2, r, 5, 5, 5, 5, d, 2, 5, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 5, 2, 2, 2, 2, 5, 2, 5, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 5, 2, r, d, 2, 5, 2, 5, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 5, 2, 5, 6, 2, 5, 2, 5, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 5, 2, 5, 2, 2, 5, 2, 5, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 5, 2, u, 5, 5, l, 2, 5, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 5, 2, 2, 2, 2, 2, 2, 5, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, u, 5, 5, 5, 5, 5, 5, l, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 5, 2, 5, 2}, 
 {2, 5, 2, 5, 2, u, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, l, 2, 5, 2}, 
 {2, 1, 2, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 5, 2}, 
 {2, u, 2, u, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, l, 2}, 
 {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2}},
  
  
};

float slide=0.9;  //used to produce sliding effect once key is released
int win=0;
int levels=0;
int d_d=0;  //left
int a_a=0;  //right
int s_s=0;  //down
int w_w=0;  //up
int s_sp=0;  //space bar
int[] key_log;
int alph;
int[] skip={1,3,1,3,2,4,2,4,5,5};  //skip sequence

float[] ball_size={10};
int mode=1;  //ball movement direction


void setup() {
  //fullScreen();
  size(650, 700);
  ball_size[0] = height/(2*level[0].length);

  key_log=new int[10];
  p=new Player();
  p.prep();
  frameRate(60);
  green = loadImage("g1 replacement.png");
  red = loadImage("red.png");
  winimage = loadImage("win.jpeg");
  bg = loadImage("dp2.png");
  wall = loadImage("wall 2.png");
  gamebg = loadImage("g1 replacement.png");
  winimage.resize(width,height);
  gamebg.resize(width,height);

  ball = loadImage("g.png");
  f = createFont("sakers.ttf", 24);
  textFont(f);

}


void draw() {
  if (scene ==1){
    scene1();
  }
  else{
    //background(#3c0f46);
    //background(#fffcf9);
    background(241,236,228);
    //background(gamebg);
  background(winimage);
    p.move();
    p.show();
    if(key_log[0]==skip[0]&&key_log[1]==skip[1]&&key_log[2]==skip[2]&&key_log[3]==skip[3]&&key_log[4]==skip[4]&&key_log[5]==skip[5]&&key_log[6]==skip[6]&&key_log[7]==skip[7]
    &&key_log[8]==skip[8]&&key_log[9]==skip[9]){
      win=1;
      key_log=new int[10];
    }
    if (win==1) {
      levels++;
      if (levels==level.length) {
        //println(millis());
        winimage.resize(width,height);
        image(gamebg,0,0);
        //delay(3000);
        int wait =0;
        while(wait<2000){wait++;}
        image(winimage,0,0);
        
        noLoop();
      }
      levels=levels%level.length;
      win=0;
      p.prep();
    }
  }
}

void scene1(){
    background (0);
    bg.resize(width,height);
    image(bg,0,0);
        textAlign(CENTER, CENTER);
    fill(2);
    textSize(width/10);
    text("What Movie Next?", width/2 + 0, height/4);
    textSize(height/15);
    text("How to Play", width/2 + 0, height/2.2);
    text("Click to continue", width/2, height/2 +150);

    textSize(height/21);
    text("  Move the ball using arrow keys", width/2 + 0, height/2 + 40);
    text("Collect all flowers", width/2, height/2 + 80);

 
}


class Player {
  PVector pos;
  PVector vel=new PVector(0, 0);
  PVector acc=new PVector(0, 0);
  PVector maxvel;
  int p=0;
  int sd=1;
  //movement speed
  float mm=5;
  //gravity
  float g=1;
  float hg=0;
  float bounce=0.5;
  float bounce_2=1.5;

  //creates maze
  void show() {
    //fill(0, 255, 0);
    fill(#bf391f);
    //noStroke();
    ball.resize(int(ball_size[levels]), int(ball_size[levels]));
    image(ball,pos.x, pos.y);
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        noFill();
        noStroke();
        //walls
        if (level[levels][i][j]==2) {
            //background(48,40,48);
          //fill(48,40,48);
          fill(#474747);
          //stroke(48,40,48);
          //fill(#EFE3EA);
          //stroke(#EFE3EA);
        } else if (level[levels][i][j]==3) {
           fill(0, 255, 0, 100);
          //fill(#547980,100);
          stroke(0, 255, 0, 100);
          //deathbox
        } else if (level[levels][i][j]==4) {
          fill(#ff6978);
          //stroke(255, 0, 0);
        } else if (level[levels][i][j]==5) {
          fill(0, 0, 0, 100);
          stroke(255, 255, 0, 100);
          //locked door
        } else if (level[levels][i][j]==6) {
          fill(#4f6367);
          //stroke(0, 0, 255, 100);
        } else if (level[levels][i][j]==7) {
          fill(0, 255, 255, 100);
          stroke(0, 255, 255, 100);
        } else if (level[levels][i][j]==8) {
          fill(180, 100, 100);
          stroke(180, 100, 100);
        } else if (level[levels][i][j]==9) {
          fill(180, 100, 50, 100);
          stroke(180, 100, 50, 100);
        } else if (level[levels][i][j]==14) {
          fill(100, 25, 25);
          stroke(100, 25, 25);
        } else if (level[levels][i][j]==15) {
          fill(255, 225, 125);
          stroke(255, 225, 125);
        } else if (level[levels][i][j]==16) {
          fill(0);
          stroke(0);
        } else {
          noFill();
          noStroke();
        }
        int xaxis = width/level[levels][i].length;
        int yaxis = height/level[levels][i].length;
        if (level[levels][i][j]==5 || level[levels][i][j]==10 ||level[levels][i][j]== 11 || level[levels][i][j]== 12 || level[levels][i][j]== 13 ||level[levels][i][j]== 6){
          //tint( 185,143,238);
          //int rex = xaxis/2;
          green.resize(xaxis,yaxis);
          //green.resize(rex,rex);
          imageMode(CENTER);
          fill(255);
          //tint(#16b137);
          //rect((xaxis)*j, (yaxis)*i, xaxis, yaxis-1);
          //image(green,(xaxis)*j+(xaxis/2), (yaxis)*i+(yaxis/2));
          image(green,(xaxis)*j+(xaxis/2), (yaxis)*i+(yaxis/2));
          noTint();
     
        }
        else if(level[levels][i][j]==4){
        red.resize(xaxis, yaxis);
          imageMode(CENTER);  
          //rect((xaxis)*j, (yaxis)*i, xaxis, yaxis-1);
          tint(227,99,78);
          image(red,(xaxis)*j+(xaxis/2), (yaxis)*i+(yaxis/2));
          noTint();

        }
        else if(level[levels][i][j]==2){
        wall.resize(xaxis, yaxis);
          imageMode(CENTER);  
          //rect((xaxis)*j, (yaxis)*i, xaxis, yaxis-1);
          //tint(#456367);
          image(wall,(xaxis)*j+(xaxis/2), (yaxis)*i+(yaxis/2));
          
        }
        else if (level[levels][i][j]!=0){
          
        rect((xaxis)*j, (yaxis)*i, xaxis, yaxis);}
      }
      imageMode(CORNER);
    }
  }
//
  void prep() {
    //sets limits on velocity of the ball
    maxvel=new PVector(ball_size[levels]/2, ball_size[levels]/2);
    //figures out the initial position of ball on the grid and sets ball location
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        if (level[levels][i][j]==1) {
          //sets position by dividing the screen width and height to figure out how to where the ball will be located on screen
          pos=new PVector((width/level[levels][i].length)*j+(width/level[levels][i].length)/2, (height/level[levels].length)*i+(height/level[levels].length)/2);
          vel.x=0;
          vel.y=0;
          g=1;
          //horizontal gravity (1 = on, 0 =off)
          hg=0;
          return;
        }
      }
    }
  }
  
   
  void move() {
    //used to produce slide effect
    if (keyPressed==false) {
      if (g!=0) {
        float save=vel.y;
        vel.set(vel.x*slide, save);
      } else {
        float save=vel.x;
        vel.set(save, vel.y*slide);
      }
    }
    
    
    PVector att=new PVector(pos.x, pos.y);  //added to ball position vector to move it around
    int k=0;
    //adds movement value to move ball in respective direction
    if ((d_d==1)&&(g!=0)) {
      att.add(mm, 0);
      att.sub(pos);
      k=1;
    }
    if ((a_a==1)&&(g!=0)) {
      att.add(-mm, 0);
      att.sub(pos);
      k=1;
    }
    if ((w_w==1)&&(hg!=0)) {
      att.add(0, -mm);
      att.sub(pos);
      k=1;
    }
    if ((s_sp==1)&&(hg!=0)) {
      att.add(0, mm);
      att.sub(pos);
      k=1;
    }
    if ((s_s==1)&&(sd==1)) {
      g*=-1;
      hg*=-1;
      sd=0;
    }
    //if no key is pressed, sets att to zero vector so that it doesnt make changes to ball position
    if (k==0) {
      att.sub(pos);
    }
    
    //accelerates the ball if pressed for long
    if (g!=0) {
      acc.set(att.x, 0);
    } else {
      acc.set(0, att.y);
    }
    
    if (mode==0) {
      acc.add(hg, g);
    }
    
    
    acc.setMag(0.5);
    if (mode==1) {
      acc.add(hg, g);
    }
    
    //keeps velocity of ball in boundaries
    vel.add(acc);
    if (vel.x>maxvel.x) {
      vel.x=maxvel.x;
    }
    if (vel.y>maxvel.y) {
      vel.y=maxvel.y;
    }
    if (vel.x<-maxvel.x) {
      vel.x=-maxvel.x;
    }
    if (vel.y<-maxvel.y) {
      vel.y=-maxvel.y;
    }
    
    //stops from passing through walls
    vel.div(hitboxCheck);
    for (int lo=0; lo<hitboxCheck; lo++) {
      pos.add(vel);
      hitbox();
    }
    //resets if you go out of bounds
    vel.mult(hitboxCheck);
    if (pos.x<0) {
      prep();
    }
    if (pos.x>width) {
      prep();
    }
    if (pos.y<0) {
      prep();
    }
    if (pos.y>height) {
      prep();
    }
    
    //goal reached
    int gs=0;
    
    //locks door if key present in level
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        if (level[levels][i][j]==5) {
          gs=1;
        }
      }
    }
  
    if (gs==0) {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if (level[levels][i][j]==6) {
            level[levels][i][j]=3;
          }
        }
      }
    } else {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if (level[levels][i][j]==3) {
            level[levels][i][j]=6;
          }
        }
      }
    }
    
    
    
 
    //changes state of inv to blocked and vice versaa gate
    if (frameCount%60==0) {
      for (int i=0; i<level[levels].length; i++) {
        for (int j=0; j<level[levels][i].length; j++) {
          if ((level[levels][i][j]==9)||(level[levels][i][j]==8)) {
            if (level[levels][i][j]==8) {
              level[levels][i][j]=9;
            } else {
              level[levels][i][j]=8;
            }
          }
        }
      }
    }
  }
  
  
  //decides how ball interacts with different components
  void hitbox() {
    for (int i=0; i<level[levels].length; i++) {
      for (int j=0; j<level[levels][i].length; j++) {
        //block : stops ball from going through blocks
        if ((level[levels][i][j]==2)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==2)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==2)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        if ((level[levels][i][j]==2)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        //change block
        if ((level[levels][i][j]==8)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==8)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          vel.y*=-bounce;
        }
        if ((level[levels][i][j]==8)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        if ((level[levels][i][j]==8)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
        }
        //death
        //resets game
        if ((level[levels][i][j]==4)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }
        if ((level[levels][i][j]==4)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }
        if ((level[levels][i][j]==4)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }
        if ((level[levels][i][j]==4)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          for (int l=0; l<level[levels].length; l++) {
            for (int o=0; o<level[levels][l].length; o++) {
              if (level[levels][l][o]==-1) {
                level[levels][l][o]=5;
              }
              if (level[levels][l][o]==-15) {
                level[levels][l][o]=15;
              }
            }
          }
          g=1;
          hg=0;
          prep();
          vel.set(0, 0);
        }

        //goal

        if ((level[levels][i][j]==3)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==3)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==3)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }
        if ((level[levels][i][j]==3)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          win=1;
          g=1;
          hg=0;
        }

        //key
        if ((level[levels][i][j]==5)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }
        if ((level[levels][i][j]==5)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }
        if ((level[levels][i][j]==5)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }
        if ((level[levels][i][j]==5)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          level[levels][i][j]=-1;
        }

        //bounce pad
        if ((level[levels][i][j]==7)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          vel.y=-maxvel.y;
          vel.y*=bounce_2;
        }
        if ((level[levels][i][j]==7)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          vel.y=maxvel.y;
          vel.y*=bounce_2;
        }
        if ((level[levels][i][j]==7)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          vel.x=-maxvel.x;
          vel.x*=bounce_2;
        }
        if ((level[levels][i][j]==7)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          vel.x=maxvel.x;
          vel.x*=bounce_2;
        }
         //gravity change

        //change up
        if ((level[levels][i][j]==10)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==10)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==10)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==10)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=-1;
          hg=0;
          level[levels][i][j]= 5;
        }
        //change right
        if ((level[levels][i][j]==11)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==11)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==11)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==11)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=1;
          level[levels][i][j]= 5;
        }
        //change down
        if ((level[levels][i][j]==12)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==12)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==12)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==12)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=1;
          hg=0;
          level[levels][i][j]= 5;
        }
        //change left
        if ((level[levels][i][j]==13)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==13)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==13)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==13)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          g=0;
          hg=-1;
          level[levels][i][j]= 5;
        }
        //gate
        if ((level[levels][i][j]==14)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          vel.y*=-bounce;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==14)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          vel.y*=-bounce;
          level[levels][i][j]= 5;
        }
     
        if ((level[levels][i][j]==14)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
          level[levels][i][j]= 5;
        }
        if ((level[levels][i][j]==14)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          vel.x*=-bounce;
          level[levels][i][j]= 5;
        }
        //gate key
        if ((level[levels][i][j]==15)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        if ((level[levels][i][j]==15)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        if ((level[levels][i][j]==15)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        if ((level[levels][i][j]==15)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          if (level[levels][i][j]>0) {
            level[levels][i][j]*=-1;
          }
        }
        //halt
        if ((level[levels][i][j]==16)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y+(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y+(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*i-(ball_size[levels]/2+1));
          bounce/=10;
          vel.y*=-bounce;
          bounce*=10;
          vel.x*=bounce;
        }
        if ((level[levels][i][j]==16)&&(pos.x>=(width/level[levels][i].length)*j)&&(pos.x<=(width/level[levels][i].length)*(j+1))&&
          (pos.y-(ball_size[levels]/2+1)>=(height/level[levels].length)*i)&&(pos.y-(ball_size[levels]/2+1)<=(height/level[levels].length)*(i+1))) {
          pos.set(pos.x, (height/level[levels].length)*(i+1)+(ball_size[levels]/2+1));
          bounce/=10;
          vel.y*=-bounce;
          bounce*=10;
          vel.x*=bounce;
        }
        if ((level[levels][i][j]==16)&&(pos.x+(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x+(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*j-(ball_size[levels]/2+1), pos.y);
          bounce/=10;
          vel.x*=-bounce;
          bounce*=10;
          vel.y*=bounce;
        }
        if ((level[levels][i][j]==16)&&(pos.x-(ball_size[levels]/2+1)>=(width/level[levels][i].length)*j)&&(pos.x-(ball_size[levels]/2+1)<=(width/level[levels][i].length)*(j+1))&&
          (pos.y>=(height/level[levels].length)*i)&&(pos.y<=(height/level[levels].length)*(i+1))) {
          pos.set((width/level[levels][i].length)*(j+1)+(ball_size[levels]/2+1), pos.y);
          bounce/=10;
          vel.x*=-bounce;
          bounce*=10;
          vel.y*=bounce;
        }
      }
    }
  }
}



//adds input to key log array
void key_logAdd(int num){
  int[] temp_key;
  temp_key=new int[10];
  for(int i=1;i<temp_key.length;i++){
    temp_key[i-1]=key_log[i];
  }
  temp_key[temp_key.length-1]=num;
  key_log=temp_key;
}


//logs inputs to check for skip levels
//key press released
void keyReleased() {
  if (key==' ') {
    s_s=0;
    p.sd=1;
  }
  if (key=='a') {
    a_a=0;
    key_logAdd(2);
  }
  if (key=='w') {
    w_w=0;
    key_logAdd(1);
  }
  if (key=='s') {
    s_sp=0;
    key_logAdd(3);
  }
  if (key=='d') {
    d_d=0;
    key_logAdd(4);
  }
  if (key=='A') {
    a_a=0;
    key_logAdd(2);
  }
  if (key=='W') {
    w_w=0;
    key_logAdd(1);
  }
  if (key=='S') {
    s_sp=0;
    key_logAdd(3);
  }
  if (key=='D') {
    d_d=0;
    key_logAdd(4);
  }
  if (keyCode==LEFT) {
    a_a=0;
    key_logAdd(2);
  }
  if (keyCode==RIGHT) {
    d_d=0;
    key_logAdd(4);
  }
  if (keyCode==UP) {
    w_w=0;
    key_logAdd(1);
  }
  if (keyCode==DOWN) {
    s_sp=0;
    key_logAdd(3);
  }
  if(key=='r' || key=='R'){
    key_logAdd(5);
  }
}

//key pressed
void keyPressed() {
  if (key==' ') {
    s_s=1;
  }
  if (key=='r') {
    p.prep();
  }
  if (key=='R') {
    p.prep();
  }
  if (key=='a') {
    a_a=1;
  }
  if (key=='d') {
    d_d=1;
  }
  if (key=='w') {
    w_w=1;
  }
  if (key=='s') {
    s_sp=1;
  }
  if (key=='A') {
    a_a=1;
  }
  if (key=='D') {
    d_d=1;
  }
  if (key=='W') {
    w_w=1;
  }
  if (key=='S') {
    s_sp=1;
  }
  if (keyCode==LEFT) {
    a_a=1;
  }
  if (keyCode==RIGHT) {
    d_d=1;
  }
  if (keyCode==UP) {
    w_w=1;
  }
  if (keyCode==DOWN) {
    s_sp=1;
  }
}

void mouseClicked(){
  if (scene == 1){
  scene = 2;
  }
}
