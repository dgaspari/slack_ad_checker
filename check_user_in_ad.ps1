# This script checks to see if given email exists in AD
Import-Module activedirectory
$emailToCheck = [string]$args[0]
$acct = Get-ADUser -filter {userPrincipalName -like $emailToCheck}
If($acct -and $acct.Enabled) { Exit 0 } Else { Exit 1 }