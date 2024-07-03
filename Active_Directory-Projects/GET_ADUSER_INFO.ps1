###############################################################################################
#                                                                                             #
#                                     GET_ADUSER_INFO.ps1                                     #
#                                  Zavier Chambers - 7/3/24                                   #
#                     this script will prompt the user for an AD samaccountname,              #
#                     and return a users properites or a selected property.                   #
#                                                                                             #
###############################################################################################

#####-Vars-###################################################################################
$userSamaccountname = Read-Host "Enter a Samaccountname"                                     #
$adUserNeeded = Get-ADUser -Filter {samaccountname -like $userSamaccountname} -Properties *  #
##############################################################################################

#if the entered samaccoutname is not found then report that the user does not exist in AD
if($adUserNeeded -eq $null)
{
    Write-Host "ERROR: User does not exist in AD with samaccountname: $userSamaccountname" -BackgroundColor red -ForegroundColor white
    return
}

#Asking user for there desired property, need this here so the user is only asked if the user does exist in AD
$propertyNeeded = Read-Host "Enter the property needed [Leave Blank for All] "

#if the property field is left blank, return all of the properties
if($propertyNeeded -eq "")
{
    $adUserNeeded
    return
}
#else return the property they are needing
else
{
    #this assumes that the entered property is a vaild option
    $adUserNeeded.$propertyNeeded
    return
}
