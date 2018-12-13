$inputData = Get-Content C:\gitstuff\AdventOfCode2018-PS\input-1.2.txt
$ncnt = 0
$ubound = $inputData.Count
$current = 0
$history = @(0)
do {
    If ($ncnt -eq $ubound) { $ncnt = 0 }
    $current = $current + [int]$inputData[$ncnt]
    if ($history -contains $current) { break }
    $history = $history + $current
    $ncnt = $ncnt + 1
} while ($true)
Write-Host "$current repeated!"