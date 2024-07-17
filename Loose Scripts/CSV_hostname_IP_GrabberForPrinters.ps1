#######################################################################################################
#                                                                                                     #
#                                 6/5/24 - Made by Zavier Chambers                                    #
#                                                                                                     #
#                                 hostname/IP Grabber for Printers                                    #
#                                                                                                     #
#   takes the existing printers in AD and output a document with IP and hostname for each device      #                
#                                                                                                     #
#######################################################################################################


#this will output a list of printers with a passed in printer-server
function outputPrinters{
[CmdletBinding()]
    
    param(
        [Parameter(Mandatory)]
        [string] $computerName
        )

    #gets all printers from passed in server
    $Printers = Get-Printer -ComputerName $computerName
    #makes csv
    Add-Content -Path "C:\util\tester.csv" -Value "Hostname,IP Address,Server"
    foreach ($printer in $Printers)
    {
        $printerName = $printer.Name
        $printerIP = $printer.PortName
        $printerName
        $printerIP
        Add-Content -Path "C:\util\tester.csv" -Value "$printerName,$printerIP,$computerName"
    }
    Write-Host "Completed" -ForegroundColor Green -BackgroundColor Black
    
}

#Call the function and pass in a printer server.









