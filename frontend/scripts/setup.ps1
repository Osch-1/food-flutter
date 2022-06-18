function WriteColor($message, $color) {
    Write-Host $message -ForegroundColor $color
}

function WriteRed($message) {
    WriteColor $message "Red"
}

function WriteYellow($message) {
    WriteColor $message "Yellow"
}

function WriteGreen($message) {
    WriteColor $message "Green"
}

function WriteBlue($message) {
    WriteColor $message "Blue"
}

function WriteHeader($message) {
    Write-Host ""
    WriteBlue "=== $message ==="
    Write-Host ""
}

function CheckLastCommand {
    if (-not $?) {
        ExitWithError($Error[0].Exception.Message)
    }
    WriteGreen "OK"
}

function RemovePath($path) {
    if (Test-Path $path -ErrorAction SilentlyContinue) {
        Write-Host "Removing path ""$path""..." -NoNewline
        if (Test-Path $path -PathType Container) {
            Get-ChildItem -Path $path -Recurse | Remove-Item -force -recurse -ErrorAction Stop
        }
        Remove-Item $path -Force -Recurse -ErrorAction Stop
        CheckLastCommand
    }
}

function GetUserEnvironmentPath {
    return [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User)
}

function SetUserEnvironmentPath($value) {
    [Environment]::SetEnvironmentVariable("Path", $value, [EnvironmentVariableTarget]::User)
    CheckLastCommand
}

function RemovePathEntry($entry) {
    $oldPathStringValue = GetUserEnvironmentPath
    $oldPathArrayValue = $oldPathStringValue.Split(';')
    $newPathArrayValue = $oldPathArrayValue | Where-Object -FilterScript { -Not($_ -eq $entry) }
    if (-Not ($newPathArrayValue.Length -eq $oldPathArrayValue.Length)) {
        Write-Host "Removing entry ""$entry"" from ""Path"" environment variable..." -NoNewline
        SetUserEnvironmentPath $newPathArrayValue -Join ';'
    }
}

function AddPathEntry($entry) {
    $userPath = GetUserEnvironmentPath
    Write-Host "Adding entry ""$entry"" to ""Path"" environment variable..." -NoNewline
    SetUserEnvironmentPath "$entry;$userPath"
}

function ExitWithError($errorMessage) {
    Write-Host ""
    WriteRed "Error: $errorMessage"
    [Environment]::Exit(1)
}

function CommandExists($command) {
    return Get-Command $command -ErrorAction SilentlyContinue
}

function InstallFlutter($flutterSdkPath, $commitShaPath) {
    Write-Host "Cloning Flutter SDK to user home directory..." -NoNewline
    $env:GIT_REDIRECT_STDERR = '2>&1'
    git clone -n https://github.com/flutter/flutter.git $flutterSdkPath | Out-Null
    CheckLastCommand
    $commitSha = if (Test-Path($commitShaPath)) { [IO.File]::ReadAllLines($commitShaPath)[0] } else { "HEAD" }
    Write-Host "Checking out to $commitSha..." -NoNewline
    Set-Location $flutterSdkPath
    git checkout $commitSha | Out-Null
    CheckLastCommand
    Set-Location $PSScriptRoot\..
}

$commitShaPath = "$PSScriptRoot\..\flutter_sdk.version";
$flutterSdkPath = "$home\FlutterSdk"
$flutterSdkBinPath = "$flutterSdkPath\bin";
$flutterSdkDartBinPath = "$flutterSdkBinPath\cache\dart-sdk\bin"

WriteHeader "Clean"

Stop-Process -Name "adb" -ErrorAction SilentlyContinue

RemovePath $flutterSdkPath
RemovePath "$env:APPDATA\Pub"

RemovePath "$env:APPDATA\.flutter"
RemovePath "$env:APPDATA\.flutter_settings"

RemovePathEntry $flutterSdkBinPath
RemovePathEntry $flutterSdkDartBinPath

WriteHeader "Install"

if ($PSVersionTable.PSVersion.Major -lt 5) {
    ExitWithError "Your PowerShell version is $($PSVersionTable.PSVersion.Major), but 5.0 or newer is required."
}

if (-Not (CommandExists "git")) {
    ExitWithError "Git for Windows 2.x with the ""Use Git from the Windows Command Prompt"" option is required"
}

if (CommandExists "flutter") {
    WriteYellow "Warning: Another Flutter SDK installation was found in system"
}

InstallFlutter $flutterSdkPath $commitShaPath

AddPathEntry $flutterSdkBinPath
AddPathEntry $flutterSdkDartBinPath

cmd.exe /C "$flutterSdkBinPath\flutter" config --enable-web

WriteGreen "Setup succeeded. Please restart console to work with flutter console utility"