---------------------------------------------------------------
--create database bankers;
--use bankers;
---------------------------------------------------------------
---------------------------------------------------------------
--Table: Accounts
--------------------
--Accounts	representing	all	the	accounts	and	has	the	fields	accId,	custCode,	name,	email,
--mobile,	branchCode,	accManager.	accId	is	an	auto	increment	primary	key.

CREATE TABLE `Accounts` (
  `bataccrefid` bigint(20) NOT NULL AUTO_INCREMENT,				--account number
  `batcustcode` varchar(64) NOT NULL,
  `batcustname` varchar(64) NOT NULL,
  `batcustemail` varchar(64) NOT NULL,
  `batcustmobile` varchar(20) NOT NULL,

  `batbranchcode` varchar(64) NOT NULL,
  `bataccmanager` varchar(64) DEFAULT NULL,

  `batcreateddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `batmodifieddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  `batfield1` varchar(64) DEFAULT NULL,

  PRIMARY KEY (`bataccrefid`),
  UNIQUE KEY `batcustemail_UNIQUE` (batcustemail),
  UNIQUE KEY `batcustmobile_UNIQUE` (batcustmobile)

) ENGINE=InnoDB AUTO_INCREMENT=1000000 DEFAULT CHARSET=latin1 COMMENT='Banker Account Table - BAT'

---------------------------------------------------------------
--Table: Cheques
---------------------
--Cheques	contains	all	the	cheque	transactions	and	has	the	fields	chqTransId,	accId,
--chqNumber,	partyName,	partyAccNum,	bankName,	bankCode,	amount.	chqTransId	is	an auto	increment primary key.

CREATE TABLE `Cheques` (
  `bctchqtransrefid` bigint(20) NOT NULL AUTO_INCREMENT,
  `bctbataccrefid` bigint(20) NOT NULL,
  `bctchqnumber` varchar(64) NOT NULL,
  `bctpartyname` varchar(64) NOT NULL,
  `bctpartyaccnumber` bigint(20) NOT NULL,				--party account id
  `bctbankname` varchar(128) NOT NULL,
  `bctbankcode` varchar(16) NOT NULL,
  `bctamount` DECIMAL(15,2) DEFAULT 0,

  `bctcreateddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bctmodifieddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  `bctfield1` varchar(64) DEFAULT NULL,

  PRIMARY KEY (`bctchqtransrefid`),

  KEY `FK_bctbataccrefid` (`bctbataccrefid`),
  CONSTRAINT `FK_bctbataccrefid` FOREIGN KEY (`bctbataccrefid`) REFERENCES `Accounts` (`bataccrefid`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Banker Cheques Table - BCT'

---------------------------------------------------------------
Table: Atms
---------------------
--Atms	contains	all	the	ATM	transactions	and	has	the	fields	atmTransId,	accId,	atmNumber,
--amount.	atmTransId	is	an	autoincrement	primary	key.


CREATE TABLE `Atms` (
  `batmttransrefid` bigint(20) NOT NULL AUTO_INCREMENT,
  `batmtbataccrefid` bigint(20) NOT NULL,
  `batmtmnumber` varchar(64) NOT NULL,

  `batmtamount` DECIMAL(15,2) DEFAULT 0,
  `batmtcreateddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `batmtmodifieddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `batmtfield1` varchar(64) DEFAULT NULL,

  PRIMARY KEY (`batmttransrefid`),

  KEY `FK_batmtbataccrefid` (`batmtbataccrefid`),
  CONSTRAINT `FK_batmtbataccrefid` FOREIGN KEY (`batmtbataccrefid`) REFERENCES `Accounts` (`bataccrefid`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Banker Atms Table - BATMT'

---------------------------------------------------------------

---------------------------------------------------------------
--Table: NetBankings
---------------------
--Transaction	through	internet	banking	are	stored	in	the	table	NetBankings	which	has	the
--fields	netTransId,	accId,	loginName,	partyName,	partyAccNum,	bankName,	bankCode,
--amount.	netTransId	is	an	autoincrement	primary	key.


CREATE TABLE `NetBankings` (
  `bnttransrefid` bigint(20) NOT NULL AUTO_INCREMENT,
  `bntbataccrefid` bigint(20) NOT NULL,
  `bntloginname` varchar(64) NOT NULL,
  `bntpartyname` varchar(64) NOT NULL,
  `bntpartyaccnumber` bigint(20) NOT NULL,
  `bntbankname` varchar(128) NOT NULL,
  `bntbankcode` varchar(16) NOT NULL,

  `bntamount` DECIMAL(15,2) DEFAULT 0,

  `bntmtcreateddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bntmtmodifieddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bntmtfield1` varchar(64) DEFAULT NULL,

  PRIMARY KEY (`bnttransrefid`),

  KEY `FK_bntbataccrefid` (`bntbataccrefid`),
  CONSTRAINT `FK_bntbataccrefid` FOREIGN KEY (`bntbataccrefid`) REFERENCES `Accounts` (`bataccrefid`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Banker NetBankings Table - BNT'

---------------------------------------------------------------

--Table: Transactions
---------------------

--All	the	transactions	are	also	recorded	in	the	table	Transactions	which	has	the	fields	- transId,
--accId,	type,	typeId,	typeCode,	partyName,	amount.	transId	is	an	autoincrement	primary	key.

• Type	denotes	the	type of	transaction	and	has	the	possible values	as	: Cheque,	ATM	or	NetBanking.
• TypeId:	is	chqTransId	or	atmTransId	or	netTransId
• TypeCode	is	chqNumber	or	atmNumber	or	loginName in case netbanking
• PartyName	is	the	same	as	partyName	in	Cheques	and	NetBankings. In	the	case of	ATM	 transaction it	will be	Self.


CREATE TABLE `Transactions` (

  `btttransrefid` bigint(20) NOT NULL AUTO_INCREMENT,
  `bttbataccrefid` bigint(20) NOT NULL,
  `btttype` enum('CHEQUE','ATM','NETBANKING') NOT NULL,
  `btttypeid` bigint(20) NOT NULL,			/*(chqTransId	or	atmTransId	or	netTransId)*/

  `btttypecode` varchar(64) NOT NULL,		/*(chqNumber	or	atmNumber	or	atmNumber in case netbanking)*/

  `bttpartyname` varchar(64) NOT NULL,      /*(partyName in Cheques	or	NetBankings	or	Self in case of ATM transaction)*/

  `bttmtcreateddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bttmtmodifieddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bttmtfield1` varchar(64) DEFAULT NULL,

  PRIMARY KEY (`btttransrefid`),

  KEY `FK_bttbataccrefid` (`bttbataccrefid`),
  CONSTRAINT `FK_bttbataccrefid` FOREIGN KEY (`bttbataccrefid`) REFERENCES `Accounts` (`bataccrefid`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Banker Transactions Table - BTT'


---------------------------------------------------------------
--===================================================================================
