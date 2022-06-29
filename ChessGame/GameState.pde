/* This is the main file for the game, it will give information about the board
display possible moves and have a moveLog */

class GameState{
  String[][] board;
  boolean whiteMove;
  ArrayList<String> movelog;
  
  
  
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
    movelog = new ArrayList<>();
  }
}
