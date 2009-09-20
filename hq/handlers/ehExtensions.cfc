<cfcomponent extends="eventHandler">

	<cffunction name="dspMain" access="public" returntype="void">
		<cfscript>
			try {
				aRules = getService("app").getRules();
				aActiveRules = getService("app").getActiveRules();
	
				setValue("aRules", aRules);
				setValue("aActiveRules", aActiveRules);
	
				setView("vwExtensions");

			} catch(any e) {
				setMessage("error",e.message);
				getService("bugTracker").notifyService(e.message, e);
				setNextEvent("ehGeneral.dspMain");
			}
		</cfscript>
	</cffunction>

	<cffunction name="dspRule" access="public" returntype="void">
		<cfscript>
			var index = getValue("index",0);
			var ruleName = getValue("ruleName","");

			try {
				if(ruleName eq "") throw("Please select a valid rule type","validation");
				
				stRule = getService("app").getRuleInfo(ruleName);
	
				setValue("stRule", stRule);
				setValue("index", index);
				setValue("ruleName", ruleName);
				
				if(index gt 0) {
					aActiveRules = getService("app").getActiveRules();
					setValue("aActiveRule", aActiveRules[index]);
				}

				setView("vwRule");

			} catch(validation e) {
				setMessage("warning",e.message);
				setNextEvent("ehExtensions.dspMain");

			} catch(any e) {
				setMessage("error",e.message);
				getService("bugTracker").notifyService(e.message, e);
				setNextEvent("ehExtensions.dspMain");
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="doSaveRule" access="public" returntype="void">
		<cfscript>
			var user = getValue("currentUser");
			
			try {
				if(not user.getIsAdmin()) {setMessage("warning","You must be an administrator to create or modify a rule"); setNextEvent("ehExtensions.dspMain");}
				getService("app").saveRule(argumentCollection = form);
				setMessage("info","Rule saved. Changes will be effective the next time the listener service is started.");
			
			} catch(any e) {
				setMessage("error",e.message);
				getService("bugTracker").notifyService(e.message, e);
			}

			setNextEvent("ehExtensions.dspMain");
		</cfscript>
	</cffunction>

	<cffunction name="doDeleteRule" access="public" returntype="void">
		<cfscript>
			var user = getValue("currentUser");
			
			try {
				if(not user.getIsAdmin()) {setMessage("warning","You must be an administrator to delete a rule"); setNextEvent("ehExtensions.dspMain");}
				getService("app").deleteRule(index);
				setMessage("info","Rule has been removed. Changes will be effective the next time the listener service is started.");
			
			} catch(any e) {
				setMessage("error",e.message);
				getService("bugTracker").notifyService(e.message, e);
			}

			setNextEvent("ehExtensions.dspMain");
		</cfscript>
	</cffunction>

	<cffunction name="doDisableRule" access="public" returntype="void">
		<cfscript>
			var user = getValue("currentUser");
			
			try {
				if(not user.getIsAdmin()) {setMessage("warning","You must be an administrator to enable or disable a rule"); setNextEvent("ehExtensions.dspMain");}
				getService("app").disableRule(index);
				setMessage("info","Rule has been disabled. Changes will be effective the next time the listener service is started.");
			
			} catch(any e) {
				setMessage("error",e.message);
				getService("bugTracker").notifyService(e.message, e);
			}

			setNextEvent("ehExtensions.dspMain");
		</cfscript>
	</cffunction>

	<cffunction name="doEnableRule" access="public" returntype="void">
		<cfscript>
			var user = getValue("currentUser");
			
			try {
				if(not user.getIsAdmin()) {setMessage("warning","You must be an administrator to enable or disable a rule"); setNextEvent("ehExtensions.dspMain");}
				getService("app").enableRule(index);
				setMessage("info","Rule has been enabled. Changes will be effective the next time the listener service is started.");
			
			} catch(any e) {
				setMessage("error",e.message);
				getService("bugTracker").notifyService(e.message, e);
			}

			setNextEvent("ehExtensions.dspMain");
		</cfscript>
	</cffunction>	
	
</cfcomponent>