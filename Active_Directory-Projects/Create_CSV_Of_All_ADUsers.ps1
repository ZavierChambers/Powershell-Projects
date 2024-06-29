######################################################
#             Zavier Chambers - 6/29/24              #
#                                                    #
#       Creates a CSV, with all Users in AD          #
#       The status returned can be modified below    #
#                                                    #
######################################################

#File path to where you store your AD information
$filePath = "C:/Full_ADUsers_List.csv"

#holds all ADUsers with all their properties if needed
$ADUsers = Get-ADUser -Filter * -Properties *
#loops through each user in AD and creates a custom object to use as an output to the file path above.
foreach ($user in $ADUsers)
{
   #Custom Object used to store the current users info
   [PSCustomObject]@{
        Name = $user.name
        Samaccountname = $user.SamAccountName
        Enabled = $user.Enabled
        dateCreated = $user.whenCreated

    } | export-csv -Path $filePath -Delimiter "," -NoTypeInformation -Append
}

Write-Host "Finished generating a list of Users located on your C: Drive as: $filePath"

