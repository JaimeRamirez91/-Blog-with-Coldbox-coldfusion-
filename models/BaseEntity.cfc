component mappedsuperclass="true" accessors="true" extends="cborm.models.ActiveEntity"{

    property 	name="createdDate"
    type="date"
    ormtype="timestamp"
    notnull="true"
    update="false";

    property 	name="updatedDate"
        type="date"
        ormtype="timestamp"
        notnull="true";

    property 	name="isActive"
        sqltype="boolean"
        default="true"
        notnull="true"
        index="idx_active";

}