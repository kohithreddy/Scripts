$devops_org="<DevOps Orginization url> "                 ##  Sample url https://dev.azure.com/sampleor or https://sampleorg.visualstudio.com
$devops_proj="<Project Name>"                            ##  project where your service connection is present    
$endpoint_id="<enter End point copied from URL>"         ##  endpoint Id (get from azure devops UI go to the service connection in browser URL you see resourceId)
$key="<New Secret created in azure portal> "             ##  Newly created secret
$token="<Personal Access token created in Azure devops>" ##  PAT created in azure devops

##
write-host "Info: Get json presentation of service connection"

az devops service-endpoint show  --organization $devops_org --project $devops_proj --id $endpoint_id > sc.json

##
write-host "Info: Replace service principal key"

$prev_string="`"serviceprincipalkey`": null"
$new_string="`"serviceprincipalkey`": `"$key`""
(Get-Content -path ./sc.json -Raw) -replace $prev_string,$new_string | Set-Content -Path ./sc.json

##

write-host "Info: Update service principal key in service connection"
# Base64-encodes the Personal Access Token (PAT) appropriately
$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$token"))

$uri="$devops_org/_apis/serviceendpoint/endpoints/${endpoint_id}?operation=&api-version=6.0-preview.4"

Get-Content -Raw sc.json  | Invoke-RestMethod $uri -Method 'PUT' -ContentType "application/json" -Headers @{Authorization="Basic $base64AuthInfo"}