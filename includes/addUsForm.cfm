<cfif isUserLoggedIn()>
    <cflocation url="index.cfm" />
</cfif>
<cfset userService = createObject("component","testcfgi.components.userService")/>
<cfif structKeyExists(form, 'fld_addUserSubmit')>
	<cfset aErrorMessages = userService.validateUser(form.fld_userNickName,form.fld_userFirstName,form.fld_userSurName,form.fld_userPassword,form.fld_userPasswordConfirm,true) />
	<cfif arrayIsEmpty(aErrorMessages)>	
		<cfset userService.addUser(form.fld_userNickName,form.fld_userFirstName,form.fld_userSurName,form.fld_userPassword,form.fld_userRole) />
		<cfset variables.formSubmitComplete = true />
        <p class="feedback">Создание нового аккаунта прошло успешно!</p>
	</cfif>
</cfif>

<cfform name="addUser" id="addUser">
    <fieldset>
        <legend>Данные аккаунта</legend>
        <cfif isDefined('aErrorMessages') AND NOT arrayIsEmpty(aErrorMessages)>
            <cfoutput>
                <cfloop array="#aErrorMessages#" index="message">
                    <p class="errorMessage">#message#</p>
                </cfloop>
            </cfoutput>
        </cfif>
        <dl>
            <dt><label for="fld_userNickName">Имя пользователя</label></dt>
            <dd><cfinput name="fld_userNickName" id="fld_userNickName" required="true"  message="Пожалуйста, укажите никнейм" validateAt="onSubmit" /></dd>
            <dt><label for="fld_userFirstName">Имя</label></dt>
            <dd><cfinput name="fld_userFirstName" id="fld_userFirstName" required="true" message="Пожалуйста, укажите свое имя" validateAt="onSubmit" /></dd>
            <dt><label for="fld_userSurName">Фамилия</label></dt>
            <dd><cfinput name="fld_userSurName" id="fld_userSurName"  required="true" message="Пожалуйста, укажите свою фамилию" validateAt="onSubmit" /></dd>
            <dt><label for="fld_userPassword">Пароль</label></dt>
            <dd><cfinput type="password" name="fld_userPassword"  id="fld_userPassword" required="true" message="Пожалуйста, напишите пароль" validateAt="onSubmit" /></dd>
            <dt><label for="fld_userPasswordConfirm">Подтверждающий пароль</label></dt>
            <dd><cfinput type="password" name="fld_userPasswordConfirm"  id="fld_userPasswordConfirm" required="true" message="Пожалуйста, подтвердите свой пароль" validateAt="onSubmit" /></dd>
        </dl>
        <cfinput name="fld_userRole" value="2" type="hidden" />
        <input type="submit" name="fld_addUserSubmit" id="fld_addUserSubmit" value="Создать" />
    </fieldset>
</cfform>