########################################################## 
#             Created By: Zavier Chambers                #
#                                                        #
#            A Simple Process Managment GUI              #
#                      6/26/24                           #
#                                                        #
##########################################################

#importing the Type into the script for GUI creation
Add-Type -AssemblyName System.Windows.Forms

#variable that stores the acutal form
$testerForm = New-Object System.Windows.Forms.Form
$testerForm.ClientSize = '1500,500'
$testerForm.Text = "Deep Process | by Zavier Chambers"
$testerForm.BackColor = "gray"

#Returns the output of a pressed $button1, will remove info from all process details and lists, displays text allowing user to understand the intraction that has happened
function delProcess {
    $RemovedStatus.Text = "Process: $($dropdown.SelectedItem) has been removed"
    Stop-Process -Name $dropdown.SelectedItem
    $dropdown.Items.Remove($dropdown.SelectedItem)
    $ProcessInfo.Text = "" 
    $ProcessName.Text = ""
    
    
}

#Returns a process selected from the user.
function updateInfo { $ProcessName.Text = $dropdown.SelectedItem
     $ProcessInfo.Text = (Get-Process -Name $dropdown.SelectedItem).Description
     
     #if Process information does not exist, them display default text.
     if($ProcessInfo.Text -eq "" -or $ProcessInfo.Text -eq $null -or $ProcessInfo.Text -eq " ")
     {
        $ProcessInfo.Text = "No Details"
        $ProcessInfo.ForeColor = "red"
     }
     #else color remains the same
     else
     {
         $ProcessInfo.ForeColor = "black"
     }
 
 }


 #Var for Title of whole program
$Title1 = New-Object System.Windows.Forms.Label
$Title1.Text = "Process Lister"
$Title1.AutoSize = $true
$Title1.Width = 25
$Title1.Height = 10
$Title1.Location = New-Object System.Drawing.Point(275,10)
$Title1.Font = 'Microsoft Sans Serif,13'

#Var for Displayname holder
$ProcessInfoTitle = New-Object System.Windows.Forms.Label
$ProcessInfoTitle.Location = New-Object System.Drawing.Point(175,140)
$ProcessInfoTitle.Text = "Process: "
$ProcessInfoTitle.AutoSize = $true
$ProcessInfoTitle.Font = 'Microsoft Sans Serif,13'
$ProcessInfoTitle.Width = 25
$ProcessInfoTitle.Height = 10

#Var for updated name in function "delprocess"
$ProcessName = New-Object System.Windows.Forms.Label
$ProcessName.Location = New-Object System.Drawing.Point(270,140)
$ProcessName.AutoSize = $true
$ProcessName.Font = 'Microsoft Sans Serif,13'
$ProcessName.Width = 25
$ProcessName.Height = 10

#Var for selected Process from user interaction with $button1
$ProcessInfo = New-Object System.Windows.Forms.Label
$ProcessInfo.Location = New-Object System.Drawing.Point(230,240)
$ProcessInfo.Text = ""
$ProcessInfo.AutoSize = $true
$ProcessInfo.Font = 'Microsoft Sans Serif,10'
$ProcessInfo.Width = 25
$ProcessInfo.Height = 10

#Var for displayName holder
$ProcessInfoT = New-Object System.Windows.Forms.Label
$ProcessInfoT.Location = New-Object System.Drawing.Point(170,240)
$ProcessInfoT.Text = "Info: "
$ProcessInfoT.AutoSize = $true
$ProcessInfoT.Font = 'Microsoft Sans Serif,13'
$ProcessInfoT.Width = 25
$ProcessInfoT.Height = 10

#Var for The User interactions with this dropdown menu
$dropdown = New-Object System.Windows.Forms.ComboBox
$dropdown.AutoSize = $true
$dropdown.Location = New-Object System.Drawing.Point(200,50)
$dropdown.Width = 300
$dropdown.Text = "Pick a Process"
$dropdown.add_SelectedIndexChanged({updateInfo})
$dropdown.Font = 'Microsoft Sans Serif,17'

#Var for user interaction that causes the "delProcess" function to fire.
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Kill Process"
$button1.BackColor = "black"
$button1.ForeColor = "white"
$button1.Location = New-Object System.Drawing.Point(200,300)
$button1.Width = 300
$button1.Height = 50
$button1.add_click({delProcess})

#Var for Label that is updated with a Status when user interaction happens with $button1
$RemovedStatus = New-Object System.Windows.Forms.Label
$RemovedStatus.Text = ""
$RemovedStatus.Location = New-Object System.Drawing.Point(700,50)
$RemovedStatus.Font = 'Microsoft Sans Serif,16'
$RemovedStatus.Width = 600
$RemovedStatus.Height = 50
$RemovedStatus.BackColor = "black"
$RemovedStatus.ForeColor = "white"


#stores process list
$processes = Get-Process 

#loops through each process and add's them to a dropdown menu
foreach ($p in $processes)
{
    [void] $dropdown.Items.Add($p.Name)
}

#adding element to the form
$testerForm.Controls.AddRange(@($Title1,$ProcessInfoTitle,$ProcessInfo,$ProcessInfoT,$ProcessName, $dropdown,$button1,$RemovedStatus))

#allows the form to be shown on screen
[void]$testerForm.ShowDialog()