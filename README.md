# CUBA example policy versioning

This example shows how to use CUBAs [entity log](https://doc.cuba-platform.com/manual-6.7/entity_log.html) features as well as [entity snapshots](https://doc.cuba-platform.com/manual-6.7/entity_snapshots.html)

The example domain is an insurance backend. It will store customer information together with policies.

The policies should be audited so that it is clear what happened at any point in time of the policy.

### Policy Details page
![Screenshot Policy detail information](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/policy-information.png)

### Policy Changes (Entity Log)
![Screenshot Policy changes - entity log](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/entity-log.png)

### Policy History (Entity snapshots)
![Screenshot Policy changes - entity snapshots](https://github.com/mariodavid/cuba-example-policy-versioning/blob/master/img/entity-snapshots.png)
