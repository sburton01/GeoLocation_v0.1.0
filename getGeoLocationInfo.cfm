<!--- 
LEGAL: Copyright: M.Orth , Orth u. Pilatzki GbR, 2012 http://www.cfsolutions.de
License: http://www.cfsolutions.de/coldfusion_adwords_api/
Keep in touch with latest development news and become a Facebook Fan
http://www.facebook.com/pages/ColdFusion-Adwords-API-Client-Library/405372629479704
--->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>ColdFusion Google Adwords Api Example for Method get()</title>
</head>

<body>

<!--- include configuration --->
<cfinclude template="config.cfm">

<!--- setting a packagepath --->
<cfset packagepath="adwords_api.com.google.adwords.api.v201109.">

<!--- create instance of the class clientloginservice and login to get a valid authToken --->
<cfset oClientLoginService=createObject("component","#packagepath#clientloginservice")>

<cfset oClientLoginService.setEmail(adwords_api_email_account)>
<cfset oClientLoginService.setPasswd(adwords_api_password)>
<cfset authToken=oClientLoginService.getAuthTokenFromGoogle()>

<!--- create instance of the class adwordsuser and setting values based on variables inside config.cfm --->
<cfset oAdwordsUser=createObject("component","#packagepath#adwordsuser")>

<cfset oAdwordsUser.setAuthToken(authToken)>
<cfset oAdwordsUser.setUseragent(adwords_api_useragent)>
<cfset oAdwordsUser.setDeveloperToken(developer_token)>

<!--- create instance of the class geolocationservice --->
<cfset oGeoLocationService=createObject("component","#packagepath#geolocationservice")>

<!--- setting the adwordsUser --->
<cfset oGeoLocationService.setAdwordsUser(oAdwordsUser)>

<!--- switch to sandbox mode --->
<cfset oGeoLocationService.setUseSandbox(bUseSandBox)>

<!--- use defaultLogging and log request and response to logs directory --->
<cfset oGeoLocationService.setUseDefaultLogging(bUseLogging)>

<!--- create instance of the class GeoLocationSelector --->
<cfset oGeoLocationSelector=createObject("component","#packagepath#geolocationselector")>

<!--- create empty array to store address data --->
<cfset aAddresses=arrayNew(1)>

<cfset oAddress_01=createObject("component","#packagepath#address")>

<cfset oAddress_01.setStreetAddress('1600 Amphitheatre Parkway')>
<cfset oAddress_01.setCityName('Mountain View')>
<cfset oAddress_01.setProvinceCode('US-CA')>
<cfset oAddress_01.setPostalCode('94043')>
<cfset oAddress_01.setCountryCode('US')>

<cfset arrayAppend(aAddresses,oAddress_01)>

<cfset oAddress_02=createObject("component","#packagepath#address")>

<cfset oAddress_02.setStreetAddress('Schau ins Land 7')>
<cfset oAddress_02.setCityName('Bergisch Gladbach')>
<cfset oAddress_02.setProvinceCode('NRW')>
<cfset oAddress_02.setPostalCode('51429')>
<cfset oAddress_02.setCountryCode('DE')>

<cfset arrayAppend(aAddresses,oAddress_02)>

<cfset oGeoLocationSelector.setAddresses(aAddresses)>

<cftry>

<!--- get the oGeoLocations object through the google adwords api --->
<cfset aGeoLocationsObjects=oGeoLocationService.get(oGeoLocationSelector)>

	<!--- dump the returned data as a struct --->
	<cfloop from="1" to="#arrayLen(aGeoLocationsObjects)#" index="i">	
		<cfdump var="#aGeoLocationsObjects[i].getObjectData(true)#" label="aGeoLocationsObject No. #i#">
	</cfloop>
	
	<!--- Is it an error raised through the api usage? --->
	<cfcatch type="adwordsapi">
		<!--- the method getError() returns the google api error messag as a coldfusion structure --->
		<cfdump var="#oGeoLocationService.getError()#" label="API Error Message">
	</cfcatch>
	
	<!--- Okay, it's a general error. --->
	<cfcatch type="any">
		<cfdump var="#cfcatch#" label="general cfcatch">
	</cfcatch>
	
</cftry>

</body>
</html>
