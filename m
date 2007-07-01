Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l61BquPK009343
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 07:52:56 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l61BqnMQ016451
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 11:52:50 GMT
Received: from [127.0.0.1] (j069218.ppp.asahi-net.or.jp [61.213.69.218])
	by mail.asahi-net.or.jp (Postfix) with ESMTP id 0649549739
	for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2007 20:52:42 +0900 (JST)
Message-ID: <468795FD.8050505@kaigai.gr.jp>
Date: Sun, 01 Jul 2007 20:54:37 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [ANN] SE-PostgreSQL 1.0 Beta released
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We released the beta version of SE-PostgreSQL and the first
official documentation at Jul 01 2007.

The purpose of the version is to improve its quality, like bugfix.
The SE-PostgreSQL development team welcomes any feedback from open
source community, like your comments or opinions, bug-reporting,
and so on.

Thanks,

============================================================
SE-PostgreSQL 1.0 Beta version Released
============================================================

SE-PostgreSQL development team released SE-PostgreSQL 1.0 beta
version and "The security guide of Security-Enhanced PostgreSQL
beta edition (Japanese/English)" at Jul 01 2007.

You can get those packages from the following URL:
 http://code.google.com/p/sepgsql/downloads/list

o SE-PostgreSQL 1.0 beta version
 sepostgresql-8.2.4-0.391.beta.fc6.i386.rpm
 sepostgresql-8.2.4-0.391.beta.fc7.i386.rpm
 sepostgresql-8.2.4-0.391.beta.fc7.src.rpm
 sepostgresql-8.2.4-0.391.beta.fc7.patch
o The base security policy for Fedora 7
 selinux-policy-2.6.4-14.sepgsql.fc7.noarch.rpm
 selinux-policy-targeted-2.6.4-14.sepgsql.fc7.noarch.rpm
 selinux-policy-devel-2.6.4-14.sepgsql.fc7.noarch.rpm
o The base security policy for Fedora core 6
 selinux-policy-2.4.6-74.sepgsql.fc6.noarch.rpm
 selinux-policy-targeted-2.4.6-74.sepgsql.fc6.noarch.rpm
 selinux-policy-devel-2.4.6-74.sepgsql.fc6.noarch.rpm
o "The security guide of Security-Enhanced PostgreSQL" beta edition
 sepgsql_security_guide.20070701.jp.beta.pdf (Japanese)
 sepgsql_security_guide.20070701.en.beta.pdf (English)

See the following URL, for details of installation.
o SE-PostgreSQL installation memo (Fedora 7)
 http://code.google.com/p/sepgsql/wiki/install_memo_Fedora7
o SE-PostgreSQL installation memo (Fedora core 6)
 http://code.google.com/p/sepgsql/wiki/install_memo_FC6

The features of SE-PostgreSQL
-----------------------------
Security Enhanced PostgreSQL (SE-PostgreSQL) is a security extension
built in PostgreSQL. It enables to administrate operating system and
database management system under the unified security policy by
cooperation with SELinux.
In addition, it also provides fine-grained access control including
column and row level, and mandatory access control being non-bypassable,
even if privileged database user.

Those features enables to build a database management system into
information flow control scheme integrated with operating system,
and to protect our information asset from threats like manipulation
or leaking.

The purpose of this version
---------------------------
The purpose of this version is evaluation and test for the stable
SE-PostgreSQL 1.0 release. Therefore, we don't recommends to apply
this version for test/evaluation purpose.
SE-PostgreSQL development team also declares the feature freeze for
the stable SE-PostgreSQL 1.0. It means that we have no plan to add
any feature except for bug fixes until it is released.
We always welcome any feedback from open source community, such as
bug reporting, question for SE-PostgreSQL and documentation.

Roadmap
-------
SE-PostgreSQL development team have a plan to release the stable
SE-PostgreSQL 1.0 after one month's evaluation.
In the future, we continue our activity to merge PGACE/SE-PostgreSQL
features into the upstreamed PostgreSQL.

Changes since SE-PostgreSQL 1.0 alpha
-------------------------------------
The following remarkable changes are applied from SE-PostgreSQL 1.0
alpha released at May 05 2007.

o Applying PGACE framework
 PostgreSQL Access Control Extension (PGACE) is a framework consist
 of many hooks and a mechanism to associate a security attribute with
 database objects, to provide a common infrastructure for multiple
 security extensions built in PostgreSQL.
o backup/restore utility
 '--enable-security' option was added for pg_dump and pg_dumpall commands.
 It enables to backup and restore database with security context.
o Extended SQL statement
 Extensions of CREATE TABLE/FUNCTION/DATABASE and ALTER TABLE/FUNCTION/DATABASE
 statements enables to configure security context of database object without
 modifying system catalog directly.
o Adding new permissions
 {use} permission was added for table, column and tuple object classes.
 It is evaluated in the case when a column is accessed without reading its
 contents such as use on WHERE or GROUP BY clause.
o Improve security policy
 Two new types are defined.
 One is sepgsql_ro_table_t for read-only tables. The other is sepgsql_fixed_table_t
 for non-manipulatable tables. A type of 'sepgsql_user_proc_t' is attached for
 user defined SQL function. Administrative domain cannot execute a function with this
 type, so we can avoid to execute untrusted functions with unconfined authorities.

Fixed many bugs
---------------
 We found and fixed many bugs for four months since alpha release on this March.

Acknowledgment
--------------
 The development of SE-PostgreSQL is supported by Exploratory Software Project,
 IPA(Information-technology Promotion Agency, Japan).

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
