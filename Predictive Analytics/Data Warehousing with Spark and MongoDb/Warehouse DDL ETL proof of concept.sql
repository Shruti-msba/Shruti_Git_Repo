/*
Data Warehouse Best Buy. Snowflake Schema ETL + DDL
Author: Matthew Leong
*/

--Create the central data table facts.
create table facts
(
    custid          INT,
    rid             int,
    transacid       int,
    sku             int,
    warrtickid      int,
    quantity        float(100),
    revenue         float(100)
    
    );
--no primary key. Think of the central facts table as a huge joining table that also has info on quantity and revenue where applicable.

--create the views for everything.
Create OR REPLACE VIEW member_view AS
    Select *
    from member;

CREATE OR REPLACE VIEW cards_view AS
    Select *
    from cards;

CREATE OR REPLACE VIEW return_view AS
    SELECT *
    FROM Returns;

CREATE OR REPLACE VIEW stores_view AS
    SELECT *
    FROM stores;
    
CREATE OR REPLACE VIEW gift_cards_view AS
    SELECT *
    from gift_cards;
    
CREATE OR REPLACE VIEW transaction_view AS
    Select *
    from transaction;
    
CREATE OR REPLACE VIEW tline_view AS
    Select *
    from tline;
    
CREATE OR REPLACE VIEW tax_rate_view AS
    Select *
    from tax_rate;

CREATE OR REPLACE VIEW product_view AS
    Select * from product;

CREATE OR REPLACE VIEW model_view AS
    Select * from model_table;
    
CREATE OR REPLACE VIEW Reviews_view AS
    Select * from reviews;
    
Create or replace view warranty_ticket_view AS
    Select * from warranty_ticket;
    
CREATE OR REPLACE VIEW warr_comp_view AS
    Select * from warr_comp;
    
CREATE OR REPLACE VIEW components_view AS
    Select * from components;

--Testing insert statement    
--Member dimension
INSERT INTO facts
    Select mv.custid, Null as RID, Null as transacid, Null as SKU, Null as warrtickid, Null as quantity, Null as Revenue
    from member_view mv left join facts dw on
    mv.custid = dw.custid
    where dw.custid is Null;

--Expand the rest of the inserts to the other tables.
--Return dimension
INSERT INTO facts
    Select Null as custid, rv.rid as RID, Null as transacid, Null as SKU, Null as warrtickid, rv.rquantity as quantity, 
    -rv.rquantity*(tlv.uprice-tlv.udiscount) as Revenue
    from return_view rv join tline_view tlv on rv.tlineid = tlv.tlineid
    left join facts dw on rv.rid = dw.rid
    where dw.rid is Null;

--Transaction dimension
--done with a subquery
Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, tv.transacid 
    from transaction_view tv join tline_view tlv on tv.transacid = tlv.transacid
    GROUP BY tv.transacid;

INSERT into facts
    Select Null as custid, Null as RID, tv.transacid as transacid, Null as SKU, Null as warrtickid, tv.quantity as quantity, 
    tv.revenue as Revenue
    from (Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, tv.transacid 
    from transaction_view tv join tline_view tlv on tv.transacid = tlv.transacid
    GROUP BY tv.transacid)
    tv left join facts dw on tv.transacid = dw.transacid
    where dw.transacid is Null;
    
--Product Dimension. Also done with a subquery
Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, pv.sku as sku
    from product_view pv join tline_view tlv on pv.sku = tlv.sku
    GROUP BY pv.sku;

--One thing to note is that info here is redundant with transaction. However, transaction has other relevant info.
INSERT into facts
    Select Null as custid, Null as RID, NULL as transacid, pv.sku as SKU, Null as warrtickid, pv.quantity as quantity, 
    pv.revenue as Revenue
    from (Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, pv.sku as sku
    from product_view pv join tline_view tlv on pv.sku = tlv.sku
    GROUP BY pv.sku)
    pv left join facts dw on pv.sku = dw.sku
    where dw.sku is Null;
    
--Warranty ticket dimension.
INSERT INTO facts
    Select NULL as custid, Null as RID, Null as transacid, Null as SKU, wv.warrtickid as warrtickid, 
    Null as quantity, Null as Revenue
    from warranty_ticket_view wv left join facts dw on
    wv.warrtickid = dw.warrtickid
    where dw.custid is Null;
    
--Testing update statement
Delete from facts where custid is not NULL;
INSERT INTO facts
    Select mv.custid, Null as RID, Null as transacid, Null as SKU, Null as warrtickid, Null as quantity, Null as Revenue
    from member_view mv left join facts dw on
    mv.custid = dw.custid
    where dw.custid is Null;
    
--Create the ETL procedure
CREATE OR REPLACE PROCEDURE three_transac_etl_proc
AS
BEGIN
    --Member dimension
    INSERT INTO facts
        Select mv.custid, Null as RID, Null as transacid, Null as SKU, Null as warrtickid, Null as quantity, Null as Revenue
        from member_view mv left join facts dw on
        mv.custid = dw.custid
        where dw.custid is Null;
        
    --Return dimension
    INSERT INTO facts
        Select Null as custid, rv.rid as RID, Null as transacid, Null as SKU, Null as warrtickid, rv.rquantity as quantity, 
        -rv.rquantity*(tlv.uprice-tlv.udiscount) as Revenue
        from return_view rv join tline_view tlv on rv.tlineid = tlv.tlineid
        left join facts dw on rv.rid = dw.rid
        where dw.rid is Null;
    
    --Transaction dimension
    INSERT into facts
        Select Null as custid, Null as RID, tv.transacid as transacid, Null as SKU, Null as warrtickid, tv.quantity as quantity, 
        tv.revenue as Revenue
        from (Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, tv.transacid 
        from transaction_view tv join tline_view tlv on tv.transacid = tlv.transacid
        GROUP BY tv.transacid)
        tv left join facts dw on tv.transacid = dw.transacid
        where dw.transacid is Null;
    
    --Product Dimension
    INSERT into facts
        Select Null as custid, Null as RID, NULL as transacid, pv.sku as SKU, Null as warrtickid, pv.quantity as quantity, 
        pv.revenue as Revenue
        from (Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, pv.sku as sku
        from product_view pv join tline_view tlv on pv.sku = tlv.sku
        GROUP BY pv.sku)
        pv left join facts dw on pv.sku = dw.sku
        where dw.sku is Null;
        
    --Warranty ticket dimension.
    INSERT INTO facts
        Select NULL as custid, Null as RID, Null as transacid, Null as SKU, wv.warrtickid as warrtickid, 
        Null as quantity, Null as Revenue
        from warranty_ticket_view wv left join facts dw on
        wv.warrtickid = dw.warrtickid
        where dw.custid is Null;
        
    --update part
    --Member dimension
    Delete from facts where custid is not null;
    INSERT INTO facts
        Select mv.custid, Null as RID, Null as transacid, Null as SKU, Null as warrtickid, Null as quantity, Null as Revenue
        from member_view mv left join facts dw on
        mv.custid = dw.custid
        where dw.custid is Null;
        
    --Return dimension
    Delete from facts where rid is not null;
    INSERT INTO facts
        Select Null as custid, rv.rid as RID, Null as transacid, Null as SKU, Null as warrtickid, rv.rquantity as quantity, 
        -rv.rquantity*(tlv.uprice-tlv.udiscount) as Revenue
        from return_view rv join tline_view tlv on rv.tlineid = tlv.tlineid
        left join facts dw on rv.rid = dw.rid
        where dw.rid is Null;
    
    --Transaction dimension
    Delete from facts where transacid is not null;
    INSERT into facts
        Select Null as custid, Null as RID, tv.transacid as transacid, Null as SKU, Null as warrtickid, tv.quantity as quantity, 
        tv.revenue as Revenue
        from (Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, tv.transacid 
        from transaction_view tv join tline_view tlv on tv.transacid = tlv.transacid
        GROUP BY tv.transacid)
        tv left join facts dw on tv.transacid = dw.transacid
        where dw.transacid is Null;
    
    --Product Dimension
    Delete from facts where sku is not null;
    INSERT into facts
        Select Null as custid, Null as RID, NULL as transacid, pv.sku as SKU, Null as warrtickid, pv.quantity as quantity, 
        pv.revenue as Revenue
        from (Select sum(tlv.quantity) as quantity, sum(tlv.quantity*(tlv.uprice-tlv.udiscount)) as revenue, pv.sku as sku
        from product_view pv join tline_view tlv on pv.sku = tlv.sku
        GROUP BY pv.sku)
        pv left join facts dw on pv.sku = dw.sku
        where dw.sku is Null;
        
    --Warranty ticket dimension.
    Delete from facts where warrtickid is not null;
    INSERT INTO facts
        Select NULL as custid, Null as RID, Null as transacid, Null as SKU, wv.warrtickid as warrtickid, 
        Null as quantity, Null as Revenue
        from warranty_ticket_view wv left join facts dw on
        wv.warrtickid = dw.warrtickid
        where dw.custid is Null;
    
END;
/

call three_transac_etl_proc();

