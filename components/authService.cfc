<cfcomponent output="false">
    <cffunction name="validateUser" access="public" output="false" returntype="array">
        <cfargument name="username" type="string" required="true">
        <cfargument name="password" type="string" required="true">
        
        <cfset var aErrorMessages=arrayNew(1) />

        <cfif  arguments.username EQ ''>
            <cfset arrayAppend(aErrorMessages,'Пожалуйста, введите   имя') />
        </cfif>
        
        <cfif arguments.password EQ ''>
            <cfset arrayAppend(arrayAppend,'Пожалуйста, введите пароль') />
        </cfif>

        <cfreturn aErrorMessages/>
        
    </cffunction>

    <cffunction name="doLogin" access="public" output="false" returntype="boolean">
        <cfargument name="username" type="string" required="true">
        <cfargument name="password" type="string" required="true">

        <cfset var isUserLoggedIn=false/>

        <cfquery name="loginUser" datasource="testP">
            SELECT u.id,u.name as usern , r.name as rolename
            FROM test.test.users u
            inner join test.test.user_roles r 
            on u.role= r.id
            WHERE  nickname=<cfqueryparam value="#arguments.username#" cfsqltype="varchar">
            and password=<cfqueryparam value="#arguments.password#" cfsqltype="varchar">;  
        </cfquery>
        <cfif loginUser.recordCount EQ 1>
            <cflogin>
                <cfloginuser name="#loginUser.usern# #arguments.username#" password="#arguments.password#" roles="#loginUser.rolename#"  />
            </cflogin>
            
            <cfset session.stLoggedInUser= {'username'=#arguments.username#, 'userID'=loginUser.id,'firstname'=loginUser.usern} />

            <cfset var isUserLoggedIn=true />
        </cfif>
        
        <cfreturn isUserLoggedIn />

    </cffunction>

    <cffunction name="doLogout" access="public" output="false" returntype="void">

        <cfset structDelete(session,'stLoggedInUser') />

        <cflogout/>

    </cffunction>

</cfcomponent>