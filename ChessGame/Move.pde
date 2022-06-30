import java.util.Map;

class Move{
  
  HashMap<Integer, String> rowToValue = initRow();
  HashMap<Integer, String> colToValue = initCol();
  int start_row;
  int start_col;
  int end_col;
  int end_row;
  String pieceMoved;
  String pieceCaptured;
  int moveID; // unique move id for every possible move
  
  HashMap<Integer, String> initRow(){ // rows to numbers
    HashMap<Integer, String> map = new HashMap<>();
    map.put(0, "8");
    map.put(1, "7");
    map.put(2, "6");
    map.put(3, "5");
    map.put(4, "4");
    map.put(5, "3");
    map.put(6, "2");
    map.put(7, "1");
    return map;
  }
  
  HashMap<Integer, String> initCol(){ // columns to letters
    HashMap<Integer, String> map = new HashMap<>();
    map.put(0, "a");
    map.put(1, "b");
    map.put(2, "c");
    map.put(3, "d");
    map.put(4, "e");
    map.put(5, "f");
    map.put(6, "g");
    map.put(7, "h");
    return map;
  }
  
  
  Move(PVector startSq, PVector endSq, String[][] board){ // move object
    
    start_row = (int)startSq.x; 
    start_col = (int)startSq.y;
    end_row = (int)endSq.x;
    end_col = (int)endSq.y;
    pieceMoved = board[start_col][start_row];
    pieceCaptured = board[end_col][end_row];
    moveID = start_row * 1000 + start_col * 100 + end_row * 10 + end_col;
  }
  
  
  String chessNotation(){ // chess notation function
    String notation = ("" + colToValue.get(start_row)+ rowToValue.get(start_col) + colToValue.get(end_row) + rowToValue.get(end_col));
    return notation;
  }
  
}
