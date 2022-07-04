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
    
    
    for (int i = 0; i < 8; i++){ // start for i
      for (int j = 0; j < 8; j++){ // start for j
        
        char turn = board[j][i].charAt(0); // check whose piece is it
        
        if ((turn == 'w' && whiteMove) || (turn == 'b' && !whiteMove)){ // start if turn
          char piece = board[j][i].charAt(1); // check whick piece is it
          
          if(piece == 'P'){ // start if pawn
            moves = getPawnMoves(i,j,moves);
          } // end if pawn
          
          else if (piece == 'R'){ // start if rook
            getRookMoves(i,j,moves);
          } // end if rook
          
          else if (piece == 'B'){ // start if bishop
            getBishopMoves(i,j,moves);
          } // end if bishop
          
          else if (piece == 'Q'){
            getQueenMoves(i,j,moves);
          }
          
          else if(piece == 'K'){
            getKingMoves(i,j,moves);
          }
          
          else if(piece == 'N'){
            getKnightMoves(i,j,moves);
          }
          
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
    Move aux;
    PVector end_p;
    PVector st_pos = new PVector(col,row);
    
    
    if (board[row][col].charAt(0) == 'w'){ // white moves
      if (row == 6 && board[row-2][col] == "--" && board[row-1][col] == "--"){
        end_p = new PVector(col,row-2);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
      }
      if (row > 0){
        if (board[row-1][col] == "--"){
          end_p = new PVector(col,row-1);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
      }
      if (row > 0 && col > 0){
        if (board[row-1][col-1].charAt(0) == 'b'){
          end_p = new PVector(col-1,row-1);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
      }
      if (row > 0 && col < 7){
        if (board[row-1][col+1].charAt(0) == 'b'){
          end_p = new PVector(col+1,row-1);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
      }
    }
    
    
    else if(board[row][col].charAt(0) == 'b'){ // black moves
      if (row == 1 && board[row+2][col] == "--"){
        end_p = new PVector(col,row+2);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
      }
      if (row < 7){
        if (board[row+1][col] == "--"){
          end_p = new PVector(col,row+1);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
      }
      if (row < 7 && col < 7){
        if (board[row+1][col+1].charAt(0) == 'w'){
          end_p = new PVector(col+1,row+1);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
      }
      if (row < 7 && col > 0){
        if (board[row+1][col-1].charAt(0) == 'w'){
          end_p = new PVector(col-1,row+1);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
      }
    }
      
    return moves;
  }
  
  ArrayList<Move> getRookMoves(int col, int row, ArrayList<Move> moves){
    Move aux;
    PVector end_p;
    PVector st_pos = new PVector(col,row);
    
    for (int i = row; i <= 7; i++){ // rook move down
      if (board[i][col] == "--"){
        end_p = new PVector(col,i);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
      }
      else if(board[i][col].charAt(0) != board[row][col].charAt(0)){ // rook eat piece
        end_p = new PVector(col,i);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        break;
        }
        else if(board[i][col].charAt(0) == board[row][col].charAt(0) && i != row){ // rook stop if piece is same color
        break;
        }
      }
      
      for (int i = row; i >= 0; i--){ // rook move up
      if (board[i][col] == "--"){
        end_p = new PVector(col,i);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
      }
      else if(board[i][col].charAt(0) != board[row][col].charAt(0)){ // rook eat piece
        end_p = new PVector(col,i);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        break;
        }
        else if(board[i][col].charAt(0) == board[row][col].charAt(0) && i != row){ // rook stop if piece is same color
        break;
        }
      }
      
      for (int i = col; i >= 0; i--){ // rook move left
      if (board[row][i] == "--"){
        end_p = new PVector(i,row);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
      }
      else if(board[row][i].charAt(0) != board[row][col].charAt(0)){ // rook eat piece
        end_p = new PVector(i,row);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        break;
        }
        else if(board[row][i].charAt(0) == board[row][col].charAt(0) && i != col){ // rook stop if piece is same color
        break;
        }
      }
      
      for (int i = col; i <= 7; i++){ // rook move right
      if (board[row][i] == "--"){
        end_p = new PVector(i,row);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
      }
      else if(board[row][i].charAt(0) != board[row][col].charAt(0)){ // rook eat piece
        end_p = new PVector(i,row);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        break;
        }
        else if(board[row][i].charAt(0) == board[row][col].charAt(0) && i != col){ // rook stop if piece is same color
        break;
        }
      }
      
    
    
    return moves;
  }
  
    ArrayList<Move> getBishopMoves(int col, int row, ArrayList<Move> moves){
      Move aux;
      PVector end_p;
      PVector st_pos = new PVector(col,row);
      
      for (int i = row, j = col; i <= 7 && j >= 0; i++, j--){ // bishop left down
        if (board[i][j] == "--"){
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
        else if(board[i][j].charAt(0) != board[row][col].charAt(0)){ // bishop eat
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
          break;
        }
        else if(board[i][j].charAt(0) == board[row][col].charAt(0) && i != row && j != col){ // bishop stop if piece is same color
          break;
        }
      }
      
      for (int i = row, j = col; i >= 0 && j <= 7; i--, j++){ // bishop right up
        if (board[i][j] == "--"){
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
        else if(board[i][j].charAt(0) != board[row][col].charAt(0)){ // bisho eat
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
          break;
        }
        else if(board[i][j].charAt(0) == board[row][col].charAt(0) && i != row && j != col){ // bisho stop if piece is same color
          break;
        }
      }
      
      for (int i = row, j = col; i <= 7 && j <= 7; i++, j++){ // bishop right down
        if (board[i][j] == "--"){
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
        else if(board[i][j].charAt(0) != board[row][col].charAt(0)){ // bishop eat
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
          break;
        }
        else if(board[i][j].charAt(0) == board[row][col].charAt(0) && i != row && j != col){ // bishop stop if piece is same color
          break;
        }
      }
      
      for (int i = row, j = col; i >= 0 && j >= 0; i--, j--){ // bishop left up
        if (board[i][j] == "--"){
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
        else if(board[i][j].charAt(0) != board[row][col].charAt(0)){ // bishop eat
          end_p = new PVector(j,i);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
          break;
        }
        else if(board[i][j].charAt(0) == board[row][col].charAt(0) && i != row && j != col){ // bishop stop if piece is same color
          break;
        }
      }
      
      return moves;
    }
    
    ArrayList<Move> getQueenMoves(int col, int row, ArrayList<Move> moves){
      moves = getBishopMoves(col,row,moves);
      moves = getRookMoves(col,row,moves);
      return moves;
    }
    
    ArrayList<Move> getKingMoves(int col, int row, ArrayList<Move> moves){
      Move aux;
      PVector end_p;
      PVector st_pos = new PVector(col,row);
      
      if(row+1<=7 && board[row+1][col].charAt(0) != board[row][col].charAt(0)){
        end_p = new PVector(col,row+1);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
      }
      if(row+1<=7 && col+1 <= 7 && board[row+1][col-1].charAt(0) != board[row][col].charAt(0)){
        end_p = new PVector(col+1,row+1);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        }
      if(row+1<=7 && col-1 >= 0 && board[row+1][col-1].charAt(0) != board[row][col].charAt(0)){
        end_p = new PVector(col-1,row+1);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        }
      
      if(row-1>=0 && board[row-1][col].charAt(0) != board[row][col].charAt(0)){
        end_p = new PVector(col,row-1);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        }
      if(row-1>=0 && col+1 <= 7 && board[row-1][col+1].charAt(0) != board[row][col].charAt(0)){
        end_p = new PVector(col+1,row-1);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        }
      if(row-1>=0 && col-1 >= 0 && board[row-1][col-1].charAt(0) != board[row][col].charAt(0)){
        end_p = new PVector(col-1,row-1);
        aux = new Move(st_pos,end_p,board);
        moves.add(aux);
        }
      
      if(col+1 <= 7 && board[row][col+1].charAt(0) != board[row][col].charAt(0)){
          end_p = new PVector(col+1,row);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
        if(col-1 >= 0 && board[row][col-1].charAt(0) != board[row][col].charAt(0)){
          end_p = new PVector(col-1,row);
          aux = new Move(st_pos,end_p,board);
          moves.add(aux);
        }
      
      return moves;
  }
  
      ArrayList<Move> getKnightMoves(int col, int row, ArrayList<Move> moves){
        Move aux;
        PVector end_p;
        PVector st_pos = new PVector(col,row);
        
        if(row+2<=7){
          if (col+1<= 7 && board[row+2][col+1].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col+1,row+2);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
          if (col-1>= 0 && board[row+2][col-1].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col-1,row+2);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
        }
        
        if(row-2>=0){
          if (col+1<= 7 && board[row-2][col+1].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col+1,row-2);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
          if (col-1>= 0 && board[row-2][col-1].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col-1,row-2);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
        }
        
        if(col-2>=0){
          if (row+1<= 7 && board[row+1][col-2].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col-2,row+1);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
          if (row-1>= 0 && board[row-1][col-2].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col-2,row-1);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
        }
        
        if(col+2<=7){
          if (row+1<= 7 && board[row+1][col+2].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col+2,row+1);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
          if (row-1>= 0 && board[row-1][col+2].charAt(0) != board[row][col].charAt(0)){
            end_p = new PVector(col+2,row-1);
            aux = new Move(st_pos,end_p,board);
            moves.add(aux);
          }
        }
        
        
        return moves;
        
      }
  
}
