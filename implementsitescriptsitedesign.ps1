Import-Module .\Import-SharePointReferences\Import-SharePointReferences.psm1
Import-SharePointReferences SharePointOnline

Connect-SPOService -Url "https://catsysdemo-admin.sharepoint.com"

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
Add-SPOTheme -Name "Project Site Theme" -Palette $themepalette -IsInverted $true

$siteScriptActions = '
{
    "$schema": "schema.json",
        "actions": [
            {
                "verb": "applyTheme",
                "themeName": "Project Site Theme"
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

Add-SPOSiteScript -Title "Apply Project Theme Site Script" -Content $siteScriptActions -Description "Site Script for applying the Project Theme"

# Add Site Design
# 68 is the id of the web template for modern communication sites / 64 is the id of the web template for modern team sites
Add-SPOSiteDesign `
-Title "Project Site" `
-WebTemplate "64" `
-SiteScripts "5ceecc70-e301-427e-911a-a798b75dd24d" `
-Description "Create a new project site" `
-PreviewImageAltText "Project Site Image#" #`
#-IsDefault


    
    

    
    
#A work in progress    
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
Add-SPOSiteDesign -Title "Fuse" -SiteScripts 72b3a553-82d7-4007-863c-43c64edcf14f -WebTemplate 64

#Hasn't worked yet
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
