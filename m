Date: Wed, 3 Sep 2008 22:50:31 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: memory leak in security_context_to_sid_core
In-Reply-To: <1220444041.6034.1.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0809032245380.21379@tundra.namei.org>
References: <1220390111.2962.19.camel@localhost.localdomain> <1220444041.6034.1.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Sep 2008, Stephen Smalley wrote:

> > +	context_destroy(ctx);
> 
> Doesn't this introduce a double free on that code path (caller will also
> call context_destroy on the same context, which it passed in).

Indeed, context_destroy will be called twice and it's a bug, although 
kfree() will not be called twice on the same pointer (e.g. c->str is set 
to NULL, as is e->node).

It needs to be fixed, but it's not a double free, unless I'm missing 
something.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
