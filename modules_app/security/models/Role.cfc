/**
* Role entity
*/
component
	persistent="true"
	table="roles"
	accessors="true"
	extends="models.BaseEntity"
{

	// Primary Key
	property
		name="id"
		fieldtype="id"
		column="id"
		generator="native"
		setter="false";

	// Properties
	property
		name="role"
		notnull="true"
		unique="true"
		length="255"
		default=""
		index="idx_roleName";

	property
		name="description"
		notnull="false"
		db_html="textarea"
		default=""
		length="500";



	// Validation
	this.constraints = {

	};

	// Constructor
	function init(){
        super.init();
		return this;
	}
}
