/* This is the main file for the game, it will give information about the board
display possible moves and have a moveLog */

class GameState{
  String[][] board; // board
  boolean whiteMove; // whose turn is it to play
  ArrayList<Move> movelog = new ArrayList<Move>(); // all game moves
  
  
  
  GameState(){ // initialize board
    board = new String[][]{
    {"bR","bN","bB","bQ","bK","bB","bN","bR"},
    {"bP","bP","bP","bP","bP","bP","bP","bP"},
    {"--","--","--","--","--","--","--","--"},
    {"--","--","--","--","--","--","--","--"},
    {"--","--","--","--","--","--","--","--"},
    {"--","--","--","--","--","--","--","--"},
    {"wP","wP","wP","wP","wP","wP","wP","wP"},
    {"wR","wN","wB","wQ","wK","wB","wN","wR"}
    };
    whiteMove = true; // white starts
  }
  
  void makeMove(Move info){ // make move function
  
    board[info.start_col][info.start_row] = "--";
    board[info.end_col][info.end_row] = info.pieceMoved;
    movelog.add(info);
    whiteMove = !whiteMove;
    
  }
  
  void undoMove(){ // undo move function
    if(movelog.size() > 0){ // check if there is any move to be undone
    
      Move aux;
      aux = movelog.get(movelog.size()-1);
      board[aux.end_col][aux.end_row] = aux.pieceCaptured;
      board[aux.start_col][aux.start_row] = aux.pieceMoved;
      movelog.remove(movelog.size()-1);
      whiteMove = !whiteMove;
      
    }
  }
  
  ArrayList<Move> getValidMoves(){ // get all valid moves
  
    return getAllPossibleMoves();
  }
  
  ArrayList<Move> getAllPossibleMoves(){ // get all possible moves
  
    ArrayList<Move> moves = new ArrayList<Move>(); // move list
    Move aux;
    PVector x = new PVector(4,6);
    PVector y = new PVector(4,4);
    aux = new Move(x,y,board);
    moves.add(aux);
    
    
    for (int i = 0; i < 8; i++){ // start for i
      for (int j = 0; j < 8; j++){ // start for j
        
        char turn = board[j][i].charAt(0); // check whose piece is it
        
        if ((turn == 'w' && whiteMove) && (turn == 'b' && !whiteMove)){ // start if turn
          char piece = board[j][i].charAt(1); // check whick piece is it
          
          if(piece == 'P'){ // start if pawn
            moves = getPawnMoves(i,j,moves);
          } // end if pawn
          
          else if (piece == 'R'){ // start if rook
            getRookMoves(i,j,moves);
          } // end if rook
          
        } // end if turn
      } // end for j
    } // end for i
    
    return moves;
    
  }
  
  boolean cmp_moves(Move other, Move actual){ // compare function to compare two move objects
    if (other.moveID == actual.moveID){
      return true;
    }
    else{
      return false;
    }
  }
  
  
  ArrayList<Move> getPawnMoves(int col, int row, ArrayList<Move> moves){
    return moves;
  }
  
  ArrayList<Move> getRookMoves(int col, int row, ArrayList<Move> moves){
    return moves;
  }
  
}
