/**
* A cool users entity
*/
component
    persistent="true"
	table="users"
	accessors="true"
	extends="models.BaseEntity"
{
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
			 ormtype="date";
	property name="detail"
			 ormtype="string";

    /******************************************************************************
	 *                                                                            *
	 *                                      Relations                             *
	 *                                                                            *
	 ******************************************************************************/
	 // M2M -> A-la-carte Permissions
	property
		name="permissions"
		singularName="permission"
		fieldtype="many-to-many"
		type="array"
		lazy="extra"
		cfc="security.models.Permission"
		cascade="all"
		fkcolumn="FK_userID"
		linktable="userPermissions"
		inversejoincolumn="FK_permissionID"
		orderby="permission"
		db_displayColumns="permission";


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
		//variables.permissions = getPermissionsByUserId();
		super.init();
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
		 return getPermissionsByUserId();
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
				return ( getPermissionsByUserId().findNoCase( item ) );
			} )
			.len();
	}

    /**
     * Shortcut to verify it the user is logged in or not.
     */
    boolean function isLoggedIn(){
		return auth.isLoggedIn();
	}


	/**
	* PermissionsByUserId
	*/
	array function getPermissionsByUserId(){
		response = [ ];
		var qryResult = queryExecute(
				"
				SELECT perms.permission AS 'permissionsIsActive'
					FROM userPermissions usr_perm
						JOIN permissions perms
						JOIN users usr
							WHERE usr.id = usr_perm.FK_userID
								AND   perms.permissionId = usr_perm.FK_permissionID
								AND   perms.isActive = 1
								AND   usr.isActive   = 1
								AND   usr.id = :id
				",
				[ id = getId() ],
				{
					returnType : "array"
				}
				);
		try {
			for ( element in qryResult ) {
				response.append( element.permissionsIsActive );
			}
		} catch (exType exName) {
			//pass none result
		}

	return response;
	}
}
