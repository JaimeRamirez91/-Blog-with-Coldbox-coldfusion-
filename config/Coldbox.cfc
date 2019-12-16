component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= getSystemSetting( "Blog", "i can create a new blog using microservices" ),
			eventName 				= "event",

			//Development Settings
			reinitPassword			= "",
			handlersIndexAutoReload = true,

			//Implicit Events
			defaultEvent			= "Echo.index",
			requestStartHandler		= "",
			requestEndHandler		= "",
			applicationStartHandler = "",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "",
			viewsHelper					= "",
			modulesExternalLocation		= [],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			controllerDecorator			= "",

			//Error/Exception Handling
			invalidHTTPMethodHandler = "",
			exceptionHandler		= "BaseHandler.onError",
			invalidEventHandler			= "",
			customErrorTemplate		= "",

			//Application Aspects
			handlerCaching 			= false,
			eventCaching			= false,
			viewCaching				= false,
			// Will automatically do a mapDirectory() on your `models` for you.
			autoMapModels			= true
		};

		// custom settings
		settings = {

		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "localhost,127\.0\.0\.1"
		};

		// Module Directives
		modules = {
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ConsoleAppender" }
			},
			// Root Logger
			root = { levelmax="INFO", appenders="*" },
			// Implicit Level Categories
			info = [ "coldbox.system" ]
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
		];

	
		// module setting overrides
		moduleSettings = {

			cbauth = {
				// Which class will provide user information for authentication
				userServiceClass : "UserService@security"
			},
		
			cbSecurity : {
				// The global invalid authentication event or URI or URL to go if an invalid authentication occurs
				"invalidAuthenticationEvent"    : "security:Session.onInvalidAuth",
				// Default Authentication Action: override or redirect when a user has not logged in
				"defaultAuthenticationAction"    : "redirect",
				// The global invalid authorization event or URI or URL to go if an invalid authorization occurs
				"invalidAuthorizationEvent"        : "security:Session.onInvalidAuthorization",
				// Default Authorization Action: override or redirect when a user does not have enough permissions to access something
				"defaultAuthorizationAction"    : "redirect",
				// You can define your security rules here or externally via a source
				"rules"                            : [],
				// The validator is an object that will validate rules and annotations and provide feedback on either authentication or authorization issues.
				"validator"                        : "CBAuthValidator@cbsecurity",
				// The WireBox ID of the authentication service to use in cbSecurity which must adhere to the cbsecurity.interfaces.IAuthService interface.
				"authenticationService"          : "authenticationService@cbauth",
				// WireBox ID of the user service to use
				"userService"                     : "UserService@security",
				// The name of the variable to use to store an authenticated user in prc scope if using a validator that supports it.
				"prcUserVariable"                 : "oCurrentUser",
				// If source is model, the wirebox Id to use for retrieving the rules
				"rulesModel"                    : "",
				// If source is model, then the name of the method to get the rules, we default to `getSecurityRules`
				"rulesModelMethod"                : "getSecurityRules",
				// If source is db then the datasource name to use
				"rulesDSN"                        : "",
				// If source is db then the table to get the rules from
				"rulesTable"                    : "",
				// If source is db then the ordering of the select
				"rulesOrderBy"                    : "",
				// If source is db then you can have your custom select SQL
				"rulesSql"                         : "",
				// Use regular expression matching on the rule match types
				"useRegex"                         : true,
				// Force SSL for all relocations
				"useSSL"                        : false,
				// Auto load the global security firewall
				"autoLoadFirewall"                : true,
				// Activate handler/action based annotation security
				"handlerAnnotationSecurity"        : true,
				// Activate security rule visualizer, defaults to false by default
				"enableSecurityVisualizer"        : true,
				// JWT Settings
				"jwt"                             : {
					// The jwt secret encoding key to use
					"secretKey"               : getSystemSetting( "JWT_SECRET", "" ),
					// by default it uses the authorization bearer header, but you can also pass a custom one as well or as an rc variable.
					"customAuthHeader"        : "x-auth-token",
					// The expiration in minutes for the jwt tokens
					"expiration"              : 60,
					// If true, enables refresh tokens, longer lived tokens (not implemented yet)
					"enableRefreshTokens"     : false,
					// The default expiration for refresh tokens, defaults to 30 days
					"refreshExpiration"       : 43200,
					// encryption algorithm to use, valid algorithms are: HS256, HS384, and HS512
					"algorithm"               : "HS512",
					// Which claims neds to be present on the jwt token or `TokenInvalidException` upon verification and decoding
					"requiredClaims"          : [] ,
					// The token storage settings
					"tokenStorage"            : {
						// enable or not, default is true
						"enabled"       : true,
						// A cache key prefix to use when storing the tokens
						"keyPrefix"     : "cbjwt_",
						// The driver to use: db, cachebox or a WireBox ID
						"driver"        : "cachebox",
						// Driver specific properties
						"properties"    : {
							"cacheName" : "default"
						}
					}
				}
			}
		};
        /*
		// flash scope configuration
		flash = {
			scope = "session,client,cluster,ColdboxCache,or full path",
			properties = {}, // constructor properties for the flash scope implementation
			inflateToRC = true, // automatically inflate flash data into the RC scope
			inflateToPRC = false, // automatically inflate flash data into the PRC scope
			autoPurge = true, // automatically purge flash data for you
			autoSave = true // automatically save flash scopes at end of a request and on relocations.
		};

		//Register Layouts
		layouts = [
			{ name = "login",
		 	  file = "Layout.tester.cfm",
			  views = "vwLogin,test",
			  folders = "tags,pdf/single"
			}
		];

		//Conventions
		conventions = {
			handlersLocation = "handlers",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "models",
			eventAction 	 = "index"
		};

		*/

	}

	/**
	* Development environment
	*/
	function development(){
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
	}

}
