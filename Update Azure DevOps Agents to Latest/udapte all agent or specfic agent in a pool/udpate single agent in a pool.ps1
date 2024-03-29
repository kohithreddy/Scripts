$PAT = '<PATToken>'
$Organization = $env:SYSTEM_COLLECTIONURI
$ApiVersion = '6.0'
 
function Get-Authentication {
        Write-Host "Initialize authentication context"

        $Token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))
        $Header = @{authorization = "Basic $Token"}
        Write-Host "Returning authentication context"
        return $Header
}
$Header = Get-Authentication

$LatestReleaseVersion ='v2.189.0'

function Update-AgentVersion {
$PoolId = 30
$AgentId = 234
$Uri = "$($Organization)_apis/distributedtask/pools/$($PoolId)/messages?agentId=$($AgentId)&api-version=$($ApiVersion)"
try 
{
            Write-Host "Updating the agent"
            $Response = Invoke-RestMethod -Uri $Uri `
                                          -Method Post `
                                          -ContentType "application/json" `
                                          -Headers $Header
            Write-Host "Completed agent version update process"
        } 
        catch 
        {
            Write-Host "Caught an exception while updating the agent"
            Write-Host "URI": $Uri
            Write-Host "Status code:" $_.Exception.Response.StatusCode.value__ 
            Write-Host "Exception reason:" $_.Exception.Response.ReasonPhrase
            Write-Host "Exception message:" $_.Exception.Message
        }   
}

Update-AgentVersion
