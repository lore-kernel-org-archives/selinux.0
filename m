Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k879o2l5007155
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 05:50:02 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k879ndvK010421
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 09:49:39 GMT
Received: by py-out-1112.google.com with SMTP id 39so221042pyu
        for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2006 02:50:02 -0700 (PDT)
Message-ID: <44FFEB42.90203@kaigai.gr.jp>
Date: Thu, 07 Sep 2006 18:49:54 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [RFC] SELinux and PostgreSQL
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

In recent days, I'm making a plan to enhance PostgreSQL with SELinux,
and the followings are simple description about the plan currently
I have.
Any comments are so welcome. I want to revise the original design
and security model before starting implementation.

I hope to release it within next one year, if possible. :)

* The basic idea
The core facility of what I plan to enhance is an additional access
control between the client of PostgreSQL and tables, columns, rows.
(In future, the access control on binary large object(BLOB) is desirable.)

For the purpose, those database objects (table, column, row) must
have capability to hold its security context. The security context
of table and column can be stored in system catalog (pg_class and
pg_attribute), and row's one will be stored in the row generated
implicitlly.
The security context of PostgreSQL client will be obtained via
getpeercon().

I propose a new object class named as 'database' which contains the
following access vectors.

  class database
  {
      createtbl
      altertbl
      droptbl
      select
      update
      insert
      delete
      relabelfrom
      relabelto
  }

I propose some SQL functions reflecting to libselinux functions
like avc_has_perm(), getpeercon() and so on. We can use them not
only from SQL explicitly, but also implicitly appended to mask
the result set.
For example, the statement (B) will be actually executed when the
server received the statement (A).

(A) select * from customer;

(B) select * from customer where avc_has_perm(getpeercon(),
                                              security_context,
                                              DATABASE__SELECT);

* The expected behavior

When we try to create a new table, the client must have 'createtbl'
permission to the PostgreSQL server process. Then the created table
inherits the security context of the server process.
When we try to alter/drop a existing table, the client must have
'altertbl' or 'droptbl' permission to the targeted table.
If the client didn't have suitable permissions, the transaction is
aborted.

When we try to query with select statement, the client must have
'select' permission to all of the targeted table and column.
And any rows on which the client didn'n have permission is eliminated
from the result set.

When we try to query with insert statement, the client must have
'insert' permission to the targeted table and column. And any new
rows are attached a new security context given by security_compute_create()
with the client's context and the table's one.

When we try to query with update/delete, the client must have 'update'
or 'delete' permission to the target table and column. And any rows on
which the client didn't have permission is eliminated from the targets
to update or delete.
In addition, when we try to update the column contains security context,
'relabelfrom' and 'relabelto' are also evaluated.

* An example

+-------------------------------------------------------------------------+
| TABLE: customer                                                         |
+-------------------------------+-----+-----------+--------------+--------+
|        security_context       | id  | name      |  address     | income |
+-------------------------------+-----+-----------+--------------+--------+
|system_u:object_r:pgrow_t:s0   | 100 | Onodera   | Hokkaido ... | 2000   |
|system_u:object_r:pgrow_t:s0   | 101 | Hayashi   | Tokyo ...    | 2200   |
|system_u:object_r:pgrow_t:s0:c0| 102 | Meguro    | Yokohama ... | 1800   |
|system_u:object_r:pgrow_t:s0:c0| 103 | Terada    | Aomori ...   | 2100   |
|system_u:object_r:pgrow_t:s0   | 104 | Motohashi | Kyoto ...    | 2500   |
+-------------------------------+-----+-----------+--------------+--------+
| [security contexts]                                                     |
| table:  customer                  = system_u:object_r:postgresql_t:s0   |
| column: customer.security_context = system_u:object_r:postgresql_t:s0   |
| column: customer.id               = system_u:object_r:postgresql_t:s0   |
| column: customer.name             = system_u:object_r:postgresql_t:s0   |
| column: customer.mail             = system_u:object_r:postgresql_t:s0   |
| column: customer.income           = system_u:object_r:postgresql_t:s0.c1|
+-------------------------------------------------------------------------+
'income' is marked as different category, because it is a sensitive
information in this case, and it's configured non-privileged client
cannot access to some rows.

If the client context is user_u:system_r:unconfined_t:s0,
an SQL statement of "select * from customer" will return the following
result set.
+-----+-----------+--------------+
| id  | name      | address      |
+-----+-----------+--------------+
| 100 | Onodera   | Hokkaido ... |
| 101 | Hayashi   | Tokyo ...    |
| 104 | Motohashi | Kyoto ...    |
+-----+-----------+--------------+

If the client context is user_u:system_r:unconfined_t:SystemLow-SystemHigh,
the same SQL statement will return the following result set.
+-----+-----------+--------------+--------+
| id  | name      |  address     | income |
+-----+-----------+--------------+--------+
| 100 | Onodera   | Hokkaido ... | 2000   |
| 101 | Hayashi   | Tokyo ...    | 2200   |
| 102 | Meguro    | Yokohama ... | 1800   |
| 103 | Terada    | Aomori ...   | 2100   |
| 104 | Motohashi | Kyoto ...    | 2500   |
+-----+-----------+--------------+--------+

(*) '*' is not extract into 'security_context' and the column on which
    the client didn't have a permission.

Thanks for reading the long description.
Any comments are welcome for me.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
