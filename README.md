# CUBA example policy versioning

This example shows how to use CUBAs [entity log](https://doc.cuba-platform.com/manual-6.7/entity_log.html) features as well as [entity snapshots](https://doc.cuba-platform.com/manual-6.7/entity_snapshots.html)

The example domain is an insurance backend. It will store customer information together with policies.

The policies should be audited so that it is clear what happened at any point in time of the policy.

## Overview
![Screenshot Policy detail information](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/0-overview.gif)

## Entity Log

#### Policy Changes
![Screenshot Policy changes - entity log](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/2-policy-changes.png)

#### Customer Changes with composition
![Screenshot Customer changes - entity log with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/4-customer-changes-composition.png)


## Entity snapshots

#### Policy History / Versions
![Screenshot Policy versions - entity snapshots](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/3-policy-versioning.png)

#### Customer Histroy / Versions with composition
![Screenshot Customer versions - entity snapshots with composition](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/5-customer-versions-composition.png)
