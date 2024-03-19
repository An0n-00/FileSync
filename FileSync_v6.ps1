
#Autor: [redacted]
#Date: [redacted]
#Description: This is a script to sync files from one folder to another with other options like logging and reconfiguring the source and destination path. This script is designed to sync files from one folder to another with other options like logging and reconfiguring the source and destination path. The script provides a menu for the user to choose from various options such as syncing now, viewing current configuration, reconfiguring, opening log, and help. The user can also choose to remove all information or exit the script. The script uses the robocopy command for file synchronization.
# Version: 0.0.0.6
#############################################

# Variables
[int] $menuinput # User input for menu selection
[string] $syncoptions # Sync options

# Project related variables
[string] $ProjectName = "FileSync"
[string] $ProjectVersion = "0.0.0.6"
[string] $Tempfolder = [Environment]::GetFolderPath( 'LocalApplicationData' ) + "\FileSync"

# Source and destination paths for file synchronization
[string] $Sourcepath = ""
[string] $Destinationpath = ""

# File paths for settings and logs
[string] $settingsFilePath = "$Tempfolder\Settings.dll"
[string] $ErrorLogFilePath = "$Tempfolder\ErrorLog.log"
[string] $logFilePath = "$Tempfolder\FileSync.log"
[string] $logMessage
[int] $corrupted

# Sync options as strings
[string] $00000 = "[all contents]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $00001 = "[all contents]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $00010 = "[all contents]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $00011 = "[all contents]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
[string] $00100 = "[all contents]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $00101 = "[all contents]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $00110 = "[all contents]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $00111 = "[all contents]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
[string] $01000 = "[all contents]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $01001 = "[all contents]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $01010 = "[all contents]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $01011 = "[all contents]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
[string] $01100 = "[all contents]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $01101 = "[all contents]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $01110 = "[all contents]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $01111 = "[all contents]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
[string] $10000 = "[level 1 only]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $10001 = "[level 1 only]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $10010 = "[level 1 only]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $10011 = "[level 1 only]`n[Source to Destination]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
[string] $10100 = "[level 1 only]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $10101 = "[level 1 only]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $10110 = "[level 1 only]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $10111 = "[level 1 only]`n[Source to Destination]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
[string] $11000 = "[level 1 only]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $11001 = "[level 1 only]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $11010 = "[level 1 only]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $11011 = "[level 1 only]`n[Destination to Source]`n[without deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
[string] $11100 = "[level 1 only]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[copying files and directories]"
[string] $11101 = "[level 1 only]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[keeping all file information]`n[moving files and directories]"
[string] $11110 = "[level 1 only]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[copying files and directories]"
[string] $11111 = "[level 1 only]`n[Destination to Source]`n[deleting files and directories that no longer exist in the source]`n[deleting all file information]`n[moving files and directories]"
# End of SyncOptions
# End of Variables


#Functions
function menu {
    # This function provides a menu for the user to choose from various options.
    # The options include syncing now, viewing current configuration, reconfiguring, opening log, and help.
    # The user can also choose to remove all information or exit the script.
    do {
        log -logtype 1 -logMessage "Log: Menu opened"
        clear-host
        Write-Host "`n==========================================="
        Write-Host "| $ProjectName (ver.$ProjectVersion)                  |"
        Write-Host "|_________________________________________|"
        Write-Host "| (1) Sync now                            |"
        Write-Host "| (2) Current Configuration               |"
        Write-Host "| (3) Reconfigure                         |"
        Write-Host "| (4) Open Log                            |"
        Write-Host "| (5) Sourcecode                          |"
        Write-Host "|                                         |"
        Write-Host "| (95) Remove all Information             |"
        Write-Host "| (99) Exit                               |"
        Write-Host "|_________________________________________|`n"
        $menuinput = read-host "Please select an option"
        switch ( $menuinput ) {
            1 {
                log -logtype 1 -logMessage "Log: Sync started"
                PreSync
            }
            2 {
                log -logtype 1 -logMessage "Log: Printing current Configuration"
                Write-Host "`nSourcepath:`n$Sourcepath`n`nDestinationpath:`n$Destinationpath`n" -ForegroundColor Yellow
                Read-Host "Press Enter to return to menu..."
            }
            3 {
                log -logtype 1 -logMessage "Log: Reconfigure started"
                write-host "`nCurrent assigned sourcepath: $sourcepath`nCurrent assigned destinationpath: $destinationpath" -ForegroundColor Yellow
                setup -options 3
                setup -options 2
            }
            4 {
                log -logtype 1 -logMessage "Log: Log printed to Console"
                printlog
            }
            5 {
                log -logtype 1 -logMessage "Log: Help printed to Console"
                printSourceCode
            }
            95 {
                log -logtype 1 -logMessage "Log: Remove all Information started"
                Write-Host "READ BEFORE YOU ENTER`nYou are about to remove all information.`n`nIf you restart the script, you will be asked to reconfigure the settings and the script will automatically create the resource folders again." -ForegroundColor Red
                $u_sure = Read-Host "`nAre you sure? (y/n)"
                if ( $u_sure -eq "y" ) {
                    try {
                        Remove-Item -Path $Tempfolder -Recurse -Force
                    }
                    catch {
                        log -logtype 2 -logMessage = "Error: Removing the Tempfolder failed. Going back to Menu"
                        Write-Host "Error: Removing the Tempfolder failed. Going back to Menu`nYou try to remove the folder manually. Path: $Tempfolder" -ForegroundColor Red
                        Start-Sleep -Seconds 4
                        menu
                    }
                    Write-Host "`nAll Information removed. Exiting in 3 seconds..." -ForegroundColor Green
                    Start-Sleep -Seconds 3
                    exit
                }
                else {
                    log -logtype 1 -logMessage "Log: Remove all Information aborted"
                    Write-Host "`nAborted. Going back to Menu in 1 second..." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                }
            }
            99 {
                Write-Host "Bye!"
                log -logtype 1 -logMessage "End: FileSync exited successfully"
                Start-Sleep -Seconds 1
                exit
            }
            default {
                log -logtype 1 -logMessage "Log: Invalid input in Menu"
                write-host "Invalid input. Try again"
                Write-host "To exit, enter 99" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
            }
        }
        $menuinput = 0
    }until (0 -eq 1)
}

function PreSync {
    # This function prepares for file synchronization.
    # It asks the user for various options such as whether to sync all contents or the first level only,
    # whether to copy/move the contents from source to destination or vice versa,
    # whether to delete the destination files that no longer exist in the source,
    # whether to keep or remove all information about the files, and whether to copy or move files and directories.
    # Based on the user's choices, it prepares the appropriate robocopy command for file synchronization.
    log -logtype 1 -logMessage "Log: PreSync started ------------------------------------"
    $syncoptions = ""
    Write-Host "You are going to Sync files now. If you want to exit, enter q, if you want to proceed, enter. `n"
    Write-Host "Note: You will not be able to change the source and destinationpath until you have finished the sync." -ForegroundColor DarkYellow
    Write-Host "Note: You will not be able to exit the script during the sync. If you want to exit, exit now or after the sync configuration." -ForegroundColor DarkYellow

    $syncconfirmation = Read-Host "`nEnter p = proceed or e = exit"
    if ( $syncconfirmation -eq "p" ) {
        #if proceeding:
        log -logtype 1 -logMessage "Log: FileSync proceeded."

        [string] $robocopy_00000 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e  /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_00001 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e  /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_00010 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e  /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_00011 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e  /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_00100 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e /purge /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_00101 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e /purge /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_00110 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e /purge /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_00111 = "robocopy.exe ""$sourcepath"" ""$destinationpath"" /e /purge /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01000 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e  /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01001 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e  /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01010 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e  /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01011 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e  /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01100 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e /purge /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01101 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e /purge /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01110 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e /purge /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_01111 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /e /purge /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10000 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1  /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10001 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1  /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10010 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1  /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10011 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1  /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10100 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1 /purge /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10101 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1 /purge /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10110 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1 /purge /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_10111 = "robocopy.exe ""$sourcepath ""$destinationpath"" /lev:1 /purge /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11000 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1  /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11001 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1  /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11010 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1  /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11011 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1  /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11100 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1 /purge /copy:datxso /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11101 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1 /purge /copy:datxso /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11110 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1 /purge /nocopy /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "
        [string] $robocopy_11111 = "robocopy.exe ""$destinationpath"" ""$sourcepath"" /lev:1 /purge /nocopy /mov /r:0 /w:0 /np /log+:""$logFilePath"" /tee /eta "

        Clear-Host
        #Question 1 - Copy only the top directory or all contents
        Write-Host "Do you want to sync, all contents (0) or the first level only (1)?" -ForegroundColor Yellow
        do {
            $syncoptions += Read-Host "`n0 = All`nor`n1 = Level 1 Files only`n`nEnter your option"
            if ( $syncoptions -eq "0" ) {
                log -logtype 1 -logMessage "Log: FileSync: Syncing all contents"
            }
            elseif ( $syncoptions -eq "1" ) {
                log -logtype 1 -logMessage "Log: FileSync: Syncing level 1 only"
            }
            else {
                log -logtype 1 -logMessage "Log: FileSync: Invalid input in SyncOptions question 1 ($syncoptions)"
                Write-Host "Invalid input. Try again`n" -ForegroundColor Red
                $syncoptions = ""
            }
        } until (($syncoptions -eq "0" -or $syncoptions -eq "1" ) -and $syncoptions.Length -eq 1)

        #Question 2 - Copy/Move from (A to B) or (B to A)
        Write-Host "`n`nDo you want to copy/move the contents from: `n(0): sourcepath to destinationpath `nor `n(1): destinationpath to sourcepath`n`nSourcepath being: $sourcepath`nDestinationpath being: $destinationpath`n" -ForegroundColor Yellow
        do {
            $syncoptions += Read-Host "0 = source to destination`nor`n1 = destination to source`n`nEnter your option"
            if ( $syncoptions[ - 1] -eq "0" ) {
                log -logtype 1 -logMessage "Log: FileSync: Copying/moving from Source ($sourcepath) to Destination ($destinationpath)"
            }
            elseif ( $syncoptions[ - 1] -eq "1" ) {
                log -logtype 1 -logMessage "Log: FileSync: Copying/moving from Destination ($destinationpath) to Source ($sourcepath)"
            }
            else {
                log -logtype 1 -logMessage "Log: FileSync: Invalid input in SyncOptions"
                Write-Host "Invalid input. Try again`n" -ForegroundColor Red
                $syncoptions.Substring(0, $string.Length - 1)
            }
        } until (($syncoptions[ - 1] -eq "0" -or $syncoptions[ - 1] -eq "1" ) -and $syncoptions.Length -eq 2)

        #Question 3 - Delete files and directories that no longer exist in the source?
        Write-Host "`n`nDo you want to delete the destination files (and directories) that no longer exist in the source? (but still do in the destination)" -ForegroundColor Yellow
        Write-Host "`nNote: source and destination is relative in this question, meaning it depends from where to where you are moving/copying your contents and NOT what you have set in the configuration." -ForegroundColor DarkYellow
        do {
            $syncoptions += Read-Host "`n0 = No`nor`n1 = Yes`n`nEnter your option"
            if ( $syncoptions[ - 1] -eq "0" ) {
                log -logtype 1 -logMessage "Log: FileSync: Not deleting files and directories that no longer exist in the source"
            }
            elseif ( $syncoptions[ - 1] -eq "1" ) {
                log -logtype 1 -logMessage "Log: FileSync: Deleting files and directories that no longer exist in the source"
            }
            else {
                log -logtype 1 -logMessage "Log: FileSync: Invalid input in SyncOptions"
                Write-Host "Invalid input. Try again`n" -ForegroundColor Red
                $syncoptions.Substring(0, $string.Length - 1)
            }
        }until (($syncoptions[ - 1] -eq "1" -or $syncoptions[ - 1] -eq "0" ) -and $syncoptions.Length -eq 3)


        #Question 4 - Keep or remove all information about the file
        Write-Host "`n`nDo you want to keep (0) or remove (1) ALL information ABOUT the files (and directories)?`n" -ForegroundColor Yellow
        do {
            $syncoptions += Read-Host "0 = keep information`nor`n1 = remove information`n`nEnter your option"
            if ( $syncoptions[ - 1] -eq "0" ) {
                log -logtype 1 -logMessage "Log: FileSync: Keeping all information about the file"
            }
            elseif ( $syncoptions[ - 1] -eq "1" ) {
                log -logtype 1 -logMessage "Log: FileSync: Removing all information about the file"
            }
            else {
                log -logtype 1 -logMessage "Log: FileSync: Invalid input in SyncOptions"
                Write-Host "Invalid input. Try again" -ForegroundColor Red
                $syncoptions.Substring(0, $string.Length - 1)
            }
        }until (($syncoptions[ - 1] -eq "0" -or $syncoptions[ - 1] -eq "1" ) -and $syncoptions.Length -eq 4)


        #Question 5 - Move or Copy files and directories
        Write-Host "`n`nDo you want to copy (0) or move (1) files and (directories)?" -ForegroundColor Yellow
        do {
            $syncoptions += Read-Host "`n0 = copy`nor`n1 = move`n`nEnter your option"
            if ( $syncoptions[ - 1] -eq "0" ) {
                log -logtype 1 -logMessage "Log: FileSync: Copying files and/or directories"
            }
            elseif ( $syncoptions[ - 1] -eq "1" ) {
                log -logtype 1 -logMessage "Log: FileSync: Moving files and/or directories"
            }
            else {
                log -logtype 1 -logMessage "Log: FileSync: Invalid input in SyncOptions"
                Write-Host "Invalid input. Try again" -ForegroundColor Red
                $syncoptions.Substring(0, $string.Length - 1)
            }
        }until (($syncoptions[ - 1] -eq "0" -or $syncoptions[ - 1] -eq "1" ) -and $syncoptions.Length -eq 5)


        if ( $syncoptions.Length -eq 5 ) {
            log -logtype 1 -logMessage "Log: FileSync: Sync options are valid"
        }
        else {
            log -logtype 1 -logMessage "Log: FileSync: Sync options are invalid. Too many characters in SyncOptions"
            Write-Host "Error! You are seeing this error message, because you've added multiple characters while answering the questions. That is not allowed. You are returning to the menu." -ForegroundColor Red
            ${script:syncoptions} = $null
            ${script:syncpassed} = $null
            ${script:syncconfirmation} = $null
            ${script:sync_check} = $null
            Read-Host "Press Enter to return to menu..."
            return
        }
        Clear-Host
        #Starting sync with the given options
        #Documentation https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
        switch ( $syncoptions ) {
            "00000" {
                FileSync -run_what $robocopy_00000 -write_what $00000
            }
            "00001" {
                FileSync -run_what $robocopy_00001 -write_what $00001
            }
            "00010" {
                FileSync -run_what $robocopy_00010 -write_what $00010
            }
            "00011" {
                FileSync -run_what $robocopy_00011 -write_what $00011
            }
            "00100" {
                FileSync -run_what $robocopy_00100 -write_what $00100
            }
            "00101" {
                FileSync -run_what $robocopy_00101 -write_what $00101
            }
            "00110" {
                FileSync -run_what $robocopy_00110 -write_what $00110
            }
            "00111" {
                FileSync -run_what $robocopy_00111 -write_what $00111
            }
            "01000" {
                FileSync -run_what $robocopy_01000 -write_what $01000
            }
            "01001" {
                FileSync -run_what $robocopy_01001 -write_what $01001
            }
            "01010" {
                FileSync -run_what $robocopy_01010 -write_what $01010
            }
            "01011" {
                FileSync -run_what $robocopy_01011 -write_what $01011
            }
            "01100" {
                FileSync -run_what $robocopy_01100 -write_what $01100
            }
            "01101" {
                FileSync -run_what $robocopy_01101 -write_what $01101
            }
            "01110" {
                FileSync -run_what $robocopy_01110 -write_what $01110
            }
            "01111" {
                FileSync -run_what $robocopy_01111 -write_what $01111
            }
            "10000" {
                FileSync -run_what $robocopy_10000 -write_what $10000
            }
            "10001" {
                FileSync -run_what $robocopy_10001 -write_what $10001
            }
            "10010" {
                FileSync -run_what $robocopy_10010 -write_what $10010
            }
            "10011" {
                FileSync -run_what $robocopy_10011 -write_what $10011
            }
            "10100" {
                FileSync -run_what $robocopy_10100 -write_what $10100
            }
            "10101" {
                FileSync -run_what $robocopy_10101 -write_what $10101
            }
            "10110" {
                FileSync -run_what $robocopy_10110 -write_what $10110
            }
            "10111" {
                FileSync -run_what $robocopy_10111 -write_what $10111
            }
            "11000" {
                FileSync -run_what $robocopy_11000 -write_what $11000
            }
            "11001" {
                FileSync -run_what $robocopy_11001 -write_what $11001
            }
            "11010" {
                FileSync -run_what $robocopy_11010 -write_what $11010
            }
            "11011" {
                FileSync -run_what $robocopy_11011 -write_what $11011
            }
            "11100" {
                FileSync -run_what $robocopy_11100 -write_what $11100
            }
            "11101" {
                FileSync -run_what $robocopy_11101 -write_what $11101
            }
            "11110" {
                FileSync -run_what $robocopy_11110 -write_what $11110
            }
            "11111" {
                FileSync -run_what $robocopy_11111 -write_what $11111
            }
        }
    }
    elseif ($syncconfirmation -eq "e") {
        ${script:syncoptions} = $null
        ${script:syncpassed} = $null
        ${script:syncconfirmation} = $null
        ${script:sync_check} = $null
        log -logtype 1 -logMessage "Log: FileSync aborted"
        Write-Host "`nAborted. Going back to Menu in 1 second..." -ForegroundColor Red
        Start-Sleep -Seconds 1
        return
    }
    else {
        ${script:syncoptions} = $null
        ${script:syncpassed} = $null
        ${script:syncconfirmation} = $null
        ${script:sync_check} = $null
        log -logtype 1 -logMessage "Log: Invalid sync confirmation in FileSync. Returning to FileSync Menu"
        Write-Host "Invalid input! Returning to FileSync Menu." -ForegroundColor Red
        Start-Sleep -Seconds 2
        return
    }
}

function FileSync {
    # This function performs file synchronization based on the user's choices.
    # It executes the appropriate robocopy command prepared by the PreSync function.
    # After the synchronization, it checks the exit code of the robocopy command and informs the user about the result.
    param (
        [string]$run_what,
        [string]$write_what
    )
    Clear-Host
    log -logtype 1 -logMessage "Log: FileSync: Confirming to Sync with $write_what"
    Write-Host "You are about to sync with the following Options:`n`n$write_what"
    $sync_check = Read-Host "`n`nAre you sure you want to proceed? (y)"
    if ( $sync_check -eq "y" ) {
        log -logtype 1 -logMessage "Log: FileSync: Syncing started"
        Write-Host "Proceeding with the sync. This may take a while."
        Write-Host "Warning: Do not close the script during the sync!" -ForegroundColor Red
        Invoke-Expression $run_what
        $syncpassed = $LASTEXITCODE
        log -logtype 1 -logMessage "Log: FileSync: Syncing finished"
    }
    else {
        log -logtype 1 -logMessage "Log: FileSync: Syncing aborted"
        Write-Host "`nAborted. Going back to Menu in 2 second..." -ForegroundColor Red
        Start-Sleep -Seconds 2
        return
    }

    switch ( $syncpassed ) {
        0 {
            Write-Host "No files were copied. No failure was encountered. No files were mismatched. The files already exist in the destination directory; therefore, the copy operation was skipped." -ForegroundColor Green
            log -logtype 1 -logMessage "No files were copied. No failure was encountered. No files were mismatched. The files already exist in the destination directory; therefore, the copy operation was skipped."
        }
        1 {
            Write-Host "All files were copied successfully." -ForegroundColor Green
            log -logtype 1 -logMessage "All files were copied successfully." 
        }
        2 {
            Write-Host "There are some additional files in the destination directory that aren't present in the source directory. No files were copied." -ForegroundColor Green
            log -logtype 1 -logMessage "There are some additional files in the destination directory that aren't present in the source directory. No files were copied."
        }
        3 {
            Write-Host "Some files were copied. Additional files were present. No failure was encountered." -ForegroundColor Green
            log -logtype 1 -logMessage "Some files were copied. Additional files were present. No failure was encountered."
        }
        5 {
            Write-Host "Some files were copied. Some files were mismatched. No failure was encountered." -ForegroundColor Green
            log -logtype 1 -logMessage "Some files were copied. Some files were mismatched. No failure was encountered."
        }
        6 {
            Write-Host "Additional files and mismatched files exist. No files were copied and no failures were encountered meaning that the files already exist in the destination directory." -ForegroundColor Green
            log -logtype 1 -logMessage "Additional files and mismatched files exist. No files were copied and no failures were encountered meaning that the files already exist in the destination directory."
        }
        7 {
            Write-Host "Files were copied, a file mismatch was present, and additional files were present." -ForegroundColor Red
            log -logtype 1 -logMessage "Files were copied, a file mismatch was present, and additional files were present."
        }
        8 {
            Write-Host "Several files didn't copy." -ForegroundColor Red
            log -logtype 1 -logMessage "Several files didn't copy."
        }
        default {
            Write-Host "An unknown error occurred. Please reffer to the log file for more information." -ForegroundColor Red
            log -logtype 1 -logMessage "Log: File Sync: An unknown error occurred."
        }
    }
    ${script:syncoptions} = $null
    ${script:syncpassed} = $null
    ${script:syncconfirmation} = $null
    ${script:sync_check} = $null
    Read-Host "`nPress Enter to return to menu..."
}

function printlog {
    # This function prints the log file to the console.
    Clear-Host
    Get-Content -Path $logFilePath | Out-Host 
    Read-Host "`nPress Enter to return to menu..."
}

function printSourceCode {
    # This function provides help information to the user.
    Clear-Host
    Write-Host "This script is on GitHub! You can find it here: https://github.com/An0n-00/FileSync`n"
    Write-Host "Don't forget to read this handy documentation: https://An0n-00.github.io/FileSync`n"
    Read-Host "`nPress Enter to return to menu..."
}

function startup {
    # This function performs startup checks.
    # It checks if the temp folder, log file, error log file, and settings file exist.
    # If any of them does not exist, it creates them.
    # It also checks if the source and destination paths are valid.
    # If any of them is not valid, it asks the user to enter a new one.
    log -logtype 1 -logMessage "Log: Startup started"
    if ( Test-Path -Path $Tempfolder ) {
        #Do nothing, continue
    }
    else {
        Write-Host "This script is designed to sync files from one folder to another with other options like logging and reconfiguring the source and destination path and many more.`n"
        Read-Host "Press Enter to continue..."
        setup -options 1
        startup
    }
    Write-Host "Checking Tempfolder..."  -NoNewline
    Write-Host "Success!" -ForegroundColor Green
    Write-Host "Checking Logfile..." -NoNewline
    #Check if the Logfile exists
    if ( Test-Path -Path "$Tempfolder\FileSync.log" ) {
        Write-Host "Success!" -ForegroundColor Green
        log -logtype 1 -logMessage "Log: Logfile exists"
    }
    else {
        Write-Host "Error. Fixing" -ForegroundColor Red
        setup -options 4
        startup
    }
    #Check if the ErrorLogfile exists
    Write-Host "Checking Errorlogfile..." -NoNewline
    if ( Test-Path -Path "$Tempfolder\ErrorLog.log" ) {
        Write-Host "Success!" -ForegroundColor Green
        log -logtype 1 -logMessage "Log: ErrorLogfile exists"
    }
    else {
        Write-Host "Error. Fixing" -ForegroundColor Red
        log -logtype 1 -logMessage "Error: Logfile does not exist. Creating new one"
        setup -options 5
        startup
    }
    #Check if settings file exists
    Write-Host "Checking Settings..." -NoNewline
    if ( Test-Path -Path $settingsFilePath ) {
        log -logtype 1 -logMessage "Log: Settings file exists."
        try {
            log -logtype 1 -logMessage "Log: Reading settings file"
            $content = Get-Content -Path $settingsFilePath
            if ( -not ($content[2] -match "Sourcepath =" ) ) {
                Write-Host "Error! Settings file is corrupted. Overwriting ALL past files!" -ForegroundColor Red
                setup -options 1 -corrupted 1
            }
            elseif (-not ($content[3] -match "Destinationpath =" )) {
                Write-Host "Error! Settings file is corrupted. Overwriting ALL past files!" -ForegroundColor Red
                setup -options 1 -corrupted 1
            }
            foreach ( $line in $content ) {
                if ( $line -match "Sourcepath = (.*)" ) {
                    ${script:Sourcepath} = $Matches[1]
                }
                elseif ( $line -match "Destinationpath = (.*)" ) {
                    ${script:Destinationpath} = $Matches[1]
                }
            }
            log -logtype 1 -logMessage "Log: Settings read successfully. Starting to validate paths"
            if ( (Test-Path -Path $Sourcepath) -and (-not ($null -eq $Sourcepath)) ) {
                log -logtype 1 -logMessage "Log: Read sourcepath is valid"
                if ( (Test-Path -Path $Destinationpath) -and (-not ($null -eq $Destinationpath))) {
                    log -logtype 1 -logMessage "Log: Read Destinationpath is valid"
                    Write-Host "Success!" -ForegroundColor Green
                    log -logtype 1 -logMessage "Log: Startup finished successfully"
                    Start-Sleep -Seconds 1
                    return
                }
                else {
                    log -logtype 1 -logMessage "Log: Destinationpath is invalid. Jumping to setup -options 2 to set a new one"
                    write-host "Destinationpath is invalid. Please set a new one" -ForegroundColor Red
                    setup -options 2
                    startup
                }
            }
            else {
                log -logtype 1 -logMessage "Log: Sourcepath is invalid. Jumping to setup -options 3 to set a new one"
                write-host "Sourcepath is invalid. Please set a new one." -ForegroundColor Red
                setup -options 3
                startup
            }
        }
        catch {
            Write-Host "Tried to read the settings file, but failed. Overwriting ALL past Files (including log files)." -ForegroundColor Red
            setup -options 1
            startup
        }
    }
    else {
        Write-Host "Settings file not found. Overwriting ALL past Files (including log files)." -ForegroundColor Red
        setup -options 1
        startup
    }
}

function setup {
    # This function performs setup tasks based on the given options.
    # The options include creating the temp folder, log file, error log file, and settings file,
    # and setting new source and destination paths.
    param(
        [int]$options,
        [int]$corrupted
    )
    switch ( $options ) {
        1 {
            try {
                log -logtype 1 -logMessage "Log: Creating the Files and Settings. Running Setup -options 1"
                Write-Host "Setting up Tempfolder..."  -NoNewline
                if ( -not (Test-Path -Path $Tempfolder ) ) {
                    New-Item -Path $Tempfolder -ItemType Directory -Force | Out-Null
                    log -logtype 1 -logMessage "Log: Created Tempfolder. Running Setup -options 1"
                }
                else {
                    log -logtype 1 -logMessage "Log: Tempfolder already exists. Running Setup -options 1"
                }
                Write-Host "Success!" -ForegroundColor Green

                Write-Host "Setting up Logfiles..." -NoNewline
                #Logfile
                setup -options 4
                #ErrorLogfile
                setup -options 5
                Write-Host "Success!" -ForegroundColor Green

                Write-Host "Setting up Settings..." -NoNewline
                #Settings file
                if ( (-not (Test-Path -Path $settingsFilePath ) ) -or ($corrupted -eq 1 ) ) {
                    New-Item -Path $settingsFilePath -ItemType File -Force -Value "# $ProjectName $ProjectVersion`n# DO NOT EDIT THIS FILE`nSourcepath = $sourcepath`nDestinationpath = $destinationpath" | Out-Null
                    log -logtype 1 -logMessage "Log: Created Settings file"
                    setup -options 3
                    setup -options 2
                }
                else {
                    log -logtype 1 -logMessage "Log: Settings file already exists. Running Setup -options 1"
                }
                Write-Host "Success!" -ForegroundColor Green
            }
            catch {
                log -logtype 2 -logMessage = "Error: Creating the Files and Settings failed. exiting setup -options 1."
                Write-Host "Error: Creating the Files and Settings failed. Please make sure you have the right permissions to create files and folders." -ForegroundColor Red
                Start-Sleep -Seconds 7
                exit
            }
            log -logtype 1 -logMessage "Log: Setup -options 1 successfully finished"
            Write-Host "Setup finished successfully." -ForegroundColor Green
        }
        2 {
            # Destination path
            do {
                log -logtype 1 -logMessage "Log: Setting new destinationpath. Running Setup -options 2"

                ${script:Destinationpath} = Read-Host "`nPlease enter the new destinationpath"
                $isValidPath = -not ($null -eq $Destinationpath) -and (Test-Path ${script:Destinationpath} ) -and (${script:Destinationpath}.Trim( ) -ne "" ) -and (${script:Destinationpath} -ne ${script:Sourcepath} )
                if ( -not $isValidPath ) {
                    log -logtype 1 -logMessage "Log: Destinationpath is invalid (${script:Destinationpath}). Running Setup -options 2"
                    Write-Host "The path is not valid. Please enter a valid path."
                }
            } until ($isValidPath)
            log -logtype 1 -logMessage "Log: Destinationpath is valid. Trying to save to Settings. Running Setup -options 2"
            $content = Get-Content -Path $settingsFilePath
            ForEach-Object {
                if ( $content -match "Destinationpath = (.*)" ) {
                    $content -replace "Destinationpath = (.*)", "Destinationpath = ${script:Destinationpath}" | Out-File -FilePath $settingsFilePath -Force
                }
            }
            log -logtype 1 -logMessage "Log: Successfully saved destinationpath to settings. Running Setup -options 2"
            log -logtype 1 -logMessage "Log: Setup -options 2 successfully finished"
        }
        3 {
            # Source path
            do {
                log -logtype 1 -logMessage "Log: Setting new sourcepath. Running Setup -options 3"
                ${script:Sourcepath} = Read-Host "`nPlease enter the new sourcepath"
                $isValidPath = -not ($null -eq $Destinationpath) -and (Test-Path ${script:Sourcepath} ) -and (${script:Sourcepath}.Trim( ) -ne "" ) -and (${script:Destinationpath} -ne ${script:Sourcepath} )
                if ( -not $isValidPath ) {
                    log -logtype 1 -logMessage "Log: Sourcepath is invalid (${script:Sourcepath}). Running Setup -options 3"
                    Write-Host "The path is not valid. Please enter a valid path."
                }
            } until ($isValidPath)
            log -logtype 1 -logMessage "Log: Sourcepath is valid (${script:Sourcepath}). Trying to save to Settings. Running Setup -options 3"
            $content = Get-Content -Path $settingsFilePath
            ForEach-Object {
                if ( $content -match "Sourcepath = (.*)" ) {
                    $content -replace "Sourcepath = (.*)", "Sourcepath = ${script:Sourcepath}" | Out-File -FilePath $settingsFilePath -Force
                }
            }
            log -logtype 1 -logMessage "Log: Successfully saved sourcepath to settings. Running Setup -options 3"
            log -logtype 1 -logMessage "Log: Setup -options 3 successfully finished"
        }
        4 {
            #Logfile
            if ( -not (Test-Path -Path $logFilePath ) ) {
                [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss"
                New-Item -Path $logFilePath -ItemType File -Force -Value "Created Logfile at $timestamp`n###################  Log start:  ###################`n" | Out-Null
                log -logtype 1 -logMessage "Log: Created Logfile. Running Setup -options 4"
            }
            else {
                log -logtype 1 -logMessage "Log: Logfile already exists. Returning to original function."
            }
        }
        5 {
            #ErrorLogfile
            if ( -not (Test-Path -Path $ErrorLogFilePath ) ) {
                [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss"
                New-Item -Path $ErrorLogFilePath -ItemType File -Force -Value "Created Error Logfile at $timestamp`n###################  Error Log start:  ###################`n" | Out-Null
                log -logtype 1 -logMessage "Log: Created Logfile. Running Setup -options 5"
            }
            else {
                log -logtype 1 -logMessage "Log: ErrorLogFile already exists. Returning to original function."
            }
        }
    }
}

function log {
    # This function logs messages to the log file or error log file based on the given log type.
    param(
        [int]$logtype,
        [string]$logMessage
    )
    try {
        if ( (test-path -path $logFilePath ) -and $logtype -eq 1 ) {
            [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss"
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $logFilePath -Append -Encoding utf8
        }
        elseif ((test-path -path $ErrorLogFilepath ) -and $logtype -eq 2) {
            [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss"
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $ErrorLogFilePath -Append -Encoding utf8
        }
    }
    catch {
        return
    }
}

function logo {
    # This function prints the logo and welcome message to the console.
    log -logtype 1 -logMessage "Log: Logo printed to console"
    clear-host
    write-host "  _____ _ _      ____
 |  ___(_) | ___/ ___| _   _ _ __   ___
 | |_  | | |/ _ \___ \| | | | '_ \ / __|
 |  _| | | |  __/___) | |_| | | | | (__
 |_|   |_|_|\___|____/ \__, |_| |_|\___|
                       |___/
                                            ($ProjectVersion)
====================================================="
    Write-Host "`nWelcome to FileSync!`n"
    Write-Host "Booting FileSync" -NoNewline
    [int] $i = 0
    do {
        $i++
        Start-Sleep -Seconds 1
        Write-Host "." -NoNewline
    }until ($i -eq 3)
    Write-Host "`n"
}

function main {
    # This is the main function of the script.
    # It calls the logo function, startup function, and menu function in order.
    Clear-Host
    log -logtype 1 -logMessage "Start: FileSync started"
    logo
    startup
    menu
}

#Main
try {
    main
}
catch {
    log -logtype 1 -logMessage "Fatal Error: FileSync crashed. See newest error log for details."
    log -logtype 2 -logMessage "CRASH: FileSync crashed. `nError Message: $($_.Exception.ToString( ) )`n`n"
    Write-Host "Critical Error: FileSync crashed. See log for details.`nRead the error log for more details: $ErrorLogFilePath" -ForegroundColor Red
    Read-Host "Press Enter to return to menu..."
    do {
        main
    }until (0 -eq 1)
}
