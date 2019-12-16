/**
 * A ColdBox Event Handler
 */
component extends = "handlers.BaseHandler"{

	/**
	 * Home page
	 */
   // Injection
 
	function index( event, rc, prc ){
          writeDump("llegue"); abort;
	     prc.response.setData("Welcome");
	}

	function login( event, rc, prc ){
		prc.response.setData("login pleace");
   }
   
   /**
   * onInvalidAuth
   */
   function onInvalidAuth(){
	   prc.response.setData("onInvalidAuth");
   }

   
   /**
   * onInvalidAuthorization
   */
   function onInvalidAuthorization(){
	  prc.response.setData("onInvalidAuthorization");
   }
   
   

}
