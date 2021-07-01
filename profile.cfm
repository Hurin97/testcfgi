<cfif NOT isUserLoggedIn()>
    <cflocation url="index.cfm?noaccess" />
</cfif>

<cfset userService = createObject("component","testcfgi.components.userService")/>


<cfif structKeyExists(form, 'fld_editUserSubmit')>
	<!---Server side form validation --->
	<cfset aErrorMessages = userService.validateUser(form.fld_userNickName,form.fld_userFirstName,form.fld_userSurName,form.fld_userPassword,form.fld_userPasswordConfirm) />
	<!---Continue if the aErrorMessages array is empty --->
	<cfif arrayIsEmpty(aErrorMessages)>	
		<cfset userService.updateUser(form.fld_userNickName,form.fld_userFirstName,form.fld_userSurName,form.fld_userPassword,form.fld_userRole,form.fld_userID) />
		<cfset variables.formSubmitComplete = true />
	</cfif>
</cfif>
<!---Form processing ends here--->

<!---Get user to update--->
<cfset rsSingleUser = userService.getUserByID(session.stLoggedInUser.userID) />
<!---Get instruments to feed the form's Drop-Down list--->
<!--- <cfset rsInstrumentsList = userService.getInstruments() /> --->
<!---Include header --->
<cfmodule template="front.cfm" title="ErrorCheker - Профиль">
	<div id="pageBody">
		<h1>Здесь вы  можете обновить свои данные</h1>
		<cfform id="frm_editUser">
			<fieldset>
				<legend>Ваш профиль</legend>
				<!---Output error messages if any--->
				<cfif isDefined('aErrorMessages') AND NOT arrayIsEmpty(aErrorMessages)>
					<cfoutput>
						<cfloop array="#aErrorMessages#" index="message">
							<p class="errorMessage">#message#</p>
						</cfloop>
					</cfoutput>
				</cfif>
				<!---Output feedback message if form has been successfully submitted--->
				<cfif structKeyExists(variables,'formSubmitComplete') AND variables.formSubmitComplete>
					<p class="feedback">Ваши данные обновлены!</p>
				</cfif>
				<dl>
					<dt><label for="fld_userNickName">Имя пользователя</label></dt>
					<dd><cfinput name="fld_userNickName" id="fld_userNickName" value="#rsSingleUser.nickname#" required="true"  message="Пожалуйста, укажите никнейм" validateAt="onSubmit" /></dd>
                    <!---First name text field--->
					<dt><label for="fld_userFirstName">Имя</label></dt>
					<dd><cfinput name="fld_userFirstName" id="fld_userFirstName" value="#rsSingleUser.name#" required="true" message="Пожалуйста, укажите свое имя" validateAt="onSubmit" /></dd>
					<!---Last name text field--->
					<dt><label for="fld_userSurName">Фамилия</label></dt>
					<dd><cfinput name="fld_userSurName" id="fld_userSurName" value="#rsSingleUser.surname#" required="true" message="Пожалуйста, укажите свою фамилию" validateAt="onSubmit" /></dd>
					<!---Password text field--->
					<dt><label for="fld_userPassword">Пароль</label></dt>
					<dd><cfinput type="password" name="fld_userPassword" value="#rsSingleUser.password#" id="fld_userPassword" required="true" message="Пожалуйста, напишите пароль" validateAt="onSubmit" /></dd>
					<dt><label for="fld_userPasswordConfirm">Подтверждающий пароль</label></dt>
					<dd><cfinput type="password" name="fld_userPasswordConfirm" value="#rsSingleUser.password#" id="fld_userPasswordConfirm" required="true" message="Пожалуйста, подтвердите свой пароль" validateAt="onSubmit" /></dd>
					
					</dd>
					<!---Comment Textarea--->
					<!--- <dt><label for="fld_userComment">Comment</label></dt>
					<dd><cftextarea name="fld_userComment" id="fld_userComment" richtext="true" toolbar="Basic">
							<cfoutput>
								#rsSingleUser.FLD_USERCOMMENT#
							</cfoutput>
						</cftextarea></dd> --->
				</dl>
				<!---Add userID, userRole, userIsActive, userApproved to form --->
				<cfinput name="fld_userID" value="#rsSingleUser.id#" type="hidden" />
				<cfinput name="fld_userRole" value="#rsSingleUser.role#" type="hidden" />
				<!--- <cfinput name="fld_userIsActive" value="1" type="hidden" />
				<cfinput name="fld_userApproved" value="1" type="hidden" /> --->
				<!---Submit button--->
				<input type="submit" name="fld_editUserSubmit" id="fld_editUserSubmit" value="Обновить данные" />
			</fieldset>
		</cfform>
	</div>
</cfmodule>