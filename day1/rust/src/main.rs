fn main() -> color_eyre::Result<()> {
    color_eyre::install()?;

    let input = include_str!("../../input");

    let result = input
        .lines()
        .filter_map(first_and_last_digit)
        .filter_map(|x| x.parse::<u32>().ok())
        .sum::<u32>();

    println!("Part 1: {}", result);

    Ok(())
}

fn first_and_last_digit(line: &str) -> Option<String> {
    let mut iter = line.chars().filter(|x| x.is_ascii_digit()).into_iter();
    iter.next().map(|x| match iter.next_back() {
        Some(s) => x.to_string() + &s.to_string(),
        None => x.to_string() + &x.to_string(),
    })
}
