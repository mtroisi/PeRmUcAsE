param (
	[Parameter(Mandatory=$true)][string]$String
)

$String = $String.ToLower()

$Length = $String.Length

$MaxPermutations = [Math]::Pow(2, $Length) - 1

# outer loop goes through each permutation
for ($i = 0; $i -le $MaxPermutations; $i++) {

    # calculate bitmask for case
    $mask = ([String][convert]::ToString($i,2))
    $mask = $mask.PadLeft($Length, '0')

    $index = 0
    $tmp = ''
    
    # inner loop goes through each character
    0..$Length | foreach {
        if ($mask[$index] -eq '0') {
            $tmp += $String[$index]
        }
        elseif ($mask[$index] -eq '1') {
            $tmp += $String[$index].ToString().ToUpper()
        }
        $index++        
    }

    Write-Output $tmp
    $tmp = ''

}
