Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87HIu6j020537
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 13:18:56 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87HHuuU023576
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:17:58 GMT
Subject: Re: [RFC] SELinux and PostgreSQL
From: Joshua Brindle <jbrindle@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <1157648557.22185.8.camel@twoface.columbia.tresys.com>
References: <44FFEB42.90203@kaigai.gr.jp>
	 <1157633535.14982.9.camel@twoface.columbia.tresys.com>
	 <200609072324.51487.russell@coker.com.au> <45002CA4.40907@kaigai.gr.jp>
	 <3FCBC9B9.8000302@tresys.com>  <45004041.3020407@kaigai.gr.jp>
	 <1157648557.22185.8.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 13:18:10 -0400
Message-Id: <1157649490.22185.11.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-07 at 13:02 -0400, Joshua Brindle wrote:
> On Fri, 2006-09-08 at 00:52 +0900, KaiGai Kohei wrote:
> > >>> Do we need separate object classes for database and table?
> > >>>
> > >>> We can consider databases and tables to be both roughly equivalent to 
> > >>> directories in the filesystem permissions.  In a Reiser4 model that 
> > >>> would be /database/table/row.  ;)
> > >>>
> > >>> So we could have:
> > >>> table_auto_trans(dba1_t, system_db_t, database1_t, table)
> > >>> table_auto_trans(dba1_t, database1_t, table1_t, table)
> > >>> table_trans(dba1_t, database1_t, { table2_t table3_t }, table)
> > >>> table_auto_trans({ dba1_t db_user1_t }, table2_t, row1_t, row)
> > >>
> > >> I agree Russell's suggestion, because we can describe those structure
> > >> with separated type and type_trans rule.
> > >> In addition, it will be more easily applicable to another DBMS.
> > >>
> > > 
> > > under flask object classes are used to differentiate kinds of objects. 
> > > It will make the database access control much more fine grained if you 
> > > implement a proper object model.
> > 
> > Umm, I felt both opinions are correct.
> > I want to consider for a while and hear any more opinions.
> > 
> 
> we've been thinking about this a little here at tresys and have some
> ideas about the object model if you are interested..
> 
> > >> I have a question to Russell.
> > >> How is the security context of database attached?
> > >> I estimate it should be done by type_trans rule with server process 
> > >> context
> > >> and clients process's context on database object class.
> > >>
> > > 
> > > you shouldn't use the server process context since the objects are being 
> > > created by the client ultimately and should be labeled based on the 
> > > label of the client. Labeling based on the server context would make for 
> > > almost unusable labeling granularity.
> > 
> > I'm sorry if my description is confusable.
> > I didn't say we should use server process's security context as a initial
> > label of the database. The result of security_compute_create() is used
> > as a initial label of the database, and the arguments of it is client
> > process's context as a subject and server process's context as a object.
> > Do you think it's a strange design?
> > 
> 
> The database, table and column objects should be labeled the same way
> any other object in SELinux is labeled. It can either be a policy driven
> label (security_compute_create) or be explicit. When an administrator
> sets up the schema for a table he'll want to label the columns
> explicitly if they'll have different access matrices. SQL extensions
> will be required to handle this:
> 
> CREATE table users ( username char(24), password char(24) 
> context('system_u:object_r:db_users_password_t'));
> 
> (or whatever)
> 
> meaning that parts of the schema have labels (which is how you determine
> if one can insert, delete, etc into a specific table). Additionally any
> data put into the database is labeled via security_compute_create on a
> per row basis (if you choose to make it that fine grained). 
> 
> At a minimum you should have the different kinds of objects (databases,
> tables, columns, stored procedures) and label them either explicitly or
> via security_compute_create.

Speaking of stored procedures, Karl reminded me that we probably want
stored procedures to be entrypoints into other domains so that you can
use them as trusted info flow filters.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
