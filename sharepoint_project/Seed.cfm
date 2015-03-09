<cfparam name="SubmitButton" default="">

<cfset title = "Create SharePoint Project">
<cfinclude template="zinc-head.cfm">

<cfparam name="uniID" default="0">
<cfparam name="broID" default="0">
<cfif isDefined("session.broID")>
	<cfset broID = session.broID>
<cfelseif isDefined("url.broID")>
	<cfset broID = url.broID>
</cfif>

<cfparam name="ShowForm" default="true">
<cfparam name="ErrorCount" default="0">

<cfparam name="PeriodStart" default="1/1/2015">
<cfparam name="PeriodStop" default="3/1/2015">

<cfparam name="AllowedNumChild" default="11"><!--- Set to 12, because 13 might push the number of form fields over the allowed maximum of 100 --->



<!--- Make sure this Broker has access to this Union --->
<cfquery name="qryUnionAccess" datasource="#application.db#" blockfactor="100" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
	select uniID, ubStartDate, ubStopDate, ubEnrollStartDate, ubEnrollStopDate from tblGrpSupUnionBrokerLink where broID = #broID#
</cfquery>

<cfif qryUnionAccess.recordcount neq 1>
	<h1>Error. You do not have access to this Union.</h1><cfabort>
<cfelse>
	<cfif currDate lt qryUnionAccess.ubEnrollStartDate or currDate gt qryUnionAccess.ubEnrollStopDate>
		<h1>Enrollment is closed for this Union</h1><cfabort>
	</cfif>
</cfif>


	

<!--- Key fields --->
<cfparam name="EmpID" default="0">
<cfparam name="EmpFmkey" default="0">
<cfparam name="SpoFmkey" default="0">
<cfparam name="PlanEffKey" default="0">

<!--- EmpSel & SpoSel come from the Option Table and can range 1 to 15 and 0 for no coverage --->
<cfparam name="EmpSel" default="0">
<cfparam name="SpoSel" default="0">
<cfparam name="EmpSelFromDatabase" default="0">
<cfparam name="SpoSelFromDatabase" default="0">

<!--- OptSel come from the Option Table and can range 1 to 3 and 0 for no selection --->
<cfparam name="OptSel" default="0">

<!--- Age fields --->
<cfparam name="EmpAge" default="0">
<cfparam name="SpoAge" default="0">


<!--- Selected Coverage Amounts --->
<cfparam name="EmpCoverage" default="0">
<cfparam name="SpoCoverage" default="0">
<cfparam name="ChildCoverage" default="5000">

<!--- Calculates Monthly Premium --->
<cfparam name="EmpMoPrem" default="0">
<cfparam name="SpoMoPrem" default="0">
<cfparam name="ChildMoPrem" default="0">
<cfparam name="FamMoPrem" default="0">

<cfparam name="EmpNameFirst" default="">
<cfparam name="EmpNameMiddle" default="">
<cfparam name="EmpNameLast" default="">
<cfparam name="EmpSSN" default="">
<cfparam name="VerifySSN" default="">
<cfparam name="EmpSSNLast4" default="">
<cfparam name="EmpGender" default="">
<cfparam name="EmpAddress1" default="">
<cfparam name="EmpAddress2" default="">
<cfparam name="EmpCity" default="">
<cfparam name="EmpState" default="">
<cfparam name="EmpZip" default="">
<cfparam name="EmpDOB" default="">

<cfparam name="BankAchAuth" default="">
<cfparam name="BankName" default="">
<cfparam name="BankRouting" default="">
<cfparam name="BankAccount" default="">
<cfparam name="VerifyBankAccount" default="">
<cfparam name="BankType" default="">


<!--- Error indicators --->
<cfparam name="EmpNameFirstErr" default="">
<cfparam name="EmpNameMiddleErr" default="">
<cfparam name="EmpNameLastErr" default="">
<cfparam name="EmpSSNErr" default="">
<cfparam name="EmpGenderErr" default="">
<cfparam name="EmpAddress1Err" default="">
<cfparam name="EmpAddress2Err" default="">
<cfparam name="EmpCityErr" default="">
<cfparam name="EmpStateErr" default="">
<cfparam name="EmpZipErr" default="">
<cfparam name="EmpDOBErr" default="">

<cfparam name="BankAchAuthErr" default="">
<cfparam name="BankNameErr" default="">
<cfparam name="BankRoutingErr" default="">
<cfparam name="BankAccountErr" default="">
<cfparam name="BankTypeErr" default="">

<cfparam name="SpoNameFirst" default="">
<cfparam name="SpoNameMiddle" default="">
<cfparam name="SpoNameLast" default="">
<cfparam name="SpoDOB" default="">
<cfparam name="SpoGender" default="">


<!--- Error indicators --->
<cfparam name="SpoNameFirstErr" default="">
<cfparam name="SpoNameMiddleErr" default="">
<cfparam name="SpoNameLastErr" default="">
<cfparam name="SpoDOBErr" default="">
<cfparam name="SpoGenderErr" default="">

<cfparam name="ElectChildrenCheckBox" default="off">


<cfset childNameFArray = ArrayNew(1)><!--- Array to hold Children fields (First, Middle, Last, DOB, Gender & Dependent) --->
<cfset childNameMArray = ArrayNew(1)>
<cfset childNameLArray = ArrayNew(1)>
<cfset childBirthArray = ArrayNew(1)>
<cfset childGendrArray = ArrayNew(1)>
<cfset childDepenArray = ArrayNew(1)>
<cfset childFmkeyArray = ArrayNew(1)>

<cfloop from="1" to="13" index="dx">
	<cfparam name="childNameFArray[dx]" default="">
	<cfparam name="childNameMArray[dx]" default="">
	<cfparam name="childNameLArray[dx]" default="">
	<cfparam name="childBirthArray[dx]" default="">
	<cfparam name="childGendrArray[dx]" default="">
	<cfparam name="childDepenArray[dx]" default="">
	<cfparam name="childFmkeyArray[dx]" default="0">
	<cfparam name="childArrayErr[dx]" default="">
</cfloop>

<cfif not isNumeric(EmpID)>
	<cfset EmpID = 0>
</cfif>


<!--- Read existing records (if available) --->
<cfif srpID gt 0 and SubmitButton neq 'Continue'>
	<!--- Employee --->
	<cfquery name="qryEmp" datasource="#application.db#" blockfactor="100">
		SELECT * from tblGrpSupEmployee where empID = '#empID#'
	</cfquery>
	<cfif qryEmp.recordcount neq 1>
		<h1>Error. Employee record not found.</h1><cfabort>
	</cfif>
	<cfoutput query="qryEmp">
		<cfset EmpAddress1 = empAddr1>
		<cfset EmpAddress2 = empAddr2>
		<cfset EmpCity = empCity>
		<cfset EmpState = Trim(empState)>
		<cfset EmpZip = empZip>
		<cfset EmpSSNLast4 = empSSNLastFour>
		<cfset BankAchAuth = empAuthACH>
		<cfset BankName = empBankName>
		<cfset BankRouting = empBankRouting>
		<cfset BankAccount = empBankAcctNum>
		<cfif empBankAcctType is 'C'>
			<cfset BankType = 'Checking'>
		<cfelseif empBankAcctType is 'S'>
			<cfset BankType = 'Savings'>
		<cfelse>
			<cfset BankType = ''>
		</cfif>
	</cfoutput>
	
	<!--- Family --->
	<cfquery name="qryFam" datasource="#application.db#" blockfactor="100">
		SELECT * from tblGrpSupFamilyMember where empID = '#empID#' order by fmID
	</cfquery>
	<cfif qryFam.recordcount lt 1>
		<h1>Error. Family records not found.</h1><cfabort>
	</cfif>
	<cfset cx = 1>
	<cfoutput query="qryFam">
		<cfif fmType is 'e'>
			<cfset EmpNameFirst = fmNameFirst>
			<cfset EmpNameMiddle = fmNameMiddle>
			<cfset EmpNameLast = fmNameLast>
			<cfset EmpDOB = DateFormat(fmDOB,'mm/dd/yyyy')>
			<cfset EmpAge = DateDiff('yyyy',EmpDOB,currDate)>
			<cfset EmpGender = Trim(fmGender)> 
			<cfset EmpFmkey = fmID> 
		<cfelseif fmType is 's'>
			<cfset SpoNameFirst = fmNameFirst>
			<cfset SpoNameMiddle = fmNameMiddle>
			<cfset SpoNameLast = fmNameLast>
			<cfset SpoGender = Trim(fmGender)> 
			<cfset SpoDOB = DateFormat(fmDOB,'mm/dd/yyyy')>
			<cfset SpoAge = DateDiff('yyyy',SpoDOB,currDate)>
			<cfset SpoFmkey = fmID>
		<cfelse>
			<cfset childNameFArray[cx] = fmNameFirst>
			<cfset childNameMArray[cx] = fmNameMiddle>
			<cfset childNameLArray[cx] = fmNameLast>
			<cfset childGendrArray[cx] = Trim(fmGender)> 
			<cfset childBirthArray[cx] = DateFormat(fmDOB,'mm/dd/yyyy')>
			<cfset childDepenArray[cx] = fmDependent>
			<cfset childFmkeyArray[cx] = fmID>
			<cfset cx = cx + 1>
		</cfif>
	</cfoutput>
	
	<!--- Plan Effective --->
	<cfquery name="qryPln" datasource="#application.db#" blockfactor="100">
		SELECT * from tblGrpSupPlanEffective where empID = '#empID#'
	</cfquery>
	<cfif qryPln.recordcount neq 1>
		<h1>Error. Plan Effective record not found.</h1><cfabort>
	</cfif>
	<cfoutput query="qryPln">
		<cfset PlanEffKey = peID>
		
		<!--- Emp fields --->
		<cfset OptSel = peOption>
		<cfset EmpSelFromDatabase = peEmpSelection>
		<cfset EmpCoverage = peEmpCoverage>
		<cfset EmpMoPrem = peEmpMoPrem>
		
		<!--- Spo fields --->
		<cfset SpoSelFromDatabase = peSpoSelection>
		<cfset SpoCoverage = peSpoCoverage>
		<cfset SpoMoPrem = peSpoMoPrem>

		<!--- Child fields --->
		<cfset ChildCoverage = peChildCoverage>
		<cfset ChildMoPrem = peChildMoPrem>
		<cfif ChildMoPrem gt 0><cfset ElectChildrenCheckbox = 'on'></cfif>
		
		<!--- Other --->
		<cfset FamMoPrem = EmpMoPrem + SpoMoPrem + ChildMoPrem>
	</cfoutput>
</cfif>

<cfset errInd = '<span class="errorText"><img src="err.png" width="9" height="17" alt="Error" /> Error</span>'>
<cfset errChildInd = '<span class="errorText"><img src="err.png" width="9" height="17" alt="Error" /> Err</span>'>

<!--- Anti-Cross-Site Scripting: Start --->
<cfinclude template="decodeScopeFunction.cfm">






<cfif SubmitButton is "Submit">
	<!--- Edit out bad characters --->
	<cfset EmpNameFirst = Trim(REReplace(EmpNameFirst,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset EmpNameMiddle = Trim(REReplace(EmpNameMiddle,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset EmpNameLast = Trim(REReplace(EmpNameLast,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset EmpAddress1 = Trim(REReplace(EmpAddress1,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset EmpAddress2 = Trim(REReplace(EmpAddress2,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset EmpCity = Trim(REReplace(EmpCity,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset EmpState = Trim(REReplace(EmpState,"[^a-zA-Z]","","ALL"))>
	<cfset EmpZip = Trim(REReplace(EmpZip,"[^0-9]","","ALL"))>
	<cfset EmpGender = Trim(REReplace(EmpGender,"[^fm]","","ALL"))>
	<cfset EmpSSN = Trim(REReplace(EmpSSN,"[^0-9]","","ALL"))>
	<cfset VerifySSN = Trim(REReplace(VerifySSN,"[^0-9]","","ALL"))>
	<cfset EmpDOB = Trim(REReplace(EmpDOB,"[^0-9/]","","ALL"))>

	<cfset BankAchAuth = Trim(REReplace(BankAchAuth,"[^on]","","ALL"))>
	<cfset BankName = Trim(REReplace(BankName,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset BankRouting = Trim(REReplace(BankRouting,"[^0-9]","","ALL"))>
	<cfset BankAccount = Trim(REReplace(BankAccount,"[^0-9]","","ALL"))>
	<cfset BankType = Trim(REReplace(BankType,"[^a-zA-Z]","","ALL"))>
	
	<cfset SpoNameFirst = Trim(REReplace(SpoNameFirst,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset SpoNameMiddle = Trim(REReplace(SpoNameMiddle,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset SpoNameLast = Trim(REReplace(SpoNameLast,"[^0-9a-zA-Z '-.]","","ALL"))>
	<cfset SpoGender = Trim(REReplace(SpoGender,"[^fm]","","ALL"))>
	<cfset SpoDOB = Trim(REReplace(SpoDOB,"[^0-9/]","","ALL"))>

	<cfset OptSel = Trim(REReplace(OptSel,"[^0-3]","","ALL"))>

	<cfset EmpSel = Trim(REReplace(EmpSel,"[^0-9]","","ALL"))>
	<cfset EmpCoverage = Trim(REReplace(EmpCoverage,"[^0-9.]","","ALL"))>
	<cfset EmpMoPrem = Trim(REReplace(EmpMoPrem,"[^0-9.]","","ALL"))>

	<cfset SpoSel = Trim(REReplace(SpoSel,"[^0-9]","","ALL"))>
	<cfset SpoCoverage = Trim(REReplace(SpoCoverage,"[^0-9.]","","ALL"))>
	<cfset SpoMoPrem = Trim(REReplace(SpoMoPrem,"[^0-9.]","","ALL"))>

	<cfset ElectChildrenCheckbox = Trim(REReplace(ElectChildrenCheckbox,"[^on]","","ALL"))>
	<cfset ChildCoverage = Trim(REReplace(ChildCoverage,"[^0-9.]","","ALL"))>
	<cfset ChildMoPrem = Trim(REReplace(ChildMoPrem,"[^0-9.]","","ALL"))>

	<cfset FamMoPrem = Trim(REReplace(FamMoPrem,"[^0-9.]","","ALL"))>

	<!--- Loop over the list of returned form fields and load child arrays with form values --->
	<cfloop list="#fieldnames#" index="word">
		<cfif Left(word,5) is 'child'><!--- process fields that start with 'child' --->
			<cfset temp = Left(word,10)><!--- all of the child field have the same length (10) plus the number 1-16 --->
			<cfset formID = mid(word,11,2)><!--- get child number starting in position 11 --->
			<cfswitch expression = "#temp#">
				<cfcase value = "childNameF">
					<cfset temp = Trim(REReplace(Evaluate(word),"[^0-9a-zA-Z '-.]","","ALL"))>
					<cfif temp gt ''><cfset childNameFArray[formID] = temp></cfif>
				</cfcase>
				<cfcase value = "childNameM">
					<cfset temp = Trim(REReplace(Evaluate(word),"[^0-9a-zA-Z '-.]","","ALL"))>
					<cfif temp gt ''><cfset childNameMArray[formID] = temp></cfif>
				</cfcase>
				<cfcase value = "childNameL">
					<cfset temp = Trim(REReplace(Evaluate(word),"[^0-9a-zA-Z '-.]","","ALL"))>
					<cfif temp gt ''><cfset childNameLArray[formID] = temp></cfif>
				</cfcase>
				<cfcase value = "childBirth">
					<cfset temp = Trim(REReplace(Evaluate(word),"[^0-9/]","","ALL"))>
					<cfif temp gt ''><cfset childBirthArray[formID] = temp></cfif>
				</cfcase>
				<cfcase value = "childGendr">
					<cfset temp = Evaluate(word)>
					<cfif temp is 'm' or temp is 'f'>
						<cfset childGendrArray[formID] = temp>
					</cfif>
				</cfcase>
				<cfcase value = "childDepen">
					<cfset temp = Evaluate(word)>
					<cfif temp is 'y'>
						<cfset childDepenArray[formID] = 1>
					<cfelseif temp is 'n'>
						<cfset childDepenArray[formID] = 0>
					</cfif>
				</cfcase>
				<cfcase value = "childFmkey">
					<cfset temp = Trim(REReplace(Evaluate(word),"[^0-9]","","ALL"))>
					<cfif temp gt ''><cfset childFmkeyArray[formID] = temp></cfif>
				</cfcase>
			</cfswitch>
		</cfif>
	</cfloop>


	<!--- EDITS --->
	<!--- EDITS --->
	<!--- EDITS --->
	<cfif EmpNameFirst is ''>
		<div class="errorText">Error: Employee First Name is required</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpNameFirstErr  = '#errInd#<br>'>
	<cfelseif len(EmpNameFirst) lt 2>
		<div class="errorText">Error: Employee First Name must be at least 2 characters</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpNameFirstErr  = '#errInd#<br>'>
	</cfif>

	<cfif EmpNameLast is ''>
		<div class="errorText">Error: Employee Last Name is required</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpNameLastErr  = errInd>
	<cfelseif len(EmpNameLast) lt 2>
		<div class="errorText">Error: Employee Last Name must be at least 2 characters</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpNameLastErr  = '#errInd#<br>'>
	</cfif>

	<cfif EmpAddress1 is ''>
		<div class="errorText">Error: Address Line 1 is required</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpAddress1Err  = errInd>
	<cfelseif len(EmpAddress1) lt 3>
		<div class="errorText">Error: Address line 1 must be at least 3 characters</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpAddress1Err  = '#errInd#<br>'>
	</cfif>

	<cfif EmpCity is ''>
		<div class="errorText">Error: City is required</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpCityErr  = errInd>
	<cfelseif len(EmpCity) lt 2>
		<div class="errorText">Error: City must be at least 2 characters</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpCityErr  = '#errInd#<br>'>
	</cfif>

	<cfif EmpState is '0'>
		<div class="errorText">Error: State is required</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpStateErr  = errInd>
	</cfif>

	<cfif EmpZip is ''>
		<div class="errorText">Error: Zip Code is required</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpZipErr  = errInd>
	<cfelseif (len(EmpZip) neq 5 and len(EmpZip) neq 9)>
		<div class="errorText">Error: Zip Code must be 5 or 9 characters</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpZipErr  = '#errInd#<br>'>
	</cfif>

	<cfif EmpGender is ''>
		<div class="errorText">Error: Employee Gender is required</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpGenderErr  = errInd>
	</cfif>

	<!--- No need to check SSN if we came from Beneficiary Screen, because user cannot edit it on reentry --->
	<cfif EmpID gt 0>
		<cfset ok = 1>
	<cfelse>
		<cfif EmpSSN is ''>
			<div class="errorText">Error: Employee SSN is required</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset EmpSSNErr  = errInd>
		<cfelseif len(EmpSSN) neq 9>
			<div class="errorText">Error: Employee SSN must be 9 numbers</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset EmpSSNErr  = '#errInd#<br>'>
		</cfif>
		<cfif EmpSSN neq VerifySSN>
			<div class="errorText">Error: Employee SSN and Verify SSN do not match</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset EmpSSNErr  = errInd>
		</cfif>
	</cfif>
	
	

	<cfif NOT isDate(EmpDOB)>
		<div class="errorText">Error: Employee Date of Birth is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpDOBErr  = errInd>
	<cfelseif Year(EmpDOB) lt 1900>
		<div class="errorText">Error: Employee Date of Birth is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpDOBErr  = errInd>
	<cfelseif Year(EmpDOB) gt Year(now())>
		<div class="errorText">Error: Employee Date of Birth is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset EmpDOBErr  = errInd>
	</cfif>

	<cfif BankAchAuth neq 'on'>
		<div class="errorText">Error: ACH Authroization must be checked</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset BankAchAuthErr  = '#errInd#<br>'>
	</cfif>
	
	<cfif BankName is ''>
		<div class="errorText">Error: Bank Name must be entered</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset BankNameErr  = '#errInd#<br>'>
	</cfif>
	
	<!--- Edit Bank Routing Number --->
	<!--- Valid routing prefix (00-12, 21-32, 61-72 and 80) --->
	<!--- checksum:  3 (d1 + d4 + d7) + 7 (d2 + d5 + d8) + (d3 + d6 + d9) mod 10 = 0 --->
	<cfif BankRouting is ''>
		<div class="errorText">Error: Bank Routing must be entered</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset BankRoutingErr  = '#errInd#<br>'>
	<cfelseif Len(BankRouting) neq 9>
		<div class="errorText">Error: Bank Routing number must be 9 digits</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset BankRoutingErr  = '#errInd#<br>'>
	<cfelse>
		<cfset BankPrefix = Mid(BankRouting,1,2)>
		<cfset checksum = (3 * (Mid(BankRouting,1,1) + Mid(BankRouting,4,1) + Mid(BankRouting,7,1))) +
								(7 * (Mid(BankRouting,2,1) + Mid(BankRouting,5,1) + Mid(BankRouting,8,1))) +
								(1 * (Mid(BankRouting,3,1) + Mid(BankRouting,6,1) + Mid(BankRouting,9,1)))>
		<cfif (BankPrefix gt 12 and BankPrefix lt 21) or
				(BankPrefix gt 32 and BankPrefix lt 61) or
				(BankPrefix gt 72 and BankPrefix lt 80) or
				(BankPrefix gt 80)>
			<div class="errorText">Error: Bank Routing number is invalid - bad prefix</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset BankRoutingErr  = errInd>
		<cfelseif Right(checksum,1) neq 0>
			<div class="errorText">Error: Bank Routing number is invalid - bad Checksum (<cfoutput>#checksum#</cfoutput>)</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset BankRoutingErr  = '#errInd#<br>'>
		</cfif>
	</cfif>
	
	
	<cfif BankAccount is ''>
		<div class="errorText">Error: Bank Account must be entered</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset BankAccountErr  = '#errInd#<br>'>
	</cfif>
	
	<cfif VerifyBankAccount is ''>
		<div class="errorText">Error: Verify Bank Account must be entered</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset VerifyBankAccountErr  = '#errInd#<br>'>
	</cfif>
	
	<cfif BankAccount neq VerifyBankAccount>
		<div class="errorText">Error: Bank Account and Verify Bank Account must match</div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset BankAccountErr  = '#errInd#<br>'>
	</cfif>
	
	<cfif BankType is 'Checking' or BankType is 'Savings'>
	<cfelse>
		<div class="errorText">Error: Bank Type must be Checking or Savings, not <cfoutput>#BankType#</cfoutput></div>
		<cfset ErrorCount  = ErrorCount + 1>
		<cfset BankTypeErr  = '#errInd#<br>'>
	</cfif>
				
				

	<!--- If SpoSel coverage is SELECTED Spouse fields are required --->
	<cfif SpoSel gt 0 or SpoMoPrem gt 0>
		<cfif SpoNameFirst is ''>
			<div class="errorText">Error: Spouse First Name is required for Spouse coverage</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset SpoNameFirstErr  = '#errInd#<br>'>
		</cfif>

		<cfif SpoNameLast is ''>
			<div class="errorText">Error: Spouse Last Name is required for Spouse coverage</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset SpoNameLastErr  = errInd>
		</cfif>

		<cfif SpoGender is ''>
			<div class="errorText">Error: Spouse Gender is required for Spouse coverage</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset SpoGenderErr  = errInd>
		</cfif>

		<cfif NOT isDate(SpoDOB)>
			<div class="errorText">Error: Spouse Date of Birth is required for Spouse coverage</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset SpoDOBErr  = errInd>
		<cfelseif Year(SpoDOB) lt 1900>
			<div class="errorText">Error: Spouse Date of Birth is invalid</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset SpoDOBErr  = errInd>
		<cfelseif Year(SpoDOB) gt Year(now())>
			<div class="errorText">Error: Spouse Date of Birth is invalid</div>
			<cfset ErrorCount  = ErrorCount + 1>
			<cfset SpoDOBErr  = errInd>
		</cfif>
	</cfif>
	<cfoutput>
	<!--- Edit Children --->
	<cfloop from="1" to="13" index="jx">
		<cfif childNameFArray[jx] gt '' or childNameMArray[jx] gt '' or childNameLArray[jx] gt '' or childBirthArray[jx] gt ''>

			<cfset allReqFieldsSw = 0>

			<!--- if you are here at least one child field was entered --->
			<cfif childNameFArray[jx] is ''>
				<div class="errorText">Error: Child Line #jx# requires all fields except Middle Name</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset allReqFieldsSw = 1>
				<cfset childArrayErr[jx]  = errChildInd>
			<cfelseif len(childNameFArray[jx]) lt 2>
				<div class="errorText">Error: Child Line #jx# First Name must be at least 2 characters</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset childArrayErr[jx]  = errChildInd>
			</cfif>

			<cfif childNameLArray[jx] is '' and allReqFieldsSw is 0>
				<div class="errorText">Error: Child Line #jx# requires all fields except Middle Name</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset allReqFieldsSw = 1>
				<cfset childArrayErr[jx]  = errChildInd>
			<cfelseif len(childNameLArray[jx]) lt 2>
				<div class="errorText">Error: Child Line #jx# Last Name must be at least 2 characters</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset childArrayErr[jx]  = errChildInd>
			</cfif>

			<cfif childBirthArray[jx] is '' and allReqFieldsSw is 0>
				<div class="errorText">Error: Child Line #jx# requires all fields except Middle Name</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset allReqFieldsSw = 1>
				<cfset childArrayErr[jx]  = errChildInd>
			<cfelseif not isDate(childBirthArray[jx])>
				<div class="errorText">Error: Child Line #jx# Birthdate is invalid</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset childArrayErr[jx]  = errChildInd>
			<cfelseif Year(childBirthArray[jx]) lt 1900>
				<div class="errorText">Error: Child Line #jx# Birth year is invalid</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset childArrayErr[jx]  = errChildInd>
			<cfelseif Year(childBirthArray[jx]) gt Year(now())>
				<div class="errorText">Error: Child Line #jx# Birth year is invalid</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset childArrayErr[jx]  = errChildInd>
			</cfif>

			<cfif childGendrArray[jx] is '' and allReqFieldsSw is 0>
				<div class="errorText">Error: Child Line #jx# must be Male or Female</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset allReqFieldsSw = 1>
				<cfset childArrayErr[jx]  = errChildInd>
			</cfif>

			<cfif childDepenArray[jx] is '' and allReqFieldsSw is 0>
				<div class="errorText">Error: Child Line #jx# Dependent must be Yes or No</div>
				<cfset ErrorCount  = ErrorCount + 1>
				<cfset allReqFieldsSw = 1>
				<cfset childArrayErr[jx]  = errChildInd>
			</cfif>
		</cfif>
	</cfloop>

	<!--- Edit for missing fields --->
	<cfif not isNumeric(EmpCoverage)>
		<div class="errorText">Error: Employee Coverage is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
	</cfif>
	<cfif not isNumeric(SpoCoverage)>
		<div class="errorText">Error: Spouse Coverage is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
	</cfif>
	<cfif not isNumeric(EmpMoPrem)>
		<div class="errorText">Error: Employee Monthly Premium is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
	</cfif>
	<cfif not isNumeric(SpoMoPrem)>
		<div class="errorText">Error: Spouse Monthly Premium is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
	</cfif>
	<cfif not isNumeric(ChildMoPrem)>
		<div class="errorText">Error: Child Monthly Premium is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
	</cfif>
	<cfif not isNumeric(FamMoPrem)>
		<div class="errorText">Error: Family Monthly Premium is invalid</div>
		<cfset ErrorCount  = ErrorCount + 1>
	</cfif>
	</cfoutput>

	<cfif EmpID gt 0>
		<cfset ok = 1>
	<cfelseif ErrorCount is 0>
		<!--- Check to see if this Employee SSN is already on file --->
		<cfset EmpSSNLastFour = Right(EmpSSN,4)>
		<cfset EmpSSNEncrypted = Encrypt(EmpSSN,EncryptKey,'AES/CBC/PKCS5Padding','HEX') />
		<cfquery name="qryDup" datasource="#application.db#" blockfactor="100">
			select empSSNLastFour, fmNameFirst, fmNameMiddle, fmNameLast, empSSNEncrypted, empAddUserID, empAddDate, userName
				from tblGrpSupEmployee E
				join tblGrpSupFamilyMember F on E.empID = F.empID
				join tblGrpSupExtUsers U on E.empAddUserID = U.userID
				where empSSNLastFour = '#EmpSSNLastFour#'
		</cfquery>
		<cfif qryDup.recordcount gt 0>
			<cfloop query="qryDup">
				<!--- Decrypt ---><cfset myCipherText = empSSNEncrypted>
				<cfset myPlainText = Decrypt(myCipherText,EncryptKey,'AES/CBC/PKCS5Padding','HEX') />
				<cfif myPlainText is EmpSSN>
					<div class="errorText">Error: Record with this SSN was added on
						<cfoutput>#DateFormat(empAddDate,'mm/dd/yyyy')# - #TimeFormat(empAddDate, 'hh:mm tt')# by #userName#</cfoutput></div>
					<cfset ErrorCount  = ErrorCount + 1>
					<cfbreak>
				</cfif>
			</cfloop>
		</cfif>
	</cfif>


	<cfif ErrorCount gt 0>
		<!--- Display Errors --->
		<cfset ShowForm = true>
	<cfelse>
		<cfset ShowForm = false>
		<cfset AddDate = now()>

		<!--- Get tblGrpSupEmployee recordID --->
		<cftransaction>
			<cfif EmpID gt 0>
				<!--- Update Employee data --->
				<cfquery name="UpdatetblGrpSupEmployee" datasource="#application.db#">
					Update tblGrpSupEmployee set
						empAddr1 = '#empAddress1#',
						empAddr2 = '#empAddress2#',
						empCity = '#empCity#',
						empState = '#empState#',
						empZip = '#empZip#',
						empAuthACH = <cfif BankAchAuth is 'on'>1<cfelse>0</cfif>, 
						empBankName = '#BankName#', 
						empBankRouting = #BankRouting#, 
						empBankAcctNum = #BankAccount#, 
						empBankAcctType = '#Left(BankType,1)#',
						empUpdateUserID = '#session.id#', 
						empUpdateDate = #CreateODBCDateTime(AddDate)#
					Where empID = #empID#
				</cfquery>
			<cfelse>
			<cfparam name="BankAchAuth" default="">
<cfparam name="BankName" default="">
<cfparam name="BankRouting" default="">
<cfparam name="BankAccount" default="">
<cfparam name="VerifyBankAccount" default="">
<cfparam name="BankType" default="">
				<!--- Write Employee to tblGrpSupEmployee --->
				<cfquery name="inserttblGrpSupEmployee" datasource="#application.db#">
					Insert into tblGrpSupEmployee
						(empSSNEncrypted, empSSNLastFour, empAddr1, empAddr2, empCity, empState, empZip,
						 empAuthACH, empBankName, empBankRouting, empBankAcctNum, empBankAcctType,
						 empAddUserID, empAddDate, uniID)
					Values
						('#EmpSSNEncrypted#', '#EmpSSNLastFour#', '#empAddress1#', '#empAddress2#', '#empCity#', '#empState#', '#empZip#',
						 <cfif BankAchAuth is 'on'>1<cfelse>0</cfif>, '#BankName#', #BankRouting#, #BankAccount#, '#Left(BankType,1)#',
						 '#session.id#', #CreateODBCDateTime(now())#, #uniID#)
				</cfquery>
	
				<cfquery name="getMaxID" dataSource="#application.db#">
					select MAX(empID) AS maxID FROM tblGrpSupEmployee where empSSNEncrypted = '#EmpSSNEncrypted#'
				</cfquery>
				<cfoutput query="getMaxID">
					<cfset empID = maxID>
				</cfoutput>
			</cfif>

			<!--- Write Employee to tblGrpSupFamilyMember --->
			<cfif isNumeric(empFmkey) and empFmkey gt 0>
				<cfquery name="UpdateFamilyMemberM" datasource="#application.db#">
					Update tblGrpSupFamilyMember set
						fmNameFirst = '#empNameFirst#',
						fmNameMiddle = '#empNameMiddle#',
						fmNameLast = '#empNameLast#',
						fmDOB = #CreateODBCDate(empDOB)#,
						fmGender = '#empGender#',
						fmUpdateUserID = '#session.id#', 
						fmUpdateDate = #CreateODBCDateTime(AddDate)#
					Where fmID = #empFmkey#
				</cfquery>
			<cfelse>
				<cfquery name="insertFamilyMemberM" datasource="#application.db#">
					Insert into tblGrpSupFamilyMember
						(fmType, fmNameFirst, fmNameMiddle, fmNameLast, fmDOB, fmGender, fmDependent,
						 fmAddUserID, fmAddDate, empID)
					Values
						('e', '#empNameFirst#', '#empNameMiddle#', '#empNameLast#', #CreateODBCDate(empDOB)#, '#empGender#', 0,
						 '#session.id#', #CreateODBCDateTime(AddDate)#, #empID#)
				</cfquery>
			</cfif>

			<!--- Write Spouse to tblGrpSupFamilyMember --->
			<cfif isNumeric(spoFmkey) and spoFmkey gt 0>
				<cfquery name="UpdateFamilyMemberS" datasource="#application.db#">
					Update tblGrpSupFamilyMember set
						fmNameFirst = '#spoNameFirst#',
						fmNameMiddle = '#spoNameMiddle#',
						fmNameLast = '#spoNameLast#',
						fmDOB = <cfif Trim(spoDOB) is "">NULL<cfelse>#CreateODBCDate(spoDOB)#,</cfif>
						fmGender = '#spoGender#',
						fmUpdateUserID = '#session.id#', 
						fmUpdateDate = #CreateODBCDateTime(AddDate)#
					Where fmID = #spoFmkey#
				</cfquery>
			<cfelse>
				<cfif SpoNameFirst neq ''>
					<cfquery name="insertFamilyMemberS" datasource="#application.db#">
						Insert into tblGrpSupFamilyMember
							(fmType, fmNameFirst, fmNameMiddle, fmNameLast, fmDOB, fmGender, fmDependent,
							 fmAddUserID, fmAddDate, empID)
						Values
							('s', '#spoNameFirst#', '#spoNameMiddle#', '#spoNameLast#', #CreateODBCDate(spoDOB)#, '#spoGender#', 0,
							 '#session.id#', #CreateODBCDateTime(AddDate)#, #empID#)
					</cfquery>
				</cfif>
			</cfif>


			<!--- Write Children to tblGrpSupFamilyMember --->
			<cfloop from="1" to="#ArrayLen(childNameFArray)#" index="jx">
				<cfif isNumeric(childFmkeyArray[jx]) and childFmkeyArray[jx] gt 0>
					<cfquery name="UpdateFamilyMemberC" datasource="#application.db#">
						Update tblGrpSupFamilyMember set
							fmNameFirst = '#childNameFArray[jx]#',
							fmNameMiddle = '#childNameMArray[jx]#',
							fmNameLast = '#childNameLArray[jx]#',
							fmDOB = <cfif Trim(childBirthArray[jx]) is "">NULL<cfelse>#CreateODBCDate(childBirthArray[jx])#,</cfif>
							fmGender = '#childGendrArray[jx]#',
							fmUpdateUserID = '#session.id#', 
							fmUpdateDate = #CreateODBCDateTime(AddDate)#
						Where fmID = #childFmkeyArray[jx]#
					</cfquery>
				<cfelse>
					<cfif childNameFArray[jx] gt ''>
						<cflog file="Ullico3" type="error" text="Enroll:686: Emp=#fmNameLast#">
						<cfquery name="insertFamilyMemberC" datasource="#application.db#">
							Insert into tblGrpSupFamilyMember
								(fmType, fmNameFirst, fmNameMiddle, fmNameLast, fmDOB, fmGender, fmDependent,
								 fmAddUserID, fmAddDate, empID)
							Values
								('c', '#childNameFArray[jx]#', '#childNameMArray[jx]#', '#childNameLArray[jx]#', #CreateODBCDate(childBirthArray[jx])#,
								'#childGendrArray[jx]#', #childDepenArray[jx]#,
								 '#session.id#', #CreateODBCDateTime(AddDate)#, #empID#)
						</cfquery>
					</cfif>
				</cfif>
			</cfloop>

			<!--- get Bill Class for Employee --->
			<cfset EmpBillClass = ''>
			<cfif EmpMoPrem gt 0>
				<cfset EmpAge = DateDiff('yyyy',EmpDob,AddDate)>
				<cfquery name="qryBillClassE" datasource="#application.db#" blockfactor="100">
					select bcCode from tblGrpSupBillClass where uniID = #uniID# and bcPersonType = 'e' and bcAgeLow <= #EmpAge# and bcAgeHigh >= #EmpAge# and bcOption = #OptSel#
				</cfquery>
				<cfif qryBillClassE.recordcount is 1>
					<cfoutput query="qryBillClassE"><cfset EmpBillClass = bcCode></cfoutput>
				</cfif>
			</cfif>

			<!--- get Bill Class for Spouse --->
			<cfset SpoBillClass = ''>
			<cfif SpoMoPrem gt 0>
				<cfset SpoAge = DateDiff('yyyy',SpoDob,AddDate)>
				<cfquery name="qryBillClassS" datasource="#application.db#" blockfactor="100">
					select bcCode from tblGrpSupBillClass where uniID = #uniID# and bcPersonType = 's' and bcAgeLow <= #SpoAge# and bcAgeHigh >= #SpoAge# and bcOption = #OptSel#
				</cfquery>
				<cfif qryBillClassS.recordcount is 1>
					<cfoutput query="qryBillClassS"><cfset SpoBillClass = bcCode></cfoutput>
				</cfif>
			</cfif>


			<!--- get Bill Class for Child --->
			<cfset ChildBillClass = ''>
			<cfif ChildMoPrem gt 0>
				<cfquery name="qryBillClassC" datasource="#application.db#" blockfactor="100">
					select bcCode from tblGrpSupBillClass where uniID = #uniID# and bcPersonType = 'c'
				</cfquery>
				<cfif qryBillClassC.recordcount is 1>
					<cfoutput query="qryBillClassC"><cfset ChildBillClass = bcCode></cfoutput>
				</cfif>
			</cfif>

			<!--- Write Info to tblGrpSupPlanEffective --->
			<cfif not isNumeric(SpoCoverage)><cfset SpoCoverage = 0></cfif>
			<cfif not isNumeric(ChildCoverage)><cfset ChildCoverage = 0></cfif>
			
			<cfif isNumeric(PlanEffKey) and PlanEffKey gt 0>
				<cfquery name="UpdatePlanEffective" datasource="#application.db#">
					Update tblGrpSupPlanEffective set
						peOption = #OptSel#,
						peEmpCoverage = #EmpCoverage#,
						peEmpMoPrem = #EmpMoPrem#,
						peEmpSelection = #EmpSel#,
						peEmpBillClass = '#EmpBillClass#',
						peSpoCoverage = #SpoCoverage#,
						peSpoMoPrem = #SpoMoPrem#,
						peSpoSelection = #SpoSel#,
						peSpoBillClass = '#SpoBillClass#',
						peChildCoverage = #ChildCoverage#,
						peChildMoPrem = #ChildMoPrem#,
						peChildBillClass = '#ChildBillClass#',
						peFamMoPrem = #FamMoPrem#,
						peUpdateUserID = '#session.id#',
						peUpdateDate = #CreateODBCDateTime(CurrDate)#
					Where peID = #PlanEffKey#
				</cfquery>
			<cfelse>
				<cfquery name="insertPlanEffective" datasource="#application.db#">
					Insert into tblGrpSupPlanEffective
						(peStartDate, peStopDate, peOption,
						 peEmpCoverage, peEmpMoPrem, peEmpSelection, peEmpBillClass,
						 peSpoCoverage, peSpoMoPrem, peSpoSelection, peSpoBillClass,
						 peChildCoverage, peChildMoPrem, peChildBillClass,
						 peFamMoPrem,
						 peAddUserID, peAddDate, empID, uniID)
					Values
						(#CreateODBCDate(PeriodStart)#, #CreateODBCDate(PeriodStop)#, #OptSel#,
						 #EmpCoverage#, #EmpMoPrem#, #EmpSel#, '#EmpBillClass#',
						 #SpoCoverage#, #SpoMoPrem#, #SpoSel#, '#SpoBillClass#',
						 #ChildCoverage#, #ChildMoPrem#, '#ChildBillClass#',
						 #FamMoPrem#,
						 '#session.id#', #CreateODBCDateTime(AddDate)#, #empID#, #uniID#)
				</cfquery>
			</cfif>
		</cftransaction>

		<h1>Congrats!</h1>
		<cflocation url="Beneficiary.cfm?empID=#empID#&uniID=#uniID#" addtoken="no">
	</cfif>

</cfif>




<cfif ShowForm is true>
	<cfinclude template="EnrollForm.cfm">
</cfif>



<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<script type="text/javascript">
// format social security number
$('#EmpSSN').keyup(function() {
	var val = this.value.replace(/\D/g, '');
	var newVal = '';
	if(val.length > 4) {
		this.value = val;
	}
	if((val.length > 3) && (val.length < 6)) {
		newVal += val.substr(0, 3) + '-';
		val = val.substr(3);
	}
	if (val.length > 5) {
		newVal += val.substr(0, 3) + '-';
		newVal += val.substr(3, 2) + '-';
		val = val.substr(5);
	}
	newVal += val;
	this.value = newVal;
});
$('#VerifySSN').keyup(function() {
	var val = this.value.replace(/\D/g, '');
	var newVal = '';
	if(val.length > 4) {
		this.value = val;
	}
	if((val.length > 3) && (val.length < 6)) {
		newVal += val.substr(0, 3) + '-';
		val = val.substr(3);
	}
	if (val.length > 5) {
		newVal += val.substr(0, 3) + '-';
		newVal += val.substr(3, 2) + '-';
		val = val.substr(5);
	}
	newVal += val;
	this.value = newVal;
});

$('#moreChildren').hide();

<!--- if we are returning from page two - recreate the Option Table as it was when we left --->
<cfif EmpID gt 0>recreateOptionTable();</cfif>

</script>

<cfinclude template="zinc-foot.cfm">