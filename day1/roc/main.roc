app "task-usage"
    packages { 
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.7.1/Icc3xJoIixF3hCcfXrDwLCu4wQHtNdPyoJkEbkgIElA.tar.br"
    }
    imports [ 
        pf.Stdout,
        pf.Task,
        Part1,
        Part2,
        "../input" as inputStr : Str
    ]
    provides [ main ] to pf

main = 
    _ <- "Part 1: \(inputStr |> Part1.process)" |> Stdout.line |> Task.await
    "Part 2: \(inputStr |> Part2.process)" |> Stdout.line


