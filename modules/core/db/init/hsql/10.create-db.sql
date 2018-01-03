-- begin CEPV_POLICY
create table CEPV_POLICY (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    CUSTOMER_ID varchar(36) not null,
    POLICY_ID bigint not null,
    COVER_START_DATE date not null,
    COVER_END_DATE date,
    DOCUMENTS_SIGNING_DATE date,
    PREMIUM decimal(19, 2),
    --
    primary key (ID)
)^
-- end CEPV_POLICY
-- begin CEPV_CUSTOMER
create table CEPV_CUSTOMER (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255) not null,
    --
    primary key (ID)
)^
-- end CEPV_CUSTOMER
