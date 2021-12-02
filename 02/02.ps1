$data = Get-Content ./input.txt
$forwardCommand = "forward"
$downCommand = "down"
$upCommand = "up"

# part 1
$horizontalPosition = 0
$depth = 0
$data | Where-Object {
    $_.StartsWith($forwardCommand)
} | ForEach-Object {
    $horizontalPosition += [int]$_.SubString($forwardCommand.Length + 1)
}
$data | Where-Object {
    $_.StartsWith($downCommand)
} | ForEach-Object {
    $depth += [int]$_.SubString($downCommand.Length + 1)
} 
$data | Where-Object {
    $_.StartsWith($upCommand)
} | ForEach-Object {
    $depth -= [int]$_.SubString($upCommand.Length + 1)
} 

$horizontalPosition * $depth #1962940

# part 2
$horizontalPosition = 0
$depth = 0
$aim = 0
$data | ForEach-Object {
    if($_.StartsWith($forwardCommand)) {
        $horizontalPosition += [int]$_.SubString($forwardCommand.Length + 1)
        $depth += [int]$_.SubString($forwardCommand.Length + 1) * $aim
    }
    elseif($_.StartsWith($downCommand)) {
        $aim += [int]$_.SubString($downCommand.Length + 1)
    }
    elseif($_.StartsWith($upCommand)) {
        $aim -= [int]$_.SubString($upCommand.Length + 1)
    }
}
$horizontalPosition * $depth #1813664422