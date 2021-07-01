<cfset errRepServ=createObject("component","testcfgi.components.errRepService") />

<cfform id="viewLEF" preservedata="true">
    <fieldset>
        <cfset rsAllError = errRepServ.getAllErrR() />
        <legend>Список ошибок в системе</legend>        
        <cfgrid query="rsAllError" format="html" autowidth="true" selectmode="browse" name="Список ошибок в системе" >
            <cfgridcolumn name="shDesc" header="Краткое описание" />
            <cfgridcolumn name="errUID" header="Идентификатор" href="errReport.cfm" hrefkey="errUID" />
            <cfgridcolumn name="stName" header="Статус"/>
            <cfgridcolumn name="urName" header="Срочность" />
            <cfgridcolumn name="crName" header="Критичность"/>
        </cfgrid>
    </fieldset>
</cfform>