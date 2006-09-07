Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87EEAwU014857
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 10:14:10 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87EDgEu013765
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 14:13:45 GMT
Subject: Re: [RFC] SELinux and PostgreSQL
From: Joshua Brindle <jbrindle@tresys.com>
To: russell@coker.com.au
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
In-Reply-To: <200609080007.39558.russell@coker.com.au>
References: <44FFEB42.90203@kaigai.gr.jp>
	 <200609072324.51487.russell@coker.com.au>
	 <1157637259.14982.22.camel@twoface.columbia.tresys.com>
	 <200609080007.39558.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 10:15:00 -0400
Message-Id: <1157638500.14982.29.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-08 at 00:07 +1000, Russell Coker wrote:
> On Thursday 07 September 2006 23:54, Joshua Brindle <jbrindle@tresys.com> 
> wrote:
> > > Do we need separate object classes for database and table?
> > >
> > > We can consider databases and tables to be both roughly equivalent to
> > > directories in the filesystem permissions.  In a Reiser4 model that would
> > > be /database/table/row.  ;)
> >
> > databases and tables are different. You can select on a table, you
> > cannot select on a database. you can insert into a table, you cannot
> > insert into a database, and so on.
> 
> Files, directories, and symbolic links are different.  You can swapon to a 
> file but not a directory or a sym-link.  You can't mounton a sym-link.  
> Currently the object classes defined in the SE Linux policy support such 
> things.
> 

seems like you are agreeing. file, sym_file and dir are all different
object classes, as should be databases and tables.

> > > > So is this done from within the database or are you trying to make a
> > > > trusted proxy that will munge requests before they make it to the
> > > > database server?
> > >
> > > When I briefly discussed such things with KaiGai the idea was to have it
> > > within the database.  A proxy would be very inefficient for this if SE
> > > Linux controls were used in any serious manner.  Large amounts of data
> > > could be retrieved only to be discarded by the proxy.
> >
> > Not really. The proxy would change the query as above (A and B) and the
> > database server would only return the results that match the query
> > (including the avc_has_perm) and the proxy will pass the results on. The
> > proxy in this model manipulates the query, not the result set.
> 
> To implement the functionality of having a SELECT return only rows that you 
> are permitted to see the result set will be changed.  Think of a situation 
> where you have 100 user domains permitted to access a table and 100 types of 
> row.  The administrator would see all rows, but each user would only see a 
> small fraction of them.
> 

No, you do exactly what KaiGai said above:

> > (A) select * from customer;
> >
> > (B) select * from customer where avc_has_perm(getpeercon(),
> >                                               security_context,
> >                                               DATABASE__SELECT);
>

A turns in to B via the proxy. Then the database does the avc_has_perm
check as part of the query. An administrator would have more access via
the policy. The proxy would not be discarding anything.


> Then when you do a join of two tables with such configurations things would 
> get even more interesting for the author of a proxy.
> 
> > One could even use the proxy model within the same process space to
> > manipulate the query as it enters the database server instead of hooking
> > in to the database server at every access point.
> >
> > The bad part about this is that it makes for a less fine grained model
> > than hooking at access points.
> 
> If you want to only control table access then things become much easier.
> 

like I said, "it makes for a less fine grained model"

> > One thing to think about is stored procedures and how those can be dealt
> > with, triggers, etc. Without access control hooks triggers are much
> > harder to deal with access control wise, as are stored procedures.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
