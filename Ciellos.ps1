$containerName = 'bc22usapi'
$artifactUrl = Get-BcArtifactUrl -type 'OnPrem' -country 'us' -select 'Latest'
$licensePath = 'C:\Users\Usuario\OneDrive - GDE Internacional\DynamicsBS\Conexion Intercompanies\Container\fin.bclicense'
$login='angello'
$password = '1026.Angelo*#'
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$credential = New-Object pscredential $login, $securePassword
$auth = 'Windows'

New-BcContainer `
    -accept_eula `
    -containerName $containerName `
    -credential $credential `
    -auth $auth `
    -artifactUrl $artifactUrl `
    -licenseFile $licenseFile `
    -memoryLimit 8G `
    -updateHosts `
    -isolation 'hyperv' `
    -dns '8.8.8.8' `
    -includeTestToolkit `
    -includeTestLibrariesOnly `
    <#-myscripts @( @{ "SetupNavUsers.ps1" = "Write-Host 'Skipping user creation'" } )#>