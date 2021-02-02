# Create a Resource Group
New-AzResourceGroup `
   -Name RG-AVSET `
   -Location EastUS2

#Create a AvailabilitySet
New-AzAvailabilitySet `
   -Location "EastUS2" `
   -Name "AVSet-FS" `
   -ResourceGroupName "RG-AVSET" `
   -Sku aligned `
   -PlatformFaultDomainCount 2 `
   -PlatformUpdateDomainCount 2  

#Create Credentials
$cred = Get-Credential

#Create Virtual Machines
for ($i=1; $i -le 4; $i++)
{
    New-AzVm `
        -ResourceGroupName "RG-AVSET" `
        -Name "FS$i" `
        -Location "East US2" `
        -VirtualNetworkName "Vnet-AVSet" `
        -SubnetName "Subnet" `
        -SecurityGroupName "Nsg-AVSet" `
        -PublicIpAddressName "Pip-AVSet$i" `
        -AvailabilitySetName "AVSet-FS" `
        -Credential $cred
}

