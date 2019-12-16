/**
* A cool users entity
*/
component persistent="true" table="users" accessors="true"{
	
	property name="auth" inject="authenticationService@cbauth";
    property name="qb" inject="provider:QueryBuilder@qb";

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="true";
	
	// Properties
	property name="name" ormtype="string";
	property name="email" ormtype="string";
	property name="username" ormtype="string";
	property name="password" ormtype="string";
	property name="createdDate" ormtype="date";
	property name="modifiedDate" ormtype="date";
	property name="detail" ormtype="string";
	
	
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
		
		return this;
	}
	boolean function isLoaded(){
		return ( !isNull( variables.id ) && len( variables.id ) );
	}

	/**
     * A struct of custom claims to add to the JWT token
     */
    struct function getJwtCustomClaims(){
		return {};
	}

    /**
     * This function returns an array of all the scopes that should be attached to the JWT token that will be used for authorization.
     */
	array function getJwtScopes(){
		return [];
	}

    /**
     * Verify if the user has one or more of the passed in permissions
     *
     * @permission One or a list of permissions to check for access
     *
     */
    boolean function hasPermission( required permission ){
		return true;
	}

    /**
     * Shortcut to verify it the user is logged in or not.
     */
    boolean function isLoggedIn(){
		return auth.isLoggedIn();
	}

}



