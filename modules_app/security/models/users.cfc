/**
* A cool users entity
*/
component persistent="true" table="users"{

	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	
	// Properties
	property name="name" ormtype="string";	property name="email" ormtype="string";	property name="username" ormtype="string";	property name="password" ormtype="string";	property name="createdDate" ormtype="date";	property name="modifiedDate" ormtype="date";	
	
	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="numeric" }
	};
	
	// Constructor
	function init(){
		
		return this;
	}
}

