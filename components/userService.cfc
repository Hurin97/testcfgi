<cfcomponent output="false">
	<cffunction name="updateUser" access="public" output="false" returntype="void">
		<cfargument name="userNickName" type="string" required="true" />
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userSurName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userRole" type="numeric" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		<cfquery name="updUser" datasource="testP" >
			UPDATE test.test.users
			SET
			nickname = '#arguments.userNickName#',
            name = '#arguments.userFirstName#',
			surname = '#arguments.userSurName#',
			password = '#arguments.userPassword#'
			WHERE id = <cfqueryparam value="#arguments.userID#" cfsqltype="numeric">;
		</cfquery>
	</cffunction>
	<cffunction name="getAllUsers" access="public" output="false" returntype="query">
		<cfquery name="allUsers" datasource="testP">
			Select u.nickname as nick,
			u.name as firstname,
			u.surname as surname,
			r.name as urole
			from test.test.users u
			join test.test.user_roles r on u.role=r.id;
		</cfquery>
		<cfreturn allUsers/>
	</cffunction>
	<cffunction name="addUser" access="public" output="false" returntype="void">
		<cfargument name="userNickName" type="string" required="true" />
        <cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userSurName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userRole" type="numeric" required="true" />
		<cfquery name="addUser" datasource="testP" >
			insert into test.test.users
            (nickname, name, surname, password,role)
            values
			(<cfqueryparam value='#arguments.userNickName#' cfsqltype="varchar">,
			<cfqueryparam value='#arguments.userFirstName#' cfsqltype="varchar">,
			<cfqueryparam value='#arguments.userSurName#' cfsqltype="varchar">, 
			<cfqueryparam value='#arguments.userPassword#' cfsqltype="varchar">,
			<cfqueryparam value="#arguments.userRole#" cfsqltype="numeric">);
		</cfquery>
	</cffunction>
	<cffunction name="validateUser" access="public" output="false" returntype="array" >
		<cfargument name="userNickName" type="string" required="true" />
		<cfargument name="userFirstName" type="string" required="true" />
		<cfargument name="userSurName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userPasswordConfirm" type="string" required="true" />
		<cfargument name="addUsr" type="boolean" required="false"/>
		<cfset var aErrorMessages = arrayNew(1) />
		<cfif arguments.userFirstName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Пожалуйста, укажите имя') />
		</cfif>
		<cfif arguments.userSurName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Пожалуйста, укажите фамилию') />
		</cfif>
		<cfif arguments.userNickName EQ '' OR NOT isValid('VariableName',arguments.userNickName)>
			<cfset arrayAppend(aErrorMessages,'Пожалуйста, укажите никнейм')/>
		</cfif>
		<cfquery name="validateNickname" datasource="testP">
			Select id 
			from test.test.users
			where nickname='#arguments.userNickName#';
		</cfquery>
		<cfif validateNickname.recordCount NEQ 0 AND addUser EQ true>
			<cfset arrayAppend(aErrorMessages,'Имя пользователя занято')/>
		</cfif>
		<cfif arguments.userPassword EQ '' >
			<cfset arrayAppend(aErrorMessages,'Пожалуйста, укажите пароль ')/>
		</cfif>
		<cfif arguments.userPasswordConfirm EQ '' >
			<cfset arrayAppend(aErrorMessages,'Пожалуйста, подтвердите свой пароль')/>
		</cfif>
		<cfif arguments.userPassword NEQ arguments.userPasswordConfirm >
			<cfset arrayAppend(aErrorMessages,'Пароли не совпадают')/>
		</cfif>
		<cfreturn aErrorMessages />	
	</cffunction>
	<cffunction name="getUserByID" access="public" output="false" returntype="query">
		<cfargument name="userID" type="numeric" required="true" />
		<cfset var rsSingleUser='' />
		<cfquery datasource="testP" name="rsSingleUser">
			SELECT id,nickname, name, surname, password,role 
			FROM test.test.users
			WHERE id = <cfqueryparam value="#arguments.userID#" cfsqltype="numeric">;
		</cfquery>
		<cfreturn rsSingleUser />
	</cffunction>
</cfcomponent>