# IMPORTANT: Below sample is only for demo purpose not PROD purpose. 
# Please take your own risk using below script and veriry it in your TEST environment first before applying to PROD environment!!
 

$token = "<Enter PAT Token>"

$changedate="2020-09-18"

$pat = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("PAT:$token"))

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"

$headers.Add("Content-Type", "application/json-patch+json")

$headers.Add("Authorization", "Basic $pat")


# Get the link changes history from the JSON file.

# The JSON file comes from the API: https://docs.microsoft.com/en-us/rest/api/azure/devops/wit/reporting%20work%20item%20links/get?view=azure-devops-rest-6.0. 
#Save the output in local ( single file is there is no contuniation , if there are many save files in seq ex: page1.json, page2.json...) 

$links = (Get-Content -Path "<PATH TO FILES IN LOCAL> | ConvertFrom-Json).values

#for Example if ouput has 6 files 

for ( $i = 1; $i -le 6; $i++) 
{
   $path = "C:\Users\kohith\Desktop\RON\Prodtest\Page" + $i + ".json"
   $links = (Get-Content -Path $path | ConvertFrom-Json).values
   $continuationToken = (Get-Content -Path $path | ConvertFrom-Json).continuationToken     
 # Update the page number each iteration.
   if ($ct -ne $null) 
   {
       foreach ($link in $links)
       {
       #To Determine the count 
         $count = $links.Count
       # We only restore the removed links. Note if the link was already added back manually, the below PATCH request will still be successful and nothing changes.
       if ($link.attributes.changedOperation -eq "remove")
       {
        # We only restore the link deletion actions performed by this user. If you would like to restore all users' deletion action, please remove this condition.
        if ($link.attributes.changedBy.UniqueName -eq "kohith@ranomd.com")

        {
            $parentIdId = $link.attributes.sourceId
            
            $childIdID = $link.attributes.targetId
            
            $organizationName= "<Enter Organization Name>"

            $projectName = "<Enter Project Name>"
           
            # URL with Start date 
            #$url = "https://dev.azure.com/"+$(organizationName)+"/"+$(projectName)+"/_apis/wit/workitems/"+ $parentId1 +"&startDateTime="+$changedate+"?api-version=6.0"

            #URL with start date
            $url = "https://dev.azure.com/"+$(organizationName)+"/"+$(projectName)+"/_apis/wit/workitems/" + $parentId +"?api-version=6.0"

            $body = "[{`"op`": `"add`",
                       `"path`": `"/relations/-`",
                       `"value`": 
                                {`"rel`": `"System.LinkTypes.Hierarchy-Forward`",
                                 `"url`": `"https://dev.azure.com/"+$(organizationName)+"/"+$(projectName)+"/_apis/wit/workItems/$childId1`",
                                 `"attributes`": 
                                               {`"comment`": `"<Comments>`"}
                                 }
                      }]"

            Write-Host "Trying to link work item:" $parentId1 " as parent of work item:" $childId1
            
            try
            {
                Invoke-RestMethod $url -Method 'PATCH' -Headers $headers -Body $body
            }
            catch
            {
                Write-Host "Failed URL:" $url " with status code:" $_.Exception.Response.StatusCode.value__
            }
           }
           }

        }
   }
}

