import 'dart:convert';
import 'dart:core';
import 'dart:io';

enum Direction { up, down, forward }

Direction directionFromString(String input) {
  switch (input) {
    case "up":
      return Direction.up;
    case "down":
      return Direction.down;
    case "forward":
      return Direction.forward;
    default:
      throw 'Not a valid direction: $input';
  }
}

class Command {
  final Direction direction;
  final int amount;

  Command(this.direction, this.amount);

  @override
  String toString() {
    return '$direction $amount';
  }
}

Command parseSingle(String commandLine) {
  final split = commandLine.split(RegExp(r"\s"));

  final direction = directionFromString(split[0]);
  final amount = int.parse(split[1]);

  return Command(direction, amount);
}

class Position {
  int x = 0;
  int y = 0;
  int aim = 0;

  void move(Command command) {
    switch (command.direction) {
      case Direction.up:
        aim -= command.amount;
        break;
      case Direction.down:
        aim += command.amount;
        break;
      case Direction.forward:
        x += command.amount;
        y += aim * command.amount;
        break;
    }
  }

  int multiply() {
    return x * y;
  }
}

Stream<Command> parse(Stream<String> input) {
  return input.map(parseSingle);
}

void main(List<String> arguments) async {
  final contents = File('input')
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter());

  final commands = await parse(contents).toList();

  final position = Position();
  commands.forEach(position.move);

  print(position.multiply());
}
