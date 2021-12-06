$data = Get-Content ./input.txt
$sequence = [int[]]$data[0].Split(",")

$numOfBoards = 0
for($i = 2; $i -lt $data.Length; $i+=6) {
    $numOfBoards++
}

$boards = @()::new($numOfBoards)
$checkedBoards = @()::new($numOfBoards)
for($i = 0; $i -lt $numOfBoards; $i++) {
    $board = [int[][]]::new(5,5)
    $checkedBoard = [bool[][]]::new(5,5)

    for($y = 0; $y -lt 5; $y++) {
        # first board starts at index 2, second at index 8, third at index 14
        $boardStartIndex = 2 + $y + ($i * 6)
        $rowValues = [int[]]($data[$boardStartIndex].Split() | Where-Object {$_.Trim() -ne ''})
        for($x = 0; $x -lt $rowValues.Length; $x++) {
            $board[$x][$y] = $rowValues[$x]
            $checkedBoard[$x][$y] = 0
        }
    }
    
    $boards[$i] = $board
    $checkedBoards[$i] = $checkedBoard
}

function IsColumnComplete {
    param (
        $board
    )
    for($x = 0; $x -lt 5; $x++) {
        if($board[$x][0] -and
            $board[$x][1] -and
            $board[$x][2] -and
            $board[$x][3] -and
            $board[$x][4]) {
            # mark as checked
            
            return $true
        }
    }
    return $false
}

function IsRowComplete {
    param (
        $board
    )

    for($y = 0; $y -lt 5; $y++) {
        if($board[0][$y] -and
            $board[1][$y] -and
            $board[2][$y] -and
            $board[3][$y] -and
            $board[4][$y]) {
            return $true
        }
    }
    return $false    
}

function GetUnmarkedSum {
    param(
        $board,
        $checkedBoard
    )
    $sum = 0
    for($y = 0; $y -lt 5; $y++) {
        for($x = 0; $x -lt 5; $x++) {
            if($checkedBoard[$x][$y] -eq 0) {
                $sum += $board[$x][$y]
            }
        }
    }
    return $sum
}

$boardsWon =  [int[]]@()

foreach($num in $sequence) {
    for($i = 0; $i -lt $boards.Length; $i++) {
        for($y = 0; $y -lt 5; $y++) {
            for($x = 0; $x -lt 5; $x++) {
                if($boards[$i][$x][$y] -eq $num) {
                    # mark as checked
                    $checkedBoards[$i][$x][$y] = 1
                }
            }
        }
        
        if(IsRowComplete $checkedBoards[$i]) {
            if($boardsWon.Contains($i)) {
                continue
            }
            write-host "BINGO! Number" $num "completed row or column in board" $i
            $score = (GetUnmarkedSum $boards[$i] $checkedBoards[$i]) * $num
            $score #67716
            $boardsWon += $i
            #return
        }
        elseif(IsColumnComplete $checkedBoards[$i]) {
            if($boardsWon.Contains($i)) {
                continue
            }
            write-host "BINGO! Number" $num "completed row or column in board" $i
            $score = (GetUnmarkedSum $boards[$i] $checkedBoards[$i]) * $num
            $score #67716
            $boardsWon += $i
            #return
        }
    }
}

# part 2
#1830