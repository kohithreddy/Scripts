##Reference link : https://docs.microsoft.com/en-us/rest/api/azure/devops/test/test-plans/list?view=azure-devops-rest-5.0

write-Host This script to list the test plans in the Azure DevOps Project (Services).  
$token = "<Provide Pat Token>"
$pat = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("PAT:$token"))
$org="<Provide Azure DevOps Org name. eg: kohithfs>"
$proj="<provide Azure devops project name. eg: test >"
$header = @{'Authorization' = "Basic $pat"}
$URI= "https://dev.azure.com/"+$org+"/"+$proj+"/_apis/test/plans?api-version=5.0"
Write-Host DevOps Url ============ $URI
$listtestplan= Invoke-WebRequest -Method GET -Uri  $URI -Headers $header -ContentType 'application/json'
$output = $listtestplan.Content | ConvertFrom-Json 
$testplanId = $output.value.id  
Write-Host Test Plan IDs are ====== $testplanId `n `n 
$testplannames = $output.value.name 
Write-Host  Test Plan Names are ======$testplannames 
