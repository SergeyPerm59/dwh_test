-- KNOTS --------------------------------------------------------------------------------------------------------------
--
-- Knots are used to store finite sets of values, normally used to describe states
-- of entities (through knotted attributes) or relationships (through knotted ties).
-- Knots have their own surrogate identities and are therefore immutable.
-- Values can be added to the set over time though.
-- Knots should have values that are mutually exclusive and exhaustive.
--
-- ANCHORS AND ATTRIBUTES ---------------------------------------------------------------------------------------------
--
-- Anchors are used to store the identities of entities.
-- Anchors are immutable.
-- Attributes are used to store values for properties of entities.
-- Attributes are mutable, their values may change over one or more types of time.
-- Attributes have four flavors: static, historized, knotted static, and knotted historized.
-- Anchors may have zero or more adjoined attributes.
--
-- Anchor table -------------------------------------------------------------------------------------------------------
-- FM1_ID1 table (with 4 attributes)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create sequences if not exist
    execute immediate 'create sequence FM1_ID1_FM1_ID_SEQ start with 10000 increment by 1 cache 20 nocycle ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM1_ID1 (
            FM1_ID int not null,
            FM1_Dummy bit null,
            constraint PK_FM1_ID1 primary key (
                FM1_ID 
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- Static attribute table ---------------------------------------------------------------------------------------------
-- FM1_s11_ID1_s11 table (on FM1_ID1)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM1_s11_ID1_s11 (
            FM1_ID int not null,
            FM1_s11_ID1_s11 varchar not null,
            constraint FK_FM1_s11_ID1_s11 foreign key (
                FM1_ID
            ) references FM1_ID1(FM1_ID),
            constraint PK_FM1_s11_ID1_s11 primary key (
                FM1_ID
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- Static attribute table ---------------------------------------------------------------------------------------------
-- FM1_s22_ID1_s22 table (on FM1_ID1)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM1_s22_ID1_s22 (
            FM1_ID int not null,
            FM1_s22_ID1_s22 varchar not null,
            constraint FK_FM1_s22_ID1_s22 foreign key (
                FM1_ID
            ) references FM1_ID1(FM1_ID),
            constraint PK_FM1_s22_ID1_s22 primary key (
                FM1_ID
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- Static attribute table ---------------------------------------------------------------------------------------------
-- FM1_f42_ID1_f42 table (on FM1_ID1)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM1_f42_ID1_f42 (
            FM1_ID int not null,
            FM1_f42_ID1_f42 varchar not null,
            constraint FK_FM1_f42_ID1_f42 foreign key (
                FM1_ID
            ) references FM1_ID1(FM1_ID),
            constraint PK_FM1_f42_ID1_f42 primary key (
                FM1_ID
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- Static attribute table ---------------------------------------------------------------------------------------------
-- FM1_f21_ID1_f21 table (on FM1_ID1)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM1_f21_ID1_f21 (
            FM1_ID int not null,
            FM1_f21_ID1_f21 varchar not null,
            constraint FK_FM1_f21_ID1_f21 foreign key (
                FM1_ID
            ) references FM1_ID1(FM1_ID),
            constraint PK_FM1_f21_ID1_f21 primary key (
                FM1_ID
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- Anchor table -------------------------------------------------------------------------------------------------------
-- FM2_ID2 table (with 0 attributes)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create sequences if not exist
    execute immediate 'create sequence FM2_ID2_FM2_ID_SEQ start with 10000 increment by 1 cache 20 nocycle ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM2_ID2 (
            FM2_ID int not null,
            FM2_Dummy bit null,
            constraint PK_FM2_ID2 primary key (
                FM2_ID 
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- Anchor table -------------------------------------------------------------------------------------------------------
-- FM3_ID3 table (with 0 attributes)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create sequences if not exist
    execute immediate 'create sequence FM3_ID3_FM3_ID_SEQ start with 10000 increment by 1 cache 20 nocycle ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM3_ID3 (
            FM3_ID int not null,
            FM3_Dummy bit null,
            constraint PK_FM3_ID3 primary key (
                FM3_ID 
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- TIES ---------------------------------------------------------------------------------------------------------------
--
-- Ties are used to represent relationships between entities.
-- They come in four flavors: static, historized, knotted static, and knotted historized.
-- Ties have cardinality, constraining how members may participate in the relationship.
-- Every entity that is a member in a tie has a specified role in the relationship.
-- Ties must have at least two anchor roles and zero or more knot roles.
--
-- Static tie table ---------------------------------------------------------------------------------------------------
-- FM1_ID1_FM2_ID2_FM3_ID3 table (having 3 roles)
-----------------------------------------------------------------------------------------------------------------------
begin -- Create table with pk column
    execute immediate '
        CREATE TABLE FM1_ID1_FM2_ID2_FM3_ID3 (
            FM1_ID_ID1 int not null, 
            FM2_ID_ID2 int not null, 
            FM3_ID_ID3 int not null, 
            constraint FK1_FM1_ID1_FM2_ID2_FM3_ID3FM1 foreign key (
                FM1_ID_ID1
            ) references FM1_ID1(FM1_ID), 
            constraint FK2_FM1_ID1_FM2_ID2_FM3_ID3FM2 foreign key (
                FM2_ID_ID2
            ) references FM2_ID2(FM2_ID), 
            constraint FK3_FM1_ID1_FM2_ID2_FM3_ID3FM3 foreign key (
                FM3_ID_ID3
            ) references FM3_ID3(FM3_ID), 
            constraint PK_FM1_ID1_FM2_ID2_FM3_ID3 primary key (
                FM1_ID_ID1,
                FM2_ID_ID2,
                FM3_ID_ID3
            )
        ) ORGANIZATION INDEX
    ';
exception when others then 
    if sqlcode = -955 then NULL; else RAISE; end if;
end;
/
-- ANCHOR TEMPORAL PERSPECTIVES ---------------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each anchor. There are four types of perspectives: latest,
-- point-in-time, difference, and now. They also denormalize the anchor, its attributes,
-- and referenced knots from sixth to third normal form.
--
-- The latest perspective shows the latest available information for each anchor.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- @changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints, and for
-- changes in all or a selection of attributes.
--
-- @intervalStart the start of the interval for finding changes
-- @intervalEnd the end of the interval for finding changes
-- @selection a list of mnemonics for tracked attributes, ie 'MNE MON ICS', or null for all
--
CREATE OR REPLACE VIEW lFM1_ID1 AS
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lFM1_ID1 viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
SELECT
    FM1.FM1_ID,
    s11.FM1_s11_ID1_s11,
    s22.FM1_s22_ID1_s22,
    f42.FM1_f42_ID1_f42,
    f21.FM1_f21_ID1_f21
FROM FM1_ID1 FM1
LEFT JOIN FM1_s11_ID1_s11 s11 ON s11.FM1_ID = FM1.FM1_ID
LEFT JOIN FM1_s22_ID1_s22 s22 ON s22.FM1_ID = FM1.FM1_ID
LEFT JOIN FM1_f42_ID1_f42 f42 ON f42.FM1_ID = FM1.FM1_ID
LEFT JOIN FM1_f21_ID1_f21 f21 ON f21.FM1_ID = FM1.FM1_ID 
WHERE 1=1 
; 
/*
CREATE FUNCTION [test].[pFM1_ID1] (
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pFM1_ID1 viewed as it was on the given timepoint
-----------------------------------------------------------------------------------------------------------------------
    @changingTimepoint timestamp(7)
)
RETURNS TABLE WITH SCHEMABINDING AS RETURN
SELECT
    [FM1].FM1_ID,
    [s11].FM1_s11_ID1_s11,
    [s22].FM1_s22_ID1_s22,
    [f42].FM1_f42_ID1_f42,
    [f21].FM1_f21_ID1_f21
FROM
    [test].[FM1_ID1] [FM1]
LEFT JOIN
    [test].[FM1_s11_ID1_s11] [s11]
ON
    [s11].FM1_ID = [FM1].FM1_ID
LEFT JOIN
    [test].[FM1_s22_ID1_s22] [s22]
ON
    [s22].FM1_ID = [FM1].FM1_ID
LEFT JOIN
    [test].[FM1_f42_ID1_f42] [f42]
ON
    [f42].FM1_ID = [FM1].FM1_ID
LEFT JOIN
    [test].[FM1_f21_ID1_f21] [f21]
ON
    [f21].FM1_ID = [FM1].FM1_ID;
GO 
CREATE VIEW [test].[nFM1_ID1]
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nFM1_ID1 viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
AS
SELECT
    *
FROM
    [test].[pFM1_ID1](sysdatetime());
GO
 */ -- TEST
CREATE OR REPLACE VIEW lFM2_ID2 AS
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lFM2_ID2 viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
    SELECT * FROM FM2_ID2 FM2
;
CREATE OR REPLACE VIEW lFM3_ID3 AS
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lFM3_ID3 viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
    SELECT * FROM FM3_ID3 FM3
;
-- ANCHOR TRIGGERS ---------------------------------------------------------------------------------------------------
--
-- The following triggers on the latest view make it behave like a table.
-- There are three different 'instead of' triggers: insert, update, and delete.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent attributes, only changes that represent a value different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
CREATE OR REPLACE TRIGGER itFM1_ID1 
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- itFM1_ID1 instead of INSERT trigger on lFM1_ID1
-----------------------------------------------------------------------------------------------------------------------
INSTEAD OF INSERT
ON lFM1_ID1
FOR EACH ROW
DECLARE
    x INTEGER;
    l_now date := sysdate;
BEGIN
    INSERT INTO FM1_ID1 (
        FM1_ID,
        FM1_Dummy
    ) VALUES (
        :NEW.FM1_ID,
        :NEW.FM1_Dummy
    );
    if (:NEW.FM1_s11_ID1_s11 is not null) then -- insert
        INSERT INTO FM1_s11_ID1_s11 (
            FM1_s11_ID1_s11, -- varchar null, ELSE
        ) VALUES (
            :NEW.FM1_s11_ID1_s11, -- varchar null, ELSE
        );
    end if;
    if (:NEW.FM1_s22_ID1_s22 is not null) then -- insert
        INSERT INTO FM1_s22_ID1_s22 (
            FM1_s22_ID1_s22, -- varchar null, ELSE
        ) VALUES (
            :NEW.FM1_s22_ID1_s22, -- varchar null, ELSE
        );
    end if;
    if (:NEW.FM1_f42_ID1_f42 is not null) then -- insert
        INSERT INTO FM1_f42_ID1_f42 (
            FM1_f42_ID1_f42, -- varchar null, ELSE
        ) VALUES (
            :NEW.FM1_f42_ID1_f42, -- varchar null, ELSE
        );
    end if;
    if (:NEW.FM1_f21_ID1_f21 is not null) then -- insert
        INSERT INTO FM1_f21_ID1_f21 (
            FM1_f21_ID1_f21, -- varchar null
        ) VALUES (
            :NEW.FM1_f21_ID1_f21, -- varchar null
        );
    end if;
END itFM1_ID1;
/ 
-- TIE TEMPORAL PERSPECTIVES ------------------------------------------------------------------------------------------
--
-- These table valued functions simplify temporal querying by providing a temporal
-- perspective of each tie. There are four types of perspectives: latest,
-- point-in-time, difference, and now.
--
-- The latest perspective shows the latest available information for each tie.
-- The now perspective shows the information as it is right now.
-- The point-in-time perspective lets you travel through the information to the given timepoint.
--
-- @changingTimepoint the point in changing time to travel to
--
-- The difference perspective shows changes between the two given timepoints.
--
-- @intervalStart the start of the interval for finding changes
-- @intervalEnd the end of the interval for finding changes
--
-- Drop perspectives --------------------------------------------------------------------------------------------------
begin
    NULL;
end;
/
CREATE OR REPLACE VIEW lFM1_ID1_FM2_ID2_FM3_ID3 
-- Latest perspective -------------------------------------------------------------------------------------------------
-- lFM1_ID1_FM2_ID2_FM3_ID3 viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
AS
SELECT
    tie.FM1_ID_ID1,
    tie.FM2_ID_ID2,
    tie.FM3_ID_ID3
FROM
    FM1_ID1_FM2_ID2_FM3_ID3 tie
;
/* CREATE FUNCTION [test].[pFM1_ID1_FM2_ID2_FM3_ID3] (
-- Point-in-time perspective ------------------------------------------------------------------------------------------
-- pFM1_ID1_FM2_ID2_FM3_ID3 viewed by the latest available information (may include future versions)
-----------------------------------------------------------------------------------------------------------------------
    @changingTimepoint timestamp(7)
)
RETURNS TABLE WITH SCHEMABINDING AS RETURN
SELECT
    tie.FM1_ID_ID1,
    tie.FM2_ID_ID2,
    tie.FM3_ID_ID3
FROM
    [test].[FM1_ID1_FM2_ID2_FM3_ID3] tie;
GO */
/* CREATE VIEW [test].[nFM1_ID1_FM2_ID2_FM3_ID3]
-- Now perspective ----------------------------------------------------------------------------------------------------
-- nFM1_ID1_FM2_ID2_FM3_ID3 viewed as it currently is (cannot include future versions)
-----------------------------------------------------------------------------------------------------------------------
AS
SELECT
    *
FROM
    [test].[pFM1_ID1_FM2_ID2_FM3_ID3](sysdatetime());
GO */
-- TIE TRIGGERS -------------------------------------------------------------------------------------------------------
--
-- The following triggers on the latest view make it behave like a table.
-- There are three different 'instead of' triggers: insert, update, and delete.
-- They will ensure that such operations are propagated to the underlying tables
-- in a consistent way. Default values are used for some columns if not provided
-- by the corresponding SQL statements.
--
-- For idempotent ties, only changes that represent values different from
-- the previous or following value are stored. Others are silently ignored in
-- order to avoid unnecessary temporal duplicates.
--
CREATE OR REPLACE TRIGGER itFM1_ID1_FM2_ID2_FM3_ID3 
-- Insert trigger -----------------------------------------------------------------------------------------------------
-- itFM1_ID1_FM2_ID2_FM3_ID3 instead of INSERT trigger on lFM1_ID1_FM2_ID2_FM3_ID3
-----------------------------------------------------------------------------------------------------------------------
INSTEAD OF INSERT
ON lFM1_ID1_FM2_ID2_FM3_ID3
FOR EACH ROW
DECLARE
    x INTEGER;
    l_now date := sysdate;
BEGIN
 -- NOT HISTORIZED NOT KNOTTED 
    INSERT INTO FM1_ID1_FM2_ID2_FM3_ID3 (
        FM1_ID_ID1,
        FM2_ID_ID2,
        FM3_ID_ID3,
    ) VALUES (
        :NEW.FM1_ID_ID1,
        :NEW.FM2_ID_ID2,
        :NEW.FM3_ID_ID3,
    );
END itFM1_ID1_FM2_ID2_FM3_ID3;
/ 
CREATE OR REPLACE TRIGGER dtFM1_ID1_FM2_ID2_FM3_ID3 
-- DELETE trigger -----------------------------------------------------------------------------------------------------
-- dtFM1_ID1_FM2_ID2_FM3_ID3 instead of DELETE trigger on lFM1_ID1_FM2_ID2_FM3_ID3
-----------------------------------------------------------------------------------------------------------------------
INSTEAD OF DELETE
ON lFM1_ID1_FM2_ID2_FM3_ID3
FOR EACH ROW
DECLARE
    x INTEGER;
    l_now date := sysdate;
BEGIN
    DELETE FM1_ID1_FM2_ID2_FM3_ID3 WHERE 1=1 
    AND FM1_ID_ID1 = :NEW.FM1_ID_ID1
    AND FM2_ID_ID2 = :NEW.FM2_ID_ID2
    AND FM3_ID_ID3 = :NEW.FM3_ID_ID3
    ;
END dtFM1_ID1_FM2_ID2_FM3_ID3;
/
-- KNOT KNOT KNOT KNOT
-- KNOT KNOT KNOT KNOT
-- KNOT KNOT KNOT KNOT
-- KNOT KNOT KNOT KNOT
-- ANCHOR ANCHOR ANCHOR ANCHOR
-- ANCHOR ANCHOR ANCHOR ANCHOR
-- ANCHOR ANCHOR ANCHOR ANCHOR
-- ANCHOR ANCHOR ANCHOR ANCHOR
prompt Populate ANCHOR lFM1_ID1;
declare
    l_now date := sysdate;
    l_count integer := 0;
begin
    for i in 10000000 .. 10000100 loop 
        INSERT INTO lFM1_ID1 ( -- 10000000
            FM1_ID,
            FM1_Dummy ,
            FM1_s11_ID1_s11, -- ATTRIBUTE
            FM1_s22_ID1_s22, -- ATTRIBUTE
            FM1_f42_ID1_f42, -- ATTRIBUTE
            FM1_f21_ID1_f21 -- ATTRIBUTE
        ) VALUES ( -- 10000000
            i, -- FM1_ID
            , -- Metadata_FM1, : FM1_Dummy,
            substr(l_count,1,varchar, -- FM1_s11_ID1_s11 varchar l_precision = varchar
            substr(l_count,1,varchar, -- FM1_s22_ID1_s22 varchar l_precision = varchar
            substr(l_count,1,varchar, -- FM1_f42_ID1_f42 varchar l_precision = varchar
            substr(l_count,1,varchar -- FM1_f21_ID1_f21 varchar l_precision = varchar
        );
        l_count := l_count + 1;
    end loop;
end;
/
prompt Populate ANCHOR lFM2_ID2;
declare
    l_now date := sysdate;
    l_count integer := 0;
begin
    for i in 20000000 .. 20000100 loop 
        INSERT INTO lFM2_ID2 ( -- 20000000
            FM2_ID,
            FM2_Dummy 
        ) VALUES ( -- 20000000
            i, -- FM2_ID
             -- Metadata_FM2, : FM2_Dummy,
        );
        l_count := l_count + 1;
    end loop;
end;
/
prompt Populate ANCHOR lFM3_ID3;
declare
    l_now date := sysdate;
    l_count integer := 0;
begin
    for i in 30000000 .. 30000100 loop 
        INSERT INTO lFM3_ID3 ( -- 30000000
            FM3_ID,
            FM3_Dummy 
        ) VALUES ( -- 30000000
            i, -- FM3_ID
             -- Metadata_FM3, : FM3_Dummy,
        );
        l_count := l_count + 1;
    end loop;
end;
/
-- TIE TIE TIE TIE
-- TIE TIE TIE TIE
-- TIE TIE TIE TIE
-- TIE TIE TIE TIE
prompt Populate TIE lFM1_ID1_FM2_ID2_FM3_ID3;
-- Static tie table ---------------------------------------------------------------------------------------------------
    insert into lFM1_ID1_FM2_ID2_FM3_ID3 (
        FM1_ID_ID1,
        FM2_ID_ID2,
        FM3_ID_ID3
    ) SELECT 
        ,
        FM1_ID_ID1.FM1_ID,
        FM2_ID_ID2.FM2_ID,
        FM3_ID_ID3.FM3_ID
    FROM 
        FM1_ID1 FM1_ID_ID1,
        FM2_ID2 FM2_ID_ID2,
        FM3_ID3 FM3_ID_ID3
    WHERE 1=1
    AND substr(FM1_ID_ID1.FM1_ID,4) = substr(FM2_ID_ID2.FM2_ID,4)
    AND substr(FM2_ID_ID2.FM2_ID,4) = substr(FM3_ID_ID3.FM3_ID,4)
    ;
COMMIT;