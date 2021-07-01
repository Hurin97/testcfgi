<cfset errRepServ=createObject("component","testcfgi.components.errRepService") />
<cfif structKeyExists(form,'fld_submitCreateR')>
    <cfset successCreateR = errRepServ
    .createErrorReport(form.fld_shortDesc,form.fld_fullDesc,form.fld_status,form.fld_urgency,form.fld_critical) />

    <cfif successCreateR NEQ "">
        <cflocation url="errReport.cfm?successCreate&reportN=#successCreateR#" />

         
    </cfif>
</cfif>
<cfset statusList=errRepServ.getStatusList()/>
<cfset urgList=errRepServ.getUrgencyList()/>
<cfset critList=errRepServ.getCriticalityList()/>

<cfform id="newErr" preservedata="true">
    <fieldset>
        <legend>Новый отчет</legend>
        <dl>
            <dt><label for="fld_shortDesc">Краткое описание</label></dt>
            <dd><cfinput type="text" name="fld_shortDesc" id="fld_shortDesc" required="true"  validateAt="onSubmit" message="Пожалуйста, введите краткое описание" /></dd>
            <dt><label for="fld_fullDesc">Полное описание</label></dt>
            <dd><cfinput type="text" name="fld_fullDesc" id="fld_fullDesc" required="true"  validateAt="onSubmit" message="Пожалуйста, введите полное описание" /></dd>
            <dt><label for="fld_status">Статус</label></dt>
            <dd><cfselect query="statusList" queryposition="below" name="fld_status" id="fld_status" required="true" 
                validateAt="onSubmit" message="Пожалуйста, выберите статус ошибки"  display="status" value="id" >
                <option name="0">--Выберите статус--</option>  
            </cfselect></dd> 
            <dt><label for="fld_urgency">Срочность</label></dt> 
            <dd><cfselect query="urgList" queryposition="below" name="fld_urgency" id="fld_urgency" required="true" 
                validateAt="onSubmit" message="Пожалуйста, выберите срочность ошибки"  display="urgency" value="id" >
             <option name="0">--Выберите срочность--</option>  
            </cfselect></dd> 
            <dt><label for="fld_critical">Критичность</label></dt>
            <dd><cfselect query="critList" queryposition="below" name="fld_critical" id="fld_critical" required="true" 
            validateAt="onSubmit" message="Пожалуйста, выберите cрочность ошибки"  display="criticality" value="id" >
            <option name="0">--Выберите критичность--</option>  
            </cfselect></dd> 
        </dl>
        <cfinput type="submit" name="fld_submitCreateR" id="fld_submitCreateR" value="Создать" />
    </fieldset>
</cfform>