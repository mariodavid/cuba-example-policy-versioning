----------------------------------------------------------------------------------------------------
-- Entity Log Configuration
----------------------------------------------------------------------------------------------------

-- Entity Log Configuration - Policy

insert into SEC_LOGGED_ENTITY
(ID, NAME, AUTO, MANUAL)
values ('08996bb9-a10a-f9f9-0e8a-39c0ae13d0c9', 'cepv$Policy', true, false);

insert into SEC_LOGGED_ATTR
(ID, ENTITY_ID, NAME)
values ('6fc7ff7d-3a54-419e-aed1-3662396abded', '08996bb9-a10a-f9f9-0e8a-39c0ae13d0c9', 'coverStartDate');
insert into SEC_LOGGED_ATTR
(ID, ENTITY_ID, NAME)
values ('70433b14-7b48-eb5c-736f-4de0062a44a8', '08996bb9-a10a-f9f9-0e8a-39c0ae13d0c9', 'coverEndDate');
insert into SEC_LOGGED_ATTR
(ID, ENTITY_ID, NAME)
values ('78585f43-a35d-27ac-c272-dd8e7245a724', '08996bb9-a10a-f9f9-0e8a-39c0ae13d0c9', 'documentsSigningDate');
insert into SEC_LOGGED_ATTR
(ID, ENTITY_ID, NAME)
values ('a038fb59-cbb1-c86c-176a-21589899cdee', '08996bb9-a10a-f9f9-0e8a-39c0ae13d0c9', 'policyId');
insert into SEC_LOGGED_ATTR
(ID, ENTITY_ID, NAME)
values ('aab08b2b-d964-bf8f-edce-e87e1c2ed535', '08996bb9-a10a-f9f9-0e8a-39c0ae13d0c9', 'customer');
insert into SEC_LOGGED_ATTR
(ID, ENTITY_ID, NAME)
values ('b7466711-cb0f-eb58-04db-72f379359d46', '08996bb9-a10a-f9f9-0e8a-39c0ae13d0c9', 'premium');

-- Entity Log Configuration - Customer
insert into SEC_LOGGED_ENTITY
(ID, CREATE_TS, CREATED_BY, NAME, AUTO, MANUAL)
values ('abf331c2-a197-b7d4-993e-2af9f3d44241', '2019-05-17 18:18:45', 'admin', 'cepv$Customer', true, false);

insert into SEC_LOGGED_ATTR
(ID, CREATE_TS, CREATED_BY, ENTITY_ID, NAME)
values ('14d83cf9-9187-fbaf-b5a4-9891cd21605d', '2019-05-17 18:18:45', 'admin', 'abf331c2-a197-b7d4-993e-2af9f3d44241', 'name');




----------------------------------------------------------------------------------------------------
-- Example data
----------------------------------------------------------------------------------------------------

-- Customers

insert into CEPV_CUSTOMER
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, NAME)
values ('4bbd55dd-d0d7-e5c6-481a-911277a5f66e', 1, '2018-01-03 08:58:47', 'admin', '2018-01-03 08:58:47', null, null, null, 'Marge Simpson');
insert into CEPV_CUSTOMER
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, NAME)
values ('dccfc5df-f0f2-f990-6020-ce48212944a4', 1, '2018-01-03 08:58:35', 'admin', '2018-01-03 08:58:35', null, null, null, 'Bart Simpson');


-- Policies

insert into CEPV_POLICY
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, CUSTOMER_ID, POLICY_ID, COVER_START_DATE, COVER_END_DATE, DOCUMENTS_SIGNING_DATE, PREMIUM)
values ('83b87d40-effd-4840-63ab-a661c9ac876e', 1, '2018-01-03 09:05:23', 'admin', '2018-01-03 09:05:23', null, null, null, 'dccfc5df-f0f2-f990-6020-ce48212944a4', 2, '2020-01-01', '2021-01-01', '2020-01-01', 50.00);

insert into CEPV_POLICY
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, CUSTOMER_ID, POLICY_ID, COVER_START_DATE, COVER_END_DATE, DOCUMENTS_SIGNING_DATE, PREMIUM)
values ('da0aab30-0cf1-fb87-322e-961f5ec7f35d', 4, '2018-01-03 09:02:22', 'admin', '2018-01-03 09:04:40', 'admin', null, null, '4bbd55dd-d0d7-e5c6-481a-911277a5f66e', 1, '2018-01-01', '2021-01-01', '2018-01-01', 150.00);





----------------------------------------------------------------------------------------------------
-- Example log entries
----------------------------------------------------------------------------------------------------


-- Entity Log entries

insert into SEC_ENTITY_LOG
(ID, EVENT_TS, USER_ID, CHANGE_TYPE, ENTITY, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID, CHANGES)
values ('1343602d-1564-fbca-2e22-57d13f39a463', '2018-01-03 09:04:29', '60885987-1b61-4247-94c7-dff348347f93', 'M', 'cepv$Policy', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null, 'coverEndDate-oldVl=2019-01-01 00\:00\:00.000
coverEndDate=2020-01-01
');

insert into SEC_ENTITY_LOG
(ID, EVENT_TS, USER_ID, CHANGE_TYPE, ENTITY, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID, CHANGES)
values ('98d7515b-4186-c9e8-bc3b-5331e5246232', '2018-01-03 09:04:35', '60885987-1b61-4247-94c7-dff348347f93', 'M', 'cepv$Policy', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null, 'coverEndDate-oldVl=2020-01-01 00\:00\:00.000
coverEndDate=2021-01-01
');

insert into SEC_ENTITY_LOG
(ID, EVENT_TS, USER_ID, CHANGE_TYPE, ENTITY, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID, CHANGES)
values ('9dd12a92-fefd-536c-a76b-227d2bbb9c28', '2018-01-03 09:02:22', '60885987-1b61-4247-94c7-dff348347f93', 'C', 'cepv$Policy', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null, 'premium=150
documentsSigningDate=2018-01-01
policyId=1
coverEndDate=2019-01-01
coverStartDate=2018-01-01
customer=Marge Simpson
customer-id=2552c617-13af-0a34-2b4a-9d8e8d69098b
');

insert into SEC_ENTITY_LOG
(ID, EVENT_TS, USER_ID, CHANGE_TYPE, ENTITY, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID, CHANGES)
values ('a112480a-9fe1-314f-4a33-bcd1cefc1b99', '2018-01-03 09:04:40', '60885987-1b61-4247-94c7-dff348347f93', 'M', 'cepv$Policy', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null, 'customer-oldVl=Marg Simpson
customer-oldVlId=2552c617-13af-0a34-2b4a-9d8e8d69098b
customer=Marge Simpson
customer-id=4bbd55dd-d0d7-e5c6-481a-911277a5f66e
');

insert into SEC_ENTITY_LOG
(ID, EVENT_TS, USER_ID, CHANGE_TYPE, ENTITY, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID, CHANGES)
values ('db640cc3-686d-5c14-3010-28578ec6a40e', '2018-01-03 09:05:23', '60885987-1b61-4247-94c7-dff348347f93', 'C', 'cepv$Policy', '83b87d40-effd-4840-63ab-a661c9ac876e', null, null, null, 'premium=50
documentsSigningDate=2020-01-01
policyId=2
coverEndDate=2021-01-01
coverStartDate=2020-01-01
customer=Bart Simpson
customer-id=dccfc5df-f0f2-f990-6020-ce48212944a4
');


-- Entity Snapshots

insert into SYS_ENTITY_SNAPSHOT
(ID, CREATE_TS, CREATED_BY, VIEW_XML, SNAPSHOT_XML, ENTITY_META_CLASS, SNAPSHOT_DATE, AUTHOR_ID, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID)
values ('4aeeb910-28e0-8fcf-6e98-d025ba6b0872', '2018-01-03 09:02:22', 'admin', '{"name":"policy-view","entity":"cepv$Policy","properties":["coverEndDate","documentsSigningDate","premium","policyId","coverStartDate",{"name":"customer","view":{"name":"_minimal","properties":["name"]}}]}', '{"_entityName":"cepv$Policy","id":"da0aab30-0cf1-fb87-322e-961f5ec7f35d","version":1,"coverEndDate":"2019-01-01","documentsSigningDate":"2018-01-01","premium":150,"policyId":1,"createdBy":"admin","createTs":"2018-01-03 09:02:22.052","updateTs":"2018-01-03 09:02:22.052","customer":{"_entityName":"cepv$Customer","id":"2552c617-13af-0a34-2b4a-9d8e8d69098b","name":"Marge Simpson","version":1},"coverStartDate":"2018-01-01"}', 'cepv$Policy', '2018-01-03 09:02:22', '60885987-1b61-4247-94c7-dff348347f93', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null);

insert into SYS_ENTITY_SNAPSHOT
(ID, CREATE_TS, CREATED_BY, VIEW_XML, SNAPSHOT_XML, ENTITY_META_CLASS, SNAPSHOT_DATE, AUTHOR_ID, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID)
values ('5b007621-5cfa-ab35-2f0a-f6382688068a', '2018-01-03 09:04:35', 'admin', '{"name":"policy-view","entity":"cepv$Policy","properties":["coverEndDate","documentsSigningDate","premium","policyId","coverStartDate",{"name":"customer","view":{"name":"_minimal","properties":["name"]}}]}', '{"_entityName":"cepv$Policy","id":"da0aab30-0cf1-fb87-322e-961f5ec7f35d","updatedBy":"admin","version":3,"coverEndDate":"2021-01-01","documentsSigningDate":"2018-01-01","premium":150.00,"policyId":1,"createdBy":"admin","createTs":"2018-01-03 09:02:22.052","updateTs":"2018-01-03 09:04:35.426","customer":{"_entityName":"cepv$Customer","id":"2552c617-13af-0a34-2b4a-9d8e8d69098b","createdBy":"admin","name":"Marge Simpson","createTs":"2018-01-03 08:58:39.547","version":1,"updateTs":"2018-01-03 08:58:39.547"},"coverStartDate":"2018-01-01"}', 'cepv$Policy', '2018-01-03 09:04:35', '60885987-1b61-4247-94c7-dff348347f93', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null);
insert into SYS_ENTITY_SNAPSHOT
(ID, CREATE_TS, CREATED_BY, VIEW_XML, SNAPSHOT_XML, ENTITY_META_CLASS, SNAPSHOT_DATE, AUTHOR_ID, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID)
values ('63ab33cb-2e95-d07e-1ae0-e64d53975dfa', '2018-01-03 09:05:23', 'admin', '{"name":"policy-view","entity":"cepv$Policy","properties":["coverEndDate","documentsSigningDate","premium","policyId","coverStartDate",{"name":"customer","view":{"name":"_minimal","properties":["name"]}}]}', '{"_entityName":"cepv$Policy","id":"83b87d40-effd-4840-63ab-a661c9ac876e","version":1,"coverEndDate":"2021-01-01","documentsSigningDate":"2020-01-01","premium":50,"policyId":2,"createdBy":"admin","createTs":"2018-01-03 09:05:23.099","updateTs":"2018-01-03 09:05:23.099","customer":{"_entityName":"cepv$Customer","id":"dccfc5df-f0f2-f990-6020-ce48212944a4","name":"Bart Simpson","version":1},"coverStartDate":"2020-01-01"}', 'cepv$Policy', '2018-01-03 09:05:23', '60885987-1b61-4247-94c7-dff348347f93', '83b87d40-effd-4840-63ab-a661c9ac876e', null, null, null);
insert into SYS_ENTITY_SNAPSHOT
(ID, CREATE_TS, CREATED_BY, VIEW_XML, SNAPSHOT_XML, ENTITY_META_CLASS, SNAPSHOT_DATE, AUTHOR_ID, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID)
values ('90c6f863-009e-5f2b-7453-aeadd50c254a', '2018-01-03 09:04:29', 'admin', '{"name":"policy-view","entity":"cepv$Policy","properties":["coverEndDate","documentsSigningDate","premium","policyId","coverStartDate",{"name":"customer","view":{"name":"_minimal","properties":["name"]}}]}', '{"_entityName":"cepv$Policy","id":"da0aab30-0cf1-fb87-322e-961f5ec7f35d","updatedBy":"admin","version":2,"coverEndDate":"2020-01-01","documentsSigningDate":"2018-01-01","premium":150.00,"policyId":1,"createdBy":"admin","createTs":"2018-01-03 09:02:22.052","updateTs":"2018-01-03 09:04:29.780","customer":{"_entityName":"cepv$Customer","id":"2552c617-13af-0a34-2b4a-9d8e8d69098b","createdBy":"admin","name":"Marge Simpson","createTs":"2018-01-03 08:58:39.547","version":1,"updateTs":"2018-01-03 08:58:39.547"},"coverStartDate":"2018-01-01"}', 'cepv$Policy', '2018-01-03 09:04:29', '60885987-1b61-4247-94c7-dff348347f93', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null);
insert into SYS_ENTITY_SNAPSHOT
(ID, CREATE_TS, CREATED_BY, VIEW_XML, SNAPSHOT_XML, ENTITY_META_CLASS, SNAPSHOT_DATE, AUTHOR_ID, ENTITY_ID, STRING_ENTITY_ID, INT_ENTITY_ID, LONG_ENTITY_ID)
values ('c1848e80-eb48-a85f-f72a-529689a61474', '2018-01-03 09:04:40', 'admin', '{"name":"policy-view","entity":"cepv$Policy","properties":["coverEndDate","documentsSigningDate","premium","policyId","coverStartDate",{"name":"customer","view":{"name":"_minimal","properties":["name"]}}]}', '{"_entityName":"cepv$Policy","id":"da0aab30-0cf1-fb87-322e-961f5ec7f35d","updatedBy":"admin","version":4,"coverEndDate":"2021-01-01","documentsSigningDate":"2018-01-01","premium":150.00,"policyId":1,"createdBy":"admin","createTs":"2018-01-03 09:02:22.052","updateTs":"2018-01-03 09:04:40.388","customer":{"_entityName":"cepv$Customer","id":"4bbd55dd-d0d7-e5c6-481a-911277a5f66e","createdBy":"admin","name":"Marge Simpson","createTs":"2018-01-03 08:58:47.028","version":1,"updateTs":"2018-01-03 08:58:47.028"},"coverStartDate":"2018-01-01"}', 'cepv$Policy', '2018-01-03 09:04:40', '60885987-1b61-4247-94c7-dff348347f93', 'da0aab30-0cf1-fb87-322e-961f5ec7f35d', null, null, null);
