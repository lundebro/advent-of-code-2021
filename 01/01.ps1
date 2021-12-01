$data = Get-Content ./input.txt
$largerThanPrevious = 0
for ($i = 1; $i -lt $data.length; $i++) {
    if([int]$data[$i] -gt [int]$data[$i - 1]) {
        $largerThanPrevious++
    }
}
$largerThanPrevious #1301

$largerThankPrevious2 = 0
for ($i = 2; $i -lt $data.length - 1; $i++) {
    $prev = [int]$data[$i - 2] + [int]$data[$i - 1] + [int]$data[$i]
    $curr = [int]$data[$i - 1] + [int]$data[$i] + [int]$data[$i + 1]
    #write-host $curr ">" $prev ($curr -gt $prev)
    if ($curr -gt $prev) {
        $largerThankPrevious2++
    }
    $prev = $curr

}
$largerThankPrevious2 #1346