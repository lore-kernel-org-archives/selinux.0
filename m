Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87DOxhh012909
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 09:24:59 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87DOC6l008914
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 13:24:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [RFC] SELinux and PostgreSQL
Date: Thu, 7 Sep 2006 23:24:48 +1000
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
References: <44FFEB42.90203@kaigai.gr.jp> <1157633535.14982.9.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157633535.14982.9.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609072324.51487.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 07 September 2006 22:52, Joshua Brindle <jbrindle@tresys.com> 
wrote:
> > I propose a new object class named as 'database' which contains the
> > following access vectors.
> >
> >   class database
> >   {
> >       createtbl
> >       altertbl
> >       droptbl
> >       select
> >       update
> >       insert
> >       delete
> >       relabelfrom
> >       relabelto
> >   }
>
> I think you are almost there, below you talk about labeling the tables,
> rows, etc individually but your object model above isn't treating them
> any differently.
>
> The object model should have an object class for each distinct kind of
> object, for example database should have create, drop, createtable,
> droptable, relabelto, relabelfrom. the table object class should have
> insert. update, delete, select, drop, create, etc. field (or column)
> object class should have select, update, etc.

Do we need separate object classes for database and table?

We can consider databases and tables to be both roughly equivalent to 
directories in the filesystem permissions.  In a Reiser4 model that would 
be /database/table/row.  ;)

So we could have:
table_auto_trans(dba1_t, system_db_t, database1_t, table)
table_auto_trans(dba1_t, database1_t, table1_t, table)
table_trans(dba1_t, database1_t, { table2_t table3_t }, table)
table_auto_trans({ dba1_t db_user1_t }, table2_t, row1_t, row)

> > (A) select * from customer;
> >
> > (B) select * from customer where avc_has_perm(getpeercon(),
> >                                               security_context,
> >                                               DATABASE__SELECT);
>
> So is this done from within the database or are you trying to make a
> trusted proxy that will munge requests before they make it to the
> database server?

When I briefly discussed such things with KaiGai the idea was to have it 
within the database.  A proxy would be very inefficient for this if SE Linux 
controls were used in any serious manner.  Large amounts of data could be 
retrieved only to be discarded by the proxy.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
