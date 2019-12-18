/**
 * @by_Jaime_Ramirez
 * 12/16/2019
*  User Service
*/
component singleton accessors="true"{

	// Properties
	property name="bcrypt"
			 inject="@BCrypt";

	property name="qb"
			 inject="provider:QueryBuilder@qb";

	property name="auth"
			 inject="authenticationService@cbauth";

	property name="populator"
			 inject="wirebox:populator";

	property name="ormService"
	         inject="entityService";

	/**
	 * Constructor
	 */
	UserService function init(){
		return this;
	}
    /**
	 * Create a new Provider and injected by module @security
	 */
	User function new() provider="User@security"; //

   /**
	* Create  User function
	*
	* @user
	*/
	function create( required user ){
		var qResults = qb.from( "users" )
			.insert( values     = {
				"name" 		    = arguments.user.getName(),
				"email" 	    = arguments.user.getEmail(),
				"username" 	    = arguments.user.getUsername(),
				"password" 	    = bcrypt.hashPassword( arguments.user.getPassword() ),
				"isActive"      = 1,
				"updatedDate"   = now(),
				"createdDate"   = now()
			} );

		// populate the id
		arguments.user.setId( qResults.result.generatedKey );

		return arguments.user;
	}

    /**
	 * isValidCredentials
	 *
	 * @username
	 * @password
	 */
	function isValidCredentials( required username, required password ){
		var oUser = retrieveUserByUsername( arguments.username );
		if( !oUser.isLoaded() ){ return false; }

		try{
			return bcrypt.checkPassword( arguments.password, oUser.getPassword() );
		} catch( any e ){
			return false;
		}
	}

	/**
	 * retrieveUserByUsername
	 *
	 * @username
	 */
	function retrieveUserByUsername( required username ){
		return populator.populateFromStruct(
            new(),
            qb.from( "users" ).where( "username" , arguments.username ).first()
        );
	}

	/**
	 * retrieveUserById
	 *
	 * @id
	 */
	function retrieveUserById( required id ){
		return populator.populateFromStruct(
			new(),
            qb.from( "users" ).where( "id" , arguments.id ).first()
        );
	}

}
