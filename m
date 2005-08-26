Date: Fri, 26 Aug 2005 10:06:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris Wright <chrisw@osdl.org>, selinux@tycho.nsa.gov,
   linux-security-module@wirex.com
Subject: Re: [PATCH] remove selinux stacked ops
Message-ID: <20050826170654.GM7762@shell0.pdx.osdl.net>
References: <20050825221732.GR7991@shell0.pdx.osdl.net> <20050825225104.GC7762@shell0.pdx.osdl.net> <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil> <1125057491.5812.38.camel@moss-spartans.epoch.ncsc.mil> <1125059398.5812.53.camel@moss-spartans.epoch.ncsc.mil> <20050826162241.GG7762@shell0.pdx.osdl.net> <1125075022.8692.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1125075022.8692.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> On Fri, 2005-08-26 at 09:22 -0700, Chris Wright wrote:
> > I left it for two reasons.  Making it built-in will mean you can't
> > load another security module.
> 
> CONFIG_SECURITY=n achieves the same effect.

Yup, agreed (and if we could reduce performance impact that config could
go away ;-)

> >   Some distros use the module already, so
> > it's compatibility.  
> 
> I'd assume that they only do that so that they can load something else
> as primary, and then optionally stack capability under it.  Which they
> can still achieve (just by modifying their primary to use the commoncap
> functions directly).

No, they do it because they want capabilities, but for some strange
reason prefer to do everythign with modules.

> > These aren't the best reasons to keep it long term.
> 
> Yes, it seems confusing to leave it.  I can easily see people leaving it
> enabled as long as it remains without realizing that it is no longer
> serving any purpose.  And it will definitely kick out an error message
> if you leave SELinux+capability enabled together due to the failed
> registration.

True.  I'd prefer to have the whole of capabilities to simply be default
functionality always enabled.  Leaving it in there is not required for
that.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
