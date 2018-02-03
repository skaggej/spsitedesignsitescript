Import-Module .\Import-SharePointReferences\Import-SharePointReferences.psm1
Import-SharePointReferences SharePointOnline

$site_script = @'
{
 "$schema": "schema.json",
     "actions": [
         {
             "verb": "createSPList",
             "listName": "Customer Tracking",
             "templateType": 100,
             "subactions": [
                 {
                     "verb": "SetDescription",
                     "description": "List of Customers and Orders"
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "Text",
                     "displayName": "Customer Name",
                     "isRequired": false,
                     "addToDefaultView": true
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "Number",
                     "displayName": "Requisition Total",
                     "addToDefaultView": true,
                     "isRequired": true
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "User",
                     "displayName": "Contact",
                     "addToDefaultView": true,
                     "isRequired": true
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "Note",
                     "displayName": "Meeting Notes",
                     "isRequired": false
                 }
             ]
         }
     ],
         "bindata": { },
 "version": 1
}
'@

Connect-SPOService -Url "https://catsysdemo-admin.sharepoint.com"
Add-SPOSiteScript -Title "Create customer tracking list" -Content $site_script -Description "Creates list for tracking customer contact information"

<# 
    Sample output
    Id          : bd9f3cb7-5f6d-4132-886a-740e5265d423
    Title       : Create customer tracking list
    Description : Creates list for tracking customer contact information
    Content     :
    Version     : 0
#>

# Add Site Design
# 68 is the id of the web template for modern communication sites / 64 is the id of the web template for modern team sites
Add-SPOSiteDesign `
-Title "A Sample Site Design" `
-WebTemplate "64" `
-SiteScripts "e7cb3c62-4e7b-4fbe-8391-f5525f17ab7b" `
-Description "This is the description of the sample site design" `
-PreviewImageAltText "Site design preview image" #`
-IsDefault

$themepalette = @{
    "themePrimary" = "#3b8c38";
    "themeLighterAlt" = "#030703";
    "themeLighter" = "#060e06";
    "themeLight" = "#0c1c0b";
    "themeTertiary" = "#193b18";
    "themeSecondary" = "#357e32";
    "themeDarkAlt" = "#44a341";
    "themeDark" = "#65c062";
    "themeDarker" = "#86ce84";
    "neutralLighterAlt" = "#28469a";
    "neutralLighter" = "#2b4ba4";
    "neutralLight" = "#2f53b5";
    "neutralQuaternaryAlt" = "#3257bf";
    "neutralQuaternary" = "#345bc7";
    "neutralTertiaryAlt" = "#5476d3";
    "neutralTertiary" = "#1b1508";
    "neutralSecondary" = "#775d25";
    "neutralPrimaryAlt" = "#9e7c31";
    "neutralPrimary" = "#846729";
    "neutralDark" = "#c7a04b";
    "black" = "#d3b472";
    "white" = "#25418f";
    "primaryBackground" = "#25418f";
    "primaryText" = "#846729";
    "bodyBackground" = "#25418f";
    "bodyText" = "#846729";
    "disabledBackground" = "#2b4ba4";
    "disabledText" = "#5476d3";
}
    
# Add the theme
Add-SPOTheme -Name "Sample Theme" -Palette $themepalette -IsInverted $false
    
$siteScriptActions = '
{
    "$schema": "schema.json",
        "actions": [
            {
                "verb": "applyTheme",
                "themeName": "Sample Theme"
            },
            {
               "verb": "addNavLink",
               "url": "http://www.microsoft.com",
               "displayName": "Microsoft Site",
               "isWebRelative": false
            }            
        ],
    "bindata": { },
    "version": 1
}
'
    
Add-SPOSiteScript -Title "Sample Theme Site Script" -Content $siteScriptActions -Description "Site Script for applying the Sample Theme"
    
    
$applyFusePnPTemplate = '{
    "$schema": "schema.json",
    "actions": [
    {
            "verb": "triggerFlow",
            "url": "https://prod-22.westus.logic.azure.com:443/workflows/0ae6c892ba8e4043a705a1bd4ad55927/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=ERKPeWWvVGNJDyoOCDyjwl5krKNxNV0cCju3tGM5PqA",
            "name": "Apply Fuse PnP Template",
            "parameters": {
                "event":"",
                "product":""
            }
    }
    ],
    "bindata": {},
    "version": 1
}'

Add-SPOSiteScript -Title "Apply Fuse PnP Template" -Content $applyFusePnPTemplate
Get-SPOSiteScript
Add-SPOSiteDesign -Title "Fuse" -SiteScripts f6996e46-3b42-4ce6-85ba-2beccfc750a3 -WebTemplate 64
