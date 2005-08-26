Date: Fri, 26 Aug 2005 07:54:55 -0500
From: serue@us.ibm.com
To: Tony Jones <tonyj@suse.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>,
   linux-security-module@wirex.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] remove selinux stacked ops
Message-ID: <20050826125455.GA10491@sergelap.austin.ibm.com>
References: <20050825221732.GR7991@shell0.pdx.osdl.net> <20050825225104.GC7762@shell0.pdx.osdl.net> <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil> <1125057491.5812.38.camel@moss-spartans.epoch.ncsc.mil> <1125059398.5812.53.camel@moss-spartans.epoch.ncsc.mil> <20050826163307.GA32690@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050826163307.GA32690@immunix.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Tony Jones (tonyj@suse.de):
> On Fri, Aug 26, 2005 at 08:29:58AM -0400, Stephen Smalley wrote:
> > On Fri, 2005-08-26 at 07:58 -0400, Stephen Smalley wrote:
> > > Ok, as with my prior comment, this one is also invalidated by the fact
> > > that the static inlines fall back to the cap_ functions if the operation
> > > is NULL.  So I suppose this would work.
> > 
> > Given these changes, what purpose does the capability module and the
> > CONFIG_SECURITY_CAPABILITIES option serve anymore?  Should capability.c
> > be removed entirely?
> 
> Since stacker will implement every hook (preventing the static inline
> falling thru) wouldn't retaining capability as a module for composition 
> be useful?

For conceptual simplicity I think keeping an actual module for it around
will be best.  Then other module can either stack with it, or not,
however they prefer.

> Of course I can see alternate methods for implementing this.  At the very least,
> as this thread demonstrates, the current stacker approach of calling dummy
> when no submodule implements a hook will need some rework.

Actually that's not quite the way it works under stacker right now.
If no module is loaded, then dummy is used, but if a module is loaded,
then stacker doesn't call dummy__hook if the module doesn't define that
hook.  (Though there are a few hooks which are specially handled, ie
__vm_enough)

So switching from having dummy be the default module when nothing is
stacked, to having capability, is simple enough.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
