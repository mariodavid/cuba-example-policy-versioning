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
![Screenshot Policy changes - entity log](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/2-policy-changes.png)

#### Customer Changes with composition
![Screenshot Customer changes - entity log with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/4-customer-changes-composition.png)


## Entity snapshots

#### Policy History / Versions
![Screenshot Policy versions - entity snapshots](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/3-policy-versioning.png)

#### Customer Histroy / Versions with composition
![Screenshot Customer versions - entity snapshots with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/5-customer-versions-composition.png)
