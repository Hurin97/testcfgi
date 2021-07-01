<cfcomponent output="false">
    <cffunction name="getStatusList" access="public" returntype="query">    
        <cfquery name="StList" datasource="testP">
            Select s.id as id,s.name as status
            from test.test.status s;
        </cfquery>
        <cfreturn StList />
    </cffunction>
    <cffunction name="getCriticalityList" access="public" returntype="query">
        <cfquery name="CrList" datasource="testP">
            Select c.id as id, c.name as criticality
            from test.test.criticality c;
        </cfquery>
        <cfreturn CrList />
    </cffunction>
    <cffunction name="getUrgencyList" access="public">
        <cfquery name="UrList" datasource="testP">
            Select u.id as id, u.name as urgency
            from test.test.urgency u;
        </cfquery>
        <cfreturn UrList />
    </cffunction>

    <cffunction name="createErrorReport" access="public" output="false" returntype="string">
        <cfargument name="shortDesc" type="string" required="true">
        <cfargument name="fullDesc" type="string" required="true">
        <cfargument name="statusErr" type="numeric" required="true">
        <cfargument name="urgency" type="numeric" required="true">
        <cfargument name="criticality" type="numeric" required="true">
        
        <cfset var errUid=""/>
        <cfset var sucCreate=false/>
        <cfquery name="createErrR" datasource="testP" >
            Insert into test.test.error
            (uid, create_date, brief_desc, full_desc, user_, status, urgency, criticality) values
            (<cfqueryparam value="#CreateUUID()#" cfsqltype="varchar">,
            <cfqueryparam value="#now()#" cfsqltype="cf_sql_date">,
            <cfqueryparam value='#arguments.shortDesc#' cfsqltype="varchar">,
            <cfqueryparam value='#arguments.fullDesc#' cfsqltype="varchar">,
            <cfqueryparam value='#session.stLoggedInUser.userID#' cfsqltype="numeric">,
            <cfqueryparam value='#arguments.statusErr#' cfsqltype="numeric">,
            <cfqueryparam value='#arguments.urgency#' cfsqltype="numeric">,
            <cfqueryparam value='#arguments.criticality#' cfsqltype="numeric">)
            returning id,uid as errUID;
        </cfquery>

        <cfif createErrR.recordCount EQ 1>
            <cfquery name="addToHistoryErr" datasource="testP">
                insert into test.test.historyoferr(error, date, action, comment, user_) VALUES 
                (<cfqueryparam value='#createErrR.id#' cfsqltype="numeric">,
                <cfqueryparam value="#now()#" cfsqltype="cf_sql_date">,
                <cfqueryparam value='1' cfsqltype="numeric">,
                <cfqueryparam value='Создание ошибки' cfsqltype="varchar">,
                <cfqueryparam value='#session.stLoggedInUser.userID#' cfsqltype="numeric">)
                returning id;
            </cfquery>

            <cfif addToHistoryErr.recordCount EQ 1>
                <cfset var sucCreate=true/>
            </cfif>
        </cfif>

        <cfif sucCreate EQ true>
            <cfset var  errUid=createErrR.errUID/>
        </cfif>
        

        <cfreturn errUid/>
    </cffunction>
    <cffunction name="getErrR" access="public" output="false" returntype="query">
        <cfargument name="errUID" type="string" required="true">
        
        <cfquery name="getER" datasource="testP">
            Select e.id as errId,
            e.uid as errUID,
            e.create_date as crDate,
            e.brief_desc as shDesc,
            e.full_desc as fDesc,
            u.nickname as usNN,
            e.status as stID,
            s.name as stName,
            e.urgency as urID,
            ur.name as urName,
            e.criticality as crID,
            cr.name as crName
            from test.test.error e
            join test.test.users u on e.user_ = u.id
            join test.test.status s on e.status = s.id
            join test.test.urgency ur on e.urgency = ur.id
            join test.test.criticality cr on e.criticality = cr.id
            where e.uid= <cfqueryparam value='#arguments.errUID#' cfsqltype="varchar">;
        </cfquery>
        <cfreturn getER/>
    </cffunction>

    <cffunction name="getAllErrR" access="public" output="false" returntype="query">
        <cfquery name="getAER" datasource="testP">
            Select 
            e.uid as errUID,
            e.create_date as crDate,
            e.brief_desc as shDesc,
            s.name as stName,
            ur.name as urName,
            cr.name as crName
            from test.test.error e
            join test.test.status s on e.status = s.id
            join test.test.urgency ur on e.urgency = ur.id
            join test.test.criticality cr on e.criticality = cr.id
        </cfquery>
        <cfreturn getAER/>
    </cffunction>
    <cffunction name="getAllComER" access="public" output="false" returntype="query">
        <cfargument name="errUID" type="string" required="true">
        
        <cfquery name="getACER" datasource="testP">
            select 
            h.date as comDate,
            a.name as nameAct,
            h.comment as comment,
            u.name as userNickName
            from test.test.historyoferr h 
            join test.test.error e on h.error = e.id
            join test.test.action a on h.action=a.id
            join test.test.users u on h.user_=u.id
            where e.uid=<cfqueryparam value='#arguments.errUID#' cfsqltype="varchar">;  
        </cfquery>
        <cfreturn getACER/>
    </cffunction>
    <cffunction name="updErrR" access="public" output="false" returntype="boolean">
        <cfargument name="statusErr" type="numeric" required="true">
        <cfargument name="urgency" type="numeric" required="true">
        <cfargument name="criticality" type="numeric" required="true">
        <cfargument name="errUID" type="string" required="true">

        <cfset var sucUpdER=false>
        <cfquery name="updER" datasource="testP">
            update test.test.error e
            set e.status=#arguments.statusErr#, e.urgency=#arguments.urgency#,
            e.criticality=#arguments.criticality#
            where e.uid=<cfqueryparam value='#arguments.errUID#' cfsqltype="varchar">;
        </cfquery>
    </cffunction>
    <cffunction name="updStErrR" access="public" output="false" returntype="boolean">
        <cfargument name="statusErr" type="numeric" required="true">
        <cfargument name="comment" type="string" required="true">
        <cfargument name="errUID" type="string" required="true">

        <cfset var sucUpdStER=false>
        <cfquery name="updSTER" datasource="testP">
            update test.test.error e
            set status=#arguments.statusErr#
            where e.uid=<cfqueryparam value='#arguments.errUID#' cfsqltype="varchar">
            returning id;
        </cfquery>
        <cfif updSTER.recordCount EQ 1>
            <cfquery name="addToHoE" datasource="testP">
             insert into test.test.historyoferr(error, date, action, comment, user_) 
             VALUES (<cfqueryparam value="#updSTER.id#" cfsqltype="numeric">,
             <cfqueryparam value="#now()#" cfsqltype="cf_sql_date">,
            <cfqueryparam value="#arguments.statusErr#" cfsqltype="numeric">,
            <cfqueryparam value='#arguments.comment#' cfsqltype="varchar">,
            <cfqueryparam value='#session.stLoggedInUser.userID#' cfsqltype="numeric">)
             returning id;
            </cfquery>
        </cfif>
        <cfif updSTER.recordCount EQ 1 AND addToHoE.recordCount EQ 1>
            <cfset sucUpdStER=true/>
        </cfif>
        <cfreturn sucUpdStER />
    </cffunction>
    <cffunction name="getStatName" access="public" output="false" returntype="string">
        <cfargument name="stId" type="numeric" required="true">

        <cfquery name="getStN" datasource="testP">
            Select s.name as statName
            from test.test.status s 
            where s.id=<cfqueryparam value='#arguments.stId#' cfsqltype="numeric">;
        </cfquery>

        <cfreturn #getStN.statName#/>
    </cffunction>
    
</cfcomponent>