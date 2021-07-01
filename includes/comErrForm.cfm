<cfset errRepServ=createObject("component","testcfgi.components.errRepService") />

<cfform id="viewACER" preservedata="true">
    <cfset  rN=""/>
    <cfif isDefined("url.reportN")>
        <cfset rN=url.reportN/>
    <cfelseif isDefined("url.CFGRIDKEY")>
        <cfset rN=url.CFGRIDKEY/>
    <cfelseif isDefined("url.streportN")>
        <cfset rN=url.streportN/>
    </cfif>
    <cfif rN NEQ "" >
        <fieldset>
            <cfset rsAllCER = errRepServ.getAllComER(rN) />
            <legend>История ошибки</legend>        
            <cfgrid query="rsAllCER" format="html" autowidth="true" selectmode="browse" name="Список пользователей" striperowcolor="green">
                <cfgridcolumn name="comDate" header="Дата"/>
                <cfgridcolumn name="nameAct" header="Действие"/>
                <cfgridcolumn name="comment" header="Коментарий" />
                <cfgridcolumn name="userNickName" header="Никнейм"/>
            </cfgrid>
        </fieldset>
    </cfif>
</cfform>   