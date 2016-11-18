
# wipe screen
Clear-Host

$PROJECT_HOME = $PSScriptRoot
$DEMO="Install Demo"
$AUTHORS="Andrew Block, Eric D. Schabell"
$PROJECT="git@github.com:jbossdemocentral/bpms-install-demo.git"
$PRODUCT="JBoss BPM Suite"
$TARGET=$PROJECT_HOME\target
$JBOSS_HOME="$TARGET\jboss-eap-7.0"
$SERVER_DIR="$JBOSS_HOME\standalone\deployments\"
$SERVER_CONF="$JBOSS_HOME\standalone\configuration\"
$SERVER_BIN="$JBOSS_HOME\bin"
$SRC_DIR="$PROJECT_HOME\installs"
$SUPPORT_DIR="$PROJECT_HOME\support"
$PRJ_DIR="$PROJECT_HOME\projects"
$BPMS="jboss-bpmsuite-6.4.0.GA-deployable-eap7.x.zip"
$EAP="jboss-eap-6.4.0-installer.jar"
#$EAP_PATCH="jboss-eap-6.4.7-patch.zip"
$VERSION="6.4"

Write-Host "#################################################################"
Write-Host "##                                                             ##"
Write-Host "##  Setting up the %DEMO%                          ##"
Write-Host "##                                                             ##"
Write-Host "##                                                             ##"
Write-Host "##     ####  ####   #   #      ### #   # ##### ##### #####     ##"
Write-Host "##     #   # #   # # # # #    #    #   #   #     #   #         ##"
Write-Host "##     ####  ####  #  #  #     ##  #   #   #     #   ###       ##"
Write-Host "##     #   # #     #     #       # #   #   #     #   #         ##"
Write-Host "##     ####  #     #     #    ###  ##### #####   #   #####     ##"
Write-Host "##                                                             ##"
Write-Host "##                                                             ##"
Write-Host "##  brought to you by,                                         ##"
Write-Host "##                     %AUTHORS%           ##"
Write-Host "##                       %AUTHORS2%          ##"
Write-Host "##                                                             ##"
Write-Host "##  %PROJECT%##"
Write-Host "##                                                             ##"
Write-Host "#################################################################`n"

If (Test-Path "$SRC_DIR\$EAP") {
	Write-Host "Product sources are present...`n"
} Else {
	Write-Host "Need to download $EAP package from the Customer Support Portal"
	Write-Host "and place it in the $SRC_DIR directory to proceed...`n"
	exit
}

#If (Test-Path "$SRC_DIR\$EAP_PATCH") {
#	Write-Host "Product patches are present...`n"
#} Else {
#	Write-Host "Need to download $EAP_PATCH package from the Customer Support Portal"
#	Write-Host "and place it in the $SRC_DIR directory to proceed...`n"
#	exit
#}

If (Test-Path "$SRC_DIR\$BPMS") {
	Write-Host "Product sources are present...`n"
} Else {
	Write-Host "Need to download $BPMS package from the Customer Support Portal"
	Write-Host "and place it in the $SRC_DIR directory to proceed...`n"
	exit
}

#Test whether Java is available.
if ((Get-Command "java.exe" -ErrorAction SilentlyContinue) -eq $null)
{
   Write-Host "The 'java' command is required but not available. Please install Java and add it to your PATH.`n"
   exit
}

if ((Get-Command "javac.exe" -ErrorAction SilentlyContinue) -eq $null)
{
   Write-Host "The 'javac' command is required but not available. Please install Java and add it to your PATH.`n"
   exit
}


# Remove the old installation if it exists
If (Test-Path "$JBOSS_HOME") {
	Write-Host "Removing existing installation.`n"
	# The "\\?\" prefix is a trick to get around the 256 path-length limit in Windows.
	# If we don't do this, the Remove-Item command fails when it tries to delete files with a name longer than 256 characters.
	Remove-Item "\\?\$JBOSS_HOME" -Force -Recurse
}

#Run installers.
Write-Host "EAP installer running now...`n"
$argList = "-jar $SRC_DIR\$EAP $SUPPORT_DIR\installation-eap -variablefile $SUPPORT_DIR\installation-eap.variables"
$process = (Start-Process -FilePath java.exe -ArgumentList $argList -Wait -PassThru)
Write-Host "Process finished with return code: " $process.ExitCode
Write-Host "`n"

If ($process.ExitCode -ne 0) {
	Write-Error "Error installing JBoss EAP."
	exit
}

#Write-Host "Applying JBoss EAP patch now...`n"
#Write-Host "The patch process will run in a separate window. Please wait for the 'Press any key to continue ...' message...`n"
#$argList = '--command="patch apply ' + "$SRC_DIR\$EAP_PATCH" + ' --override-all"'
#$patchProcess = (Start-Process -FilePath "$JBOSS_HOME\bin\jboss-cli.bat" -ArgumentList $argList -Wait -PassThru)
#Write-Host "Process finished with return code: " $patchProcess.ExitCode
#Write-Host ""

#If ($patchProcess.ExitCode -ne 0) {
#	Write-Error "Error occurred during JBoss EAP patch installation."
#	exit
#}

#Write-Host "JBoss EAP patch applied succesfully!`n"

Write-Host "Deploying JBoss BPM Suite now..."
#$argList = "-qo $SRC_DIR\$BPMS $SUPPORT_DIR\installation-bpms -variablefile $SUPPORT_DIR\installation-bpms.variables"
#$bpmsProcess = (Start-Process -FilePath java.exe -ArgumentList $argList -Wait -PassThru)
Expand-ZIPFile $BPMS $TARGET
#Write-Host "Process finished with return code: " $bpmsProcess.ExitCode
Write-Host ""

If ($bpmsProcess.ExitCode -ne 0) {
	Write-Error "Error occurred during JBoss BPM Suite installation."
	exit
}

Write-Host "- enabling demo accounts setup ...`n"
$argList1 = "-a -r ApplicationRealm -u bpmsAdmin -p bpmsuite1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent"
$argList2 = "-a -r ApplicationRealm -u erics -p bpmsuite1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent"
$addUserProcess1 = (Start-Process -FilePath $JBOSS_HOME\bin\add-user.bat -ArgumentList $argList1 -Wait -PassThru)
$addUserProcess2 = (Start-Process -FilePath $JBOSS_HOME\bin\add-user.bat -ArgumentList $argList2 -Wait -PassThru)

If ($addUserProcess1.ExitCode -ne 0 || $addUserProcess2.ExitCode -ne 0) {
	Write-Error "Error occurred during user account setup."
	exit
}

Write-Host "- setting up standalone.xml configuration adjustments...`n"
Copy-Item "$SUPPORT_DIR\standalone.xml" "$SERVER_CONF" -force

Write-Host "- setup email task notification user...`n"
Copy-Item "$SUPPORT_DIR\userinfo.properties" "$SERVER_DIR\business-central.war\WEB-INF\classes\" -force


Write-Host "============================================================================"
Write-Host "=                                                                          ="
Write-Host "=  You can now start the $PRODUCT with:                             ="
Write-Host "=                                                                          ="
Write-Host "=   $SERVER_BIN/standalone.sh                          ="
Write-Host "=                                                                          ="
Write-Host "=  Login into business central at:                                         ="
Write-Host "=                                                                          ="
Write-Host "=    http://localhost:8080/business-central  (u:bpmsAdmin / p:bpmsuite1!)  ="
Write-Host "=                                                                          ="
Write-Host "=  See README.md for general details to run the various demo cases.        ="
Write-Host "=                                                                          ="
Write-Host "=  $PRODUCT $VERSION $DEMO Setup Complete.                  ="
Write-Host "=                                                                          ="
Write-Host "============================================================================"

# Little function to Unzip files using Windows built-in unzip support.
function Expand-ZIPFile($file, $destination)
{
  $shell = new-object -com shell.application
  $zip = $shell.NameSpace($file)
  foreach($item in $zip.items())
  {
    $shell.Namespace($destination).copyhere($item)
  }
}
