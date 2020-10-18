
Q. What does this script does?
A. This script will help to override the expired / active / about to expire Service connection / End points in Azure. 

Q. what are the updates need to perform before running the script ?
A. update below field values in the script:

    1. Name of the devops org
    2. Name of the project 
    3. PAT token
    4. End point ID
    5. Secret key 

Q. how to get the End point ID?
A. Navigate to devops project settings --> Service connections --> select the target service connection --> click on it. In the url copy the end token i.e resourceId value. 
   Sample 
   ====== 
       * Consider post clicking the desired service connection you will get the below url in the browser.
     	 url : https://dev.azure.com/sampleorg/sampleproject/_settings/adminservices?resourceId=daba8c77-ee12-4afd-9187-e85d9f55c2bc 

       * from above url consider End point as "daba8c77-ee12-4afd-9187-e85d9f55c2bc"

Q. How to get the new secret key ?
A. 

option 1: 
           * Navigate to https://ms.portal.azure.com
           * Search for Azure Active directory 
           * Click on App Registrations.
           * search for the App and click on it.
           * Navigate to "Certicates and secrets" section 
           * Click on New Secret hyperlink and select the desired expire date ( 1 years / 2 years / Never)

option 2: 
          * Navigate to Azure devops project settings page 
          * click on "service connections" page.
          * select and click on target service connection. 
          * click on "Manage Service Connection" link. 