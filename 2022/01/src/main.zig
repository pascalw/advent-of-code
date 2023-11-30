const std = @import("std");
const ArrayList = std.ArrayList;

var gpa = std.heap.GeneralPurposeAllocator(.{}){};

pub fn main() !void {
  const allocator = gpa.allocator();

  var file = try std.fs.cwd().openFile("input", .{});
  defer file.close();

  var buf_reader = std.io.bufferedReader(file.reader());
  var in_stream = buf_reader.reader();

  var buf: [1024]u8 = undefined;
  var list = ArrayList(u32).init(allocator);
  defer list.deinit();

  var caloriesForElf: u32 = 0;

  while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
    if(line.len > 0) {
      const calories = try std.fmt.parseInt(u32, line, 10);
      caloriesForElf += calories;
    } else {
      try list.append(caloriesForElf);
      caloriesForElf = 0;
    }
  }

  std.sort.sort(u32, list.items, {}, std.sort.desc(u32));
  const top3 = list.items[0] + list.items[1] + list.items[2];

  std.debug.print("Most calories: {}\n", .{list.items[0]});
  std.debug.print("Top 3 elves: {}\n", .{top3});
}
