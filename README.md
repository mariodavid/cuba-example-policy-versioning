# CUBA example policy versioning

This example shows how to use CUBAs [entity log](https://doc.cuba-platform.com/manual-6.7/entity_log.html) features as well as [entity snapshots](https://doc.cuba-platform.com/manual-6.7/entity_snapshots.html)

The example domain is an insurance backend. It will store customer information together with policies.

The example shows for those both entities the use of the generic features of CUBA in order to fulfil audit related requirements.

## Overview
![Screenshot Policy detail information](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/0-overview.gif)

## Entity Log

The first platform feature of CUBA when it comes to audit related requirements is called "entity log". This feature tracks every interaction (creation, modification and deletion) that has been done to a given entity. It answers the following questions:

* what has been changed?
* when did the change happen?
* who did the change?

The entity log functionality of CUBA is the one that requires the least amount of implementation - which is: zero. The only thing that it requires is to configure the audit log functionality for a given entity.

### Configuration 
This configuration can be done at runtime via the corresponding administration UI: `Administration > Entity Log > Setup`


![Screenshot Entity Log configuration](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/6-entity-log-configuration.png)

It requires the administration of the application to enable audit log per entity. Furthermore it allows to define which fields of the entity should be audited.

### Generic Usage

Besides the configuration it is also possible to use the generic entity log UI (`Administration > Entity Log > View`).

This UI is useful for administrators which don't use the audit log only for administrative but not business related use-cases. It is generic in the sense, that allows to filter by the following criteria:
 
* entity type 
* entity instance
* user
* time range of the change
* change type  

![Screenshot Entity Log generic usage](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/7-entity-log-generic-usage.png)


#### Policy Changes

The first example is the changes of a policy. In the screen it is possible to see all changes that have been made. The table on the top, the list of changes are displayed. It contains information about the change type as well as the person that changed the entity.

The detailed information on what changed is shown in the second table, that is activated once a given entry
in the first table is selected.

The second table contains information about which attributes have been changed as well as new and old values.

![Screenshot Policy changes - entity log](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/2-policy-changes.png)

The Tables are defined in the [policy-edit.xml](
https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/modules/web/src/com/rtcab/cepv/web/policy/policy-edit.xml#L69):

```xml
<split height="100%"
       orientation="vertical"
       width="100%">
    <table id="logTable"
           height="100%"
           width="100%">
        <columns>
            <column id="eventTs"/>
            <column id="user.login"/>
            <column id="type"/>
        </columns>
        <rows datasource="logDs"/>
    </table>
    <table id="logAttrTable"
           height="100%"
           width="100%">
        <columns>
            <column id="name"/>
            <column id="value"/>
        </columns>
        <rows datasource="logAttrDs"/>
    </table>
</split>
```

The underlying datasource defines which audit log data is displayed for this policy:

```xml
<collectionDatasource id="logDs"
                      class="com.haulmont.cuba.security.entity.EntityLogItem"
                      view="logView">
    <query>
        <![CDATA[select i from sec$EntityLog i
        where i.entityRef.entityId = :ds$policyDs order by i.eventTs desc]]>
    </query>
    <collectionDatasource id="logAttrDs"
                          property="attributes"/>
</collectionDatasource>
```

The query basically fetches entries of the `EntityLogItem` entity, which represents the audit log.
The column `entityRef` stores a soft-reference to the entity that should be audited. The `:ds$policyDs` cross-references the policy editor datasource, so that only the `EntityLogItem` instances are fetched
that contain this policy ID as a reference.

#### Customer Changes with composition

In case of the Customer entity, there is a association (modelled as a composition) to the policy entity.

Tracking this composition is not supported out of the box by CUBA. In the [configuration](https://github.com/mariodavid/cuba-example-policy-versioning#configuration) for the customer entity, it is not possible to select the attributes `policies`, but only direct attributes and *-to-One attributes are selectable.

In order to still accomplish the audit log for *-to-Many associations for entities and display it directly in a editor screen, it can be achieved in the following way:

1. Configure the audit log for the child entity (`Policy` in this case)
2. adjust the query to fetch the audit log data in the customer editor screen to also fetch any audit log information from the child entity

The query to fetch all customer audit logs as well as related policy audit logs can be found in the 
[customer-edit.xml](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/modules/web/src/com/rtcab/cepv/web/customer/customer-edit.xml):

```xml
<collectionDatasource id="logDs"
  class="com.haulmont.cuba.security.entity.EntityLogItem"
  view="logView">
    <query>
        <![CDATA[select i from sec$EntityLog i where (i.entityRef.entityId = :ds$customerDs or i.entityRef.entityId in (select e.id from cepv$Policy e where e.customer.id = :ds$customerDs)) order by i.eventTs]]>
    </query>
    <collectionDatasource id="logAttrDs"
      property="attributes"/>
</collectionDatasource>
```

The important part is the subselect that fetches all policy IDs that belong to this customer:

`or i.entityRef.entityId in (select e.id from cepv$Policy e where e.customer.id = :ds$customerDs))`

For multiple associations the subselect would need to be adjusted accordingly to all *-to-Many associations.

The result looks like this:
![Screenshot Customer changes - entity log with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/4-customer-changes-composition.png)


## Entity snapshots

The entity snapshots functionality of CUBA is another way to save information about previous states of a given entity.

Entity snapshots are in general more feature rich, but require programmatic interaction by the developer on a per-entity basis.

The main difference is, that entity snapshots are taking a snapshot of an entity at a given point in time. They store all data of that entity as a JSON structure like this:

```json
{
  "_entityName": "cepv$Customer",
  "id": "9e84d5ce-f18d-9429-7d51-793c710a5a84",
  "createdBy": "admin",
  "name": "Homer Simpson",
  "policies": [
    {
      "_entityName": "cepv$Policy",
      "id": "b2487f00-0f56-5fd5-b93c-ce6b981e9efd",
      "version": 1,
      "coverEndDate": "2010-12-31",
      "documentsSigningDate": "2010-01-01",
      "premium": 140,
      "policyId": 2,
      "createdBy": "admin",
      "createTs": "2019-05-18 11:48:54.080",
      "updateTs": "2019-05-18 11:48:54.080",
      "customer": {
        "_entityName": "cepv$Customer",
        "id": "9e84d5ce-f18d-9429-7d51-793c710a5a84"
      },
      "coverStartDate": "2010-01-01"
    }
  ],
  "createTs": "2019-05-18 11:48:54.079",
  "version": 1,
  "updateTs": "2019-05-18 11:48:54.079"
}
```

This JSON is stored next to the actual business entity tables in a generic table called `EntitySnapshot`.

In comparison, the entity log only stores the delta of the data for the different versions as plain text.

Therefore it is possible to easily re-create old versions of entity instances programmatically and interact with them. For entity logs, this is hardly possible if at all.

Also with entity snapshots comparisons between versions can be displayed. This is not only possible for direct successive versions (like V2 --> V3), but also to compare arbitrary versions (V2 <--> V5, V3 <--> V7 etc.). See "policy versions" screenshot below.

For entity logs such a visual representation is also almost impossible.

### programmatic storage of entity snapshots

As said before, it is required for entity snapshots to programmatically trigger the storage of the snapshot.

An example can be found in the [Policy editor controller](
https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/modules/web/src/com/rtcab/cepv/web/policy/PolicyEdit.groovy#L38):

```groovy
import com.haulmont.cuba.core.app.EntitySnapshotService

import javax.inject.Inject

class PolicyEdit extends AbstractEditor<Policy> {

    @Inject
    protected EntitySnapshotService entitySnapshotService

    @Inject
    protected Datasource<Policy> policyDs

    // ...
    
    @Override
    protected boolean postCommit(boolean committed, boolean close) {
        if (committed) {
            entitySnapshotService.createSnapshot(policyDs.getItem(), policyDs.getView())
        }
        return super.postCommit(committed, close)
    }
}
```

The `EntitySnapshotService` allows to programmatically store an entity snapshot. The parameter is the entity instance itself, as well as a view that is used to store the information. This allows to decide which attributes and references are stored in the snapshot.


### Entity Snapshot Diff viewer

CUBA offers a powerful generic UI for displaying the differences between entity instance versions, that can be inserted into a screen:

```xml
<frame id="diffFrame"
       height="100%"
       src="/com/haulmont/cuba/gui/app/core/entitydiff/diff-view.xml"
       width="100%"/>
```

The frame has to be initialized programmatically at screen opening time: `diffFrame.loadVersions(getItem())`. With that all versions of the given entity instances are loaded and can be used as shown below.


#### Policy History / Versions

![Screenshot Policy versions - entity snapshots](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/3-policy-versioning.png)

#### Customer History / Versions with composition

The only difference for the customer entity snapshots is that the view of the customer also contains the policies. Therefore the entity snapshots also contains the information about the associations (similar to the functionality shown in the entity log above):

![Screenshot Customer versions - entity snapshots with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/5-customer-versions-composition.png)


### GOTCHAS for Entity snapshots

There is one main thing to be aware of when using entity snapshots.

The above description showed that a JSON based snapshot is stored in the database. It contains the data as well as the field names of the entity.

Since this snapshot is just loosely coupled to the entity definition, it is easy to forget about the fact that somehow those snapshots need work with changes of the structure of the entity.

Imagine the following example:

The policy contains the attribute `premium` at the beginning of the application. The app is used for several months and snapshots get created by the users.

Now at some point the attribute `premium` should get renamed to `grossWrittenPremium`, because it is more accurate.

Doing that change in the entity is easy. Probably also a SQL based data-migration of the column is also thought of. But what about the entity snapshots? In fact, when the new version of the application is rolled out, the new snapshots will now contain the new attribute. It would result in the following JSON:

Before:

```JSON
{
  "_entityName": "cepv$Policy",
  "id": "da0aab30-0cf1-fb87-322e-961f5ec7f35d",
  "updatedBy": "admin",
  "version": 4,
  "coverEndDate": "2021-01-01",
  "documentsSigningDate": "2018-01-01",
  "premium": 150.00,
  "policyId": 1,
  "createdBy": "admin",
  "createTs": "2018-01-03 09:02:22.052",
  "updateTs": "2018-01-03 09:04:40.388",
  "customer": {
    "_entityName": "cepv$Customer",
    "id": "4bbd55dd-d0d7-e5c6-481a-911277a5f66e",
    "createdBy": "admin",
    "name": "Marge Simpson",
    "createTs": "2018-01-03 08:58:47.028",
    "version": 1,
    "updateTs": "2018-01-03 08:58:47.028"
  },
  "coverStartDate": "2018-01-01"
}
```

After:

```JSON
{
  "_entityName": "cepv$Policy",
  "id": "da0aab30-0cf1-fb87-322e-961f5ec7f35d",
  "updatedBy": "admin",
  "version": 5,
  "grossWrittenPremium": 432,
  "coverEndDate": "2021-01-01",
  "documentsSigningDate": "2018-01-01",
  "policyId": 1,
  "createdBy": "admin",
  "createTs": "2018-01-03 09:02:22.000",
  "updateTs": "2019-05-24 08:59:03.115",
  "customer": {
    "_entityName": "cepv$Customer",
    "id": "4bbd55dd-d0d7-e5c6-481a-911277a5f66e",
    "updatedBy": "admin",
    "createdBy": "admin",
    "name": "Marge Simpson",
    "createTs": "2018-01-03 08:58:47.000",
    "version": 2,
    "updateTs": "2019-05-18 11:48:06.262"
  },
  "coverStartDate": "2018-01-01"
}
``` 

Also the snapshot diff is still capable of displaying the values between to versions, for this particular attribute `premium` vs. `grossWrittenPremium` it is not possible anymore to identify the connection.

What it boils down to is that this particular feature: `EntitySnapshot` has now to be treated like an public API, that cannot easily be changed.

There are some possibilities to do it, like data migration and so on, but as you can imagine, this can get very complicated easily.

The `EntitySnapshotService` has capabilities to deal with that (like: `migrateSnapshots()`), but it is a very important thing to understand when working with entity snapshots.

