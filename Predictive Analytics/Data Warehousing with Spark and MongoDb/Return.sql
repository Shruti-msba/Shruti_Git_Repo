--------------------------------------------------------------------------
-- AUTHOR: MAURICIO MORALES (mm96964)
-- DROP SEQUENCE/TABLES SECTION
--------------------------------------------------------------------------

DROP TABLE RETURNS;
DROP TABLE GIFT_CARDS;
DROP TABLE STORES;
DROP TABLE TLINE;
DROP TABLE Product;
DROP TABLE MODEL_TABLE;
DROP TABLE TRANSACTIONS;
DROP TABLE CARDS;
DROP TABLE Member;

DROP SEQUENCE MEMBERID_SEQ;
DROP SEQUENCE GIFTID_SEQ;
DROP SEQUENCE STORESID_SEQ;
DROP SEQUENCE MODELID_SEQ;
DROP SEQUENCE CARDSID_SEQ;
DROP SEQUENCE SKUID_SEQ;
DROP SEQUENCE TRANSACTIONSID_SEQ;
DROP SEQUENCE TLINEID_SEQ;
DROP SEQUENCE RETURNS_SEQ;

--------------------------------------------------------------------------
-- AUTHOR: MAURICIO MORALES (mm96964)
-- CREATE TABLES SECTION
--------------------------------------------------------------------------

CREATE TABLE Member (
  CustID            INT NOT NULL,
  FirstName         VARCHAR(100) NOT NULL,
  LastName          VARCHAR(100) NOT NULL,
  Phone             CHAR(12)     NOT NULL,
  Email             VARCHAR(100) NOT NULL,
  Address1          VARCHAR(255) NOT NULL,
  Address2          VARCHAR(255),
  City              VARCHAR(100) NOT NULL,
  State             CHAR(2)      NOT NULL,
  ZIP               CHAR(5)      NOT NULL,
  CardFlag          CHAR(1)      DEFAULT 'N' NOT NULL,
  RewardPoints      INT,
  RewardTier        VARCHAR(8)  NOT NULL,
  PRIMARY KEY (CustID)
);

CREATE TABLE GIFT_CARDS (
  GiftCardID NUMBER,
  Balance NUMBER NOT NULL,
  CONSTRAINT GiftCardID_PK PRIMARY KEY (GiftCardID)
);

CREATE TABLE STORES (
    StoreID          NUMBER NOT NULL,
    Name             VARCHAR(50) NOT NULL,
    Address          VARCHAR(200),
    City             VARCHAR(100) NOT NULL,
    State            CHAR(2) NOT NULL,
    Zip              CHAR(5) NOT NULL,
    Grade            CHAR(10) NOT NULL,
    PRIMARY KEY (StoreID) 
);

CREATE TABLE MODEL_TABLE
(
    ModelID             NUMBER NOT NULL,
    Name                VARCHAR(100) NOT NULL,
    Brand               VARCHAR(50),
    Length              VARCHAR(50) NOT NULL,
    Width               VARCHAR(50) NOT NULL ,
    Height              VARCHAR(50) NOT NULL,
    Weight              VARCHAR(50) NOT NULL,
    Category            VARCHAR(50) NOT NULL,

    PRIMARY KEY (ModelID)
);

CREATE TABLE CARDS (
  CCID                  INT             NOT NULL,
  CustID                INT             NOT NULL,
  CNumber               CHAR(16)        NOT NULL,
  EXPDate               DATE            NOT NULL,
  Baddress              VARCHAR(255)    NOT NULL,
  BState                CHAR(2)         NOT NULL,
  BCity                 VARCHAR(255)    NOT NULL,
  BZIP                  CHAR(5)         NOT NULL,
  SecCode               CHAR(3)         NOT NULL,
  BB_CardFlag           CHAR(1)         DEFAULT 'N' NOT NULL,
  PRIMARY KEY (CCID),
  FOREIGN KEY (CustID) REFERENCES Member(CustID)
);

CREATE TABLE Product (
    Sku                 NUMBER NOT NULL,
    ModelID             NUMBER NOT NULL,
    Description         VARCHAR(2000),
    Color               VARCHAR(100) NOT NULL,
    Condition           VARCHAR(100) NOT NULL,
    Price               NUMBER NOT NULL,
    PRIMARY KEY (Sku),
    FOREIGN KEY (ModelID) REFERENCES MODEL_TABLE(ModelID)
);

CREATE TABLE TRANSACTIONS (
  TransacID             INT         NOT NULL,
  OnlineFlag            CHAR(1)     DEFAULT 'N' NOT NULL,
  TDate                 DATE        NOT NULL,
  TaxState              CHAR(2)     NOT NULL,
  CCID                  INT,
  CCAmount              FLOAT(20),
  GCAmount              FLOAT(20),
  ShippingType          VARCHAR(100),
  ShippingRate          FLOAT(2),
  CustID                INT,
  PRIMARY KEY (TransacID),
  FOREIGN KEY (CustID) REFERENCES Member(CustID),
  FOREIGN KEY (CCID) REFERENCES CARDS(CCID)
);

CREATE TABLE TLINE (
  TLineID               INT            NOT NULL,
  TransacID             INT            NOT NULL,
  SKU                   INT            NOT NULL,
  Quantity              INT,
  UPrice                FLOAT(20)      NOT NULL,
  UDiscount             FLOAT(20),
  PRIMARY KEY (TLineID),
  FOREIGN KEY (TransacID) REFERENCES TRANSACTIONS(TransacID),
  FOREIGN KEY (SKU) REFERENCES Product(Sku)
);

CREATE TABLE RETURNS
(
    RID                 NUMBER NOT NULL,
    TLineID             NUMBER NOT NULL,
    RDate               DATE,
    RQuantity           VARCHAR(100) NOT NULL,
    StoreID             NUMBER NOT NULL UNIQUE ,
    Reason              VARCHAR(500) NOT NULL,
    CCID                NUMBER NOT NULL,
    GiftCardID          NUMBER NOT NULL,

    PRIMARY KEY (RID),
    CONSTRAINT TLINEID_LINK_FK   FOREIGN KEY (TLineID)  REFERENCES TLINE (TLineID),
    CONSTRAINT STOREID_LINK_FK   FOREIGN KEY (StoreID)  REFERENCES STORES (StoreID),
    CONSTRAINT CCID_LINK_FK      FOREIGN KEY (CCID)  REFERENCES CARDS (CCID),
    CONSTRAINT GIFTID_LINK_FK    FOREIGN KEY (GiftCardID)  REFERENCES GIFT_CARDS (GiftCardID)
);
--------------------------------------------------------------------------
-- AUTHOR: MAURICIO MORALES (mm96964)
-- CREATE SEQUENCES SECTION
--------------------------------------------------------------------------

CREATE SEQUENCE MEMBERID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE GIFTID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE STORESID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE MODELID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE CARDSID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE SKUID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE TRANSACTIONSID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE TLINEID_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

CREATE SEQUENCE RETURNS_SEQ
START WITH 1000000
MINVALUE 1000000 MAXVALUE 9999999;

--------------------------------------------------------------------------
-- AUTHOR: MAURICIO MORALES (mm96964)
-- INSERTING VALUES
--------------------------------------------------------------------------
-- MEMBER
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Mile','Kellough','253-872-6601','mkellough0@angelfire.com','234 Stang Pass','143 Carioca Pass','Tacoma','WA','58370','Y','573','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Honey','Collie','484-113-7105','hcollie1@cbslocal.com','830 Fuller Street','81025 Mandrake Alley','Valley Forge','PA','99235','Y','84','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Tobye','Vasechkin','646-799-1770','tvasechkin2@skyrock.com','553 Fuller Road','194 Eastwood Court','New York City','NY','73819','Y','912','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Carroll','Dewdney','847-729-1729','cdewdney3@washingtonpost.com','88809 Dawn Court','17789 Montana Street','Chicago','IL','39560','N','892','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Annalee','Aleksankov','251-419-4454','aaleksankov4@com.com','00008 Blackbird Crossing','76934 Hanover Hill','Mobile','AL','96808','N','306','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Marylee','Kyles','727-721-3879','mkyles5@symantec.com','25 Hayes Junction','25 Oakridge Crossing','Clearwater','FL','12867','Y','471','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Boigie','Brentnall','336-935-0580','bbrentnall6@imageshack.us','70 Sachs Terrace','0 Doe Crossing Lane','Winston Salem','NC','29556','N','64','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Raphael','Seamarke','678-599-5321','rseamarke7@yellowpages.com','0087 Dahle Court','0436 Talmadge Terrace','Lawrenceville','GA','63411','Y','489','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Gallagher','Guerry','212-360-5943','gguerry8@si.edu','29545 Doe Crossing Lane','22119 Commercial Center','New York City','NY','69142','Y','33','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Cathlene','Borrie','907-741-9543','cborrie9@spotify.com','1388 Eastwood Lane','62338 Veith Center','Anchorage','AK','33271','N','723','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Carter','Prettyman','239-203-0384','cprettymana@is.gd','5519 Kenwood Junction','347 Carey Court','Naples','FL','39157','N','34','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Bennie','Fransinelli','573-568-5295','bfransinellib@cbsnews.com','7181 Commercial Street','98 Autumn Leaf Way','Columbia','MO','35118','N','237','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Alaster','Aphale','916-167-0374','aaphalec@tamu.edu','39180 Service Point','6846 Haas Point','Sacramento','CA','36402','N','636','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Helli','Marzellano','850-111-3602','hmarzellanod@wp.com','6314 Weeping Birch Center','44741 Canary Terrace','Pensacola','FL','43548','N','209','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Renee','Gatward','937-682-3645','rgatwarde@who.int','8 Florence Center','56032 Morningstar Crossing','Hamilton','OH','84744','N','512','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Kahlil','Groven','908-931-2267','kgrovenf@paginegialle.it','381 Upham Crossing','45819 Vera Terrace','Elizabeth','NJ','23452','N','444','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Austin','Hallowell','832-694-3370','ahallowellg@theguardian.com','2 Fordem Junction','539 Rigney Avenue','Houston','TX','55311','N','341','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Paulette','Fink','850-724-7381','pfinkh@state.gov','3432 Farragut Way','01960 Ramsey Trail','Pensacola','FL','60808','Y','44','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Windy','Sandeman','334-401-2194','wsandemani@cocolog-nifty.com','5729 Service Pass','9 Shelley Center','Montgomery','AL','20596','N','661','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Quentin','Haberjam','610-561-3317','qhaberjamj@businessweek.com','03 Browning Street','213 Namekagon Crossing','Reading','PA','18325','N','94','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Mavra','Meneur','330-703-1932','mmeneurk@samsung.com','13065 Sachtjen Alley','75 Longview Center','Canton','OH','62154','N','750','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Clywd','Carlesi','336-256-0405','ccarlesil@issuu.com','73575 Namekagon Road','496 Burning Wood Center','Greensboro','NC','13006','Y','274','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Chryste','Apdell','254-854-3045','capdellm@clickbank.net','1 Gerald Avenue','490 Coolidge Trail','Waco','TX','88976','Y','58','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Tadeo','Szymoni','561-519-8360','tszymonin@constantcontact.com','8149 Grim Center','30 Hansons Trail','West Palm Beach','FL','99584','N','960','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Joy','Gurnay','323-546-2528','jgurnayo@census.gov','7 Sundown Center','8514 4th Circle','Los Angeles','CA','48244','Y','252','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Nannie','Prigg','318-595-2223','npriggp@youtu.be','44517 Myrtle Hill','571 Corry Lane','Shreveport','LA','76528','Y','24','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Antons','Pigeon','410-645-2433','apigeonq@blogtalkradio.com','4205 Cherokee Lane','9 Sommers Park','Baltimore','MD','76780','N','806','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Alane','Perigoe','520-624-7645','aperigoer@dmoz.org','323 Manley Plaza','27 Glendale Terrace','Tucson','AZ','65577','Y','821','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Judd','Assard','865-199-1878','jassards@privacy.gov.au','9 Debs Lane','84 Ruskin Street','Knoxville','TN','59416','Y','938','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Angela','Gross','501-573-4258','agrosst@upenn.edu','9774 Myrtle Avenue','94 Ilene Point','Little Rock','AR','16238','Y','620','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Bibbye','OCodihie','585-595-3970','bocodihieu@xinhuanet.com','876 Shelley Trail','2 Lyons Avenue','Rochester','NY','73547','N','105','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Cobbie','Zuanazzi','215-504-0864','czuanazziv@dropbox.com','1590 Corry Point','80 Oak Valley Court','Philadelphia','PA','13955','N','339','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Cathe','Lesley','504-208-1035','clesleyw@creativecommons.org','8 Anhalt Street','810 Stone Corner Place','New Orleans','LA','61300','Y','223','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Marybelle','Ballay','602-931-5436','mballayx@opera.com','84392 Stone Corner Drive','032 Forest Hill','Glendale','AZ','42381','N','508','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Pier','Aggs','215-532-1824','paggsy@wordpress.org','4397 Lerdahl Trail','05254 Gina Alley','Philadelphia','PA','23685','N','838','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Abdel','Hughill','323-426-9879','ahughillz@gmpg.org','99 Farmco Road','787 Talmadge Terrace','Los Angeles','CA','83646','N','140','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Mort','Tull','786-493-0998','mtull10@storify.com','414 Pepper Wood Pass','617 International Circle','Miami','FL','88655','N','910','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Marten','Swigger','646-938-6276','mswigger11@cyberchimps.com','294 Badeau Pass','29 Oak Place','New York City','NY','13192','Y','767','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Constancia','Spry','203-880-5284','cspry12@rambler.ru','04228 Corben Plaza','3 Fuller Hill','Waterbury','CT','71736','Y','295','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Christal','Stirley','405-772-9416','cstirley13@ning.com','8375 Arapahoe Road','76645 Almo Pass','Oklahoma City','OK','51582','N','544','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Bern','Humbatch','972-517-0996','bhumbatch14@nba.com','60 Center Hill','33973 Chinook Lane','Garland','TX','44378','N','741','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Almire','Wybrow','904-390-0086','awybrow15@shareasale.com','02017 Hoard Road','117 Union Lane','Jacksonville','FL','16717','N','342','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Ofella','Lempke','212-394-0105','olempke16@google.cn','633 Sycamore Plaza','49 Summit Lane','New York City','NY','92810','Y','85','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Adah','Wedgwood','408-724-9031','awedgwood17@360.cn','1402 Crescent Oaks Park','8 Sommers Pass','San Jose','CA','62082','N','173','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Orazio','Ivie','505-636-1881','oivie18@blinklist.com','78305 Killdeer Point','9 Gulseth Road','Santa Fe','NM','42926','Y','64','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Carlene','Ayars','203-641-5931','cayars19@nhs.uk','0232 East Hill','5509 Barnett Drive','Bridgeport','CT','96731','Y','293','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Carolee','Halsho','314-951-2289','chalsho1a@china.com.cn','5467 Grover Lane','77922 Sullivan Street','Saint Louis','MO','68318','N','903','Standard');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Bryce','Mackison','314-844-8214','bmackison1b@jugem.jp','93 Jackson Court','17 Westerfield Court','Saint Louis','MO','35560','N','744','Elite+');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Raye','Sowerby','234-655-7652','rsowerby1c@google.fr','4 Rusk Hill','72 Kingsford Parkway','Canton','OH','85793','N','902','Elite');
INSERT INTO Member VALUES (MEMBERID_SEQ.NEXTVAL,'Hillery','Mountain','254-595-1885','hmountain1d@chronoengine.com','17061 Straubel Drive','0 Tennyson Street','Gatesville','TX','87713','N','774','Standard');

-- GIFT CARDS
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,221);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,146);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,634);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,218);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,909);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,470);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,557);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,43);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,192);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,866);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,35);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,464);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,513);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,143);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,445);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,3);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,776);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,935);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,384);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,387);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,382);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,955);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,747);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,328);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,908);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,198);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,90);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,529);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,28);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,576);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,888);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,659);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,212);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,300);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,80);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,789);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,789);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,424);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,149);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,735);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,744);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,889);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,704);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,126);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,448);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,125);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,363);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,466);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,901);
INSERT INTO GIFT_CARDS VALUES (GIFTID_SEQ.NEXTVAL,149);

-- STORES
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'SNES BestBuy','55018 Hagan Center','West Palm Beach','FL','66578','C');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'SPKE BestBuy','125 Kropf Way','Milwaukee','WI','45957','C');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'TRUE BestBuy','890 Bobwhite Street','Inglewood','CA','18653','A');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'EPD BestBuy','446 Shasta Trail','Miami','FL','64984','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'PPSI BestBuy','95 Susan Park','Clearwater','FL','96875','E');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'CNX BestBuy','70504 Express Pass','Columbia','SC','10169','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'FCE.A BestBuy','2 Old Shore Road','Tulsa','OK','76962','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'WIX BestBuy','1 Sachtjen Terrace','Nashville','TN','43669','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'HGH BestBuy','788 South Lane','Tucson','AZ','96306','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'DIN BestBuy','90270 Katie Junction','Tulsa','OK','71022','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'THLD BestBuy','320 Barby Parkway','Reading','PA','36285','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'DLB BestBuy','8085 Kingsford Junction','Greenville','SC','52848','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'TZOO BestBuy','320 Kingsford Street','San Antonio','TX','98504','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'AIC BestBuy','8 Derek Hill','Arlington','VA','57695','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'ZNWAA BestBuy','302 Anhalt Pass','Long Beach','CA','99134','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'MKL BestBuy','13 Nevada Terrace','Ocala','FL','63907','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'GLOB BestBuy','3 Eastlawn Crossing','Oklahoma City','OK','79678','E');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'ANDAR BestBuy','32 Jenifer Alley','Denver','CO','60478','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'RCL BestBuy','6176 Sycamore Plaza','Chicago','IL','38370','E');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'MLM BestBuy','16124 Grasskamp Pass','Chicago','IL','70505','E');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'SVA BestBuy','366 Waxwing Crossing','Flushing','NY','65482','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'VAR BestBuy','69 Esker Pass','Phoenix','AZ','39769','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'INPX BestBuy','3613 Jana Crossing','East Saint Louis','IL','67997','E');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'BFO BestBuy','60610 Bunker Hill Drive','Saint Petersburg','FL','40806','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'GRVY BestBuy','34 Rigney Place','Arlington','VA','75776','E');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'DCT BestBuy','541 Mallard Trail','Orlando','FL','53143','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'HMNY BestBuy','793 Cordelia Junction','San Antonio','TX','48758','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'MSEX BestBuy','3 Gina Center','Greensboro','NC','47826','C');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'SPWH BestBuy','046 Roxbury Crossing','Newark','NJ','57753','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'ADMS BestBuy','909 Nevada Park','Shreveport','LA','80242','E');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'VIVO BestBuy','27 Claremont Avenue','Boise','ID','68510','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'OEC BestBuy','6 Cody Junction','Muncie','IN','78403','C');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'OTEL BestBuy','28478 Starling Terrace','New Haven','CT','74255','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'HIG.WS BestBuy','651 Hoard Trail','Akron','OH','49728','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'SPB            BestBuy','549 Gina Crossing','Topeka','KS','82129','C');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'BGIO BestBuy','1297 Pawling Street','Paterson','NJ','51568','A');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'PEN BestBuy','39593 Fisk Parkway','Beaverton','OR','51140','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'INO BestBuy','562 Elgar Park','Richmond','VA','16837','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'CIO BestBuy','33272 Coleman Pass','Chula Vista','CA','52062','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'MSG BestBuy','31629 Homewood Street','Minneapolis','MN','52662','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'EMES BestBuy','0508 Hansons Court','Las Vegas','NV','44378','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'EQIX BestBuy','262 Summit Plaza','Panama City','FL','99111','A');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'LANDP BestBuy','04108 Londonderry Trail','Las Vegas','NV','25272','B');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'VLY BestBuy','9 Pine View Lane','Pittsburgh','PA','67950','F');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'BIVV BestBuy','9691 Leroy Avenue','Atlanta','GA','42991','A');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'KFN^ BestBuy','1 Algoma Lane','Salt Lake City','UT','80035','A');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'NGLS^A BestBuy','66300 Algoma Terrace','Santa Monica','CA','24181','C');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'OLP BestBuy','4473 Eastlawn Trail','Dearborn','MI','61108','A');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'ATRI BestBuy','927 Sutteridge Road','Chicago','IL','35828','D');
INSERT INTO STORES VALUES (STORESID_SEQ.NEXTVAL,'FMS BestBuy','43690 Ronald Regan Terrace','San Francisco','CA','66954','B');

-- MODEL
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Alpha','triamcinolone acetonide',25,42,63,72,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Temp','Citalopram',30,72,35,42,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Redhold','Lorazepam',54,13,60,64,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Biodex','IASO White Science EX Serum',11,60,62,9,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Flexidy','Serotonin',61,63,64,97,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Redhold','DG Health cold and flu relief',68,65,7,11,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Job','Alka-Seltzer Plus',54,79,40,61,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Alphazap','Nitrostat',24,56,4,69,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Treeflex','Dermarest',10,8,12,93,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Bitwolf','Betamethasone Dipropionate',85,80,62,98,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Holdlamis','meijer',49,68,9,57,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Biodex','Health Mart Simethicone',57,75,62,33,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Sonair','ASH MIX, GREEN/WHITE POLLEN',87,77,65,73,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Kanlam','Standardized Meadow Fescue Grass Pollen',20,34,84,9,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Y-find','Ethambutol',59,44,3,47,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Temp','ULTRASOL',66,12,59,82,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Viva','Fremont Cottonwood',23,51,81,50,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Ronstring','Too Faced BB Creme Complete Coverage Make-Up',9,44,23,25,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Vagram','Guaifenesin DM',9,55,90,89,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Sonair','HairQ',96,53,16,38,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Ventosanzap','Cymbalta',53,93,29,20,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Job','Live Better',61,90,53,70,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Quo Lux','Exuviance CoverBlend Skin Caring Foundation',37,29,70,50,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Flexidy','HYDROMORPHONE HYDROCHLORIDE',27,68,100,86,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Y-find','Warfarin Sodium',6,16,56,93,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Redhold','Safeway Home Lemon Scent',21,94,99,68,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Namfix','Potassium Citrate',100,69,94,41,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Tresom','Amoxicillin',55,25,41,28,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Tempsoft','DORYX',80,78,18,41,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Voltsillam','Excedrin',71,53,82,41,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Zontrax','Opana ER',16,87,30,51,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Holdlamis','QUETIAPINE FUMARATE',90,33,97,50,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Zaam-Dox','Nevi (Mole) Control',11,46,66,16,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Prodder','RISPERIDONE',43,16,25,25,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Zamit','Nite Time Cold and Flu',69,35,77,30,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Fintone','Haloperidol',27,14,45,29,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'It','QUALITY CHOICE OMEPRAZOLE',62,3,65,58,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'It','Clonazepam',40,89,41,29,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Alphazap','Metaproterenol Sulfate',25,13,53,5,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Tres-Zap','Leader',70,71,71,52,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Kanlam','Enalapril Maleate',47,35,8,67,'Headphones');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Quo Lux','Yellow Jacket hymenoptera venom Venomil Maintenance',73,68,29,86,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Aerified','Smart Sense Pain Relief',79,19,43,37,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Gembucket','Neutrogena Age Shield Face',50,72,86,68,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Konklab','Proactiv',57,1,67,74,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Konklux','extra moisturizing',26,90,57,96,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Fix San','Health Mart Nicotine',88,14,66,24,'Laptop');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Voyatouch','Adidas',60,21,12,85,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Toughjoyfax','RED GINSENG FERMENTED ESSENCE BOOSTER',20,31,64,16,'Monitor');
INSERT INTO Model_Table VALUES (ModelID_seq.NEXTVAL,'Treeflex','MAGNESIA PHOS',2,78,28,1,'Monitor');

-- CARDS
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000000,'3538174289402520','31-12-2023','9318 Dovetail Street','MT','Bozeman','90413','650','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000001,'5610001964862100','30-08-2021','61 Fair Oaks Drive','CT','Bridgeport','79767','868','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000002,'3583513350393540','09-06-2025','57 Transport Center','TX','Austin','85047','810','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000003,'3534006824763610','20-05-2029','97617 Mallard Circle','NC','Asheville','84740','111','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000004,'3554727995417430','04-05-2029','79 Mosinee Place','MN','Minneapolis','24625','499','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000005,'3556024980477120','17-10-2029','966 American Ash Parkway','AL','Mobile','10498','346','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000006,'6333585437618080','10-08-2022','0 Elgar Road','MT','Helena','62965','506','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000007,'5602222103249230','13-02-2025','70 5th Alley','MN','Duluth','74884','953','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000008,'3564234735850840','05-02-2024','12 Granby Circle','WI','Green Bay','60089','606','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000009,'4041378411592020','15-06-2027','46 Spaight Point','NC','CHARlotte','21792','414','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000010,'3553758518942910','03-10-2027','078 Parkside Place','FL','Lakeland','72722','685','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000011,'3576808355868980','03-06-2020','5894 Fulton Point','IN','Evansville','11071','963','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000012,'5167626780111220','30-05-2022','7 Fairview Trail','DC','Washington','75560','630','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000013,'3575895311209900','29-06-2027','5191 Petterle Alley','TX','Fort Worth','39578','191','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000014,'3541295519711150','02-02-2030','88 Logan Court','MO','Kansas City','22059','275','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000015,'5020061018910500','20-10-2020','637 Erie Way','MO','Saint Louis','19563','636','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000016,'3563168616957500','30-01-2021','8696 Bartillon Plaza','CA','Sacramento','27602','123','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000017,'3556755394908550','18-08-2020','1 Morning Terrace','WA','Spokane','42736','768','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000018,'3533500487828480','27-03-2028','400 Delladonna Center','NY','Rochester','66450','954','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000019,'4913668658652380','06-12-2020','40980 Merry Parkway','CA','Fresno','91386','563','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000020,'3538173446498570','20-01-2030','589 Northfield Street','MI','Lansing','57288','346','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000021,'5100173015180640','23-12-2021','625 Nobel Crossing','NC','Durham','44023','306','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000022,'3556393022293150','29-04-2020','84 Macpherson Lane','ID','Boise','74708','880','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000023,'3742882007707400','22-09-2024','320 Towne Junction','CA','Long Beach','38928','213','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000024,'3553299999479960','25-03-2021','8311 Bellgrove Point','PA','Reading','91069','376','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000025,'3577407341728970','23-09-2026','27 Dakota Hill','MI','Warren','30787','480','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000026,'3746225362739060','18-01-2025','75 Sunfield Junction','CA','Los Angeles','30562','829','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000027,'5602210997730570','10-01-2023','97 Londonderry Drive','TN','Chattanooga','28418','834','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000028,'3545159132049610','21-05-2028','0 Elka Alley','NM','Albuquerque','90084','565','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000029,'5048377367846370','04-09-2022','13 Butternut Plaza','UT','Provo','55256','988','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000030,'3715357108721990','09-12-2024','67 Elka Alley','AZ','Phoenix','40263','476','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000031,'3557559882633090','22-04-2026','1509 Hansons Lane','CA','Pomona','95100','791','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000032,'5007662004001610','17-07-2028','1238 Continental Street','CA','San Diego','94029','859','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000033,'3529380792286440','10-04-2028','6 Westport Trail','NY','New York City','29241','164','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000034,'2018448602560390','20-10-2027','25 Myrtle Parkway','TX','Corpus Christi','65654','189','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000035,'3560398585786410','26-04-2021','8858 Calypso Terrace','FL','Fort Lauderdale','81355','976','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000036,'5108753040803150','25-11-2029','3 Bartelt Hill','FL','Boca Raton','57677','725','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000037,'4017952684529230','11-03-2021','64794 Quincy Terrace','TX','Fort Worth','97677','570','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000038,'3554325328850120','08-02-2029','360 Coleman Lane','DC','Washington','91741','805','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000039,'3573285954119860','24-10-2021','95 Morningstar Trail','CO','Colorado Springs','29156','312','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000040,'6389611740878710','28-06-2022','12066 Eastlawn Center','CA','Sacramento','20198','751','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000041,'3529611409909400','15-07-2022','93 Garrison Place','PA','Johnstown','23208','741','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000042,'3575999732824040','04-07-2030','23 Trailsway Junction','TN','Nashville','85984','312','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000043,'4905709840362680','15-01-2020','7244 Beilfuss Crossing','GA','Augusta','28732','802','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000044,'4017950072806890','26-02-2030','8 Eagle Crest Place','CA','San Francisco','77372','297','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000045,'5602225920988970','29-11-2023','5791 Elka Park','MA','Boston','92447','659','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000046,'4905607167588640','08-02-2030','3828 Pine View Road','AL','Birmingham','14254','204','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000047,'3581917125259330','21-02-2025','73920 Vermont Street','OH','Cleveland','53288','547','Y');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000048,'3574134230709620','30-09-2021','7 Hansons Alley','FL','Ocala','74469','632','N');
INSERT INTO CARDS VALUES (CARDSID_SEQ.NEXTVAL,1000049,'3579991375032630','14-05-2028','6 Loeprich Way','LA','New Orleans','52257','582','N');

-- SKU
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000000,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.','Blue','New',438);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000001,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.','Goldenrod','New',727);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000002,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.','Indigo','Used',372);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000003,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.','Pink','Refurbished',526);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000004,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','Yellow','Refurbished',715);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000005,'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.','Indigo','Used',763);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000006,'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.','Teal','Used',385);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000007,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.','Teal','Refurbished',360);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000008,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','Indigo','Used',272);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000009,'Donec posuere metus vitae ipsum. Aliquam non mauris.','Indigo','Used',31);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000010,'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','Violet','Used',119);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000011,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.','Puce','New',966);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000012,'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','Teal','New',786);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000013,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.','Turquoise','Refurbished',734);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000014,'Nulla suscipit ligula in lacus.','Puce','Refurbished',999);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000015,'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.','Puce','Refurbished',305);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000016,'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Maroon','Used',170);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000017,'Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.','Indigo','New',873);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000018,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.','Purple','New',603);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000019,'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.','Goldenrod','Used',796);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000020,'Donec dapibus. Duis at velit eu est congue elementum.','Blue','New',877);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000021,'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','Turquoise','Used',294);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000022,'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','Orange','Used',370);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000023,'Donec ut mauris eget massa tempor convallis.','Fuscia','New',163);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000024,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','Khaki','New',44);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000025,'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','Blue','New',353);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000026,'Sed sagittis.','Crimson','Used',352);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000027,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','Purple','New',825);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000028,'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','Violet','Used',604);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000029,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.','Puce','Used',959);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000030,'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','Blue','Refurbished',492);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000031,'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','Red','Refurbished',798);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000032,'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','Purple','New',245);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000033,'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.','Red','Refurbished',736);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000034,'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','Blue','Used',352);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000035,'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.','Pink','Refurbished',607);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000036,'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.','Violet','Used',268);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000037,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.','Maroon','New',45);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000038,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.','Fuscia','New',140);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000039,'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.','Mauv','New',674);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000040,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.','Indigo','Used',522);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000041,'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.','Fuscia','New',394);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000042,'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','Indigo','Used',574);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000043,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.','Fuscia','Used',351);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000044,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.','Blue','New',20);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000045,'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Yellow','Refurbished',406);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000046,'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.','Yellow','New',631);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000047,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','Red','Refurbished',294);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000048,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.','Blue','Refurbished',986);
INSERT INTO Product VALUES (SKUID_SEQ.NEXTVAL,1000049,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.','Khaki','Refurbished',308);

-- TRANSACTION
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','01-01-1900','NC',1000000,812,287,'Scheduled',0.06,1000000);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','07-08-2020','KS',1000001,46,771,'Scheduled',0.03,1000001);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','20-07-2020','VA',1000002,930,199,'2-day',0.03,1000002);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','07-11-2020','TX',1000003,496,891,'2-day',0.03,1000003);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','14-05-2020','NM',1000004,771,23,'Scheduled',0.06,1000004);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','24-11-2020','IA',1000005,575,644,'2-day',0.1,1000005);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','15-06-2020','CA',1000006,4,748,'Scheduled',0.03,1000006);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','05-12-2020','MA',1000007,311,38,'Scheduled',0.1,1000007);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','19-07-2020','NC',1000008,263,658,'Scheduled',0.03,1000008);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','04-09-2020','OK',1000009,117,568,'Standard',0.06,1000009);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','15-07-2020','MT',1000010,797,599,'Scheduled',0.03,1000010);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','13-10-2020','FL',1000011,816,322,'2-day',0.03,1000011);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','05-02-2020','TX',1000012,44,515,'2-day',0.03,1000012);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','04-09-2020','TX',1000013,941,989,'Standard',0.06,1000013);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','09-07-2020','WY',1000014,706,348,'Standard',0.03,1000014);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','28-01-2020','UT',1000015,265,307,'Scheduled',0.06,1000015);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','01-01-2020','AZ',1000016,779,171,'2-day',0.06,1000016);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','07-11-2020','NY',1000017,672,921,'2-day',0.06,1000017);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','19-10-2020','DC',1000018,949,273,'Standard',0.1,1000018);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','13-04-2020','TX',1000019,250,165,'Scheduled',0.06,1000019);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','22-04-2020','NY',1000020,137,202,'Standard',0.1,1000020);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','13-08-2020','IL',1000021,30,258,'Standard',0.1,1000021);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','08-11-2020','FL',1000022,291,742,'Scheduled',0.06,1000022);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','09-02-2020','MO',1000023,519,509,'2-day',0.03,1000023);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','14-12-2019','IL',1000024,375,776,'2-day',0.1,1000024);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','16-04-2020','TX',1000025,78,642,'Standard',0.03,1000025);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','30-05-2020','CO',1000026,582,289,'2-day',0.06,1000026);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','25-08-2020','CA',1000027,633,354,'2-day',0.06,1000027);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','23-07-2020','MO',1000028,837,989,'Standard',0.1,1000028);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','22-08-2020','OH',1000029,41,749,'2-day',0.1,1000029);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','05-06-2020','HI',1000030,617,25,'2-day',0.06,1000030);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','04-05-2020','KS',1000031,112,11,'Standard',0.03,1000031);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','12-06-2020','FL',1000032,803,758,'Scheduled',0.1,1000032);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','21-08-2020','CA',1000033,305,539,'Standard',0.06,1000033);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','12-08-2020','MA',1000034,373,848,'Scheduled',0.1,1000034);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','21-07-2020','MT',1000035,29,623,'Standard',0.03,1000035);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','16-12-2019','MA',1000036,213,884,'Standard',0.1,1000036);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','10-02-2020','VA',1000037,648,818,'Standard',0.06,1000037);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','08-02-2020','CA',1000038,482,208,'Standard',0.1,1000038);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','28-05-2020','CA',1000039,919,279,'2-day',0.1,1000039);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','29-08-2020','PA',1000040,542,173,'Standard',0.03,1000040);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','06-09-2020','CT',1000041,788,679,'Standard',0.06,1000041);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','15-04-2020','TX',1000042,754,701,'2-day',0.1,1000042);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','07-08-2020','FL',1000043,381,156,'2-day',0.03,1000043);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','27-04-2020','IL',1000044,823,347,'Standard',0.1,1000044);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','27-11-2020','MO',1000045,188,134,'Scheduled',0.1,1000045);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','04-05-2020','TX',1000046,724,152,'Scheduled',0.1,1000046);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','08-06-2020','GA',1000047,586,745,'Scheduled',0.03,1000047);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'N','13-05-2020','AZ',1000048,160,600,'Scheduled',0.06,1000048);
INSERT INTO TRANSACTIONS VALUES (TRANSACTIONSID_SEQ.NEXTVAL,'Y','13-06-2020','NY',1000049,833,243,'Standard',0.1,1000049);

-- TLINE
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000000,1000000,483,589,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000001,1000001,301,536,0.34);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000002,1000002,695,107,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000003,1000003,891,533,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000004,1000004,12,806,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000005,1000005,813,480,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000006,1000006,408,854,0.17);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000007,1000007,211,702,0.5);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000008,1000008,367,821,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000009,1000009,401,841,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000010,1000010,106,898,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000011,1000011,290,968,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000012,1000012,388,446,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000013,1000013,698,917,0.15);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000014,1000014,972,846,0.43);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000015,1000015,975,321,0.32);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000016,1000016,2,91,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000017,1000017,36,42,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000018,1000018,488,747,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000019,1000019,841,810,0.21);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000020,1000020,321,106,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000021,1000021,20,335,0.26);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000022,1000022,671,417,0.18);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000023,1000023,539,361,0.47);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000024,1000024,805,366,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000025,1000025,768,391,0.32);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000026,1000026,614,763,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000027,1000027,486,979,0.24);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000028,1000028,515,753,0.1);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000029,1000029,171,371,0.16);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000030,1000030,214,74,0.35);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000031,1000031,460,601,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000032,1000032,924,447,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000033,1000033,271,997,0.36);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000034,1000034,742,452,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000035,1000035,834,833,0.18);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000036,1000036,901,505,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000037,1000037,199,115,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000038,1000038,121,437,0.42);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000039,1000039,595,412,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000040,1000040,704,33,0.15);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000041,1000041,146,766,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000042,1000042,179,180,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000043,1000043,596,136,NULL);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000044,1000044,972,543,0.06);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000045,1000045,188,279,0.42);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000046,1000046,837,675,0.23);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000047,1000047,507,161,0.08);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000048,1000048,84,556,0.38);
INSERT INTO TLINE VALUES (TLINEID_SEQ.NEXTVAL,1000049,1000049,520,3,NULL);

-- RETURNS
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000000,'12-10-2020','557',1000000,'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.',1000000,1000000);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000001,'25-01-2020','150',1000001,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',1000001,1000001);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000002,'27-04-2020','965',1000002,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.',1000002,1000002);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000003,'16-10-2020','168',1000003,'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.',1000003,1000003);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000004,'25-03-2020','485',1000004,'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',1000004,1000004);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000005,'22-09-2020','577',1000005,'Donec dapibus. Duis at velit eu est congue elementum.',1000005,1000005);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000006,'16-01-2020','999',1000006,'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',1000006,1000006);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000007,'25-07-2020','433',1000007,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.',1000007,1000007);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000008,'10-08-2020','747',1000008,'Proin at turpis a pede posuere nonummy.',1000008,1000008);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000009,'11-07-2020','51',1000009,'Sed sagittis.',1000009,1000009);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000010,'23-02-2020','902',1000010,'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.',1000010,1000010);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000011,'04-04-2020','428',1000011,'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.',1000011,1000011);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000012,'21-03-2020','332',1000012,'Integer ac neque.',1000012,1000012);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000013,'16-03-2020','626',1000013,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.',1000013,1000013);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000014,'27-10-2020','646',1000014,'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.',1000014,1000014);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000015,'19-08-2020','214',1000015,'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.',1000015,1000015);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000016,'16-04-2020','555',1000016,'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.',1000016,1000016);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000017,'07-03-2020','967',1000017,'Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.',1000017,1000017);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000018,'21-04-2020','223',1000018,'Nulla nisl. Nunc nisl.',1000018,1000018);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000019,'26-11-2019','717',1000019,'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.',1000019,1000019);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000020,'06-11-2020','802',1000020,'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.',1000020,1000020);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000021,'29-10-2020','123',1000021,'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.',1000021,1000021);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000022,'22-07-2020','717',1000022,'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.',1000022,1000022);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000023,'18-08-2020','879',1000023,'Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.',1000023,1000023);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000024,'29-08-2020','287',1000024,'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.',1000024,1000024);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000025,'25-03-2020','505',1000025,'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.',1000025,1000025);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000026,'03-03-2020','649',1000026,'Suspendisse potenti. Cras in purus eu magna vulputate luctus.',1000026,1000026);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000027,'10-12-2019','346',1000027,'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',1000027,1000027);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000028,'12-08-2020','70',1000028,'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.',1000028,1000028);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000029,'03-08-2020','583',1000029,'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.',1000029,1000029);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000030,'21-12-2019','194',1000030,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.',1000030,1000030);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000031,'11-02-2020','456',1000031,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.',1000031,1000031);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000032,'07-09-2020','589',1000032,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',1000032,1000032);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000033,'10-10-2020','184',1000033,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.',1000033,1000033);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000034,'12-12-2019','866',1000034,'Quisque id justo sit amet sapien dignissim vestibulum.',1000034,1000034);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000035,'10-09-2020','574',1000035,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',1000035,1000035);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000036,'06-01-2020','335',1000036,'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',1000036,1000036);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000037,'17-08-2020','997',1000037,'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.',1000037,1000037);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000038,'14-02-2020','165',1000038,'Vivamus vestibulum sagittis sapien.',1000038,1000038);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000039,'16-10-2020','759',1000039,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.',1000039,1000039);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000040,'06-01-2020','347',1000040,'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.',1000040,1000040);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000041,'11-12-2019','761',1000041,'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpi',1000041,1000041);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000042,'02-09-2020','796',1000042,'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.',1000042,1000042);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000043,'14-04-2020','622',1000043,'Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',1000043,1000043);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000044,'10-11-2020','616',1000044,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.',1000044,1000044);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000045,'03-12-2019','122',1000045,'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.',1000045,1000045);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000046,'24-12-2019','360',1000046,'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',1000046,1000046);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000047,'18-07-2020','481',1000047,'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.',1000047,1000047);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000048,'23-08-2020','959',1000048,'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',1000048,1000048);
INSERT INTO RETURNS VALUES (RETURNS_SEQ.NEXTVAL,1000049,'26-04-2020','925',1000049,'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.',1000049,1000049);