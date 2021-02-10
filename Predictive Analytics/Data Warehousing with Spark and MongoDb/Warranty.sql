DROP TABLE Warr_comp;
DROP TABLE Components;
DROP TABLE warranty_ticket;
DROP TABLE Agent;
DROP TABLE WARRANTY;
DROP TABLE Tline;
DROP TABLE Product;
DROP TABLE Model_table;
DROP TABLE Transaction;
DROP TABLE Member;


--Drop Sequences 
DROP SEQUENCE CustID_seq;
DROP SEQUENCE TransacID_seq;
DROP SEQUENCE ModelID_seq;
DROP SEQUENCE SkuID_seq;
DROP SEQUENCE TLineID_seq;
DROP SEQUENCE WarrantyID_seq;
DROP SEQUENCE AgentID_seq;
DROP SEQUENCE WartickID_seq;
DROP SEQUENCE PartID_seq;



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



CREATE TABLE Transaction (
  TransacID             INT         NOT NULL,
  CustID                INT NOT NULL,
  OnlineFlag            CHAR(1)     DEFAULT 'N' NOT NULL,
  TDate                 DATE        NOT NULL,
  TaxState              CHAR(2)     NOT NULL,
  CCID                  INT,
  CCAmount              FLOAT(20),
  GCAmount              FLOAT(20),
  ShippingType          VARCHAR(100),
  ShippingRate          FLOAT(2),
  PRIMARY KEY (TransacID),
  FOREIGN KEY (CustID) REFERENCES Member(CustID)
);

CREATE TABLE Model_table
(
    ModelID             NUMBER NOT NULL,
    Name                VARCHAR(100) NOT NULL,
    Brand               VARCHAR(100),
    Length              VARCHAR(50) NOT NULL,
    Width               VARCHAR(50) NOT NULL ,
    Height              VARCHAR(50) NOT NULL,
    Weight              VARCHAR(50) NOT NULL,
    Category            VARCHAR(50) NOT NULL,

    PRIMARY KEY (ModelID)
);



CREATE TABLE Product
(
    Sku                 NUMBER NOT NULL,
    ModelID             NUMBER NOT NULL,
    Description         VARCHAR(600),
    Color               VARCHAR(10) NOT NULL,
    Condition           VARCHAR(100) NOT NULL,
    Price               NUMBER NOT NULL,

    PRIMARY KEY (Sku),
    FOREIGN KEY (ModelID) REFERENCES Model_table(ModelID)
);


CREATE TABLE TLine (
  TLineID               INT            NOT NULL,
  TransacID             INT            NOT NULL,
  Sku                   INT            NOT NULL,
  Quantity              INT,
  UPrice                FLOAT(20)      NOT NULL,
  UDiscount             FLOAT(20)	   DEFAULT 0,
  PRIMARY KEY (TLineID),
  FOREIGN KEY (TransacID) REFERENCES Transaction(TransacID),
  FOREIGN KEY (Sku) REFERENCES Product(Sku)
);


CREATE TABLE WARRANTY (
  WarrID NUMBER ,
  TLineID NUMBER,
  WType VARCHAR(100) NOT NULL,
  WTerm VARCHAR(100) NOT NULL,
  Price NUMBER NOT NULL,
  CONSTRAINT WARRID_PK PRIMARY KEY (WarrID),
  CONSTRAINT TLineID_FK   FOREIGN KEY (TLineID) REFERENCES TLINE (TLineID)
);


CREATE TABLE Agent
(
    AgentID            NUMBER NOT NULL,
    FirstName          VARCHAR(100) NOT NULL,
    LastName           VARCHAR(100)  NOT NULL,

    PRIMARY KEY (AgentID)
);


CREATE TABLE warranty_ticket (
  WartickID                INT           NOT NULL,
  WarrID                   INT           NOT NULL,
  AgentID                  INT           NOT NULL,
  Issue_date               DATE NOT NULL,
  Problem                  VARCHAR(500)  NOT NULL,
  Solution                 VARCHAR(500),
  Enddate                  DATE          NOT NULL,
  Laborhours               FLOAT(20)      NOT NULL,
  Rate                     FLOAT(20)      NOT NULL,
  
  
  PRIMARY KEY (WartickID),
  FOREIGN KEY (WarrID) REFERENCES WARRANTY(WarrID),
  FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);



CREATE TABLE Components
(
    PartID           NUMBER NOT NULL,
    Description      VARCHAR(100) NOT NULL,
    Cost             FLOAT(100)  NOT NULL,
    Quantity         VARCHAR(100)  NOT NULL,

    PRIMARY KEY (PartID)
);


CREATE TABLE Warr_comp
(
    WartickID          NUMBER NOT NULL,
    PartID             Number NOT NULL,

    PRIMARY KEY (WartickID,PartID),
    FOREIGN KEY (WartickID) REFERENCES warranty_ticket(WartickID),
    FOREIGN KEY (PartID) REFERENCES Components(PartID)
);

--Create Sequences


CREATE SEQUENCE CustID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE TransacID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE ModelID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE SkuID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE TLineID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE WarrantyID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE AgentID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE WartickID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE PartID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;



--Insert mock data.
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Mile','Kellough','253-872-6601','mkellough0@angelfire.com','234 Stang Pass','143 Carioca Pass','Tacoma','WA','58370','Y',573,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Honey','Collie','484-113-7105','hcollie1@cbslocal.com','830 Fuller Street','81025 Mandrake Alley','Valley Forge','PA','99235','Y',84,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Tobye','Vasechkin','646-799-1770','tvasechkin2@skyrock.com','553 Fuller Road','194 Eastwood Court','New York City','NY','73819','Y',912,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carroll','Dewdney','847-729-1729','cdewdney3@washingtonpost.com','88809 Dawn Court','17789 Montana Street','Chicago','IL','39560','N',892,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Annalee','Aleksankov','251-419-4454','aaleksankov4@com.com','00008 Blackbird Crossing','76934 Hanover Hill','Mobile','AL','96808','N',306,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Marylee','Kyles','727-721-3879','mkyles5@symantec.com','25 Hayes Junction','25 Oakridge Crossing','Clearwater','FL','12867','Y',471,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Boigie','Brentnall','336-935-0580','bbrentnall6@imageshack.us','70 Sachs Terrace','0 Doe Crossing Lane','Winston Salem','NC','29556','N',64,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Raphael','Seamarke','678-599-5321','rseamarke7@yellowpages.com','0087 Dahle Court','0436 Talmadge Terrace','Lawrenceville','GA','63411','Y',489,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Gallagher','Guerry','212-360-5943','gguerry8@si.edu','29545 Doe Crossing Lane','22119 Commercial Center','New York City','NY','69142','Y',33,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Cathlene','Borrie','907-741-9543','cborrie9@spotify.com','1388 Eastwood Lane','62338 Veith Center','Anchorage','AK','33271','N',723,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carter','Prettyman','239-203-0384','cprettymana@is.gd','5519 Kenwood Junction','347 Carey Court','Naples','FL','39157','N',34,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bennie','Fransinelli','573-568-5295','bfransinellib@cbsnews.com','7181 Commercial Street','98 Autumn Leaf Way','Columbia','MO','35118','N',237,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Alaster','Aphale','916-167-0374','aaphalec@tamu.edu','39180 Service Point','6846 Haas Point','Sacramento','CA','36402','N',636,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Helli','Marzellano','850-111-3602','hmarzellanod@wp.com','6314 Weeping Birch Center','44741 Canary Terrace','Pensacola','FL','43548','N',209,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Renee','Gatward','937-682-3645','rgatwarde@who.int','8 Florence Center','56032 Morningstar Crossing','Hamilton','OH','84744','N',512,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Kahlil','Groven','908-931-2267','kgrovenf@paginegialle.it','381 Upham Crossing','45819 Vera Terrace','Elizabeth','NJ','23452','N',444,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Austin','Hallowell','832-694-3370','ahallowellg@theguardian.com','2 Fordem Junction','539 Rigney Avenue','Houston','TX','55311','N',341,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Paulette','Fink','850-724-7381','pfinkh@state.gov','3432 Farragut Way','01960 Ramsey Trail','Pensacola','FL','60808','Y',44,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Windy','Sandeman','334-401-2194','wsandemani@cocolog-nifty.com','5729 Service Pass','9 Shelley Center','Montgomery','AL','20596','N',661,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Quentin','Haberjam','610-561-3317','qhaberjamj@businessweek.com','03 Browning Street','213 Namekagon Crossing','Reading','PA','18325','N',94,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Mavra','Meneur','330-703-1932','mmeneurk@samsung.com','13065 Sachtjen Alley','75 Longview Center','Canton','OH','62154','N',750,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Clywd','Carlesi','336-256-0405','ccarlesil@issuu.com','73575 Namekagon Road','496 Burning Wood Center','Greensboro','NC','13006','Y',274,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Chryste','Apdell','254-854-3045','capdellm@clickbank.net','1 Gerald Avenue','490 Coolidge Trail','Waco','TX','88976','Y',58,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Tadeo','Szymoni','561-519-8360','tszymonin@constantcontact.com','8149 Grim Center','30 Hansons Trail','West Palm Beach','FL','99584','N',960,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Joy','Gurnay','323-546-2528','jgurnayo@census.gov','7 Sundown Center','8514 4th Circle','Los Angeles','CA','48244','Y',252,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Nannie','Prigg','318-595-2223','npriggp@youtu.be','44517 Myrtle Hill','571 Corry Lane','Shreveport','LA','76528','Y',24,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Antons','Pigeon','410-645-2433','apigeonq@blogtalkradio.com','4205 Cherokee Lane','9 Sommers Park','Baltimore','MD','76780','N',806,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Alane','Perigoe','520-624-7645','aperigoer@dmoz.org','323 Manley Plaza','27 Glendale Terrace','Tucson','AZ','65577','Y',821,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Judd','Assard','865-199-1878','jassards@privacy.gov.au','9 Debs Lane','84 Ruskin Street','Knoxville','TN','59416','Y',938,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Angela','Gross','501-573-4258','agrosst@upenn.edu','9774 Myrtle Avenue','94 Ilene Point','Little Rock','AR','16238','Y',620,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bibbye','Codihie','585-595-3970','bocodihieu@xinhuanet.com','876 Shelley Trail','2 Lyons Avenue','Rochester','NY','73547','N',105,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Cobbie','Zuanazzi','215-504-0864','czuanazziv@dropbox.com','1590 Corry Point','80 Oak Valley Court','Philadelphia','PA','13955','N',339,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Cathe','Lesley','504-208-1035','clesleyw@creativecommons.org','8 Anhalt Street','810 Stone Corner Place','New Orleans','LA','61300','Y',223,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Marybelle','Ballay','602-931-5436','mballayx@opera.com','84392 Stone Corner Drive','032 Forest Hill','Glendale','AZ','42381','N',508,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Pier','Aggs','215-532-1824','paggsy@wordpress.org','4397 Lerdahl Trail','05254 Gina Alley','Philadelphia','PA','23685','N',838,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Abdel','Hughill','323-426-9879','ahughillz@gmpg.org','99 Farmco Road','787 Talmadge Terrace','Los Angeles','CA','83646','N',140,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Mort','Tull','786-493-0998','mtull10@storify.com','414 Pepper Wood Pass','617 International Circle','Miami','FL','88655','N',910,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Marten','Swigger','646-938-6276','mswigger11@cyberchimps.com','294 Badeau Pass','29 Oak Place','New York City','NY','13192','Y',767,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Constancia','Spry','203-880-5284','cspry12@rambler.ru','04228 Corben Plaza','3 Fuller Hill','Waterbury','CT','71736','Y',295,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Christal','Stirley','405-772-9416','cstirley13@ning.com','8375 Arapahoe Road','76645 Almo Pass','Oklahoma City','OK','51582','N',544,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bern','Humbatch','972-517-0996','bhumbatch14@nba.com','60 Center Hill','33973 Chinook Lane','Garland','TX','44378','N',741,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Almire','Wybrow','904-390-0086','awybrow15@shareasale.com','02017 Hoard Road','117 Union Lane','Jacksonville','FL','16717','N',342,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Ofella','Lempke','212-394-0105','olempke16@google.cn','633 Sycamore Plaza','49 Summit Lane','New York City','NY','92810','Y',85,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Adah','Wedgwood','408-724-9031','awedgwood17@360.cn','1402 Crescent Oaks Park','8 Sommers Pass','San Jose','CA','62082','N',173,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Orazio','Ivie','505-636-1881','oivie18@blinklist.com','78305 Killdeer Point','9 Gulseth Road','Santa Fe','NM','42926','Y',64,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carlene','Ayars','203-641-5931','cayars19@nhs.uk','0232 East Hill','5509 Barnett Drive','Bridgeport','CT','96731','Y',293,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carolee','Halsho','314-951-2289','chalsho1a@china.com.cn','5467 Grover Lane','77922 Sullivan Street','Saint Louis','MO','68318','N',903,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bryce','Mackison','314-844-8214','bmackison1b@jugem.jp','93 Jackson Court','17 Westerfield Court','Saint Louis','MO','35560','N',744,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Raye','Sowerby','234-655-7652','rsowerby1c@google.fr','4 Rusk Hill','72 Kingsford Parkway','Canton','OH','85793','N',902,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Hillery','Mountain','254-595-1885','hmountain1d@chronoengine.com','17061 Straubel Drive','0 Tennyson Street','Gatesville','TX','87713','N',774,'Standard');


INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,1,'Y',DATE '2019-12-29','NC',132,812,287,'Scheduled',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,2,'N',DATE '2019-12-30','KS',178,46,771,'Scheduled',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,3,'N',DATE '2019-12-31','VA',257,930,199,'2-day',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,4,'Y',DATE '2020-01-01','TX',889,496,891,'2-day',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,5,'N',DATE '2020-01-02','NM',312,771,23,'Scheduled',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,6,'N',DATE '2020-01-03','IA',78,575,644,'2-day',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,7,'Y',DATE '2020-01-04','CA',821,4,748,'Scheduled',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,8,'N',DATE '2020-01-05','MA',78,311,38,'Scheduled',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,9,'Y',DATE '2020-01-06','NC',45,263,658,'Scheduled',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,10,'N',DATE '2020-01-07','OK',774,117,568,'Standard',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,11,'Y',DATE '2020-01-08','MT',90,797,599,'Scheduled',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,12,'N',DATE '2020-01-09','FL',869,816,322,'2-day',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,13,'Y',DATE '2020-01-10','TX',159,44,515,'2-day',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,14,'N',DATE '2020-01-11','TX',628,941,989,'Standard',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,15,'N',DATE '2020-01-12','WY',934,706,348,'Standard',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,16,'N',DATE '2020-01-13','UT',475,265,307,'Scheduled',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,17,'N',DATE '2020-01-14','AZ',581,779,171,'2-day',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,18,'N',DATE '2020-01-15','NY',676,672,921,'2-day',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,19,'Y',DATE '2020-01-16','DC',24,949,273,'Standard',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,20,'Y',DATE '2020-01-17','TX',709,250,165,'Scheduled',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,21,'Y',DATE '2020-01-18','NY',286,137,202,'Standard',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,22,'Y',DATE '2020-01-19','IL',12,30,258,'Standard',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,23,'N',DATE '2020-01-20','FL',214,291,742,'Scheduled',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,24,'N',DATE '2020-01-21','MO',839,519,509,'2-day',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,25,'N',DATE '2020-01-22','IL',512,375,776,'2-day',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,26,'Y',DATE '2020-01-23','TX',904,78,642,'Standard',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,27,'N',DATE '2020-01-24','CO',916,582,289,'2-day',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,28,'Y',DATE '2020-01-25','CA',390,633,354,'2-day',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,29,'N',DATE '2020-01-26','MO',895,837,989,'Standard',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,30,'N',DATE '2020-01-27','OH',375,41,749,'2-day',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,31,'Y',DATE '2020-01-28','HI',572,617,25,'2-day',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,32,'Y',DATE '2020-01-29','KS',418,112,11,'Standard',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,33,'N',DATE '2020-01-30','FL',309,803,758,'Scheduled',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,34,'Y',DATE '2020-01-31','CA',998,305,539,'Standard',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,35,'N',DATE '2020-02-01','MA',183,373,848,'Scheduled',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,36,'N',DATE '2020-02-02','MT',816,29,623,'Standard',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,37,'N',DATE '2020-02-03','MA',923,213,884,'Standard',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,38,'N',DATE '2020-02-04','VA',846,648,818,'Standard',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,39,'Y',DATE '2020-02-05','CA',309,482,208,'Standard',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,40,'Y',DATE '2020-02-06','CA',415,919,279,'2-day',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,41,'N',DATE '2020-02-07','PA',778,542,173,'Standard',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,42,'N',DATE '2020-02-08','CT',619,788,679,'Standard',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,43,'Y',DATE '2020-02-09','TX',617,754,701,'2-day',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,44,'N',DATE '2020-02-10','FL',601,381,156,'2-day',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,45,'Y',DATE '2020-02-11','IL',894,823,347,'Standard',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,46,'N',DATE '2020-02-12','MO',843,188,134,'Scheduled',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,47,'N',DATE '2020-02-13','TX',833,724,152,'Scheduled',0.1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,48,'N',DATE '2020-02-14','GA',121,586,745,'Scheduled',0.03);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,49,'N',DATE '2020-02-15','AZ',703,160,600,'Scheduled',0.06);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,50,'Y',DATE '2020-02-16','NY',128,833,243,'Standard',0.1);



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


INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,1,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.','Blue','New',438);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,2,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.','Goldenrod','New',727);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,3,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.','Indigo','Used',372);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,4,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.','Pink','Refurbished',526);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,5,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','Yellow','Refurbished',715);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,6,'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.','Indigo','Used',763);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,7,'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.','Teal','Used',385);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,8,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.','Teal','Refurbished',360);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,9,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','Indigo','Used',272);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,10,'Donec posuere metus vitae ipsum. Aliquam non mauris.','Indigo','Used',31);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,11,'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','Violet','Used',119);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,12,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.','Puce','New',966);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,13,'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','Teal','New',786);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,14,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.','Turquoise','Refurbished',734);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,15,'Nulla suscipit ligula in lacus.','Puce','Refurbished',999);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,16,'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.','Puce','Refurbished',305);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,17,'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Maroon','Used',170);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,18,'Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.','Indigo','New',873);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,19,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.','Purple','New',603);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,20,'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.','Goldenrod','Used',796);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,21,'Donec dapibus. Duis at velit eu est congue elementum.','Blue','New',877);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,22,'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','Turquoise','Used',294);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,23,'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','Orange','Used',370);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,24,'Donec ut mauris eget massa tempor convallis.','Fuscia','New',163);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,25,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','Khaki','New',44);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,26,'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','Blue','New',353);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,27,'Sed sagittis.','Crimson','Used',352);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,28,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','Purple','New',825);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,29,'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','Violet','Used',604);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,30,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.','Puce','Used',959);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,31,'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','Blue','Refurbished',492);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,32,'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','Red','Refurbished',798);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,33,'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','Purple','New',245);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,34,'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.','Red','Refurbished',736);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,35,'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','Blue','Used',352);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,36,'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.','Pink','Refurbished',607);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,37,'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.','Violet','Used',268);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,38,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.','Maroon','New',45);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,39,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.','Fuscia','New',140);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,40,'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.','Mauv','New',674);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,41,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.','Indigo','Used',522);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,42,'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.','Fuscia','New',394);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,43,'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','Indigo','Used',574);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,44,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.','Fuscia','Used',351);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,45,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.','Blue','New',20);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,46,'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Yellow','Refurbished',406);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,47,'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.','Yellow','New',631);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,48,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','Red','Refurbished',294);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,49,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.','Blue','Refurbished',986);
INSERT INTO Product VALUES (SkuID_seq.NEXTVAL,50,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.','Khaki','Refurbished',308);



INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,38,39,483,589,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,32,8,301,536,0.34);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,20,26,695,107,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,20,4,891,533,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,12,3,12,806,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,21,44,813,480,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,15,23,408,854,0.17);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,23,14,211,702,0.5);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,22,13,367,821,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,35,9,401,841,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,28,28,106,898,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,50,32,290,968,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,11,2,388,446,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,41,21,698,917,0.15);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,30,37,972,846,0.43);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,13,16,975,321,0.32);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,30,45,2,91,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,25,1,36,42,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,12,27,488,747,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,42,1,841,810,0.21);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,13,32,321,106,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,35,34,20,335,0.26);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,7,20,671,417,0.18);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,50,36,539,361,0.47);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,17,45,805,366,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,22,48,768,391,0.32);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,38,29,614,763,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,50,36,486,979,0.24);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,47,26,515,753,0.1);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,25,20,171,371,0.16);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,26,12,214,74,0.35);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,22,3,460,601,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,35,37,924,447,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,19,39,271,997,0.36);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,44,39,742,452,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,45,28,834,833,0.18);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,45,38,901,505,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,28,44,199,115,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,16,27,121,437,0.42);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,40,17,595,412,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,29,34,704,33,0.15);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,1,37,146,766,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,13,28,179,180,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,38,1,596,136,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,21,1,972,543,0.06);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,32,2,188,279,0.42);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,4,34,837,675,0.23);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,21,20,507,161,0.08);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,35,8,84,556,0.38);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,7,10,520,3,0);




INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,1,'Limited',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,2,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,3,'Lifetime',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,4,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,5,'Limited',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,6,'Limited',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,7,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,8,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,9,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,10,'Lifetime',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,11,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,12,'Lifetime',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,13,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,14,'Limited',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,15,'Limited',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,16,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,17,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,18,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,19,'Limited',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,20,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,21,'Limited',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,22,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,23,'Lifetime',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,24,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,25,'Lifetime',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,26,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,27,'Lifetime',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,28,'Limited',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,29,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,30,'Limited',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,31,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,32,'Limited',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,33,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,34,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,35,'Limited',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,36,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,37,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,38,'Limited',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,39,'Lifetime',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,40,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,41,'Lifetime',1,50);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,42,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,43,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,44,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,45,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,46,'Lifetime',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,47,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,48,'Limited',5,100);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,49,'Limited',10,200);
INSERT INTO Warranty VALUES (WarrID_seq.NEXTVAL,50,'Lifetime',10,200);



INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Granger','Arbuckel');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Humbert','Boodle');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Kizzee','Scutter');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Susanna','Gino');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Elvis','Royce');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Shirley','Atcherley');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Mace','Bransden');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Alyse','McGirr');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Kimmie','Stannard');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Julian','Thamelt');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Dominic','Moubray');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Troy','Bach');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Iolanthe','Buffery');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Sandie','Burgill');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Leontine','Anthoney');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Judas','MacKowle');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Aurelia','Bewick');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Arvie','Hutten');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Margery','Cheesworth');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Celene','Ashburner');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Alard','Scrigmour');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Miguelita','Jesty');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Annadiana','Torrans');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Robin','Hammon');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Tammie','Fever');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Tricia','MacAdie');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Blair','Healeas');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Sarajane','McQuilliam');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Marcelia','Squibbs');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Kelbee','Arent');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Stephenie','Farfull');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Cecily','Jennrich');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Alexandro','Slaght');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Marylinda','Duckhouse');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Cort','Coon');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Jordan','Slateford');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Alexandros','Bucklee');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Shawnee','Feast');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Bartram','Kitt');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Jorge','Scouler');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Alastair','Bywaters');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Lorens','Lishmund');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Devlen','Kunzler');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Heidi','Roskam');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Josie','Richings');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Wiley','Lowes');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Delila','Gunner');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Burton','Squirrell');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Alidia','Doone');
INSERT INTO Agent VALUES (AgentID_seq.NEXTVAL,'Tarra','Skellion');


INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,31,10,DATE '2019-09-16','error5','soln1',DATE '2020-05-01',7,4);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,10,31,DATE '2019-03-05','error6','soln3',DATE '2020-10-23',96,13);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,36,38,DATE '2019-10-29','error2','soln5',DATE '2020-05-22',82,79);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,3,30,DATE '2019-09-16','error5','soln10',DATE '2020-04-29',89,13);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,19,25,DATE '2019-03-05','error7','soln3',DATE '2020-07-15',12,22);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,33,42,DATE '2019-10-29','error5','soln1',DATE '2020-04-05',26,81);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,18,8,DATE '2019-09-16','error4','soln7',DATE '2020-01-20',29,89);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,7,44,DATE '2019-03-05','error8','soln10',DATE '2020-02-27',50,44);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,13,32,DATE '2019-10-29','error1','soln7',DATE '2020-06-12',46,90);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,11,11,DATE '2019-09-16','error10','soln8',DATE '2020-11-01',16,38);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,20,21,DATE '2019-03-05','error10','soln1',DATE '2020-08-11',49,33);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,45,27,DATE '2019-10-29','error8','soln5',DATE '2020-08-19',83,47);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,42,36,DATE '2019-09-16','error6','soln3',DATE '2020-08-30',51,28);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,25,10,DATE '2019-03-05','error1','soln9',DATE '2020-02-04',66,25);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,48,7,DATE '2019-10-29','error10','soln8',DATE '2020-09-13',73,87);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,22,50,DATE '2019-09-16','error7','soln8',DATE '2020-10-11',95,39);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,10,4,DATE '2019-03-05','error7','soln10',DATE '2020-06-30',27,73);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,27,43,DATE '2019-10-29','error9','soln4',DATE '2020-03-22',67,5);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,10,2,DATE '2019-09-16','error8','soln4',DATE '2020-06-17',77,5);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,3,1,DATE '2019-03-05','error8','soln1',DATE '2020-08-06',2,77);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,21,33,DATE '2019-10-29','error9','soln4',DATE '2020-04-09',7,80);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,38,23,DATE '2019-09-16','error9','soln3',DATE '2020-05-29',90,19);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,20,8,DATE '2019-03-05','error3','soln10',DATE '2020-07-04',93,22);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,18,9,DATE '2019-10-29','error7','soln2',DATE '2020-07-01',94,85);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,39,50,DATE '2019-09-16','error2','soln4',DATE '2020-10-11',39,78);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,8,44,DATE '2019-03-05','error7','soln3',DATE '2020-05-04',45,45);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,39,43,DATE '2019-10-29','error10','soln10',DATE '2020-01-18',59,6);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,40,45,DATE '2019-09-16','error2','soln9',DATE '2020-01-17',35,9);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,40,9,DATE '2019-03-05','error7','soln10',DATE '2020-03-16',69,10);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,46,16,DATE '2019-10-29','error2','soln8',DATE '2020-01-09',25,100);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,44,21,DATE '2019-09-16','error8','soln3',DATE '2020-04-20',68,69);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,45,23,DATE '2019-03-05','error6','soln4',DATE '2020-10-31',26,64);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,8,35,DATE '2019-10-29','error10','soln2',DATE '2020-10-15',28,100);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,33,6,DATE '2019-09-16','error2','soln8',DATE '2020-03-28',39,43);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,36,4,DATE '2019-03-05','error10','soln7',DATE '2020-09-17',65,5);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,12,8,DATE '2019-10-29','error10','soln5',DATE '2020-03-18',46,26);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,13,32,DATE '2019-09-16','error2','soln5',DATE '2020-04-17',4,18);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,13,23,DATE '2019-03-05','error9','soln3',DATE '2020-09-25',60,43);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,30,28,DATE '2019-10-29','error3','soln8',DATE '2020-09-11',94,72);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,2,16,DATE '2019-09-16','error8','soln10',DATE '2020-06-23',82,98);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,22,40,DATE '2019-03-05','error9','soln7',DATE '2020-08-21',51,75);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,8,28,DATE '2019-10-29','error7','soln8',DATE '2020-04-30',79,60);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,22,16,DATE '2019-09-16','error7','soln7',DATE '2020-01-20',43,100);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,7,20,DATE '2019-03-05','error6','soln9',DATE '2020-02-02',21,72);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,46,45,DATE '2019-10-29','error10','soln5',DATE '2020-06-08',68,97);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,39,11,DATE '2019-09-16','error9','soln4',DATE '2020-09-04',40,55);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,10,47,DATE '2019-03-05','error3','soln8',DATE '2020-11-08',21,49);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,46,36,DATE '2019-10-29','error7','soln8',DATE '2020-05-11',89,10);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,32,14,DATE '2019-09-16','error8','soln7',DATE '2020-11-22',16,40);
INSERT INTO warranty_ticket VALUES (WartickID_seq.NEXTVAL,11,17,DATE '2019-03-05','error1','soln5',DATE '2020-08-25',89,74);




INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Y-find',1893.86,'32');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Mat Lam Tam',3128.44,'27');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Vagram',7789.37,'47');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Holdlamis',4468.28,'40');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Gembucket',4239.74,'99');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Konklux',1307.58,'45');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Home Ing',1377.85,'77');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Zoolab',3170.43,'95');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Flowdesk',7343.04,'61');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Otcom',4842.06,'22');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Cardguard',1736.66,'75');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Ventosanzap',2123.5,'75');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Ronstring',6559.86,'57');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Fintone',8847.45,'18');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Cardify',1009.89,'86');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Rank',1890.85,'45');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'It',4797.62,'29');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Stringtough',1110.83,'73');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Sonsing',9161.85,'44');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Stronghold',1841.67,'53');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Zaam-Dox',8937.5,'34');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Ventosanzap',3949.99,'77');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Bitwolf',2449.97,'53');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Overhold',3848.17,'6');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Namfix',93.07,'77');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Mat Lam Tam',992.33,'46');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Cardguard',1089,'75');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Voltsillam',2300.46,'100');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Holdlamis',3437.37,'69');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Zoolab',9360.51,'32');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Zontrax',2627.26,'20');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Namfix',3215.62,'81');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Subin',7041.05,'63');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Stringtough',8488.89,'90');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Zamit',4765.22,'8');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Konklab',6145.7,'61');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Wrapsafe',3575.34,'27');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Konklux',4917.68,'65');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Greenlam',4158.53,'45');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Greenlam',9682.1,'59');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Greenlam',3444.81,'93');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Bitchip',2688.99,'8');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Cardify',6266.44,'57');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Voyatouch',3277.71,'76');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Prodder',8488.33,'28');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Ronstring',4319.14,'74');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Matsoft',6567.09,'84');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Temp',1384.15,'66');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Lotlux',5365.25,'45');
INSERT INTO Components VALUES (PartID_seq.NEXTVAL,'Job',2136.39,'30');




INSERT INTO Warr_comp VALUES (22,38);
INSERT INTO Warr_comp VALUES (3,23);
INSERT INTO Warr_comp VALUES (12,30);
INSERT INTO Warr_comp VALUES (50,3);
INSERT INTO Warr_comp VALUES (14,35);
INSERT INTO Warr_comp VALUES (35,6);
INSERT INTO Warr_comp VALUES (18,30);
INSERT INTO Warr_comp VALUES (7,7);
INSERT INTO Warr_comp VALUES (31,48);
INSERT INTO Warr_comp VALUES (15,41);
INSERT INTO Warr_comp VALUES (31,33);
INSERT INTO Warr_comp VALUES (31,18);
INSERT INTO Warr_comp VALUES (21,2);
INSERT INTO Warr_comp VALUES (26,31);
INSERT INTO Warr_comp VALUES (45,1);
INSERT INTO Warr_comp VALUES (25,46);
INSERT INTO Warr_comp VALUES (25,47);
INSERT INTO Warr_comp VALUES (17,3);
INSERT INTO Warr_comp VALUES (1,3);
INSERT INTO Warr_comp VALUES (3,44);
INSERT INTO Warr_comp VALUES (45,12);
INSERT INTO Warr_comp VALUES (9,14);
INSERT INTO Warr_comp VALUES (1,1);
INSERT INTO Warr_comp VALUES (26,26);
INSERT INTO Warr_comp VALUES (22,6);
INSERT INTO Warr_comp VALUES (4,6);
INSERT INTO Warr_comp VALUES (46,30);
INSERT INTO Warr_comp VALUES (45,44);
INSERT INTO Warr_comp VALUES (26,47);
INSERT INTO Warr_comp VALUES (35,21);
INSERT INTO Warr_comp VALUES (17,43);
INSERT INTO Warr_comp VALUES (17,15);
INSERT INTO Warr_comp VALUES (8,19);
INSERT INTO Warr_comp VALUES (17,38);
INSERT INTO Warr_comp VALUES (25,23);
INSERT INTO Warr_comp VALUES (8,44);
INSERT INTO Warr_comp VALUES (9,1);
INSERT INTO Warr_comp VALUES (7,33);
INSERT INTO Warr_comp VALUES (18,22);
INSERT INTO Warr_comp VALUES (12,2);
INSERT INTO Warr_comp VALUES (19,1);
INSERT INTO Warr_comp VALUES (36,31);
INSERT INTO Warr_comp VALUES (4,40);
INSERT INTO Warr_comp VALUES (6,33);
INSERT INTO Warr_comp VALUES (18,21);
INSERT INTO Warr_comp VALUES (40,19);
INSERT INTO Warr_comp VALUES (32,31);
INSERT INTO Warr_comp VALUES (36,4);
INSERT INTO Warr_comp VALUES (1,10);
INSERT INTO Warr_comp VALUES (48,46);

COMMIT;










