$ADUsers_eIDs = Get-ADUser -Filter * -Properties EmployeeID 
Remove-Item c:\powershell\csv\Usermod\USERS_BAD_eIDs.csv -ErrorAction SilentlyContinue
foreach($user in $ADUsers_eIDs)
{
    if (($user.EmployeeID -match '[a-zA-Z]' -and (($user.EmployeeID -ne "System Account") -and ($user.EmployeeID -ne "SharedAccount"))) -or ($user.EmloyeeID -match " ")) {
        # Print the user and Employee ID if it contains letters
        Write-Output "User: $($user.SamAccountName), EmployeeID: $($user.EmployeeID)"


        [PSCustomObject]@{                                                                                                                                                                              
                    Name = $user.Name
                    BadID = $user.EmployeeID
                                     } | Export-Csv "c:\powershell\csv\Usermod\USERS_BAD_eIDs.csv" -notype -Append


    }
}
Write-Host "DONE"