/**
 * This is the base class for all persistent entities
 */
component mappedsuperclass="true" accessors="true" extends="cborm.models.ActiveEntity"{

	/* *********************************************************************
	**							PROPERTIES
	********************************************************************* */

	property 	name="createdDate"
				type="date"
				ormtype="timestamp"
				notnull="true"
				update="false"
				ndex="idx_createdDate";

	property 	name="updatedDate"
				type="date"
				ormtype="timestamp"
				notnull="true"
				index="idx_updatedDate";

	property 	name="isActive"
				ormtype="boolean"
				default="true"
				notnull="true"
				index="idx_active";

	/* *********************************************************************
	**						PUBLIC STATIC VARIABLES
	********************************************************************* */

	this.DATE_FORMAT      = "mmm dd yyyy";
	this.TIME_FORMAT      = "hh:mm tt";

	/* *********************************************************************
	**						PUBLIC FUNCTIONS
	********************************************************************* */

	/**
	* Constructor
	*/
	BaseEntity function init(){
		variables.createdDate 	= now();
		variables.updatedDate 	= now();
		variables.isActive		= true;

		// Incorporate default includes for the base class.
		if( !isNull( this.memento.defaultIncludes ) && isNull( this.memento.baseIncluded ) ){
			this.memento.defaultIncludes.append( [
				this.pk,
				"createdDate",
				"updatedDate",
				"isActive"
			], true );
			this.memento.baseIncluded = true;
		}

		super.init();

		return this;
	}

	/**
	 * Get the primary key value, if not found, return empty string
	 */
	function getId(){
		return variables[ this.pk ] ?: "";
	}

	/*
	* pre insertion procedures
	*/
	void function preInsert(){
		var now = now();
		variables.createdDate 	= now;
		variables.updatedDate 	= now;
	}

	/*
	* pre update procedures
	*/
	void function preUpdate( struct oldData ){
		variables.updatedDate 	= now();
	}

	/**
	* Get formatted createdDate
	*/
	string function getDisplayCreatedDate( dateFormat = this.DATE_FORMAT, timeFormat = this.TIME_FORMAT ){
		if( isNull( variables.createdDate ) ){ return ""; }
		return dateFormat( variables.createdDate, arguments.dateFormat ) & " " & timeFormat( variables.createdDate, arguments.timeFormat );
	}

	/**
	* Get formatted modified date
	*/
	string function getDisplayUpdatedDate( dateFormat = this.DATE_FORMAT, timeFormat = this.TIME_FORMAT ){
		if( isNull( variables.updatedDate ) ){ return ""; }
		return dateFormat( variables.updatedDate, arguments.dateFormat ) & " " & timeFormat( variables.updatedDate, arguments.timeFormat );
	}

	/**
	* Verify if entity is loaded or not
	*/
	boolean function isLoaded(){
		return ( isNull( variables[ this.pk ] ) OR !len( variables[ this.pk ] ) ? false : true );
	}

}
