Subject: Re: [PATCH] libselinux: 1/2 Introduce {get,set}procattrcon
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1151346680.5264.50.camel@moss-spartans.epoch.ncsc.mil>
References: <1151340535.21012.150.camel@localhost.localdomain>
	 <1151346680.5264.50.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 15:38:13 -0400
Message-Id: <1151350693.21012.170.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-26 at 14:31 -0400, Stephen Smalley wrote:
> > --- libselinux-1.30.15/include/selinux/selinux.h.p1	2006-06-26 12:00:54.000000000 -0400
> > +++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-26 12:00:54.000000000 -0400
> > @@ -24,6 +24,14 @@ extern void freeconary(security_context_
> >  
> >  /* Wrappers for the /proc/pid/attr API. */
> >  
> > +/* Generic /proc pid attr handlers.  These will either get or set the context
> > +   from or into the proc location passed to them.  Should only be called from 
> > +   inside libselinux */
> > +extern int getprocattrcon(security_context_t *con, char *path);
> > +extern int getprocattrcon_raw(security_context_t *con, char *path);
> > +extern int setprocattrcon(security_context_t con, char *path);
> > +extern int setprocattrcon_raw(security_context_t con, char *path);
> > +
> >  /* Get current context, and set *con to refer to it.
> >     Caller must free via freecon. */
> >  extern int getcon(security_context_t *con);
> 
> If they should only be called from inside libselinux, why are they
> defined in selinux/selinux.h, and exported to users of the library?

When I originally typed that comment I was still under the misguided
impression they were being hidden (which should have stood out as
strange for the same reason it did to james).  I could see value if you
had done something custom to your kernel or your libselinux didn't have
interfaces for all of the /proc/pid/attr/* (as is now the case since
there are kernels with keycreate and sockcreate but no libselinux
interface, even if that will get fixed shortly.)  I don't think it's
unreasonable to remove that comment and just leave them as visable
functions.  Do you want another patch to remove the comment?  Anyone
have feelings that we shouldn't export such a general interface?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
