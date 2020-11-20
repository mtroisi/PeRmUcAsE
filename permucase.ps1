param (
	[Parameter(Mandatory=$true)][string]$String
)

$String = $String.ToLower()
$Length = $String.Length

[String]$AlphaMask = ''
$NumNotAlpha = 0

# create mask to check for non alpa characters
0..($Length - 1) | foreach {
    if ($String[$_] -match '[a-z]') {
        $AlphaMask += '1'    
    }
    else {
        $AlphaMask += '0'
        $NumNotAlpha++
    }
}


$MaxPermutations = ([Math]::Pow(2, $Length) - 1)

# outer loop goes through each permutation
for ($index = $i = 0; $i -le $MaxPermutations; $i++) {

    # calculate bitmask for case
    $mask = ([String][convert]::ToString($index,2))
    $mask = $mask.PadLeft($Length, '0')
    
    # if mask is invalid try another
    $check = [convert]::ToString(([convert]::ToInt32($mask,2) -band [convert]::ToInt32($AlphaMask,2)),2)
    if ($mask -ne $check.PadLeft($Length, '0')) {
        $index++
        continue
    }

    $index++

    [String]$tmp = ''
    
    # inner loop goes through each character
    0..$Length | foreach {
        # check if character is valid alpha
        if ($AlphaMask[$_] -eq '0') {
            $tmp += $String[$_]
        }
        elseif ($mask[$_] -eq '0') {
            $tmp += $String[$_]
        }
        elseif ($mask[$_] -eq '1') {
            $tmp += $String[$_].ToString().ToUpper()
        }       
    }

    Write-Output $tmp
    $tmp = ''

}
