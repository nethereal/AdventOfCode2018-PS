$twos,$threes = 0
ForEach ($code in (Get-Content C:\gitstuff\AdventOfCode2018-PS\input-2.txt)) { 
    :twocheck ForEach ($cnt in ($code.ToCharArray() | Group-Object | ? { $_.Count -gt 1 -and $_.Count -lt 4 })) { If ($cnt.Count -eq 2) { $twos = $twos + 1; Break twocheck; } }
    :threecheck ForEach ($cnt in ($code.ToCharArray() | Group-Object | ? { $_.Count -gt 1 -and $_.Count -lt 4 })) { If ($cnt.Count -eq 3) { $threes = $threes + 1; Break threecheck; } }
}
$twos * $threes