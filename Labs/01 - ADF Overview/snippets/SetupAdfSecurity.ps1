
$resourceGroupName = "sqbitsadf01" 
$dataFactoryName = "adfdp01"
$groupName = "ADF_Access"


$myRg = Get-AzResourceGroup $resourceGroupName


$myDf = Set-AzDataFactoryV2 -ResourceGroupName $myRg.ResourceGroupName -Location $myRg.Location -Name $dataFactoryName


$mySp = Get-AzADServicePrincipal -ObjectId $($myDf.Identity.PrincipalId)



$group = New-AzADGroup -DisplayName $groupName -MailNickname $groupName
Add-AzureAdGroupMember -ObjectId $Group.Id -RefObjectId $mysp.Id
