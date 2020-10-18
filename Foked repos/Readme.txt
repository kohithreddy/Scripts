

Q. What does this script does?

A. This script check whether the are any forked repositories in the given devops project or not. If i founds it will deleted.

Q. What modifications need to be made before running the script?

A. Kindly make below mentioned changes in the pipeline(.yaml) and powershell script(.ps1)before running.

Change on Powershell script
===========================
> Provide the valid devops organization name in the script under $org line.

Change on yaml script
===========================
> Provide the powershell file name under the code check out path under "filepath" field.
  
Q. What are the pre-requsites for the yaml file?

A. Kindly create a PAT token in the org with required permissions and add the variable "PAT" with pat token as value. This pat will work on both ways ( secret / normal ) variable. 
