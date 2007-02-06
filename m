Subject: Re: audit2allow and mls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <p06002042c1ed38b34ce4@[192.168.50.32]>
References: <p0600202dc1e90d941990@[192.168.50.32]>
	 <1170690538.12293.281.camel@moss-spartans.epoch.ncsc.mil>
	 <p06002042c1ed38b34ce4@[192.168.50.32]>
Content-Type: text/plain
Date: Tue, 06 Feb 2007 07:31:19 -0500
Message-Id: <1170765079.12293.355.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-05 at 14:44 -0500, Rosalie Hiebel wrote:
> >On Fri, 2007-02-02 at 11:25 -0500, Rosalie Hiebel wrote:
> >>  Is there version of audit2allow which is capable of generating 
> >>rules specific
> >>  to the mls policy?  I see that audit2allow's tests for mls  (calling
> >>  get_mls_flag),
> >>  but this is after the rules in the .te file have been generated.
> >
> >Not presently.  Ideally, audit2allow could check whether the denial was
> >caused by a constraint (as done by audit2why via libsepol) and then try
> >to determine a type attribute that could be used as an override, and
> >then call the appropriate refpolicy interface to add that attribute to
> >the domain.
> 
> Do you mean that audit2why does check the constrain rules in mls policy ?

audit2why effectively re-plays the permission check (via libsepol) to
determine the underlying cause for the permission denial, whether it is
due to a missing or disabled TE rule, a constraint violation (which
could be any constraint, MLS or otherwise), or a missing role allow
rule.  It doesn't generate policy but just tries to diagnose the cause.
It was a quick hack in response to frequent complaints from Dan Walsh
that he wanted a way to quickly see whether a denial was caused by
something other than missing TE rules.

A smarter audit2why would go further in its diagnosis, e.g.:
- if the cause is a missing or disable TE rule, check whether the
necessary TE rule is present in a disabled conditional block and
identify the boolean required to activate it,
- if the cause is a constraint violation, display the actual constraint,
and identify the type attribute that can be used to override it
(heuristic, as there is no guarantee of such an override)

And it would be linked into policy generation such that once the cause
was determined, it could immediately generate suitable policy.

These sorts of improvements may become more feasible with the ongoing
work by Karl on a sepolgen python library for policy generation and his
reworking of the libsepol policy representation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
