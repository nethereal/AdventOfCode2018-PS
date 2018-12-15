$inputData = Get-Content C:\gitstuff\AdventOfCode2018-PS\input-2.2.txt
$IDaIndex,$IDbIndex = 0
For ($IDaIndex = 0; $IDaIndex -le (($inputData.Count)-2); $IDaIndex++ ) {
    For ($IDbIndex = $IDaIndex + 1; $IDbIndex -le (($inputData.Count)-1); $IDbIndex++) {
        $charCheckCount = 0
        $resultID = ""
        For ($charCheck = 0; $charCheck -lt $inputData[$IDaIndex].ToCharArray().Count; $charCheck++) { If ((($inputData[$IDaIndex]).ToCharArray())[$charCheck] -ne (($inputData[$IDbIndex]).ToCharArray())[$charCheck]) { $charCheckCount = $charCheckCount + 1 } else { $resultID = $resultID + "$((($inputData[$IDaIndex]).ToCharArray())[$charCheck])" } }
        if ($charCheckCount -eq 1) { $resultID }
    }
}