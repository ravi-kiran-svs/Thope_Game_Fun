int rS=200;
int flo=0;
int t=0,time=0;
int Rx=0,Ry=0;
int Rd=0,Rs=0;
boolean move=false;
boolean showR=false;
int score=-1;
IntDict hScore;

void setup()
{
  //size(800,600);
  fullScreen();
  frameRate(30);
  textAlign(CENTER);
  textSize(20);
  
  hScore = new IntDict();
  //hScore.set  ("highS",0);
}

void draw()
{
  background(0);
  stroke(255);
  noFill();
  translate(width/2,height/2);

  room(Rx,Ry);
  lamp(flo);

  flo++;
  if(flo==10)  flo=0;

  player(t);

  if((keyPressed&&move)||move)
  {
    if(t==0)
    {
      Rx-=20;
      if(Rx<-100)  Rx=100;
      if(Rx==0)    move=false;
    }
    if(t==1)
    {
      Ry-=20;
      if(Ry<-100)  Ry=100;
      if(Ry==0)    move=false;
    }
    if(t==2)
    {
      Rx+=20;
      if(Rx>100)  Rx=-100;
      if(Rx==0)    move=false;
    }
    if(t==3)
    {
      Ry+=20;
      if(Ry>100)  Ry=-100;
      if(Ry==0)    move=false;
    }
    
    printf();
  }
  
  if(keyPressed)  showR=true;
  if(showR==true)
  {
    Rd=(int)random(0,4);
    Rs=(int)random(0,4);
    if(Rs!=1) Rs=0;
  }
  if(Rd==0&&Rs==0)  {text("RIGHT",0,200);          showR=false;}
  if(Rd==1&&Rs==0)  {text("DOWN",0,200);           showR=false;}
  if(Rd==2&&Rs==0)  {text("LEFT",0,200);           showR=false;}
  if(Rd==3&&Rs==0)  {text("UP",0,200);             showR=false;}
  if(Rd==0&&Rs==1)  {text("NOT RIGHT",0,200);      showR=false;}
  if(Rd==1&&Rs==1)  {text("NOT DOWN",0,200);       showR=false;}
  if(Rd==2&&Rs==1)  {text("NOT LEFT",0,200);       showR=false;}
  if(Rd==3&&Rs==1)  {text("NOT UP",0,200);         showR=false;}
  
  time++;
  timer(time);
}

void mousePressed()
{
  loop();
  time=0;
}

void keyPressed()
{
  if(move==false)
  {
         if(keyCode==RIGHT&&((Rs==0&&Rd==0)||(Rs==1&&Rd!=0)))
           {Rx-=20;  t=0;  move=true;}
    else if(keyCode==DOWN&&((Rs==0&&Rd==1)||(Rs==1&&Rd!=1)))
           {Ry-=20;  t=1;  move=true;}
    else if(keyCode==LEFT&&((Rs==0&&Rd==2)||(Rs==1&&Rd!=2)))
           {Rx+=20;  t=2;  move=true;}
    else if(keyCode==UP&&((Rs==0&&Rd==3)||(Rs==1&&Rd!=3)))
           {Ry+=20;  t=3;  move=true;}
    else   {gameOver();}
  }
  time=0;
}

void room(int Rx,int Ry)
{
  for(int i=Rx-100;i<200;i+=200)
  {
    line(i,-200,i,200);
  }

  for(int i=Ry-100;i<=200;i+=200)
  {
    line(-200,i,200,i);
  }
}

void lamp(int flo)
{
  for(int i=flo+10;i<200;i+=10)
  {
    stroke(255,(100-i/2));
    ellipse(0,0,sqrt(5)*i,sqrt(5)*i);
  }
  stroke(255);
}

void player(float t)
{
  fill(255);
  ellipse(0,0,30,30);
  t*=PI/2;
  triangle(-15*sin(t),15*cos(t),
            15*sin(t),-15*cos(t),
            30*cos(t),30*sin(t));
}

void timer(int t)
{
  if(t==1)  score++;
  fill(255,0,0);
  rect(-width/2,-height/2,width*t/40,10);
  fill(255);
  text("Score:  "+score,0,300);
  if(t==40)  gameOver();
}

void printf()
{
  print(Rd);
  print(" ");
  print(t);
  print(" ");
  print(time);
  print(" ");
  println(move);
}

void gameOver()
{
  if  (!hScore.hasKey("highS"))  hScore.set  ("highS",0);
  else  {
    if  (score > hScore.get("highS"))  hScore.set  ("highS",score);
  }
  
  noLoop();
  background(255,100,0);
  fill(255);
  text("GAME_OVER\nPress mouse to continue.\n"+
  "High Score:"+hScore.get("highS")+
  "\nScore:"+score,0,0);
  score=-1;
}