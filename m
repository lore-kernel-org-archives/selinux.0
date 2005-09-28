Subject: RE: [PATCH] semanage-functionality 4/17
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Joshua Brindle'" <jbrindle@tresys.com>
In-Reply-To: <200509281531.j8SFVVYs010390@gotham.columbia.tresys.com>
References: <200509281531.j8SFVVYs010390@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 11:59:06 -0400
Message-Id: <1127923146.25945.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-28 at 11:31 -0400, Karl MacMillan wrote:
> Go ahead and drop, but I would like to add it back in the future. I'm not a
> big fan of library constructors, but we can do it that way if you would
> prefer (partially, it makes it harder to use this as a static library I
> believe).
> 
> Part of this is that config scheme currently doesn't make sense (this was
> discussed in the past). The current config has 3 things:
> 
> 1) Information on how to connect, etc.
> 
> 2) Verification programs to run on commit.
> 
> 3) Information on the location and commandline args to programs like
> load_policy.
> 
> I think that 1 should move to /etc/selinux/config. This will require changes
> to libselinux. Objections?

Hmmm...that seems specific to libsemanage, although I agree it is
unlikely to be policy-specific.  Not sure it necessarily requires
changes to libselinux, unless you want libselinux to handle parsing and
extraction of the value.  I think libselinux just ignores any content
in /etc/selinux/config other than its own variables (SELINUX=,
SELINUXTYPE=), so you could introduce new tags there and have
libsemanage interpret them directly.  system-config-securitylevel just
needs to know not to clobber them.

> 2 should be part of each policy, e.g., /etc/selinux/targeted/semanage.conf.
> This is really the current config file.

Not sure about this one in practice, as a single verifier program could
certainly load policy-specific settings itself based on $SELINUXTYPE
without requiring the verifier program and args to be
policy-specific.    

> 3 should be dropped in favor of Makefile variables or moved to
> /etc/selinux/config. I can't imagine a different load_policy per policy. 

Yes, I agree.

> Why not just handle.h for connections and transactions instead of the a
> separate transaction.h and handle.h?

It is unclear to me as to whether we need connections and transactions
for all uses of libsemanage.  If we do, then I'd agree that putting them
all into handle.h is correct, but it does raise the question again of
why we have separate connect/create and disconnect/destroy (well, you
only had the latter, but it yields an inconsistent interface).

> Agreed. Are you making these changes, or do you want an updated patch?

I'm already on it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
