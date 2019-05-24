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

The important part is the subselect that fetches all policy ids that belong to this customer:

`or i.entityRef.entityId in (select e.id from cepv$Policy e where e.customer.id = :ds$customerDs))`

For multiple associations the subselect would need to be adjusted accordingly to all *-to-Many associations.

The result looks like this:
![Screenshot Customer changes - entity log with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/4-customer-changes-composition.png)


## Entity snapshots

#### Policy History / Versions
![Screenshot Policy versions - entity snapshots](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/3-policy-versioning.png)

#### Customer Histroy / Versions with composition
![Screenshot Customer versions - entity snapshots with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/5-customer-versions-composition.png)
