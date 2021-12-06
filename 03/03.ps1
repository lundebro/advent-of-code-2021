$data = Get-Content ./input.txt
$columnBits = [int[]]::new(12)

# part 1
for ($i = 0; $i -lt $data.length; $i++) {
    for ($j = 0; $j -lt $data[$i].length; $j++) {
       
        # write-host $data[$i][$j].GetType()
        if([int]::Parse($data[$i][$j]) -eq 1) {
            $columnBits[$j] += 1
        }
    }
}

$gammaBits = ""
$epsilonBits = ""
for ($i = 0; $i -lt $columnBits.length; $i++) {
    if($columnBits[$i] -ge $data.Length / 2) {
        $gammaBits += 1
        $epsilonBits += 0
    }
    else {
        $gammaBits += 0
        $epsilonBits += 1
    }
}

$gammaRate = [convert]::ToInt32($gammaBits,2)
$epsilonRate = [convert]::ToInt32($epsilonBits,2)

$gammaRate * $epsilonRate #3969000

# part 2
function GetRowsWithMostCommonBits {
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $bitCriteria,
        [Parameter(Mandatory=$true, Position=1)]
        [string[]] $data,
        [Parameter(Mandatory=$true, Position=2)]
        [int] $index
    )
    if($data.Length -eq 1) {
        return $data
    }

    $currentColumnBits = 0

    for ($i = 0; $i -lt $data.length; $i++) {
        if([int]::Parse($data[$i][$index]) -eq 1) {
            $currentColumnBits += 1
        }
    }

    $mostCommonBit = if ($currentColumnBits -ge $data.Length / 2) { "1" } else { "0" }

    $newData = @()

    if($bitCriteria -eq "mostCommon") {
        $newData = $data | Where-Object {
            $_[$index] -eq $mostCommonBit
        }
    }
    elseif($bitCriteria -eq "leastCommon") {
        $newData = $data | Where-Object {
            $_[$index] -ne $mostCommonBit
        }
    }

    return GetRowsWithMostCommonBits $bitCriteria $newData (++$index)
}

$oxygenRating = GetRowsWithMostCommonBits "mostCommon" $data 0
$scrubberRating = GetRowsWithMostCommonBits "leastCommon" $data 0

$oxygenRating = [convert]::ToInt32($oxygenRating,2)
$scrubberRating = [convert]::ToInt32($scrubberRating,2)

$oxygenRating * $scrubberRating #4267809