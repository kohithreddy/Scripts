## Reference link: https://docs.microsoft.com/en-us/rest/api/azure/devops/test/test-plans/delete?view=azure-devops-rest-5.0

$token = "<Provide PAT token>"

$pat = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("PAT:$token"))

$org="<DevOps org name>"

$proj="<DevOps Project Name>"

$planId=@() ##Sample input $planId= @(1584,1587,1589))

$header = @{'Authorization' = "Basic $pat"}

$count = $planId.count

Write-Host you have choosen to delete $count test plan/s in bulk. 

for ($i=0; $i -le $count-1 ; $i++)
{ 
  $URI= "https://dev.azure.com/"+$org+"/"+$proj+"/_apis/test/plans/"+$planId[$i]+"?api-version=5.0"
  Write-Host you had choosen to delete $planId[$i] in project named $proj under $org Azure devops organization 
  Write-Host "deleting plan " $planId[$i]
  Invoke-WebRequest -Method DELETE -Uri  $URI -Headers $header -ContentType 'application/json'
  Write-Host "deleted plan " $planId[$i]
} 
