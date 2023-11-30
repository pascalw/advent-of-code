const assert = require("assert").strict;
const { Board, Game } = require("./solution");

(function testHasBingoHorizontal() {
  const board = new Board([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ]);

  board.try(1);
  board.try(2);
  board.try(3);

  assert.equal(board.hasBingo(), true);
})();

(function testHasBingoVertical() {
  const board = new Board([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ]);

  board.try(2);
  board.try(5);
  board.try(8);

  assert.equal(board.hasBingo(), true);
})();

(function testScore() {
  const board = new Board([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ]);

  board.try(2);
  board.try(5);
  board.try(8);

  assert.equal(board.score(8), 240);
})();

(function testBoardToWinLast() {
  const board1 = new Board([
    [22, 13, 17, 11, 0],
    [8, 2, 23, 4, 24],
    [21, 9, 14, 16, 7],
    [6, 10, 3, 18, 5],
    [1, 12, 20, 15, 19],
  ]);

  const board2 = new Board([
    [3, 15, 0, 2, 22],
    [9, 18, 13, 17, 5],
    [19, 8, 7, 25, 23],
    [20, 11, 10, 24, 4],
    [14, 21, 16, 12, 6],
  ]);

  const board3 = new Board([
    [14, 21, 17, 24, 4],
    [10, 16, 15, 9, 19],
    [18, 8, 23, 26, 20],
    [22, 11, 13, 6, 5],
    [2, 0, 12, 3, 7],
  ]);

  const game = new Game([board1, board2, board3]);

  const [_board, score] = game.boardToWinLast([
    7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18,
    20, 8, 19, 3, 26, 1,
  ]);
  assert.equal(score, 1924);
})();
