/*This section is to drop the tables.
Placed at the beginning in order to enable the script to be rerun again.
Does need to be dropped in that specific order due to primary and foreign key shenanigans.
Author: Matthew Leong
*/
--Drop table part
DROP TABLE SKU_Store;
DROP TABLE Stores;
DROP TABLE Method;
DROP TABLE Reviews;
DROP TABLE Warranty;
DROP TABLE Tline;
DROP TABLE Product;
DROP TABLE Model_table;
DROP TABLE Transaction;
DROP TABLE Tax_Rate;
DROP TABLE Gift_cards;
DROP TABLE Cards;
DROP TABLE Member;

/*This section is to create the database tables.
Author: Matthew Leong
*/

--Drop Sequences incase the exist already Rehan Daya rnd477
DROP SEQUENCE CustID_seq;
DROP SEQUENCE CCID_seq;
DROP SEQUENCE TransacID_seq;
DROP SEQUENCE GiftCardID_seq;
DROP SEQUENCE CommentID_seq;
DROP SEQUENCE ModelID_seq;
DROP SEQUENCE SKU_seq;
DROP SEQUENCE TLineID_seq;
DROP SEQUENCE WarrID_seq;
DROP SEQUENCE ReviewID_seq;
DROP SEQUENCE StoreID_seq;

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

CREATE TABLE Cards (
  CCID                  INT             NOT NULL,
  CustID                INT             NOT NULL,
  Card_Number           CHAR(50)        NOT NULL,
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

CREATE TABLE TAX_RATE (
  TaxState CHAR(2),
  TaxRate FLOAT(10) NOT NULL,
  PRIMARY KEY (TaxState)
);

CREATE TABLE GIFT_CARDS (
  GiftCardID NUMBER,
  Balance NUMBER NOT NULL,
  PRIMARY KEY (GiftCardID)
);

CREATE TABLE Transaction (
  TransacID             INT         NOT NULL,
  OnlineFlag            CHAR(1)     DEFAULT 'N' NOT NULL,
  Purchase_Date         DATE        NOT NULL,
  TaxState              CHAR(2)     NOT NULL,
  CCID                  INT,
  CCAmount              FLOAT(20),
  GCAmount              FLOAT(20),
  ShippingType          VARCHAR(100),
  ShippingRate          FLOAT(2),
  CustID                INT,
  PRIMARY KEY (TransacID),
  FOREIGN KEY (CustID) REFERENCES Member(CustID),
  FOREIGN KEY (TaxState) REFERENCES Tax_Rate(TaxState),
  FOREIGN KEY (CCID) REFERENCES Cards(CCID)
);

CREATE TABLE METHOD (
  TransacID NUMBER,
  GiftCardID NUMBER,
  PRIMARY KEY (TransacID, GiftCardID),
  FOREIGN KEY (TransacID)  REFERENCES TRANSACTION (TransacID),
  FOREIGN KEY (GiftCardID) REFERENCES GIFT_CARDS (GiftCardID)
);

CREATE TABLE Model_Table
(
    ModelID             NUMBER NOT NULL,
    Name                VARCHAR(100) NOT NULL,
    Brand               VARCHAR(100),
    Length              VARCHAR(50) NOT NULL,
    Width               VARCHAR(50) NOT NULL,
    Height              VARCHAR(50) NOT NULL,
    Weight              VARCHAR(50) NOT NULL,
    Category            VARCHAR(50) NOT NULL,
    PRIMARY KEY (ModelID)
);

CREATE TABLE Product
(
    Sku                 NUMBER NOT NULL,
    ModelID             INT NOT NULL,
    Description         VARCHAR(2000),
    Color               VARCHAR(10) NOT NULL,
    Condition           VARCHAR(100) NOT NULL,
    Price               NUMBER NOT NULL,
    PRIMARY KEY (Sku),
    Foreign Key (ModelID) references Model_table(ModelID)
);


CREATE TABLE TLine (
  TLineID               INT            NOT NULL,
  TransacID             INT            NOT NULL,
  SKU                   INT            NOT NULL,
  Quantity              INT,
  UPrice                FLOAT(20)      NOT NULL,
  UDiscount             FLOAT(20),
  PRIMARY KEY (TLineID),
  FOREIGN KEY (TransacID) REFERENCES Transaction(TransacID),
  FOREIGN KEY (SKU) REFERENCES Product(SKU)
);

CREATE TABLE WARRANTY (
  WarrID NUMBER,
  TLineID NUMBER,
  Type VARCHAR(100) NOT NULL,
  Term VARCHAR(100) NOT NULL,
  Price NUMBER NOT NULL,
  PRIMARY KEY (WarrID),
  FOREIGN KEY (TLineID) REFERENCES TLINE (TLineID)
);

CREATE TABLE Reviews
(
    ReviewID          NUMBER NOT NULL,
    CustID            NUMBER NOT NULL,
    ModelID           NUMBER NOT NULL,
    Comments          VARCHAR(2000) NOT NULL,
    Rating            VARCHAR(50) NOT NULL ,
    
    PRIMARY KEY (ReviewID),
    Foreign key (CustID) references Member(CustID),
    Foreign Key (ModelID) references Model_table(modelID)
);

CREATE TABLE Stores
(
    StoreID          NUMBER NOT NULL,
    Name             VARCHAR(50) NOT NULL,
    Address          VARCHAR(200),
    City             VARCHAR(100) NOT NULL,
    State            CHAR(2) NOT NULL,
    Zip              CHAR(5) NOT NULL,
    Grade            CHAR(10) NOT NULL,
    PRIMARY KEY (StoreID) 
);

CREATE TABLE SKU_Store
(
    Sku          NUMBER NOT NULL,
    StoreID      NUMBER NOT NULL,
    Primary key (Sku, StoreID),
    Foreign key (Sku) references Product(Sku),
    Foreign key (StoreID) references stores(StoreId)
);

--Create Sequences for Primary Key IDs Rehan Daya rnd477
CREATE SEQUENCE CustID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE CCID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE GiftCardID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE TransacID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE CommentID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE ModelID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE SKU_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE TLineID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE WarrID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE ReviewID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;

CREATE SEQUENCE StoreID_seq
START WITH 1 INCREMENT BY 1
MINVALUE 1 MAXVALUE 9999;


--INSERT statements
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Mile','Kellough','253-872-6601','mkellough0@angelfire.com','234 Stang Pass','143 Carioca Pass','Tacoma','WA',58370,'Y',573,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Honey','Collie','484-113-7105','hcollie1@cbslocal.com','830 Fuller Street','81025 Mandrake Alley','Valley Forge','PA',99235,'Y',84,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Tobye','Vasechkin','646-799-1770','tvasechkin2@skyrock.com','553 Fuller Road','194 Eastwood Court','New York City','NY',73819,'Y',912,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carroll','Dewdney','847-729-1729','cdewdney3@washingtonpost.com','88809 Dawn Court','17789 Montana Street','Chicago','IL',39560,'N',892,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Annalee','Aleksankov','251-419-4454','aaleksankov4@com.com','00008 Blackbird Crossing','76934 Hanover Hill','Mobile','AL',96808,'N',306,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Marylee','Kyles','727-721-3879','mkyles5@symantec.com','25 Hayes Junction','25 Oakridge Crossing','Clearwater','FL',12867,'Y',471,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Boigie','Brentnall','336-935-0580','bbrentnall6@imageshack.us','70 Sachs Terrace','0 Doe Crossing Lane','Winston Salem','NC',29556,'N',64,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Raphael','Seamarke','678-599-5321','rseamarke7@yellowpages.com','0087 Dahle Court','0436 Talmadge Terrace','Lawrenceville','GA',63411,'Y',489,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Gallagher','Guerry','212-360-5943','gguerry8@si.edu','29545 Doe Crossing Lane','22119 Commercial Center','New York City','NY',69142,'Y',33,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Cathlene','Borrie','907-741-9543','cborrie9@spotify.com','1388 Eastwood Lane','62338 Veith Center','Anchorage','AK',33271,'N',723,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carter','Prettyman','239-203-0384','cprettymana@is.gd','5519 Kenwood Junction','347 Carey Court','Naples','FL',39157,'N',34,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bennie','Fransinelli','573-568-5295','bfransinellib@cbsnews.com','7181 Commercial Street','98 Autumn Leaf Way','Columbia','MO',35118,'N',237,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Alaster','Aphale','916-167-0374','aaphalec@tamu.edu','39180 Service Point','6846 Haas Point','Sacramento','CA',36402,'N',636,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Helli','Marzellano','850-111-3602','hmarzellanod@wp.com','6314 Weeping Birch Center','44741 Canary Terrace','Pensacola','FL',43548,'N',209,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Renee','Gatward','937-682-3645','rgatwarde@who.int','8 Florence Center','56032 Morningstar Crossing','Hamilton','OH',84744,'N',512,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Kahlil','Groven','908-931-2267','kgrovenf@paginegialle.it','381 Upham Crossing','45819 Vera Terrace','Elizabeth','NJ',23452,'N',444,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Austin','Hallowell','832-694-3370','ahallowellg@theguardian.com','2 Fordem Junction','539 Rigney Avenue','Houston','TX',55311,'N',341,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Paulette','Fink','850-724-7381','pfinkh@state.gov','3432 Farragut Way','01960 Ramsey Trail','Pensacola','FL',60808,'Y',44,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Windy','Sandeman','334-401-2194','wsandemani@cocolog-nifty.com','5729 Service Pass','9 Shelley Center','Montgomery','AL',20596,'N',661,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Quentin','Haberjam','610-561-3317','qhaberjamj@businessweek.com','03 Browning Street','213 Namekagon Crossing','Reading','PA',18325,'N',94,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Mavra','Meneur','330-703-1932','mmeneurk@samsung.com','13065 Sachtjen Alley','75 Longview Center','Canton','OH',62154,'N',750,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Clywd','Carlesi','336-256-0405','ccarlesil@issuu.com','73575 Namekagon Road','496 Burning Wood Center','Greensboro','NC',13006,'Y',274,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Chryste','Apdell','254-854-3045','capdellm@clickbank.net','1 Gerald Avenue','490 Coolidge Trail','Waco','TX',88976,'Y',58,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Tadeo','Szymoni','561-519-8360','tszymonin@constantcontact.com','8149 Grim Center','30 Hansons Trail','West Palm Beach','FL',99584,'N',960,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Joy','Gurnay','323-546-2528','jgurnayo@census.gov','7 Sundown Center','8514 4th Circle','Los Angeles','CA',48244,'Y',252,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Nannie','Prigg','318-595-2223','npriggp@youtu.be','44517 Myrtle Hill','571 Corry Lane','Shreveport','LA',76528,'Y',24,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Antons','Pigeon','410-645-2433','apigeonq@blogtalkradio.com','4205 Cherokee Lane','9 Sommers Park','Baltimore','MD',76780,'N',806,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Alane','Perigoe','520-624-7645','aperigoer@dmoz.org','323 Manley Plaza','27 Glendale Terrace','Tucson','AZ',65577,'Y',821,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Judd','Assard','865-199-1878','jassards@privacy.gov.au','9 Debs Lane','84 Ruskin Street','Knoxville','TN',59416,'Y',938,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Angela','Gross','501-573-4258','agrosst@upenn.edu','9774 Myrtle Avenue','94 Ilene Point','Little Rock','AR',16238,'Y',620,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bibbye','O''Codihie','585-595-3970','bocodihieu@xinhuanet.com','876 Shelley Trail','2 Lyons Avenue','Rochester','NY',73547,'N',105,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Cobbie','Zuanazzi','215-504-0864','czuanazziv@dropbox.com','1590 Corry Point','80 Oak Valley Court','Philadelphia','PA',13955,'N',339,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Cathe','Lesley','504-208-1035','clesleyw@creativecommons.org','8 Anhalt Street','810 Stone Corner Place','New Orleans','LA',61300,'Y',223,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Marybelle','Ballay','602-931-5436','mballayx@opera.com','84392 Stone Corner Drive','032 Forest Hill','Glendale','AZ',42381,'N',508,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Pier','Aggs','215-532-1824','paggsy@wordpress.org','4397 Lerdahl Trail','05254 Gina Alley','Philadelphia','PA',23685,'N',838,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Abdel','Hughill','323-426-9879','ahughillz@gmpg.org','99 Farmco Road','787 Talmadge Terrace','Los Angeles','CA',83646,'N',140,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Mort','Tull','786-493-0998','mtull10@storify.com','414 Pepper Wood Pass','617 International Circle','Miami','FL',88655,'N',910,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Marten','Swigger','646-938-6276','mswigger11@cyberchimps.com','294 Badeau Pass','29 Oak Place','New York City','NY',13192,'Y',767,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Constancia','Spry','203-880-5284','cspry12@rambler.ru','04228 Corben Plaza','3 Fuller Hill','Waterbury','CT',71736,'Y',295,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Christal','Stirley','405-772-9416','cstirley13@ning.com','8375 Arapahoe Road','76645 Almo Pass','Oklahoma City','OK',51582,'N',544,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bern','Humbatch','972-517-0996','bhumbatch14@nba.com','60 Center Hill','33973 Chinook Lane','Garland','TX',44378,'N',741,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Almire','Wybrow','904-390-0086','awybrow15@shareasale.com','02017 Hoard Road','117 Union Lane','Jacksonville','FL',16717,'N',342,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Ofella','Lempke','212-394-0105','olempke16@google.cn','633 Sycamore Plaza','49 Summit Lane','New York City','NY',92810,'Y',85,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Adah','Wedgwood','408-724-9031','awedgwood17@360.cn','1402 Crescent Oaks Park','8 Sommers Pass','San Jose','CA',62082,'N',173,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Orazio','Ivie','505-636-1881','oivie18@blinklist.com','78305 Killdeer Point','9 Gulseth Road','Santa Fe','NM',42926,'Y',64,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carlene','Ayars','203-641-5931','cayars19@nhs.uk','0232 East Hill','5509 Barnett Drive','Bridgeport','CT',96731,'Y',293,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Carolee','Halsho','314-951-2289','chalsho1a@china.com.cn','5467 Grover Lane','77922 Sullivan Street','Saint Louis','MO',68318,'N',903,'Standard');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Bryce','Mackison','314-844-8214','bmackison1b@jugem.jp','93 Jackson Court','17 Westerfield Court','Saint Louis','MO',35560,'N',744,'Elite+');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Raye','Sowerby','234-655-7652','rsowerby1c@google.fr','4 Rusk Hill','72 Kingsford Parkway','Canton','OH',85793,'N',902,'Elite');
INSERT INTO Member VALUES (CustID_seq.NEXTVAL,'Hillery','Mountain','254-595-1885','hmountain1d@chronoengine.com','17061 Straubel Drive','0 Tennyson Street','Gatesville','TX',87713,'N',774,'Standard');

COMMIT;

INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,1,3538174289402520,'31-Dec-23','9318 Dovetail Street','MT','Bozeman',90413,650,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,2,5610001964862100000,'30-Aug-21','61 Fair Oaks Drive','CT','Bridgeport',79767,868,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,3,3583513350393540,'09-Jun-25','57 Transport Center','TX','Austin',85047,810,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,4,3534006824763610,'20-May-29','97617 Mallard Circle','NC','Asheville',84740,111,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,5,3554727995417430,'04-Dec-21','79 Mosinee Place','MN','Minneapolis',24625,499,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,6,3556024980477120,'17-Oct-29','966 American Ash Parkway','AL','Mobile',10498,346,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,7,6333585437618080000,'20-Aug-22','0 Elgar Road','MT','Helena',62965,506,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,8,560222210324923000,'13-Feb-25','70 5th Alley','MN','Duluth',74884,953,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,9,3564234735850840,'05-Feb-24','12 Granby Circle','WI','Green Bay',60089,606,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,10,4041378411592020,'15-Jun-27','46 Spaight Point','NC','CHARlotte',21792,414,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,11,3553758518942910,'03-Oct-27','078 Parkside Place','FL','Lakeland',72722,685,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,12,3576808355868980,'03-Jun-20','5894 Fulton Point','IN','Evansville',11071,963,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,13,5167626780111220,'30-May-22','7 Fairview Trail','DC','Washington',75560,630,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,14,3575895311209900,'26-Sep-27','5191 Petterle Alley','TX','Fort Worth',39578,191,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,15,3541295519711150,'02-Feb-30','88 Logan Court','MO','Kansas City',22059,275,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,16,50200610189105000,'10-Oct-20','637 Erie Way','MO','Saint Louis',19563,636,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,17,3563168616957500,'30-Jan-21','8696 Bartillon Plaza','CA','Sacramento',27602,123,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,18,3556755394908550,'18-Aug-20','1 Morning Terrace','WA','Spokane',42736,768,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,19,3533500487828480,'27-Mar-28','400 Delladonna Center','NY','Rochester',66450,954,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,20,4913668658652380,'06-Dec-20','40980 Merry Parkway','CA','Fresno',91386,563,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,21,3538173446498570,'20-Jan-30','589 Northfield Street','MI','Lansing',57288,346,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,22,5100173015180640,'23-Dec-21','625 Nobel Crossing','NC','Durham',44023,306,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,23,3556393022293150,'29-Apr-20','84 Macpherson Lane','ID','Boise',74708,880,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,24,374288200770740,'22-Sep-24','320 Towne Junction','CA','Long Beach',38928,213,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,25,3553299999479960,'25-Mar-21','8311 Bellgrove Point','PA','Reading',91069,376,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,26,3577407341728970,'23-Sep-26','27 Dakota Hill','MI','Warren',30787,480,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,27,374622536273906,'18-Jan-25','75 Sunfield Junction','CA','Los Angeles',30562,829,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,28,5602210997730570,'10-Jan-23','97 Londonderry Drive','TN','Chattanooga',28418,834,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,29,3545159132049610,'21-May-28','0 Elka Alley','NM','Albuquerque',90084,565,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,30,5048377367846370,'04-Sep-22','13 Butternut Plaza','UT','Provo',55256,988,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,31,371535710872199,'09-Dec-24','67 Elka Alley','AZ','Phoenix',40263,476,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,32,3557559882633090,'22-Apr-26','1509 Hansons Lane','CA','Pomona',95100,791,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,33,5007662004001610,'17-Jul-28','1238 Continental Street','CA','San Diego',94029,859,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,34,3529380792286440,'10-Apr-28','6 Westport Trail','NY','New York City',29241,164,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,35,201844860256039,'20-Oct-27','25 Myrtle Parkway','TX','Corpus Christi',65654,189,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,36,3560398585786410,'26-Apr-21','8858 Calypso Terrace','FL','Fort Lauderdale',81355,976,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,37,5108753040803150,'25-Nov-29','3 Bartelt Hill','FL','Boca Raton',57677,725,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,38,4017952684529230,'11-Mar-21','64794 Quincy Terrace','TX','Fort Worth',97677,570,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,39,3554325328850120,'08-Feb-29','360 Coleman Lane','DC','Washington',91741,805,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,40,3573285954119860,'24-Oct-21','95 Morningstar Trail','CO','Colorado Springs',29156,312,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,41,6389611740878710,'28-Jun-22','12066 Eastlawn Center','CA','Sacramento',20198,751,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,42,3529611409909400,'15-Jul-22','93 Garrison Place','PA','Johnstown',23208,741,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,43,3575999732824040,'04-Jul-30','23 Trailsway Junction','TN','Nashville',85984,312,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,44,490570984036268000,'15-Jan-20','7244 Beilfuss Crossing','GA','Augusta',28732,802,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,45,4017950072806890,'26-Feb-30','8 Eagle Crest Place','CA','San Francisco',77372,297,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,46,5602225920988970,'29-Nov-23','5791 Elka Park','MA','Boston',92447,659,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,47,4905607167588640000,'08-Feb-30','3828 Pine View Road','AL','Birmingham',14254,204,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,48,3581917125259330,'21-Jan-25','73920 Vermont Street','OH','Cleveland',53288,547,'Y');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,49,3574134230709620,'30-Sep-21','7 Hansons Alley','FL','Ocala',74469,632,'N');
INSERT INTO Cards VALUES (CCID_seq.NEXTVAL,50,3579991375032630,'14-May-28','6 Loeprich Way','LA','New Orleans',52257,582,'N');


COMMIT;

INSERT INTO Tax_Rate VALUES ('AL',0.18);
INSERT INTO Tax_Rate VALUES ('AK',0.06);
INSERT INTO Tax_Rate VALUES ('AZ',0.01);
INSERT INTO Tax_Rate VALUES ('AR',0.11);
INSERT INTO Tax_Rate VALUES ('CA',0.1);
INSERT INTO Tax_Rate VALUES ('CO',0.11);
INSERT INTO Tax_Rate VALUES ('CT',0.13);
INSERT INTO Tax_Rate VALUES ('DE',0.11);
INSERT INTO Tax_Rate VALUES ('FL',0.19);
INSERT INTO Tax_Rate VALUES ('GA',0.1);
INSERT INTO Tax_Rate VALUES ('HI',0.05);
INSERT INTO Tax_Rate VALUES ('ID',0.12);
INSERT INTO Tax_Rate VALUES ('IL',0.02);
INSERT INTO Tax_Rate VALUES ('IN',0.02);
INSERT INTO Tax_Rate VALUES ('IA',0.09);
INSERT INTO Tax_Rate VALUES ('KS',0.14);
INSERT INTO Tax_Rate VALUES ('KY',0.17);
INSERT INTO Tax_Rate VALUES ('LA',0.14);
INSERT INTO Tax_Rate VALUES ('ME',0.2);
INSERT INTO Tax_Rate VALUES ('MD',0.13);
INSERT INTO Tax_Rate VALUES ('MA',0.09);
INSERT INTO Tax_Rate VALUES ('MI',0.19);
INSERT INTO Tax_Rate VALUES ('MN',0.11);
INSERT INTO Tax_Rate VALUES ('MS',0.04);
INSERT INTO Tax_Rate VALUES ('MO',0.07);
INSERT INTO Tax_Rate VALUES ('MT',0.03);
INSERT INTO Tax_Rate VALUES ('NE',0.08);
INSERT INTO Tax_Rate VALUES ('NV',0.04);
INSERT INTO Tax_Rate VALUES ('NH',0.17);
INSERT INTO Tax_Rate VALUES ('NJ',0.04);
INSERT INTO Tax_Rate VALUES ('NM',0.14);
INSERT INTO Tax_Rate VALUES ('NY',0.12);
INSERT INTO Tax_Rate VALUES ('NC',0.19);
INSERT INTO Tax_Rate VALUES ('ND',0.03);
INSERT INTO Tax_Rate VALUES ('OH',0.09);
INSERT INTO Tax_Rate VALUES ('OK',0.16);
INSERT INTO Tax_Rate VALUES ('OR',0.06);
INSERT INTO Tax_Rate VALUES ('PA',0.01);
INSERT INTO Tax_Rate VALUES ('RI',0.12);
INSERT INTO Tax_Rate VALUES ('SC',0.12);
INSERT INTO Tax_Rate VALUES ('SD',0.13);
INSERT INTO Tax_Rate VALUES ('TN',0.04);
INSERT INTO Tax_Rate VALUES ('TX',0.03);
INSERT INTO Tax_Rate VALUES ('UT',0.1);
INSERT INTO Tax_Rate VALUES ('VT',0.1);
INSERT INTO Tax_Rate VALUES ('VA',0.05);
INSERT INTO Tax_Rate VALUES ('WA',0.08);
INSERT INTO Tax_Rate VALUES ('WV',0.2);
INSERT INTO Tax_Rate VALUES ('WI',0.18);
INSERT INTO Tax_Rate VALUES ('WY',0.16);


COMMIT;



INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,221);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,146);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,634);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,218);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,909);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,470);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,557);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,43);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,192);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,866);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,35);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,464);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,513);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,143);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,445);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,3);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,776);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,935);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,384);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,387);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,382);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,955);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,747);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,328);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,908);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,198);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,90);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,529);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,28);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,576);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,888);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,659);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,212);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,300);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,80);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,789);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,789);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,424);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,149);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,735);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,744);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,889);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,704);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,126);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,448);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,125);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,363);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,466);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,901);
INSERT INTO Gift_Cards VALUES (GiftCardID_seq.NEXTVAL,149);


COMMIT;

INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','29-Dec-19','NC',1,812,287,'Scheduled',0.06,1);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','07-Aug-20','KS',2,46,771,'Scheduled',0.03,2);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','20-Jul-20','VA',3,930,199,'2-day',0.03,3);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','07-Nov-20','TX',4,496,891,'2-day',0.03,4);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','14-May-20','NM',5,771,23,'Scheduled',0.06,5);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','24-Nov-19','IA',6,575,644,'2-day',0.1,6);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','15-Jun-20','CA',7,4,748,'Scheduled',0.03,7);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','05-Dec-19','MA',8,311,38,'Scheduled',0.1,8);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','19-Jul-20','NC',9,263,658,'Scheduled',0.03,9);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','04-Sep-20','OK',10,117,568,'Standard',0.06,10);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','15-Jul-20','MT',11,797,599,'Scheduled',0.03,11);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','13-Oct-20','FL',12,816,322,'2-day',0.03,12);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','05-Feb-20','TX',13,44,515,'2-day',0.03,13);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','04-Sep-20','TX',14,941,989,'Standard',0.06,14);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','09-Jul-20','WY',15,706,348,'Standard',0.03,15);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','28-Jan-20','UT',16,265,307,'Scheduled',0.06,16);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','01-Jan-20','AZ',17,779,171,'2-day',0.06,17);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','07-Nov-20','NY',18,672,921,'2-day',0.06,18);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','19-Oct-20','DC',19,949,273,'Standard',0.1,19);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','13-Apr-20','TX',20,250,165,'Scheduled',0.06,20);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','22-Apr-20','NY',21,137,202,'Standard',0.1,21);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','13-Aug-20','IL',22,30,258,'Standard',0.1,22);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','08-Nov-20','FL',23,291,742,'Scheduled',0.06,23);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','09-Feb-20','MO',24,519,509,'2-day',0.03,24);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','14-Dec-19','IL',25,375,776,'2-day',0.1,25);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','16-Apr-20','TX',26,78,642,'Standard',0.03,26);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','30-May-20','CO',27,582,289,'2-day',0.06,27);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','25-Aug-20','CA',28,633,354,'2-day',0.06,28);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','23-Jul-20','MO',29,837,989,'Standard',0.1,29);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','22-Aug-20','OH',30,41,749,'2-day',0.1,30);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','05-Jun-20','HI',31,617,25,'2-day',0.06,31);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','04-May-20','KS',32,112,11,'Standard',0.03,32);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','12-Jun-20','FL',33,803,758,'Scheduled',0.1,33);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','21-Aug-20','CA',34,305,539,'Standard',0.06,34);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','12-Aug-20','MA',35,373,848,'Scheduled',0.1,35);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','21-Jul-20','MT',36,29,623,'Standard',0.03,36);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','16-Dec-19','MA',37,213,884,'Standard',0.1,37);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','10-Feb-20','VA',38,648,818,'Standard',0.06,38);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','08-Feb-20','CA',39,482,208,'Standard',0.1,39);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','28-May-20','CA',40,919,279,'2-day',0.1,40);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','29-Aug-20','PA',41,542,173,'Standard',0.03,41);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','06-Sep-20','CT',42,788,679,'Standard',0.06,42);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','15-Apr-20','TX',43,754,701,'2-day',0.1,43);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','07-Aug-20','FL',44,381,156,'2-day',0.03,44);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','27-Apr-20','IL',45,823,347,'Standard',0.1,45);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','27-Nov-19','MO',46,188,134,'Scheduled',0.1,46);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','04-May-20','TX',47,724,152,'Scheduled',0.1,47);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','08-Jun-20','GA',48,586,745,'Scheduled',0.03,48);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'N','13-May-20','AZ',49,160,600,'Scheduled',0.06,49);
INSERT INTO Transaction VALUES (TransacID_seq.NEXTVAL,'Y','13-Jun-20','NY',50,833,243,'Standard',0.1,50);


COMMIT;

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

COMMIT;

INSERT INTO Product VALUES (SKU_seq.NEXTVAL,1,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.','Blue','New',438);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,2,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.','Goldenrod','New',727);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,3,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.','Indigo','Used',372);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,4,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.','Pink','Refurbished',526);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,5,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','Yellow','Refurbished',715);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,6,'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.','Indigo','Used',763);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,7,'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.','Teal','Used',385);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,8,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.','Teal','Refurbished',360);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,9,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.','Indigo','Used',272);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,10,'Donec posuere metus vitae ipsum. Aliquam non mauris.','Indigo','Used',31);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,11,'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','Violet','Used',119);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,12,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.','Puce','New',966);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,13,'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','Teal','New',786);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,14,'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.','Turquoise','Refurbished',734);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,15,'Nulla suscipit ligula in lacus.','Puce','Refurbished',999);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,16,'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.','Puce','Refurbished',305);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,17,'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Maroon','Used',170);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,18,'Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.','Indigo','New',873);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,19,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.','Purple','New',603);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,20,'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.','Goldenrod','Used',796);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,21,'Donec dapibus. Duis at velit eu est congue elementum.','Blue','New',877);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,22,'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.','Turquoise','Used',294);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,23,'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.','Orange','Used',370);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,24,'Donec ut mauris eget massa tempor convallis.','Fuscia','New',163);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,25,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.','Khaki','New',44);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,26,'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.','Blue','New',353);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,27,'Sed sagittis.','Crimson','Used',352);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,28,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.','Purple','New',825);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,29,'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','Violet','Used',604);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,30,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.','Puce','Used',959);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,31,'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.','Blue','Refurbished',492);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,32,'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','Red','Refurbished',798);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,33,'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.','Purple','New',245);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,34,'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.','Red','Refurbished',736);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,35,'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.','Blue','Used',352);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,36,'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.','Pink','Refurbished',607);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,37,'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.','Violet','Used',268);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,38,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.','Maroon','New',45);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,39,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.','Fuscia','New',140);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,40,'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.','Mauv','New',674);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,41,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.','Indigo','Used',522);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,42,'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.','Fuscia','New',394);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,43,'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.','Indigo','Used',574);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,44,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.','Fuscia','Used',351);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,45,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.','Blue','New',20);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,46,'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Yellow','Refurbished',406);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,47,'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.','Yellow','New',631);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,48,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.','Red','Refurbished',294);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,49,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.','Blue','Refurbished',986);
INSERT INTO Product VALUES (SKU_seq.NEXTVAL,50,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.','Khaki','Refurbished',308);


COMMIT;


INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,1,1,483,589,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,2,2,301,536,0.34);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,3,3,695,107,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,4,4,891,533,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,5,5,12,806,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,6,6,813,480,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,7,7,408,854,0.17);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,8,8,211,702,0.5);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,9,9,367,821,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,10,10,401,841,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,11,11,106,898,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,12,12,290,968,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,13,13,388,446,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,14,14,698,917,0.15);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,15,15,972,846,0.43);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,16,16,975,321,0.32);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,17,17,2,91,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,18,18,36,42,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,19,19,488,747,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,20,20,841,810,0.21);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,21,21,321,106,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,22,22,20,335,0.26);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,23,23,671,417,0.18);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,24,24,539,361,0.47);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,25,25,805,366,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,26,26,768,391,0.32);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,27,27,614,763,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,28,28,486,979,0.24);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,29,29,515,753,0.1);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,30,30,171,371,0.16);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,31,31,214,74,0.35);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,32,32,460,601,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,33,33,924,447,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,34,34,271,997,0.36);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,35,35,742,452,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,36,36,834,833,0.18);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,37,37,901,505,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,38,38,199,115,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,39,39,121,437,0.42);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,40,40,595,412,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,41,41,704,33,0.15);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,42,42,146,766,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,43,43,179,180,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,44,44,596,136,0);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,45,45,972,543,0.06);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,46,46,188,279,0.42);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,47,47,837,675,0.23);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,48,48,507,161,0.08);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,49,49,84,556,0.38);
INSERT INTO TLine VALUES (TLineID_seq.NEXTVAL,50,50,520,3,0);


COMMIT;

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


COMMIT;


INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,1,1,'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.',3);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,2,2,'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',3);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,3,3,'Suspendisse potenti. Cras in purus eu magna vulputate luctus.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,4,4,'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,5,5,'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,6,6,'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',3);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,7,7,'Morbi a ipsum.',3);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,8,8,'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,9,9,'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,10,10,'Pellentesque at nulla.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,11,11,'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,12,12,'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.',3);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,13,13,'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,14,14,'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,15,15,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,16,16,'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,17,17,'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,18,18,'Aliquam erat volutpat. In congue.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,19,19,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,20,20,'Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,21,21,'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,22,22,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,23,23,'Nunc purus. Phasellus in felis. Donec semper sapien a libero.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,24,24,'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,25,25,'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,26,26,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,27,27,'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,28,28,'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,29,29,'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,30,30,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,31,31,'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,32,32,'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,33,33,'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.',3);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,34,34,'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,35,35,'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,36,36,'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,37,37,'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,38,38,'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,39,39,'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,40,40,'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,41,41,'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,42,42,'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.',3);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,43,43,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,44,44,'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.',4);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,45,45,'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,46,46,'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',1);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,47,47,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.',2);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,48,48,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,49,49,'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.',5);
INSERT INTO Reviews VALUES (ReviewID_seq.NEXTVAL,50,50,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',4);



COMMIT;


INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'SNES BestBuy','55018 Hagan Center','West Palm Beach','FL',66578,'C');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'SPKE BestBuy','125 Kropf Way','Milwaukee','WI',45957,'C');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'TRUE BestBuy','890 Bobwhite Street','Inglewood','CA',18653,'A');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'EPD BestBuy','446 Shasta Trail','Miami','FL',64984,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'PPSI BestBuy','95 Susan Park','Clearwater','FL',96875,'E');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'CNX BestBuy','70504 Express Pass','Columbia','SC',10169,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'FCE.A BestBuy','2 Old Shore Road','Tulsa','OK',76962,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'WIX BestBuy','1 Sachtjen Terrace','Nashville','TN',43669,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'HGH BestBuy','788 South Lane','Tucson','AZ',96306,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'DIN BestBuy','90270 Katie Junction','Tulsa','OK',71022,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'THLD BestBuy','320 Barby Parkway','Reading','PA',36285,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'DLB BestBuy','8085 Kingsford Junction','Greenville','SC',52848,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'TZOO BestBuy','320 Kingsford Street','San Antonio','TX',98504,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'AIC BestBuy','8 Derek Hill','Arlington','VA',57695,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'ZNWAA BestBuy','302 Anhalt Pass','Long Beach','CA',99134,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'MKL BestBuy','13 Nevada Terrace','Ocala','FL',63907,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'GLOB BestBuy','3 Eastlawn Crossing','Oklahoma City','OK',79678,'E');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'ANDAR BestBuy','32 Jenifer Alley','Denver','CO',60478,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'RCL BestBuy','6176 Sycamore Plaza','Chicago','IL',38370,'E');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'MLM BestBuy','16124 Grasskamp Pass','Chicago','IL',70505,'E');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'SVA BestBuy','366 Waxwing Crossing','Flushing','NY',65482,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'VAR BestBuy','69 Esker Pass','Phoenix','AZ',39769,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'INPX BestBuy','3613 Jana Crossing','East Saint Louis','IL',67997,'E');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'BFO BestBuy','60610 Bunker Hill Drive','Saint Petersburg','FL',40806,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'GRVY BestBuy','34 Rigney Place','Arlington','VA',75776,'E');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'DCT BestBuy','541 Mallard Trail','Orlando','FL',53143,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'HMNY BestBuy','793 Cordelia Junction','San Antonio','TX',48758,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'MSEX BestBuy','3 Gina Center','Greensboro','NC',47826,'C');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'SPWH BestBuy','046 Roxbury Crossing','Newark','NJ',57753,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'ADMS BestBuy','909 Nevada Park','Shreveport','LA',80242,'E');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'VIVO BestBuy','27 Claremont Avenue','Boise','ID',68510,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'OEC BestBuy','6 Cody Junction','Muncie','IN',78403,'C');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'OTEL BestBuy','28478 Starling Terrace','New Haven','CT',74255,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'HIG.WS BestBuy','651 Hoard Trail','Akron','OH',49728,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'SPB            BestBuy','549 Gina Crossing','Topeka','KS',82129,'C');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'BGIO BestBuy','1297 Pawling Street','Paterson','NJ',51568,'A');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'PEN BestBuy','39593 Fisk Parkway','Beaverton','OR',51140,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'INO BestBuy','562 Elgar Park','Richmond','VA',16837,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'CIO BestBuy','33272 Coleman Pass','Chula Vista','CA',52062,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'MSG BestBuy','31629 Homewood Street','Minneapolis','MN',52662,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'EMES BestBuy','0508 Hansons Court','Las Vegas','NV',44378,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'EQIX BestBuy','262 Summit Plaza','Panama City','FL',99111,'A');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'LANDP BestBuy','04108 Londonderry Trail','Las Vegas','NV',25272,'B');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'VLY BestBuy','9 Pine View Lane','Pittsburgh','PA',67950,'F');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'BIVV BestBuy','9691 Leroy Avenue','Atlanta','GA',42991,'A');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'KFN^ BestBuy','1 Algoma Lane','Salt Lake City','UT',80035,'A');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'NGLS^A BestBuy','66300 Algoma Terrace','Santa Monica','CA',24181,'C');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'OLP BestBuy','4473 Eastlawn Trail','Dearborn','MI',61108,'A');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'ATRI BestBuy','927 Sutteridge Road','Chicago','IL',35828,'D');
INSERT INTO Stores VALUES (StoreID_seq.NEXTVAL,'FMS BestBuy','43690 Ronald Regan Terrace','San Francisco','CA',66954,'B');



COMMIT;

INSERT INTO Method VALUES (1,1);
INSERT INTO Method VALUES (2,2);
INSERT INTO Method VALUES (3,3);
INSERT INTO Method VALUES (4,4);
INSERT INTO Method VALUES (5,5);
INSERT INTO Method VALUES (6,6);
INSERT INTO Method VALUES (7,7);
INSERT INTO Method VALUES (8,8);
INSERT INTO Method VALUES (9,9);
INSERT INTO Method VALUES (10,10);
INSERT INTO Method VALUES (11,11);
INSERT INTO Method VALUES (12,12);
INSERT INTO Method VALUES (13,13);
INSERT INTO Method VALUES (14,14);
INSERT INTO Method VALUES (15,15);
INSERT INTO Method VALUES (16,16);
INSERT INTO Method VALUES (17,17);
INSERT INTO Method VALUES (18,18);
INSERT INTO Method VALUES (19,19);
INSERT INTO Method VALUES (20,20);
INSERT INTO Method VALUES (21,21);
INSERT INTO Method VALUES (22,22);
INSERT INTO Method VALUES (23,23);
INSERT INTO Method VALUES (24,24);
INSERT INTO Method VALUES (25,25);
INSERT INTO Method VALUES (26,26);
INSERT INTO Method VALUES (27,27);
INSERT INTO Method VALUES (28,28);
INSERT INTO Method VALUES (29,29);
INSERT INTO Method VALUES (30,30);
INSERT INTO Method VALUES (31,31);
INSERT INTO Method VALUES (32,32);
INSERT INTO Method VALUES (33,33);
INSERT INTO Method VALUES (34,34);
INSERT INTO Method VALUES (35,35);
INSERT INTO Method VALUES (36,36);
INSERT INTO Method VALUES (37,37);
INSERT INTO Method VALUES (38,38);
INSERT INTO Method VALUES (39,39);
INSERT INTO Method VALUES (40,40);
INSERT INTO Method VALUES (41,41);
INSERT INTO Method VALUES (42,42);
INSERT INTO Method VALUES (43,43);
INSERT INTO Method VALUES (44,44);
INSERT INTO Method VALUES (45,45);
INSERT INTO Method VALUES (46,46);
INSERT INTO Method VALUES (47,47);
INSERT INTO Method VALUES (48,48);
INSERT INTO Method VALUES (49,49);
INSERT INTO Method VALUES (50,50);


COMMIT;

INSERT INTO SKU_Store VALUES (1,1);
INSERT INTO SKU_Store VALUES (2,2);
INSERT INTO SKU_Store VALUES (3,3);
INSERT INTO SKU_Store VALUES (4,4);
INSERT INTO SKU_Store VALUES (5,5);
INSERT INTO SKU_Store VALUES (6,6);
INSERT INTO SKU_Store VALUES (7,7);
INSERT INTO SKU_Store VALUES (8,8);
INSERT INTO SKU_Store VALUES (9,9);
INSERT INTO SKU_Store VALUES (10,10);
INSERT INTO SKU_Store VALUES (11,11);
INSERT INTO SKU_Store VALUES (12,12);
INSERT INTO SKU_Store VALUES (13,13);
INSERT INTO SKU_Store VALUES (14,14);
INSERT INTO SKU_Store VALUES (15,15);
INSERT INTO SKU_Store VALUES (16,16);
INSERT INTO SKU_Store VALUES (17,17);
INSERT INTO SKU_Store VALUES (18,18);
INSERT INTO SKU_Store VALUES (19,19);
INSERT INTO SKU_Store VALUES (20,20);
INSERT INTO SKU_Store VALUES (21,21);
INSERT INTO SKU_Store VALUES (22,22);
INSERT INTO SKU_Store VALUES (23,23);
INSERT INTO SKU_Store VALUES (24,24);
INSERT INTO SKU_Store VALUES (25,25);
INSERT INTO SKU_Store VALUES (26,26);
INSERT INTO SKU_Store VALUES (27,27);
INSERT INTO SKU_Store VALUES (28,28);
INSERT INTO SKU_Store VALUES (29,29);
INSERT INTO SKU_Store VALUES (30,30);
INSERT INTO SKU_Store VALUES (31,31);
INSERT INTO SKU_Store VALUES (32,32);
INSERT INTO SKU_Store VALUES (33,33);
INSERT INTO SKU_Store VALUES (34,34);
INSERT INTO SKU_Store VALUES (35,35);
INSERT INTO SKU_Store VALUES (36,36);
INSERT INTO SKU_Store VALUES (37,37);
INSERT INTO SKU_Store VALUES (38,38);
INSERT INTO SKU_Store VALUES (39,39);
INSERT INTO SKU_Store VALUES (40,40);
INSERT INTO SKU_Store VALUES (41,41);
INSERT INTO SKU_Store VALUES (42,42);
INSERT INTO SKU_Store VALUES (43,43);
INSERT INTO SKU_Store VALUES (44,44);
INSERT INTO SKU_Store VALUES (45,45);
INSERT INTO SKU_Store VALUES (46,46);
INSERT INTO SKU_Store VALUES (47,47);
INSERT INTO SKU_Store VALUES (48,48);
INSERT INTO SKU_Store VALUES (49,49);
INSERT INTO SKU_Store VALUES (50,50);

COMMIT;