<cfmodule template="front.cfm" >
    <div id="pageBody">
        <cfif NOT isUserLoggedIn()>
            <h1> Авторизируйтесь, чтобы продолжить</h1>
            <p><img src="images/verybad.jpg" width="250" height="180" class="floatLeft" /></p>
        <cfelse>
            <h1> Привет!</h1>
            <p><img src="images/hm.jpg" width="250" height="180" class="floatLeft" /></p>
        </cfif> 
    
    </div>
</cfmodule>
    