Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8A4tl4c006964
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 00:55:47 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8A4tNVY003822
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 04:55:24 GMT
Received: by py-out-1112.google.com with SMTP id 39so1312496pyu
        for <selinux@tycho.nsa.gov>; Sat, 09 Sep 2006 21:55:46 -0700 (PDT)
Message-ID: <45039AC2.3040309@kaigai.gr.jp>
Date: Sun, 10 Sep 2006 13:55:30 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, russell@coker.com.au,
        jbrindle@tresys.com
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
References: <44FFEB42.90203@kaigai.gr.jp>
In-Reply-To: <44FFEB42.90203@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In recent days, I'm making a plan to enhance PostgreSQL with SELinux.
I posted the first draft of this plan a few days ago, and I got many
response. Thanks for your comments so much.
(Especially, Joshua and Russell)

The followings are the revised and summarized plan (draft v2).
I'm welcoming any comments to improve the project.


* New object classes and access vectors

Now, I plan to add some new object classes for databases, tables, stored
procedures, columns and rows. Those are defined as follows:

  class database
  {
      create
      alter
      drop
      relabelfrom
      relabelto
      access
      create_table
      drop_table
      create_procedure
      drop_procedure
      create_object
      drop_object
  }

  class table
  {
      create
      alter
      drop
      relabelfrom
      relabelto
      select
      update
      insert
      delete
  }

  class procedure
  {
      create
      alter
      drop
      relabelfrom
      relabelto
      execute
      entrypoint
  }

  class column
  {
      create
      alter
      drop
      relabelfrom
      relabelto
      select
      update
      insert
  #    delete
  }

  class row
  {
      relabelfrom
      relabelto
      select
      update
      insert
      delete
  }


* Labeling behavior
Some of database objects are labeled according to SELinux security policy
implicitly or by hand explicitly. The followings are labeling behaviors for
each object class.

- Labeling of database
The initial label is determined from security_compute_create() with the
the client process's label obtained from getpeercon() as a subject, the
server process's label as a object and database class.
We can also use ALTER DATABASE statement enhanced or update system catalog
(pg_database) to relabel explicitly, if relabelfrom/relabelto on database
class are allowed.

- Labeling of table
The initial label is determined from security_compute_create() with the
client, the database and table class.
We can also use ALTER TABLE statement enhanced or update system catalog
(pg_class) to relabel explicitly, if relabelfrom/relabelto on table class
are allowed.

- Labeling of stored procedure
The initial label is determined from security_compute_create() with the
client, the database and procedure class.
We can also use ALTER FUNCTION statement enhanced or update system catalog
(pg_proc) to relabel explicitly, if relabelfrom/relabelto on procedure class
are allowed.

- Labeling of column
The initial label is determined from security_compute_create() with the
client, the table and column class.
We can also use ALTER TABLE statement enhanced or update system catalog
(pg_attribute) to relabel explicitly, if relabelfrom/relabelto on column
class are allowed.

- on rows insertion
The initial label is determined from security_compute_create() with the
client, the table and row class.
We can also update the security_context column to relabel explicitly,
if relabelfrom/relabelto on row class are allowed.


* Remarkable behavior
- connection to PostgreSQL and select database
database:access is evaluated at first when the client connect to PostgreSQL
and choice the target database. If it's denied, connection will be closed.

- stored procedure
A stored procedure can be an entry point of domain transition.
It requires procedure:entrypoint permission and type_transition rule.
Using 'trusted stored procedure' with domain transition provids a method
to access sensitive data from unauthorized process.

For example, if the client doesn't have a permission on PASSWORD column,
he can access PASSWORD column via CHECK_PASSWORD() function marked as
a trusted stored procedure and cause domain transition.

- insert a new row
When we try to insert a new row into the table contains a column which
is not allowed to insert, we can insert a new row if enumerated columns
didn't contains the unauthorized column.
Then, this column will have NULL or default value. Because the client
cannot overwrite it on insertion, consistency is kept.

For example, we have a table defined as FOO(ID, NAME, PASSWORD).
When the client didn't have insert permission on PASSWORD, the (A) and
(C) of the following queries are failed.

(A) insert into FOOBAR(ID, NAME, PASSWORD) values(123, 'KaiGai', 'xyz');
(B) insert into FOOBAR(ID, NAME) values(123, 'KaiGai');
(C) insert into FOOBAR(ID, NAME, PASSWORD) values(123, 'KaiGai', null);

- delete a row
Becaues the delete opetation involves the whole of one row, column:delete
is not evaluated when we try to delete a row.
(Thus, it's not defined.)
This behavior may be a bit controvertible.

For example, it's one of the solution that deletion is not allowed without
permissions on the whole of columns on which the row has.

- interaction with PostgreSQL ACL mechanism
The SELinux enhancement works independently on PostgreSQL ACL.
It's similar to the relationship between DAC and MAC on filesystem.


Thanks for reading the long description.
Any comments are welcome for me.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
