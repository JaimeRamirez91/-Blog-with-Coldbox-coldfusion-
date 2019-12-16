/**
* I am a new handler
*/
component extends = "handlers.BaseHandler"{
	
	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};
	
	/**
	IMPLICIT FUNCTIONS: Uncomment to use
	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/
		
	/**
	* create
	*/
	property name="userService"	inject="UserService@security";
	property name="ormService" inject="entityService";

	/**
	 * Register a new user in our system
	 */
	function create( event, rc, prc ){
		// populate, validate and create

		var usr = populateModel( ormService.new( "User" ) );
		usr.setName( "jaime" );
		usr.setEmail( "q@gmail.com" );
		usr.setUsername( "jaime" );
		usr.setPassword( "1234") ;

		prc.oUser = userService.create( usr )
		prc.response.setData( {
			 "Regiter"   : "successful"
			//"user" 	: prc.oUser.getMemento(),
			//"token"	: jwtAuth().fromUser( prc.oUser )
		} );
	}
	
}
