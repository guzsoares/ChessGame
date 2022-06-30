/* This is the main file for the game, it will give information about the board
display possible moves and have a moveLog */

class GameState{
  String[][] board;
  boolean whiteMove;
  ArrayList<Move> movelog = new ArrayList<Move>();
  
  
  
  GameState(){
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
    whiteMove = true;
  }
  
  void makeMove(Move info){
    board[info.start_col][info.start_row] = "--";
    board[info.end_col][info.end_row] = info.pieceMoved;
    movelog.add(info);
    whiteMove = !whiteMove;
  }
  
  void undoMove(){
    Move aux;
    aux = movelog.get(movelog.size()-1);
    board[aux.end_col][aux.end_row] = "--";
    board[aux.start_col][aux.start_row] = aux.pieceMoved;
    movelog.remove(movelog.size()-1);
    whiteMove = !whiteMove;
    
    
  }
}
