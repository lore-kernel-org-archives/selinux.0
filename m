Subject: RE: [RFC] Ability to allow unknown class and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1165258170.8203.4.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C829F@exchange.columbia.tresys.com>
	 <1165258170.8203.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 14:39:40 -0500
Message-Id: <1165261180.2923.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-12-04 at 13:49 -0500, Eric Paris wrote:
> On Mon, 2006-12-04 at 13:13 -0500, Joshua Brindle wrote:
> > Are you suggesting we add to libsemanage the ability to manipulate the
> > config field? Do you dislike the idea of it being settable via some
> > other means at all? Should someone be able to build a kernel that does
> > not allow this option? Can it be switchable at runtime without a
> > rebuild/reload?
> 
> How about both?  I can make a /selinux tunable which takes affect
> immediately when changed.  And use 2 bits in the config field to set
> that value on policy reload.  When I originally implemented this I had
> a /selinux entry and protected it with SECURITY__LOAD_POLICY.  So policy
> would still be able to enforce if it could be turned on or off.
> 
> Does that meet all the needs?  You can still change it later by hand
> without building and loading a whole new policy, and we don't have
> races/sync problems loading new policy since the policy itself would set
> the value when it loads.

I'd prefer to avoid a selinuxfs tunable altogether, as it means that we
can't actually tell what setting was in effect for a given (kernel,
policy) pair without other external data (e.g. audit record upon
setting), and it means that we cannot prepad the avtab access vectors at
policy load time (avoiding any overhead in security_compute_av at
permission check time).

A libsemanage interface for modifying the flag in the generated kernel
policy has a similar problem with knowing what setting was in effect for
a given policy, but at least it would be visible in the generated kernel
policy file (and presumably in some file in the policy store managed by
libsemanage) and the kernel side implementation would remain simple and
efficient (all load time handling for padding access vectors in the
avtab, trivial change to security_compute_av to change handling of
unknown classes based on the flag).

The most conservative model would be to only allow the flag to be set
when the base module was built, and always propagate it from the base
module to the generated kernel policy at link/expand time.  That
requires a base module rebuild to activate this feature.  Then we would
know the behavior based solely on the (kernel, policy) pair.

Note that we have two options for how to set the flag at build time:
1) new option flag to checkmodule and checkpolicy
2) new language construct in the policy language

The latter has the advantage of capturing the flag in the policy source
rather than in the policy build process, but is naturally more work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
