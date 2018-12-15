Class claim {
    [int]$ID
    [int]$leftInd
    [int]$topInd
    [int]$Width
    [int]$Height
    claim ([int]$ID,[int]$leftInd,[int]$topInd,[int]$Width,[int]$Height) 
    {
        $this.ID = $ID
        $this.leftInd = $leftInd
        $this.topInd =$topInd
        $this.Width = $Width
        $this.Height = $Height
    }
}
[claim[]]$claims = @()
$regexfilter = "#(?<ID>.+) @ (?<leftInd>.+),(?<topInd>.+): (?<Width>.+)x(?<Height>.+)"
$fabricmaxwidth,$fabricmaxheight = 0
ForEach ($row in (Get-Content C:\gitstuff\AdventOfCode2018-PS\input-3.txt)) { 
    If (!([string]$row -match [regex]::new($regexfilter))) { Throw "Error while applying regex" }
    $claim = [claim]::New($matches.ID,$matches.leftInd,$matches.topInd,$matches.width,$matches.Height)
    $tempmaxwidth = $claim.leftInd + $claim.width
    $tempmaxheight = $claim.topInd + $claim.height
    if ($tempmaxwidth -gt $fabricmaxwidth) { $fabricmaxwidth = $tempmaxwidth }
    if ($tempmaxheight -gt $fabricmaxheight) { $fabricmaxheight = $tempmaxheight }
    $claims = $claims + $claim

}
$fabric = New-Object 'int[,]' $fabricmaxwidth,$fabricmaxheight
ForEach ($claim in $claims) {
    For ($firstIndex = $claim.leftInd; $firstIndex -lt ($claim.leftInd + $claim.Width); $firstIndex++) {
        For ($secondIndex = $claim.topInd; $secondIndex -lt ($claim.topInd + $claim.Height); $secondIndex++) {
            $fabric[$firstIndex,$secondIndex] = $fabric[$firstIndex,$secondIndex] + 1
        }
    }
}
($fabric | ? { $_ -ge 2 }).count