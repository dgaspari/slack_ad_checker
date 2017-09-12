# This script checks to see if given email exists in AD
Import-Module activedirectory
$emailToCheck = [string]$args[0]
$userFirstName = [string]$args[1]
$userLastName = [string]$args[2]
$acct = Get-ADUser -filter {userPrincipalName -like $emailToCheck}
If($acct -and $acct.Enabled) {
    Exit 0 
} Else { 
    $emailAcct = Get-ADUser -filter {EmailAddress -like $emailToCheck}
    If($emailAcct -and $emailAcct.Enabled) { Exit 0 } Else {
        If($userFirstName -ne $null -and $userLastName -ne $null) {
            $userName = $userFirstName + " " + $userLastName
            $adAcct = Get-ADUser -filter {name -like $userName} -Properties proxyAddresses
            If($adAcct -and $adAcct.Enabled) {
                $smtpAddress = "smtp:" + $emailToCheck
                If($adAcct.proxyAddresses -contains $smtpAddress) { Exit 0 }
            }
        }
        Exit 1
    }
}