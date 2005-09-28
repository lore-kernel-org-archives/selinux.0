Message-Id: <200509281624.j8SGOpYs011239@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 4/17
Date: Wed, 28 Sep 2005 12:24:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1127923146.25945.90.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, September 28, 2005 11:59 AM
> To: Karl MacMillan
> Cc: 'Ivan Gyurdiev'; selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: RE: [PATCH] semanage-functionality 4/17
> 
> On Wed, 2005-09-28 at 11:31 -0400, Karl MacMillan wrote:
> > Go ahead and drop, but I would like to add it back in the future. I'm
> not a
> > big fan of library constructors, but we can do it that way if you would
> > prefer (partially, it makes it harder to use this as a static library I
> > believe).
> >
> > Part of this is that config scheme currently doesn't make sense (this
> was
> > discussed in the past). The current config has 3 things:
> >
> > 1) Information on how to connect, etc.
> >
> > 2) Verification programs to run on commit.
> >
> > 3) Information on the location and commandline args to programs like
> > load_policy.
> >
> > I think that 1 should move to /etc/selinux/config. This will require
> changes
> > to libselinux. Objections?
> 
> Hmmm...that seems specific to libsemanage, although I agree it is
> unlikely to be policy-specific.  Not sure it necessarily requires
> changes to libselinux, unless you want libselinux to handle parsing and
> extraction of the value.  I think libselinux just ignores any content
> in /etc/selinux/config other than its own variables (SELINUX=,
> SELINUXTYPE=), so you could introduce new tags there and have
> libsemanage interpret them directly.  system-config-securitylevel just
> needs to know not to clobber them.
> 

That sounds fine. We could also just have a separate config file (see
below).

> > 2 should be part of each policy, e.g.,
> /etc/selinux/targeted/semanage.conf.
> > This is really the current config file.
> 
> Not sure about this one in practice, as a single verifier program could
> certainly load policy-specific settings itself based on $SELINUXTYPE
> without requiring the verifier program and args to be
> policy-specific.
> 

We don't really have examples of this yet, so I would argue for the simple
approach and do something more complex later. That means, I think, that we
should move the current config to /etc/selinux/semanage.conf, simplify it a
bit, and allow the verification programes (when they appear) to load
settings based on $SELINUXTYPE.

> > 3 should be dropped in favor of Makefile variables or moved to
> > /etc/selinux/config. I can't imagine a different load_policy per policy.
> 
> Yes, I agree.
> 
> > Why not just handle.h for connections and transactions instead of the a
> > separate transaction.h and handle.h?
> 
> It is unclear to me as to whether we need connections and transactions
> for all uses of libsemanage.  If we do, then I'd agree that putting them
> all into handle.h is correct, but it does raise the question again of
> why we have separate connect/create and disconnect/destroy (well, you
> only had the latter, but it yields an inconsistent interface).
> 

I think that we always need a connection - which is why the separate create
was not provided. The separate destroy was required, however, to:

a) allow extraction of errors from the handle after disconnect and
b) permit a handle to be destroyed without disconnecting. This is required
when a client forks I believe. One of the processes will have a handle that
needs to be destroyed without disconnecting.

I think that we need to have a create to allow:

1) create a handle
2) set connection options (timeout, where to connect - remote policy server,
local policy server, direct, etc.).
3) connect.
4) etc., etc.

> > Agreed. Are you making these changes, or do you want an updated patch?
> 
> I'm already on it.
> 

Ok - after you commit your changes we will sync and get you a patch for the
other issues.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
