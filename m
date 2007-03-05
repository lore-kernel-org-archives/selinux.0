Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l25CUJM0007168
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 07:30:19 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l25CViFQ018769
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 12:31:44 GMT
Received: by py-out-1112.google.com with SMTP id a78so938233pyh
        for <selinux@tycho.nsa.gov>; Mon, 05 Mar 2007 04:31:42 -0800 (PST)
Message-ID: <45EC0D21.2070706@kaigai.gr.jp>
Date: Mon, 05 Mar 2007 21:29:21 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SE-PostgreSQL 8.2.3-1.0 alpha was released as follows.

The purpose of this version is to get any feedback from the open source
community like requirements, your opinion, bug reports and so on.
The developer welcomes anything to improve.

======================================================================
Security Enhanced PostgreSQL 8.2.3-1.0 alpha release
======================================================================

Security Enhanced PostgreSQL (SE-PostgreSQL) is an extension of PostgreSQL,
provides fine grained mandatory access control based on the interaction
with SELinux and its security policy.
Those facilities of SE-PostgreSQL enables to build RDBMS into information
flow control scheme integrated with operating system, and protects your
information asset from threats like leaking, defacing and so on.

* Fine grained access control
SE-PostgreSQL enables access control onto row and column level.
The native PostgreSQL access control list does not provide any access
control onto database objects less than table, so SE-PostgreSQL enables
DBA to setup finer-grained and flexible access control.

* Mandatory access control
An access control mechanism provided by SE-PostgreSQL is applied to any
SQL queries including the ones come from privileged database users.
So, SE-PostgreSQL works as a userspace reference monitor.

* Interaction between SELinux and SE-PostgreSQL
An access control mechanism provided by SE-PostgreSQL makes its decision
based on the security policy of SELinux. The database client's authority
is determined by the security context of the peer process.

(*) The purpose of this version of SE-PostgreSQL is to get any feedback
    from the open source community like requirements and bug-reports.
    Thus, you should pay attention about what we have not verified enough
    quality of the code yet.

(*) The development of this software is under the assist of Exploratory
    Software Project (second half of 2006), IPA Japan.


======================================================================
[Installation]
You can set up SE-PostgreSQL on Fedora Core 6 system, SELinux installed.
Get RPM packages from the following URL:
  http://code.google.com/p/sepgsql/downloads/list
    selinux-policy-2.4.6-40.sepgsql.noarch.rpm
    selinux-policy-targeted-2.4.6-40.sepgsql.noarch.rpm
    sepostgresql-8.2.3-0.206a.i386.rpm

Install the selinux-policy and the selinux-policy-targeted package at first,
and the sepostgresql package next.
The default security policy of SE-PostgreSQL is also installed when
the sepostgresql package is installed.
(*) If you use 'psql' as a front-end, postgresql and postgresql-libs packages
    are necessary.

Run the following script to initialize the database cluster:

  # /etc/init.d/sepostgresql initdb

The database cluster is generated under /var/lib/sepgsql/data .

Run the following script to start up SE-PostgreSQL server, after you
confirm the native PostgreSQL server is stopping.

  # /etc/init.d/sepostgresql start

The database cluster is initialized by 'sepgsql' user.
You can translate 'sepgsql' user via 'su' command to create database,
database role and so on.
  [example]
  # su - sepgsql
  $ createuser kaigai
  Shall the new role be a superuser? (y/n) y
  CREATE ROLE
  $ createdb kaigaidb
  CREATE DATABASE
  $

======================================================================
[A sample database for playing]

CREATE TABLE drink (
    did     integer primary key,
    dname   text,
    dprice  integer,
    dsoft   bool,
    dstock  integer
);

ALTER TABLE drink ALTER dstock
    context = 'user_u:object_r:sepgsql_secret_table_t';

INSERT INTO drink VALUES (1, 'juice', 110, true,  35);
INSERT INTO drink VALUES (2, 'coke',  110, true,  20);
INSERT INTO drink VALUES (3, 'milk',  130, true,   5);
INSERT INTO drink VALUES (4, 'water', 100, true,  10);
INSERT INTO drink VALUES (5, 'beer',  240, false, 15);
INSERT INTO drink VALUES (6, 'wine',  380, false,  0);

UPDATE drink SET security_context = 'user_u:object_r:sepgsql_table_t:SystemHigh'
    where dsoft = false;

create or replace function drink_stock_exist (integer)
    returns bool
    language 'sql'
    as 'select dstock > 0 from drink where did = $1';

ALTER FUNCTION drink_stock_exist(integer)
    context = 'user_u:object_r:sepgsql_trusted_proc_t';


======================================================================
[A example of SQL execution]

$ id -Z
root:system_r:unconfined_t:SystemLow-SystemHigh
$ psql -q
kaigai=# select sepgsql_getcon();
                 sepgsql_getcon
-------------------------------------------------
 root:system_r:unconfined_t:SystemLow-SystemHigh
(1 row)

kaigai=# select * from drink;
 did | dname | dprice | dsoft | dstock
-----+-------+--------+-------+--------
   1 | juice |    110 | t     |     35
   2 | coke  |    110 | t     |     20
   3 | milk  |    130 | t     |      5
   4 | water |    100 | t     |     10
   5 | beer  |    240 | f     |     15
   6 | wine  |    380 | f     |      0
(6 rows)

## The security context of each tuples are stored in 'security_context'
## system column.
kaigai=# select security_context,* from drink;
        security_context         | did | dname | dprice | dsoft | dstock
---------------------------------+-----+-------+--------+-------+--------
 user_u:object_r:sepgsql_table_t |   1 | juice |    110 | t     |     35
 user_u:object_r:sepgsql_table_t |   2 | coke  |    110 | t     |     20
 user_u:object_r:sepgsql_table_t |   3 | milk  |    130 | t     |      5
 user_u:object_r:sepgsql_table_t |   4 | water |    100 | t     |     10
 user_u:object_r:sepgsql_table_t |   5 | beer  |    240 | f     |     15
 user_u:object_r:sepgsql_table_t |   6 | wine  |    380 | f     |      0
(6 rows)

kaigai=#

## A example of execution under lower authority:
## The two tuples which have 'SystemHigh' were filtered.

$ runcon -l s0 -- bash
$ id -Z
root:system_r:unconfined_t
$ psql -q
kaigai=# select sepgsql_getcon();
       sepgsql_getcon
----------------------------
 root:system_r:unconfined_t
(1 row)

kaigai=# select * from drink;
NOTICE:  SELinux: denied { select } scontext=root:system_r:unconfined_t tcontext=user_u:object_r:sepgsql_table_t:SystemHigh tclass=tuple
NOTICE:  SELinux: denied { select } scontext=root:system_r:unconfined_t tcontext=user_u:object_r:sepgsql_table_t:SystemHigh tclass=tuple
 did | dname | dprice | dsoft | dstock
-----+-------+--------+-------+--------
   1 | juice |    110 | t     |     35
   2 | coke  |    110 | t     |     20
   3 | milk  |    130 | t     |      5
   4 | water |    100 | t     |     10
(4 rows)

kaigai=#
$ exit

## We tried to connect from a domain which cannot access 'sepgsql_secret_table_t'

$ runcon -t initrc_t -- bash
$ id -Z
root:system_r:initrc_t:SystemLow-SystemHigh
$ psql -q
kaigai=# select * from drink;
ERROR:  SELinux: denied { select } scontext=root:system_r:initrc_t:SystemLow-SystemHigh tcontext=user_u:object_r:sepgsql_secret_table_t tclass=column name=dstock

## The client in initrc_t domain cannot access dstock column which has
## sepgsql_table_t type, but we cann access the column via trusted
## procedure only.

kaigai=# select did, dname, dprice, drink_stock_exist(did) from drink;
 did | dname | dprice | drink_stock_exist
-----+-------+--------+-------------------
   1 | juice |    110 | t
   2 | coke  |    110 | t
   3 | milk  |    130 | t
   4 | water |    100 | t
   5 | beer  |    240 | t
   6 | wine  |    380 | f
(6 rows)

kaigai=#

======================================================================
[Hint]
* There is no compatibility between SE-PostgreSQL and PostgreSQL.
  You have to pay attention not to destroy your database files
  for native PostgreSQL.

* You can enable/disable access allowed/denied messages by using
  boolean stuff of SELinux. Set the following booleans by setsebool
  command.
      sepgsql_enable_auditallow
      sepgsql_enable_auditdeny
      sepgsql_enable_audittuple

* initrc_t is defined as a less power domain for test purpose.
  We cannot use DDL statement from initrc_t domain, and cannot
  access tables, columns and tuples with sepgsql_secret_table_t
  type.

* The security policy for SE-PostgreSQL under the strict policy is now
  under development. You have to switch to the targeted policy, if you
  try to use this version.

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
