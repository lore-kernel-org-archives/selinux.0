Subject: RE: [RFC] 0/4 - Hierarchal apache policy for reference policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015887B9E3E@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015887B9E3E@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 15:24:25 -0500
Message-Id: <1169151865.22731.390.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-18 at 15:00 -0500, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > Stephen Smalley wrote:
> > > On Thu, 2007-01-18 at 13:40 -0500, Karl MacMillan wrote:
> > >> Joshua Brindle wrote:
> > >>> Karl MacMillan wrote:
> > >>>> Joshua Brindle wrote:
> > 
> > <snip>
> > 
> > >>>> I think the biggest hurdle to this gaining widespread use is the 
> > >>>> length of the meta-policy, especially since it 
> > essentially repeats 
> > >>>> the policy for the sub-types. Any ideas about how to 
> > shorten this policy?
> > >>>>
> > >>> nit: the meta-policy is short (5 lines). The policy 
> > itself is longer 
> > >>> due to the propagation of rules to children types.
> > >>>
> > >> Fine - but that answer the question. Having to define 
> > container types 
> > >> with a superset of the rules results in a much longer 
> > policy. I think 
> > >> that it is going to be hard to convince people to add that policy.
> > > 
> > > Policy build could automatically generate the rules for the 
> > container 
> > > types from the child type rules, as long as they come from the same 
> > > source (e.g. all part of the base policy build, or all 
> > within the same 
> > > module).  Then you only need to explicitly state rules for the 
> > > container types for accesses that you wish to permit to externally 
> > > defined children.
> > > 
> > 
> > That's probably a good solution. Wouldn't be too hard to make 
> > a tool to do this from selgen / sepolgen / madison.
> 
> 
> This defeats the purpose of the hierarchy. The container types define
> the maximum permissions that can be granted to a child. The intention is
> for the security admin to create types with the permissions acceptable
> to meet his goals, and allow other admins to securely make finer grained
> children types. 
> 
> The proposed solution gives the opposite effect, it builds container
> types from children so the children must meet the requirements of the
> parent types without knowing them.

No, notice that I only said that one would automatically propagate
accesses from the children to the parent if they come from the same
source (base policy build or within the same module).  You wouldn't
automatically propagate beyond that scope, so if a type in a module is a
child of a parent type in the base (or any other previously added
module), it would still be constrained to whatever was explicitly
specified by the base (or other module) on the parent type.  It merely
avoids the need to duplicate specification within the base policy or
within a single module when both the parent and the child types are
defined within that base or module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
