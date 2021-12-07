$data = Get-Content ./input.txt
$data = $data -replace "\s", ""

function DrawLine {
    param (
        $grid,
        $start,
        $end
    )
    
    $startX = [int]$start.Split(",")[0]
    $endX = [int]$end.Split(",")[0]

    $startY = [int]$start.Split(",")[1]
    $endY = [int]$end.Split(",")[1]

    $lineType = ""
    if ($startX -eq $endX) { $lineType = "horizontal" }
    elseif ($startY -eq $endY) { $lineType = "vertical" }
    else { $lineType = "diagonal" }

    if ($lineType -eq "horizontal" -or $lineType -eq "vertical") {
        if ($startX -gt $endX) {
            $tmp = $startX
            $startX = $endX
            $endX = $tmp
        }

        if ($startY -gt $endY) {
            $tmp = $startY
            $startY = $endY
            $endY = $tmp
        } 
        
        write-host "drawing" $lineType "line from" $startX","$startY "to" $endX","$endY
        for ($x = $startX; $x -le $endX; $x++) {
            for ($y = $startY; $y -le $endY; $y++) {
                $grid[$x][$y]++
            }
        }
    }
    elseif ($lineType -eq "diagonal") {

        if ($startX -ge $endX) {
            $y = $startY
            for ($x = $startX; $x -ge $endX; $x--) {
                $grid[$x][($y)]++
                if ($startY -ge $endY) {
                    $y--
                }
                else {
                    $y++
                }

            }
        }
        else {
            $y = $startY
            for ($x = $startX; $x -le $endX; $x++) {
                $grid[$x][($y)]++
                if ($startY -ge $endY) {
                    $y--
                }
                else {
                    $y++
                }
            }       
        }
    }
}


$grid = [int[][]]::new(1000, 1000)

$data | ForEach-Object {
    DrawLine $grid ($_ -split "->")[0] ($_ -split "->")[1]
}

$pointsWithOverlap = 0
$grid | ForEach-Object {
    $_ | ForEach-Object {
        if ($_ -gt 1) {
            $pointsWithOverlap++
        }
    }
}

write-host "points with overlap:" $pointsWithOverlap #6283