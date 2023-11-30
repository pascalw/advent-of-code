const fs = require('fs');

class BingoNumber {
  constructor(number) {
    this.number = number;
    this.bingo = false;
  }

  try(number) {
    if(this.number == number) {
      this.bingo = true;
    }
  }
}

class Board {
  constructor(values) {
    this.values = [...values].map((row) => {
      return row.map(number => new BingoNumber(number));
    });

    this.numColumns = this.values[0].length;
  }

  try(number) {
    this._allNumbers().forEach(bingoNumber => bingoNumber.try(number));
  }

  hasBingo() {
    const horizontal = this._rows().some(row => this._hasBingo(row));
    const vertical = this._columns().some(column => this._hasBingo(column));

    return horizontal || vertical;
  }

  score(calledNumber) {
    const sum = this._allNumbers().reduce((acc, number) => {
      if(! number.bingo) {
        return acc + number.number;
      }

      return acc;
    }, 0);

    return sum * calledNumber;
  }

  _hasBingo(numbers) {
    return numbers.every(number => number.bingo);
  }

  _rows() {
    return this.values;
  }

  _columns() {
    return [...Array(this.numColumns).keys()].map((colNumber) => {
      return this.values.map(row => row[colNumber]);
    });
  }

  _allNumbers() {
    return this.values.flatMap(row => row);
  }
}

module.exports.Board = Board;

class Game {
  constructor(boards) {
    this.boards = [...boards];
  }

  play(numbers) {
    for(const number of numbers) {
      for(const board of this.boards) {
        board.try(number);

        if(board.hasBingo()) {
          return [board, board.score(number)];
        }
      }
    }
  }

  boardToWinLast(numbers) {
    var wonBoards = 0;

    for(const number of numbers) {
      for(const board of this.boards) {
        if(board.hasBingo()) continue;

        board.try(number);

        if(board.hasBingo()) {
          wonBoards++;

          if(wonBoards == this.boards.length) {
            return [board, board.score(number)];
          }
        }
      }
    }
  }
}
module.exports.Game = Game;

if (require.main === module) {
  const input = fs.readFileSync('input').toString();
  const lines = input.split(/\r?\n/);

  const numbers = lines[0].split(',').map(Number);

  const boards = lines.slice(1, -1).reduce((result, cur) => {
    if(cur == '') {
      result.push([]); // begin new board
      return result;
    }

    const board = result[result.length - 1];
    const row = cur.trim().split(/\s+/).map(Number);

    board.push(row);

    return result;
  }, []).map(board => new Board(board));

  const game = new Game(boards);
  // const [board, score] = game.play(numbers);
  const [board, score] = game.boardToWinLast(numbers);
  console.log(score);
}
