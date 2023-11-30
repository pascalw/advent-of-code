use itertools::Itertools;

fn main() {
    let file_contents = std::fs::read_to_string("input").unwrap();
    let lines = file_contents.lines().map(|line| line.parse::<u32>().unwrap());

    let three_measurement_windows = lines.tuple_windows::<(_, _, _)>().map(|(a,b,c)| a + b + c);
    let increasing_windows_count = three_measurement_windows.tuple_windows().fold(0, |acc, (a, b)| {
        return if b > a { acc + 1 } else { acc };
    });

    println!("{}", increasing_windows_count);
}
