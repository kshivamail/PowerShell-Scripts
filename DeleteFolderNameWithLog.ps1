#################################################################################################
#			Authors     : Dilip Kumar P & Sivakumar Kuppusamy
#			Date        : 30/03/2018
#			Script Name : DeleteFolderNameWithLog
#			Description : Delete Seleted Folders in Particular Location using input folder names
#################################################################################################
Write-Host " "
Write-Host "~~~~~> Initializing Script <~~~~~" -ForegroundColor Magenta
$inputpath = ".\"
$menu=@"
1 Delete Single Folder
2 Delete Multiple Folders
Q Quit
 
Select a task by number or Q to quit
"@
Do
{
Write-Host " "
Write-Host "----------------------------------" -ForegroundColor Cyan
foreach($element in "     ===>"){Write-Host –NoNewLine  "${element} " -BackgroundColor "Yellow" -ForegroundColor "Black"; Start-Sleep -Milliseconds 300}
foreach($element in " Script"){Write-Host –NoNewLine  "${element} " -BackgroundColor "Green" -ForegroundColor "Black"; Start-Sleep -Milliseconds 300}
foreach($element in " Menu"){Write-Host –NoNewLine  "${element} " -BackgroundColor "Red" -ForegroundColor "Black"; Start-Sleep -Milliseconds 300}
foreach($element in " <===    "){Write-Host –NoNewLine  "${element} " -BackgroundColor "Yellow" -ForegroundColor "Black"; Start-Sleep -Milliseconds 300}
Write-Host " "
Write-Host "----------------------------------" -ForegroundColor Cyan
$r = Read-Host $menu
Switch ($r) {
"1" {
    Write-Host " "
    Write-Host "Getting Single Folder Name" -ForegroundColor Yellow
    Write-Host " "
    $FolderNames = Read-Host "Please Enter Folder Name"
    }
 
"2" {
    Write-Host " "
    Write-Host "Getting Multiple Multiple Folders Name" -ForegroundColor Green
    Write-Host " "
            if ( -Not (Test-Path "$inputpath\Folders.txt"))
            {
                New-Item -Path "$inputpath\Folders.txt" -ItemType File -Force | out-null
            }
            Write-Host "<Folders.txt> - Input file is created. Please provide folders name then save a file." -ForegroundColor Magenta
            Start-Sleep -Seconds 2
            Write-Host " "
            Write-Host "<Folders.txt> - File will open automatically." -ForegroundColor Yellow
            Start-Sleep -Seconds 2
            Invoke-Item $inputpath\Folders.txt
            Write-Host " "
            Write-Host "Are you saved <Folders.txt> file ?" -ForegroundColor Magenta
            Write-Host " "
    $answer = Read-Host "Press 'Y' to Continue"
    while("Y" -notcontains $answer)
    {
	$answer = Read-Host "Press 'Y' to Continue"
    }
    $FolderNames = Get-Content $inputpath\Folders.txt
    #$htmlreportcombined = @()
    }
 
"Q" {
    Write-Host "Quitting" -ForegroundColor Red
    Exit
    }

default {
        Write-Host " "
        Write-Warning "I don't understand what you want to do."
        Write-Host " "
        Write-Host "Please select menu options '1' or '2' and 'Q' to quit." -ForegroundColor Black -BackgroundColor White
        }
} #end switch
}
Until (($r -eq 1) -or ($r -eq 2))
Write-Host " "
# Script Function
$Space = Write-Output " "
$DT = Get-Date
Write-Host "Input Location Eg : C:\Folder  or  \\server\share\*" -ForegroundColor Red -BackgroundColor Yellow
Write-Host " "
$Loc = Read-Host "Enter location where you need to Delete the Folders"
$LogFile = "$inputpath\DeletedFolders.txt"
$Msg = "Deleted Folders and Date with Time : $DT"
$Msg >> $LogFile
$Space >> $LogFile
#$Folders = Get-ChildItem -Directory $Loc -Recurse
foreach ($FolderName in $FolderNames) { 
            if ($FolderName -ne $Null) { 
                Add-Content $LogFile $FolderName
                write-host "Deleting Folder --> $FolderName" -ForegroundColor "Yellow"

                Remove-Item -Path $Loc -Force -Recurse | where 
                 $Folder.Name -Force -ErrorAction SilentlyContinue 
            } 
        } 
        remove-item -path "\\server\share\*" -Force -Recurse -ErrorAction SilentlyContinue



        function removeme
 { 
  [CmdletBinding()]
  Param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$folder,
  [Parameter(Mandatory=$True,Position=2)]
  [string[]]$include,
  [Parameter(Mandatory=$false,Position=3)]
  [string]$exclude
  )
  get-childitem -Path $folder -Include $include -exclude $exclude -recurse -ErrorAction SilentlyContinue | remove-item -force
}


removeme c:\temp @(get-content c:\test\test.txt)


##########

$files = GC "C:\filenames.txt"

foreach ($file in $files)
{
  Try{
  GCI  "D:\temp\$file*" -Filter *.txt | remove-item -Force -Recurse -ErrorAction stop
  }
  Catch{
  Write-Warning $_
  }}

  #########

  Get-Content -Path "C:\filenames.txt" | Remove-Item

  Get-Content -Path "C:\filenames.txt" | ForEach-Object {Remove-Item "C:\DeletePath\$_.*"}



