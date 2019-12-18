/**
 * A TimeBox Permission
 */
component
	persistent="true"
	table="permissions"
	extends="models.BaseEntity"
{

	/* *********************************************************************
	**						PROPERTIES
	********************************************************************* */

	property
		name="permissionId"
		fieldtype="id"
        generator="native"
		setter="false";

	property
		name="permission"
		notnull="true"
		unique="true"
		length="255"
		default=""
		index="idx_permissionName";

	property
		name="description"
		notnull="false"
		default=""
		length="500"
        db_html="textarea";

	/* *********************************************************************
	**							PK + CONSTRAINTS
	********************************************************************* */



	// Mementofication
	this.memento = {
		defaultIncludes : [ "permission", "description", "numberOfRoles" ],
		defaultExcludes : [ ]
	};

	// Validation Constraints
	this.constraints ={
		"permission" 	= {	required=true, size="1..100", validator="UniqueValidator@cborm" },
		"description"	= { required = false, size = "1..500" }
	};

	/* *********************************************************************
	**							PUBLIC FUNCITONS
	********************************************************************* */

	/**
	* Constructor
	*/
	function init(){
		super.init();
		return this;
	}

}
