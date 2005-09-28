Message-Id: <200509281533.j8SFXgYs010411@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 4/17
Date: Wed, 28 Sep 2005 11:33:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <433AB4E7.4080808@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Wednesday, September 28, 2005 11:21 AM
> To: Stephen Smalley
> Cc: Karl MacMillan; selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: Re: [PATCH] semanage-functionality 4/17
> 
> 
> >+/* All accesses with semanage is through a "semanage_handle".  This
> >+ * handler may be with the monolithic policy, directly to a module
> >+ * store, or with a policy management server.  The handler represents
> >+ * a persistent connection to that policy manager.  It is created
> >+ * through a semanage_connect() call and must be afterwards
> >+ * deallocated with semanage_handle_destroy(). */
> >+typedef struct semanage_handle semanage_handle_t;
> >
> >It seems cleaner to separate create from connect, to parallel the
> >separation of disconnect from destroy.  Further, the implementation
> >already makes this easy to do; just need to make the
> >semanage_handle_create function exported and change connect to take an
> >already created handle rather than creating one of its own.  Barring
> >objections, I will do this.
> >
> >
> Yes! I was trying to write a sample session with libsemanage yesterday,
> to imagine how it would work. I think we should allow queries on local
> files with disconnected handles (there's no reason to connect to any
> policy server (or create a policydb object), just to enumerate all local
> users or booleans (not base), for example).

I disagree - in order to enforce security on the viewing of users, booleans,
etc. you need to get these from the policy server. The client may not have
permission to directly view the files.

All functions should, I believe, fail if you have not connected.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
