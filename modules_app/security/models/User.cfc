/**
* A cool users entity
*/
component persistent="true" table="users" accessors="true"{
	
	property name="auth" 
			 inject="authenticationService@cbauth" 
			 persistent="false"; // persistent="false" this is ingnored by ORM

	property name="qb" 
			 inject="provider:QueryBuilder@qb" 
			 persistent="false"; // persistent="false" this is ingnored by ORM

	// Primary Key
	property name="id" 
			 fieldtype="id" 
			 column="id"
			 generator="native" 
			 setter="true";
	
	// Properties
	property name="name" 
			 ormtype="string";
	property name="email" 
			 ormtype="string";
	property name="username" 
			 ormtype="string";
	property name="password" 
		     ormtype="string";
	property name="createdDate" 
			 ormtype="date";
	property name="modifiedDate" 
			 ormtype="date";
	property name="detail"
			 ormtype="string";
	
	
	// Validation
	this.constraints = {
		username    : { required : true, udf : ( value, target ) => {
            return qb.from( "users" ).where( "username", arguments.value ).count() == 0;
        }},
	};

	this.memento = {
		defaultIncludes = [ "*" ],
		neverInclude = [ "password" ]
	};

	// Constructor
	function init(){
		variables.permissions = [ "write", "read" ];
		return this;
	}
	/**
	 * isLoaded return boolean
	 */
	boolean function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	/**
     * A struct of custom claims to add to the JWT token
     */
    struct function getJwtCustomClaims(){
		return [ "role" : "admin" ];
	}

    /**
     * This function returns an array of all the scopes that should be attached to the JWT token that will be used for authorization.
     */
	array function getJwtScopes(){
		return variables.permissions;
	}

    /**
     * Verify if the user has one or more of the passed in permissions
     *
     * @permission One or a list of permissions to check for access
     *
     */
    boolean function hasPermission( required permission ){
		if ( isSimpleValue( arguments.permission ) ) {
			arguments.permission = listToArray( arguments.permission );
		}

		return arguments.permission
			.filter( function(item){
				return ( variables.permissions.findNoCase( item ) );
			} )
			.len();
	}

    /**
     * Shortcut to verify it the user is logged in or not.
     */
    boolean function isLoggedIn(){
		return auth.isLoggedIn();
	}
}



