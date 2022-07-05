/* Game Configs */
GameState test;
int h_window = 600;
int w_window = 600;
int dimension = 8;
int sq_size = h_window/dimension;
int posx;
int posy;
PVector[] moveSelected = new PVector[2];
ArrayList<Move> validMoves;
boolean moveMade = false;

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
  strokeCap(PROJECT);
  strokeWeight(1.25);
  size(600,600);
  frameRate(15);
  test = new GameState();
  loadImages();
  moveSelected[0] = null;
  moveSelected[1] = null;
  validMoves = test.getValidMoves();
}

void draw(){
  drawSquares();
  drawPieces();
  movePiece();
  test.gameOver();
  
  
  
}


void drawSquares(){ // draw all squares
  background(118,150,86);
  for (int i = 0; i < 8; i++){
    for (int j = 0; j < 8; j++){
      if ((i+j) % 2 == 1){
        fill(238,238,210);
        square(i*sq_size,j*sq_size,sq_size);
      }
    }
  }
  
  if (moveSelected[0] != null){ //highlight move
    fill(255,100,100);
    square(moveSelected[0].x*sq_size,moveSelected[0].y*sq_size,sq_size);
    for (int i = (validMoves.size() - 1); i >= 0; i--){
      Move aux;
      aux = validMoves.get(i);
      if (aux.start_row == (int)moveSelected[0].x && aux.start_col == (int)moveSelected[0].y){
        fill(167,100,100);
        square(aux.end_row*sq_size,aux.end_col*sq_size,sq_size);
      }
    }
  }
  
}

void drawPieces(){ // draw all pieces
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
void loadImages(){ // load all images, only run once
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

void mouseReleased(){ // get mouse clicks
  posx = mouseX/sq_size;
  posy = mouseY/sq_size;
  
  if (mouseX > 600 || mouseY > 600 || mouseX < 0 || mouseY < 0){
    return;
  }
  
  if (mouseButton == CENTER){ // if middle click undo last move
    test.undoMove();
    moveMade = true;
  }
  
  else if (moveSelected[0] == null){ // check if first click is empty
    
    moveSelected[0] = new PVector(posx,posy);
    
    if (test.board[(int)moveSelected[0].y][(int)moveSelected[0].x] == "--"){ // check if square is empty
      moveSelected[0] = null;
      moveSelected[1] = null;
    }
    
  }
  
  else if (moveSelected[0] != null){  // check if first click has been made
    moveSelected[1] = new PVector(posx,posy);
    
    if (moveSelected[1].x == moveSelected[0].x && moveSelected[1].y == moveSelected[0].y){ // deselect square if you double click same piece
      moveSelected[0] = null;
      moveSelected[1] = null;
    }
    
  }
  if (mouseButton == RIGHT){ // if right click deselect
    moveSelected[0] = null;
    moveSelected[1] = null;
  }
}

void movePiece(){
  if (moveSelected[0] != null && moveSelected[1] != null){ // check if there is mouse clicks
      Move info;
      info = new Move(moveSelected[0],moveSelected[1],test.board);
      
      for (int i = 0; i < validMoves.size(); i++){ // check valid moves size
        if(test.cmp_moves(validMoves.get(i),info)){ // compare if move is in valid moves
          test.makeMove(info); // make move if valid
          moveMade = true; // move was made
        }
      }
      
      println(info.chessNotation());
      moveSelected[0] = null;  // reset clicks
      moveSelected[1] = null;
      
  }
  
  if (moveMade){ // get new valid moves for current position
    validMoves = test.getValidMoves();
    moveMade = false; // no move was made in new position, so we reset move made
  }
  
}
