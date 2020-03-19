
function Get-IOCs {
    
    # Create a file input box  and creae my file variable
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        InitialDirectory = [Environment]::GetFolderPath('Desktop')
    } # End of Forms Properties
        
    $FileBrowser.ShowDialog()
    $InputFile = Get-Content $FileBrowser.FileName

    # Create Regex patterns
    $URLPattern = '([A-Za-z]+://)([-\w]+(?:\.\w[-\w]*)+)(:\d+)?(/[^.!,?"<>\[\]{}\s\x7F-\xFF]*(?:[.!,?]+[^.!,?"<>\[\]{}\s\x7F-\xFF]+)*)?'
    $IPPattern = '(?:(?:\d|[01]?\d\d|2[0-4]\d|25[0-5])\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d\d|\d)(?:\/\d{1,2})?|((?=.*::)(?!.*::.+::)(::)?([\dA-Fa-f]{1,4}:(:|\b)|){5}|([\dA-Fa-f]{1,4}:){6})((([\dA-Fa-f]{1,4}((?!\3)::|:\b|(?![\dA-Fa-f])))|(?!\2\3)){2}|(((2[0-4]|1\d|[1-9])?\d|25[0-5])\.?\b){4})'
    $HashPattern = '(\b[a-fA-F0-9]{32}\b)|(\b[a-fA-F0-9]{40}\b)|(\b[a-fA-F0-9]{64}\b)|(\b[a-fA-F0-9]{96}\b)|(\b[a-fA-F0-9]{128}\b)'

    # Create my Custom Object
    $URLs = $InputFile | Select-String -Pattern $URLPattern -AllMatches | Select-String -Expand Matches | Select-String -Expand value
    $IPs = $InputFile | Select-String -Pattern $IPPattern -AllMatches | Select-String -Expand Matches | Select-String -Expand value
    $Hashes = $InputFile | Select-String -Pattern $HashPattern -AllMatches | Select-String -Expand Matches | Select-String -Expand value

    $IOCs = [psobject]@{
        IP = $IPs
        URLs = $URLs
        Hashes = $Hashes
    } # End of Custom Object

    # Create My Custom Excel document an populate it with the values of my object
        <# This was the only way I could figure out how to get a hashtable/dictionary with multiple values per key to be stacked vertically.  This is the format that Zeek Intel Framework wants it in.#>
    $Excel = New-Object -ComObject Excel.Application
    $Excel.Visible = $false
    $Workbook = $Excel.Workbooks.add()
    $Sheet = $Workbook.ActiveSheet
    $Sheet.Name = 'IOC' # This is not needed, but here if you wanted to save the CSV that gets exported

    # Loop to populate the excel document with my values
    $Column = 1
    foreach ($Key in $IOCs.Key) {
        $Sheet.Cells.Item(1, $Column)
        $Row = 2
        foreach ($Value in $IOC.$key) {
            $Sheet.Cells.Item($Row, $Column) = ($value).tostring
            $Row = $Row + 1
        } # Close inner loop (The Value Loop)
    } # Close outer loop (The Key Loop)

    # Close up the excel document and export the Tab Separated file for Zeek
    $Sheet.SaveAs("$env:USERPROFILE\Documents\IOC.csv", 6) 
    <# https://docs.microsoft.com/en-us/office/vba/api/excel.xlfileformat
       https://docs.microsoft.com/en-us/office/vba/api/excel.workbook.saveas
    #>
    Get-Process -ProcessName Excel | Stop-Process
    Start-Sleep -Seconds 2
    Import-Csv "$env:USERPROFILE\Documents\IOC.csv" | Export-Csv -Delimiter "`t" "$env:USERPROFILE\Documents\IOC.tsv"
    Remove-Item "$env:USERPROFILE\Documents\IOC.csv" -Force
} # End of Function