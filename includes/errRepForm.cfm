<cfset errRepServ=createObject("component","testcfgi.components.errRepService") />
<cfif structKeyExists(form,'fld_updSTR')>
    <cfset successUpdR = errRepServ
    .updStErrR(form.fld_st_Name,form.fld_commUpE,form.fld_erUID) />

    <cfif successUpdR EQ true>
        <cflocation url="errReport.cfm?successUpdSt&reportN=#form.fld_erUID#"/>
        
         
    </cfif>
</cfif> 

<cfform id="errRep" preservedata="true">
    <cfset  rN=""/>
    <cfif isDefined("url.reportN")>
        <cfset rN=url.reportN/>
    <cfelseif isDefined("url.CFGRIDKEY")>
        <cfset rN=url.CFGRIDKEY/>
    </cfif>
    <cfif isDefined("url.repStID") And isDefined("url.streportN")>
        <fieldset>
            <cfset rsStName=errRepServ.getStatName(url.repStID)/>
            <legend> Изменение статуса ошибки</legend>
            <dl>
                <dt>Статус изменяется на</dt>
                <dd><cfoutput>#rsStName#</cfoutput></dd>
                <dt><label for="fld_commUpE">Комментарий</label></dt>
                <dd><cfinput type="text" name="fld_commUpE" id="fld_commUpE" required="true"  validateAt="onSubmit" message="Пожалуйста, введите комментарий" /></dd>
                <dt>Ошибка №</dt>
                <cfoutput>#url.streportN#</cfoutput>
                <cfinput name="fld_st_Name" value="#url.repStID#" id="fld_st_Name" type="hidden">
                <cfinput name="fld_erUID" value="#url.streportN#" id="fld_erUID" type="hidden">

            </dl>
            <cfinput type="submit" name="fld_updSTR" id="fld_updSTR" value="Подтвердить" />
        </fieldset>
    
    </cfif>
    <cfif rN NEQ "" >
        <fieldset>
            <cfset rsReport=errRepServ.getErrR(rN)/>
            <cfset rsComRList=errRepServ.getAllComER(rN)/>
            <!--- <cfset statusList=errRepServ.getStatusList()/>
            <cfset urgList=errRepServ.getUrgencyList()/>
            <cfset critList=errRepServ.getCriticalityList()/> --->
            <legend>Отчет № <cfoutput>#rsReport.errUID#</cfoutput> </legend>
            <cfif structKeyExists(url,"successCreate")>
                <p class="feedback" > Отчет успешно создан!</p>
            </cfif>
            <cfif structKeyExists(url,"successUpdSt")>
                <p class="feedback" > Статус успешно обновлен!</p>
            </cfif>
            <dl>
                <dt> Дата создания </dt>
                <dd><cfoutput>#dateformat(rsReport.crDate,'mm/dd/yyyy ')#</cfoutput> </dd>
                
                <dt><label for="fld_shortDesc">Краткое описание</label></dt>
                <dd><cfoutput>#rsReport.shDesc#</cfoutput> </dd>
                     <!--- required="true"  validateAt="onSubmit" message="Пожалуйста, введите краткое описание" /></dd> --->
                <dt><label for="fld_fullDesc">Полное описание</label></dt>
                <dd><cfoutput>#rsReport.fDesc#</cfoutput> </dd>
                <dt><label for="fld_status">Статус</label></dt>
                <dd><cfoutput>#rsReport.stName#</cfoutput></dd>
                <!--- <dd><cfselect query="statusList" queryposition="below" name="fld_status" id="fld_status" required="true" 
                    validateAt="onSubmit" message="Пожалуйста, выберите статус ошибки"  display="status" value="id" >
                    <option name="0">--Выберите статус--</option>  
                </cfselect></dd>  --->
                <dt><label for="fld_urgency">Срочность</label></dt> 
                <dd><cfoutput>#rsReport.urName#</cfoutput></dd>
                <!--- <dd><cfselect query="urgList" queryposition="below" name="fld_urgency" id="fld_urgency" required="true" 
                    validateAt="onSubmit" message="Пожалуйста, выберите срочность ошибки"  display="urgency" value="id" >
                 <option name="0">--Выберите срочность--</option>  
                </cfselect></dd>  --->
                <dt><label for="fld_critical">Критичность</label></dt>
                <dd><cfoutput>#rsReport.crName#</cfoutput></dd>
                <!--- <dd><cfselect query="critList" queryposition="below" name="fld_critical" id="fld_critical" required="true" 
                validateAt="onSubmit" message="Пожалуйста, выберите cрочность ошибки"  display="criticality" value="id" >
                <option name="0">--Выберите критичность--</option>   --->
                <!--- </cfselect></dd>  --->
            </dl>
            <cfswitch expression="#rsReport.stID#">
                <cfcase value="1" > <cfoutput> <button><a href="errReport.cfm?repStID=2&streportN=#rN#"  >Подтвердить открытие тикета</a></button> </cfoutput> </cfcase>
                <cfcase value="2" > <cfoutput><button><a href="errReport.cfm?repStID=3&streportN=#rN#">Подтвердить решение тикета</a></button></cfoutput></cfcase>
                <cfcase value="3"><cfoutput><button><a href="errReport.cfm?repStID=2&streportN=#rN#">Вернуть на доработку</a> </button>
                    <button><a href="errReport.cfm?repStID=4&streportN=#rN#">Закрыть тикет </a> </button></cfoutput></cfcase>
            </cfswitch>
                       
        </fieldset>
    </cfif>
</cfform>