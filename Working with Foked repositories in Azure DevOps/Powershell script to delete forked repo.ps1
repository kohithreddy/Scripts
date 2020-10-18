 param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$PAT,
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Project
)
$env:AZURE_DEVOPS_EXT_PAT = "$PAT"
$FORKREPOCOUNT = 0
$org= "https://dev.azure.com/<Enter Org Name>"
$Repos = az repos list --organization $org --project $Project | ConvertFrom-Json
az repos list  --organization $org --project $Project | ConvertFrom-Json
foreach($Repo in $Repos)
{
    if($Repo.isFork -eq "true")
    {
        Write-Output "[Delete] fork $($Repo.name)"
        $FORKREPOCOUNT++
        az repos delete --id $Repo.id --organization $org --project $Project -y
    }
}
if ($FORKREPOCOUNT -eq 0 )
{
    Write-Output "No Forked repo in the $Project  project" 
}