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

# Set some variables
$regexfilter = "#(?<ID>.+) @ (?<leftInd>.+),(?<topInd>.+): (?<Width>.+)x(?<Height>.+)"
$fabricmaxwidth,$fabricmaxheight = 0

# Build array of claims objects
[claim[]]$claims = @()
ForEach ($row in (Get-Content C:\gitstuff\AdventOfCode2018-PS\input-3.txt)) { 
    If (!([string]$row -match [regex]::new($regexfilter))) { Throw "Error while applying regex" }
    $claim = [claim]::New($matches.ID,$matches.leftInd,$matches.topInd,$matches.Width,$matches.Height)
    $claim
    $tempmaxwidth = $claim.leftInd + $claim.Width
    $tempmaxheight = $claim.topInd + $claim.Height
    if ($tempmaxwidth -gt $fabricmaxwidth) { $fabricmaxwidth = $tempmaxwidth }
    if ($tempmaxheight -gt $fabricmaxheight) { $fabricmaxheight = $tempmaxheight }
    $claims = $claims + $claim
}

# Map out each claim on the fabric, determine the minimum required size
# each element in fabric is a int[] of ID's that populate that particular location/element
$fabric = New-Object 'int[][,]' $fabricmaxwidth,$fabricmaxheight
ForEach ($claim in $claims) {
    For ($firstIndex = $claim.leftInd; $firstIndex -lt ($claim.leftInd + $claim.Width); $firstIndex++) {
        For ($secondIndex = $claim.topInd; $secondIndex -lt ($claim.topInd + $claim.Height); $secondIndex++) {
            $fabric[$firstIndex,$secondIndex] = $fabric[$firstIndex,$secondIndex] + $claim.ID
        }
    }
}

# Get list of distinct claim IDs that are found in locations with only 1 entry claim
$oneclaimLocations = $fabric | ? { $_.Count -eq 1 }

$postareaCounts = @{}

$oneclaimLocations | % { 
    #create a key in a hashtable if it doesn't exist, and set it to 1
    if(!($postareaCounts.ContainsKey([string]$_))) {
        $postareaCounts.Add([string]$_,[int]1)
    }
    Else {
        $postareaCounts."$_" = $postareaCounts."$_" + 1
    }
    
}

$postareaCounts.Keys | Sort-Object | % { Write-Host "    $_     $($postareaCounts."$_")" }

#$fullareaCounts = @{}

ForEach ($claimNumber in $postareaCounts.Keys) {
    #Write-Host "1"
    #Write-Host $claimNumber
    #$claims | ? { $_.ID -eq $claimNumber } 
    $claim = $claims | ? { $_.ID -eq $claimNumber } 
    #$claim
    #Nowcalculate full area counts for each claim:
    $claimFullArea = $claim.Width * $claim.Height
    #$fullareaCounts.Add([string]$claim.ID,$claimArea)
    If ($postareaCounts."$claimNumber" -eq $claimFullArea) {
        $claimNumber; 
        break
    }
}

<##
$postareaCounts.Keys | % {
    If ($fullareaCounts."$_" -eq $postareaCounts."$_") {
        Write-Host $_
    }
}
##>