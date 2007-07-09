Subject: Re: [patch] libselinux:  fix getfilecon handling of zero-length
	context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        John Ramsdell <ramsdell@mitre.org>
In-Reply-To: <469266C8.4050905@manicmethod.com>
References: <1183999553.12430.94.camel@moss-spartans.epoch.ncsc.mil>
	 <469266C8.4050905@manicmethod.com>
Content-Type: text/plain
Date: Mon, 09 Jul 2007 12:50:43 -0400
Message-Id: <1183999843.12430.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-09 at 12:48 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > As observed by John Ramsdell, *getfilecon() on a /proc/sys inode on
> > returns garbage and can lead to memory corruption upon later freecon.
> > This happens on 2.6.21 and later due to the proc sysctl rewrite in the
> > kernel.  The *getfilecon_raw() functions correctly return zero in this
> > case, but the non-raw functions are not handling that result properly.
> > Initialize *context on entry to *getfilecon() so that it has a
> > well-defined value even if *getfilecon_raw() returns zero.
> >
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> >
> >   
> 
> Acked-By: Joshua Brindle <jbrindle@manicmethod.com>
> 
> This should go into stable/1_0 and trunk, right?

Yes.

> 
> > ---
> >
> >  libselinux/src/fgetfilecon.c |    2 ++
> >  libselinux/src/getfilecon.c  |    2 ++
> >  libselinux/src/lgetfilecon.c |    2 ++
> >  3 files changed, 6 insertions(+)
> >
> > Index: trunk/libselinux/src/fgetfilecon.c
> > ===================================================================
> > --- trunk/libselinux/src/fgetfilecon.c	(revision 2490)
> > +++ trunk/libselinux/src/fgetfilecon.c	(working copy)
> > @@ -51,6 +51,8 @@
> >  	security_context_t rcontext;
> >  	int ret;
> >  
> > +	*context = NULL;
> > +
> >  	ret = fgetfilecon_raw(fd, &rcontext);
> >  
> >  	if (ret > 0) {
> > Index: trunk/libselinux/src/lgetfilecon.c
> > ===================================================================
> > --- trunk/libselinux/src/lgetfilecon.c	(revision 2490)
> > +++ trunk/libselinux/src/lgetfilecon.c	(working copy)
> > @@ -51,6 +51,8 @@
> >  	int ret;
> >  	security_context_t rcontext;
> >  
> > +	*context = NULL;
> > +
> >  	ret = lgetfilecon_raw(path, &rcontext);
> >  
> >  	if (ret > 0) {
> > Index: trunk/libselinux/src/getfilecon.c
> > ===================================================================
> > --- trunk/libselinux/src/getfilecon.c	(revision 2490)
> > +++ trunk/libselinux/src/getfilecon.c	(working copy)
> > @@ -51,6 +51,8 @@
> >  	int ret;
> >  	security_context_t rcontext;
> >  
> > +	*context = NULL;
> > +
> >  	ret = getfilecon_raw(path, &rcontext);
> >  
> >  	if (ret > 0) {
> >
> >
> >   
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
