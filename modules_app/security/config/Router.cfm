/**
 * @ByJaime_Ramirez
 * 12/16/2019
 * Config router for module: security
 */

<cfscript>

        //Default
        get("/", "home.index");
       // route( pattern="/", handler="home", action="index" );

        //Register Users
        resources( resource="registration", only="create" );

        //redirect
        get("/sessions/invalidOuth", "session.onInvalidAuth");

        //custom route for login and logout
        post("/login",  "auth.login");
        post("/logout", "auth.logout");

        //General router
        route(  pattern="/:handler/:action?" );

</cfscript>