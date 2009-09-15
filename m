Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <20090915063242.GM24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
	 <20090908163628.GC24297@myhost.felk.cvut.cz>
	 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909100647.GE24297@myhost.felk.cvut.cz>
	 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
	 <20090914081910.GL24297@myhost.felk.cvut.cz>
	 <1252930803.13634.1002.camel@moss-pluto.epoch.ncsc.mil>
	 <20090915063242.GM24297@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 07:16:24 -0400
Message-Id: <1253013385.13634.1062.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-15 at 08:32 +0200, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > I don't think so - the problem with selinuxfs tunables is that they
> > can't be changed atomically with a policy change, and this is a property
> > that should be tied to a particular policy.  For the same reason,
> > properties like handle_unknown and permissive domains are defined in the
> > policy itself rather than being selinuxfs tunables.
> 
> There have been things like compat_net, why can't the inheritance be
> done on the same basis and must be part of the policy instead?

compat_net was viewed as a mistake in retrospect, something we don't
want to repeat.

> Anyway, I've been looking at the policy loader code, and it seems that
> the easiest way to incorporate this into the policy would be to blend it
> with the config field (which is presently used for MLS and
> handle_unknown flags), perhaps by defining a flag like CATEGORY_INHERIT
> and to check for it right after ALLOW_UNKNOWN and REJECT_UNKNOWN are
> processed. This flag would then go to struct policydb and would be
> checked for in the mls_compute_sid function (I can see direct usage of
> the policydb global variable in that very function, so I guess it
> shouldn't be a problem).
> 
> Perhaps there could also be an upgrade of the policy version number and
> a check for the policy being loaded just to prevent random values being
> present in that bit.
> 
> There would also need to be a change in libsepol and checkpolicy to
> reflect this; perhaps checkpolicy could accept an additional command
> line argument (as it does with handle_unknown), and a new field defined
> in libsepol's policydb_t and further processed in its write.c.

Sounds about right to me.  It would technically be MLS_RANGE_INHERIT or
similar since it involves more than just the categories.  It might be
cleaner to make it an actual statement in the policy language rather
than a checkpolicy option, so that policy/mls or policy/mcs declares the
desired default transition behavior for objects, at which point you'd
generalize it.  The current behavior is copy-low-from-source; you want
copy-range-from-target.  But others might want copy-high-from-source or
copy-high-from-target or copy-low-from-target or copy-range-from-source.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
