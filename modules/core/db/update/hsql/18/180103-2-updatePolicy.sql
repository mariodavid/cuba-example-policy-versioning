-- alter table CEPV_POLICY add column POLICY_ID bigint ^
-- update CEPV_POLICY set POLICY_ID = <default_value> ;
-- alter table CEPV_POLICY alter column POLICY_ID set not null ;
alter table CEPV_POLICY add column POLICY_ID bigint ;
