Class claim {
    [int]$ID
    [int]$leftInd
    [int]$topInd
    [int]$Width
    [int]$Height
    [int]$Area
    claim ([int]$ID,[int]$leftInd,[int]$topInd,[int]$Width,[int]$Height) {
        $this.ID = $ID
        $this.leftInd = $leftInd
        $this.topInd =$topInd
        $this.Width = $Width
        $this.Height = $Height
        $this.Area = $Width * $Height
    }
}

$regexfilter = "#(?<ID>.+) @ (?<leftInd>.+),(?<topInd>.+): (?<Width>.+)x(?<Height>.+)"
$fabricmaxwidth,$fabricmaxheight = 0
[claim[]]$claims = @()
$postareaCounts = @{}

ForEach ($row in (Get-Content C:\gitstuff\AdventOfCode2018-PS\input-3.txt)) { 
    If (!([string]$row -match [regex]::new($regexfilter))) { Throw "Error while applying regex" }
    $claim = [claim]::New($matches.ID,$matches.leftInd,$matches.topInd,$matches.Width,$matches.Height)
    $tempmaxwidth = $claim.leftInd + $claim.Width
    $tempmaxheight = $claim.topInd + $claim.Height
    if ($tempmaxwidth -gt $fabricmaxwidth) { $fabricmaxwidth = $tempmaxwidth }
    if ($tempmaxheight -gt $fabricmaxheight) { $fabricmaxheight = $tempmaxheight }
    $claims = $claims + $claim
}

$fabric = New-Object 'int[][,]' $fabricmaxwidth,$fabricmaxheight
ForEach ($claim in $claims) {
    For ($fI = $claim.leftInd; $fI -lt ($claim.leftInd + $claim.Width); $fI++) {
        For ($sI = $claim.topInd; $sI -lt ($claim.topInd + $claim.Height); $sI++) { $fabric[$fI,$sI] = $fabric[$fI,$sI] + $claim.ID }
    }
}

$oneclaimLocations = $fabric | ? { $_.Count -eq 1 }
$oneclaimLocations | % { if(!($postareaCounts.ContainsKey([string]$_))) { $postareaCounts.Add([string]$_,[int]1) } Else { $postareaCounts."$_" = $postareaCounts."$_" + 1 } }
ForEach ($claimNumber in $postareaCounts.Keys) { If ($postareaCounts."$claimNumber" -eq ($claims | ? { $_.ID -eq $claimNumber }).Area) { $claimNumber; break; } }