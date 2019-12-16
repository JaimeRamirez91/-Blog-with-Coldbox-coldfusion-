/**
 * @ByJaime_Ramirez
 * 12/16/2019
 * Config router for module: security
 */

<cfscript>
        
        //Default
        route( pattern="/", handler="home", action="index" );  

        //Register Users
        resources( resource="registration", only="create" );

        //custom route for login and logout
        post("/login",  "auth.login");
        post("/logout", "auth.logout");  

        //General router
        route(  pattern="/:handler/:action?" );

</cfscript>