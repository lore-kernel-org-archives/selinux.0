Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1J9LnRF007908
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 04:21:49 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1J9N1ju003192
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 09:23:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC] Security design of SE-PostgreSQL (2/3)
Date: Mon, 19 Feb 2007 17:50:29 +1100
Cc: selinux@tycho.nsa.gov
References: <45D542AF.1030108@kaigai.gr.jp> <200702182204.21346.russell@coker.com.au> <45D87B8D.5030307@kaigai.gr.jp>
In-Reply-To: <45D87B8D.5030307@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702191750.31301.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 19 February 2007 03:15, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> >> I have an idea to add the following access vector for the purpose.
> >>   1. allow (context of client)   (context of database)
> >> database:load_module;
> >> 2. allow (context of database) (context of shlib
> >> file) database:associate;
> >
> > Who will be loading such modules?  Only the DBA or regular users too?
>
> A regular user also can load shared library modules, but it is limited
> to be placed under '$libdir/plugins/' directory.
> The DBA can do any files, if PostgreSQL can access.

What Unix access controls are applied?  I guess that as PostgreSQL users don't 
have a direct relationship with Unix users it can't check the UID so it's 
just a matter of what files the database server has read and execute to which 
are in that directory.

Does it just check to make sure that the file isn't a sym-link and isn't 
world-writable.

> > In the above access control design you control which databases a user may
> > load modules for and which modules may be associated with a given
> > database.  But you don't control which modules a user may load.  Is it
> > possible that modules A and B may be loaded into a database but only user
> > C will be permitted to load module A?
>
> Your indication is correct. The above design can describe the relationship
> between the client and the database, or between the database and the shared
> library file.
> It doesn't describe who can load which modules.
>
> We have to describe the relationship between the client, the database
> and shared library files to block a malicious modules.
>
> How do you think the following design to allow to load a module, for
> example?
>    allow db_client_t sepgsql_db_t : database { load_module }; 
>    allow sepgsql_db_t shlib_file_t : database { associate };
>    allow db_client_t shlib_file_t : database { load_module };

That would work.

We already have triples in the policy language for type_transition, I wonder 
whether we could do something similar for this.  Having three rules when one 
might do is not easy to understand.

Other programs might need such triples in the policy, I wonder if it would be 
possible to make this a generic language feature.  Some sort of policy class 
which instead of actions takes another type as the third parameter.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
