<cfset userService = createObject("component","testcfgi.components.userService")/>

<cfform id="viewAU" preservedata="true">
    <fieldset>
        <cfset rsAllUsers = userService.getAllUsers() />
        <legend>Список пользователей</legend>        
        <cfgrid query="rsAllUsers" format="html" autowidth="true" selectmode="browse" name="Список пользователей">
            <cfgridcolumn name="nick" header="Имя пользователя"/>
            <cfgridcolumn name="firstname" header="Имя"/>
            <cfgridcolumn name="surname" header="Фамилия" />
            <cfgridcolumn name="urole" header="Роль"/>
        </cfgrid>
    </fieldset>
</cfform>   