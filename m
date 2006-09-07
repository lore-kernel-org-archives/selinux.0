Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87DrV8F013894
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 09:53:31 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87Dr4Eu010651
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 13:53:06 GMT
Subject: Re: [RFC] SELinux and PostgreSQL
From: Joshua Brindle <jbrindle@tresys.com>
To: russell@coker.com.au
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
In-Reply-To: <200609072324.51487.russell@coker.com.au>
References: <44FFEB42.90203@kaigai.gr.jp>
	 <1157633535.14982.9.camel@twoface.columbia.tresys.com>
	 <200609072324.51487.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 09:54:19 -0400
Message-Id: <1157637259.14982.22.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-07 at 23:24 +1000, Russell Coker wrote:
> On Thursday 07 September 2006 22:52, Joshua Brindle <jbrindle@tresys.com> 
> wrote:
> > > I propose a new object class named as 'database' which contains the
> > > following access vectors.
> > >
> > >   class database
> > >   {
> > >       createtbl
> > >       altertbl
> > >       droptbl
> > >       select
> > >       update
> > >       insert
> > >       delete
> > >       relabelfrom
> > >       relabelto
> > >   }
> >
> > I think you are almost there, below you talk about labeling the tables,
> > rows, etc individually but your object model above isn't treating them
> > any differently.
> >
> > The object model should have an object class for each distinct kind of
> > object, for example database should have create, drop, createtable,
> > droptable, relabelto, relabelfrom. the table object class should have
> > insert. update, delete, select, drop, create, etc. field (or column)
> > object class should have select, update, etc.
> 
> Do we need separate object classes for database and table?
> 
> We can consider databases and tables to be both roughly equivalent to 
> directories in the filesystem permissions.  In a Reiser4 model that would 
> be /database/table/row.  ;)
> 

databases and tables are different. You can select on a table, you
cannot select on a database. you can insert into a table, you cannot
insert into a database, and so on.

> So we could have:
> table_auto_trans(dba1_t, system_db_t, database1_t, table)
> table_auto_trans(dba1_t, database1_t, table1_t, table)
> table_trans(dba1_t, database1_t, { table2_t table3_t }, table)
> table_auto_trans({ dba1_t db_user1_t }, table2_t, row1_t, row)
> 
> > > (A) select * from customer;
> > >
> > > (B) select * from customer where avc_has_perm(getpeercon(),
> > >                                               security_context,
> > >                                               DATABASE__SELECT);
> >
> > So is this done from within the database or are you trying to make a
> > trusted proxy that will munge requests before they make it to the
> > database server?
> 
> When I briefly discussed such things with KaiGai the idea was to have it 
> within the database.  A proxy would be very inefficient for this if SE Linux 
> controls were used in any serious manner.  Large amounts of data could be 
> retrieved only to be discarded by the proxy.
> 
 
Not really. The proxy would change the query as above (A and B) and the
database server would only return the results that match the query
(including the avc_has_perm) and the proxy will pass the results on. The
proxy in this model manipulates the query, not the result set.

One could even use the proxy model within the same process space to
manipulate the query as it enters the database server instead of hooking
in to the database server at every access point.

The bad part about this is that it makes for a less fine grained model
than hooking at access points. 

One thing to think about is stored procedures and how those can be dealt
with, triggers, etc. Without access control hooks triggers are much
harder to deal with access control wise, as are stored procedures.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
