Subject: Re: [PATCH] SELinux: memory leak in security_context_to_sid_core
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <alpine.LRH.1.10.0809032245380.21379@tundra.namei.org>
References: <1220390111.2962.19.camel@localhost.localdomain>
	 <1220444041.6034.1.camel@moss-spartans.epoch.ncsc.mil>
	 <alpine.LRH.1.10.0809032245380.21379@tundra.namei.org>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 09:04:55 -0400
Message-Id: <1220447095.6034.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-09-03 at 22:50 +1000, James Morris wrote:
> On Wed, 3 Sep 2008, Stephen Smalley wrote:
> 
> > > +	context_destroy(ctx);
> > 
> > Doesn't this introduce a double free on that code path (caller will also
> > call context_destroy on the same context, which it passed in).
> 
> Indeed, context_destroy will be called twice and it's a bug, although 
> kfree() will not be called twice on the same pointer (e.g. c->str is set 
> to NULL, as is e->node).
> 
> It needs to be fixed, but it's not a double free, unless I'm missing 
> something.

Ok, makes sense.

We need to decide who is responsible for freeing ctx under what
conditions.  It seems reasonable that if the function encounters an
error, it would free any transient storage and the caller would not try
to free the context; whereas, if the function succeeds and returns the
result via ctx, then the caller will free when done using it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
