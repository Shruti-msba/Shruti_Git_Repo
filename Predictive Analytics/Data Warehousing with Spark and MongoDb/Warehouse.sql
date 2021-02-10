/*This section is to drop the tables.
Placed at the beginning in order to enable the script to be rerun again.
Does need to be dropped in that specific order due to primary and foreign key shenanigans.
Author: Matthew Leong
*/
--Drop table part
DROP TABLE Warr_comp;
DROP TABLE Components;
DROP TABLE warranty_ticket;
DROP TABLE Agent;
DROP TABLE WARRANTY;
DROP TABLE RETURNS;
DROP TABLE SKU_Store;
DROP TABLE Stores;
DROP TABLE Method;
DROP TABLE Reviews;
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
  RewardTier        VARCHAR(8)   NOT NULL,
  PRIMARY KEY (CustID)
);

CREATE TABLE Cards (
  CCID                  INT             NOT NULL,
  CustID                INT             NOT NULL,
  Card_Number           CHAR(16)        NOT NULL,
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
    Brand               VARCHAR(50),
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
  Price NUMBER      NOT NULL,
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
    Foreign key (sku) references Product(sku),
    foreign key (storeid) references stores(storeid)
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
    CONSTRAINT CCID_LINK_FK   FOREIGN KEY (CCID)  REFERENCES CARDS (CCID),
    CONSTRAINT GIFTID_LINK_FK   FOREIGN KEY (GiftCardID)  REFERENCES GIFT_CARDS (GiftCardID)
);


CREATE TABLE Agent
(
    AgentID            NUMBER NOT NULL,
    FirstName          VARCHAR(100) NOT NULL,
    LastName           VARCHAR(100)  NOT NULL,

    PRIMARY KEY (AgentID)
);


CREATE TABLE warranty_ticket (
  warrtickid               INT           NOT NULL,
  WarrID                   INT           NOT NULL,
  AgentID                  INT           NOT NULL,
  Issue_date               DATE NOT NULL,
  Problem                  VARCHAR(500)  NOT NULL,
  Solution                 VARCHAR(500),
  Enddate                  DATE          NOT NULL,
  Laborhours               FLOAT(20)      NOT NULL,
  Rate                     FLOAT(20)      NOT NULL,
  
  
  PRIMARY KEY (warrtickid),
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
    warrtickid          NUMBER NOT NULL,
    PartID              NUMBER NOT NULL,

    PRIMARY KEY (warrtickid,PartID),
    FOREIGN KEY (warrtickid) REFERENCES warranty_ticket(warrtickid),
    FOREIGN KEY (PartID) REFERENCES Components(PartID)
);
