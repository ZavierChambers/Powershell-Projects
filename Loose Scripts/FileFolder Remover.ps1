####################################################
#              file/folder remover                 #
#                Zavier Chambers                   # 
#                  7/7/24                          #
#                                                  #
#    this script will remove any file or folder    #
#       with a passed in name at run time          #
#                                                  #
####################################################

############-Vars-###########################################################
#move powershell to the base folder for users
cd c:/Users

#clear var in case running script more then once
$pathToAppNeedingRemoved = ""

#taking user input for the desired file/folder to remove
$fileToRemove = Read-Host "Enter a folder/file Name to remove: "

#searching whole system from base folder to mark all paths to matched name
$pathToAppNeedingRemoved = (Get-ChildItem -Recurse $fileToRemove).FullName

#############################################################################



#if there is no files found report it.
if($pathToAppNeedingRemoved -eq $null)
{
    Write-Host "ERROR: No file exists with that name" -BackgroundColor white -ForegroundColor Red
    return
}

#if there is more then one, prepare to remove each of them.
foreach($folder in $pathToAppNeedingRemoved)
{
    #if a folder found does not exist since script ran, report it
    if($folder -eq $null)
    {
        Write-Host "Folder does not exist" -BackgroundColor white -ForegroundColor Red
    }
    #status of current removed file/folder
    Write-Host "REMOVED: $folder Complete" -BackgroundColor White -ForegroundColor Blue
    #code to remove the file/folder requested
    #Remove-Item -Path $pathToAppNeedingRemoved
}
#status to let user know the program has ended
Write-Host "The requested folder/file have been removed" -BackgroundColor white -ForegroundColor Black
