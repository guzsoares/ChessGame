/* Game Configs */
GameState test;
int h_window = 600;
int w_window = 600;
int dimension = 8;
int sq_size = h_window/dimension;

/* Images variables */
PImage bR;
PImage bP;
PImage bQ;
PImage bN;
PImage bB;
PImage bK;
PImage wR;
PImage wP;
PImage wQ;
PImage wN;
PImage wB;
PImage wK;

void setup(){
  size(600,600);
  frameRate(15);
  test = new GameState();
  loadImages();
}

void draw(){
  drawSquares();
  drawPieces();
  
  
  
}


void drawSquares(){
  background(118,150,86);
  for (int i = 0; i < 8; i++){
    for (int j = 0; j < 8; j++){
      if ((i+j) % 2 == 1){
        fill(238,238,210);
        square(i*sq_size,j*sq_size,sq_size);
      }
    }
  }
}

void drawPieces(){
  for (int i = 0; i < 8; i++){
    for (int j = 0; j < 8; j++){
      if(test.board[j][i] == "bR"){
        image(bR, i*sq_size, j*sq_size);
      }
      else if(test.board[j][i] == "bP"){
        image(bP, i*sq_size, j*sq_size);
      }
      else if(test.board[j][i] == "bN"){
        image(bN, i*sq_size, j*sq_size);
      }
      else if(test.board[j][i] == "bQ"){
        image(bQ, i*sq_size+2, j*sq_size);
      }
      else if(test.board[j][i] == "bK"){
        image(bK, i*sq_size+2, j*sq_size);
      }
      else if(test.board[j][i] == "bB"){
        image(bB, i*sq_size, j*sq_size);
      }
      else if(test.board[j][i] == "wP"){
        image(wP, i*sq_size, j*sq_size);
      }
      else if(test.board[j][i] == "wN"){
        image(wN, i*sq_size, j*sq_size);
      }
      else if(test.board[j][i] == "wQ"){
        image(wQ, i*sq_size+2, j*sq_size);
      }
      else if(test.board[j][i] == "wK"){
        image(wK, i*sq_size+2, j*sq_size);
      }
      else if(test.board[j][i] == "wB"){
        image(wB, i*sq_size, j*sq_size);
      }
      else if(test.board[j][i] == "wR"){
        image(wR, i*sq_size, j*sq_size);
      }
    }
  }
}
void loadImages(){
  bR = loadImage("images/bR.png");
  bR.resize(0,sq_size - 5);
  wR = loadImage("images/wR.png");
  wR.resize(0,sq_size - 5);
  bN = loadImage("images/bN.png");
  bN.resize(0,sq_size - 5);
  wN = loadImage("images/wN.png");
  wN.resize(0,sq_size - 5);
  bQ = loadImage("images/bQ.png");
  bQ.resize(0,sq_size - 5);
  wQ = loadImage("images/wQ.png");
  wQ.resize(0,sq_size - 5);
  bK = loadImage("images/bK.png");
  bK.resize(0,sq_size - 5);
  wK = loadImage("images/wK.png");
  wK.resize(0,sq_size - 5);
  bB = loadImage("images/bB.png");
  bB.resize(0,sq_size - 5);
  wB = loadImage("images/wB.png");
  wB.resize(0,sq_size - 5);
  wP = loadImage("images/wP.png");
  wP.resize(0,sq_size - 5);
  bP = loadImage("images/bP.png");
  bP.resize(0,sq_size - 5);
}
