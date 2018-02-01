function Import-SharePointReferences{
	<#
	.SYNOPSIS
		This module is called to import the appropriate SharePoint references from Microsoft and the OfficeDevPnP team based on the targeted SharePoint environment.
	.EXAMPLE
		Import-SharePointReferences -Environment "SharePointOnline"
	.EXAMPLE
		Import-SharePointReferences -Environment "SharePoint2013"
	.EXAMPLE	
		Import-SharePointReferences -Environment "SharePoint2016"
	.DESCRIPTION
		Valid values for the Environment parameter are "SharePointOnline", "SharePoint2013", and "SharePoint2016"
	#>
	[CmdletBinding()]
	Param(
        [Parameter(Mandatory=$true)]
		[ValidateSet("SharePointOnline","SharePoint2013","SharePoint2016")]
		[string]$Environment
	)
	foreach ($item in (Get-ChildItem -Path "$PSScriptRoot\$Environment")) {
		#Add-Type -Path $item.FullName
		#Write-Output "Added types from .\$Environment\$item"
	}
	switch($Environment.ToLower()){
		"sharepointonline"{
			Import-Module -Name "$PSScriptRoot\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.Online.SharePoint.PowerShell.psd1" -Scope Global
			Import-Module -Name "$PSScriptRoot\OfficeDevPnP\SharePointPnPPowerShellOnline\SharePointPnPPowerShellOnline.psd1" -Scope Global -DisableNameChecking #-Verbose:$true
		}
		"sharepoint2013"{
			Import-Module -Name "$PSScriptRoot\OfficeDevPnP\SharePointPnPPowerShell2013\SharePointPnPPowerShell2013.psd1" -Scope Global -DisableNameChecking #-Verbose:$true
		}
		"sharepoint2016"{
			Import-Module -Name "$PSScriptRoot\OfficeDevPnP\SharePointPnPPowerShell2016\SharePointPnPPowerShell2016.psd1" -Scope Global -DisableNameChecking #-Verbose:$true
		}
		default{
			Write-Error("Unable to import references.") -ErrorAction Stop		
		}
	}
}

Export-ModuleMember Import-SharePointReferences
