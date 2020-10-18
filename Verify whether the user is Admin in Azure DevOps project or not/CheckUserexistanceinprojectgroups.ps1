Param(
[Parameter(Mandatory=$true)][string]$AzureDevopsAccount,
[Parameter(Mandatory=$true)][string]$Project
)

$projectlevelgroupName='Project Administrators' #Changes target group name as per requirment. In this script we use "Project Administrators" group. 

$token = "<Enter PAT Token>"

$pat = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("PAT:$token"))
$header = @{'Authorization' = "Basic $pat"}
$group = "[$Project]\$projectlevelgroupName"

#Build API 
$AllGroupUri = 'https://vssps.dev.azure.com/'+$AzureDevopsAccount+'/_apis/graph/groups?api-version=6.0-preview.1'

#Invoke REST API
$AllGroupsapi= invoke-webrequest -Method GET -Uri $AllGroupUri -Headers $header -ContentType 'application/json'

#Convert Result to Json format
$jsonoutput1 = $AllGroupsapi.Content | ConvertFrom-Json

#Pick Group Id of choosen group
$Grouporiginid = $jsonoutput1.value | ?{ $_.principalName -in "$group" } | %{ $_.originId }

#Print Group ID
write-host "Project Group id = $Grouporiginid "

#Get members of the group

#Build API
$membersuri ='https://vsaex.dev.azure.com/'+$AzureDevopsAccount+'/_apis/GroupEntitlements/'+$originid+'/members?api-version=6.0-preview.1'

#Invoke Rest API
$membersapi =invoke-webrequest -Method GET -Uri $membersuri -Headers $header -ContentType 'application/json'

#Convert result to Json format
$jsonoutput2 = $membersapi.Content | ConvertFrom-Json


###### search with ---> Mail Address  #####
$emailaddress = "<Enter Target Email Address>"
$originid2 = $jsonoutput2.members | ?{ $_.user.mailAddress -in "$emailaddress" }
$f1 = $originid2.user.mailAddress 

if ($f1 -eq $emailaddress)
  {
      write-host "Result Match with mail address search" 
  }
else
  { 
      write-host "Result not Matched with mail address search"
  }
###### search with ---> User Name  #####
$name = "<Enter User Name>"
$originid1 = $finalmembersoutput.members | ?{ $_.user.displayName -in "$name" }
$f = $originid1.user.displayName 

if ($f -eq $name)
{ 
    write-host "Result Match with name search"
}
else 
{
    write-host "Result not Matched with name search"
}
