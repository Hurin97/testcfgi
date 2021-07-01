<cfif structKeyExists(URL,'logout')>
    <cfset createObject("component","testcfgi.components.authService").doLogout()/>
</cfif>

<cfif structKeyExists(form,'fld_submitLogin')>

    <cfset authenficationService=createObject("component","testcfgi.components.authService") />

    <cfset aErrorMessages = authenficationService.validateUser(form.fld_userName,form.fld_userPassword)/>

    <cfif ArrayisEmpty(aErrorMessages)>
        <cfset isUserLoggedIn = authenficationService.doLogin(form.fld_userName,form.fld_userPassword)/>
    </cfif>
</cfif>


<cfform id="fConnexion" preservedata="true">
    <fieldset>
        <legend>Login</legend>
        <cfif structKeyExists(url,"noaccess")>
            <p class="errorMessage"> Пожалуйста, войдите в систему, чтобы получить доступ к странице</p>
        </cfif>
        <cfif structKeyExists(variables,'aErrorMessages') AND NOT arrayIsEmpty(aErrorMessages)>
            <cfoutput>
                <cfloop array="#aErrorMessages#" item="message">
                    <p class="errorMessage">#message#</p>
                </cfloop>
            </cfoutput>
        </cfif>
        <cfif structKeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
            <p class="errorMessage">Пользователь не найден. Попробуйте еще раз.</p>
        </cfif>
        <cfif structKeyExists(session,'stLoggedInUser')>
            <p><cfoutput>Добро пожаловать, #session.stLoggedInUser.firstname# !</cfoutput></p>
            <p><button><a href="/testcfgi/profile.cfm">Профиль</a></button> <button><a href="/testcfgi/index.cfm?logout">Выйти</a></button></p> 
        <cfelse>
            <dl>
                <dt><label for="fld_userName">Username</label></dt>
                <dd><cfinput type="text" name="fld_userName" id="fld_userName" required="true"  validateAt="onSubmit" message="Пожалуйста, введите никнейм" /></dd>
    		    <dt><label for="fld_userPassword">Password</label></dt>
                <dd><cfinput type="password" name="fld_userPassword" id="fld_userPassword" required="true"  validateAt="onSubmit" message="Пожалуйста, введите пароль" /></dd>
            </dl>
            <cfinput type="submit" name="fld_submitLogin" id="fld_submitLogin" value="Войти" /> <button><a href="/testcfgi/addUser.cfm">Зарегистрироваться</a></button>

        </cfif>
    </fieldset>
</cfform>