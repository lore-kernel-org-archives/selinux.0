Subject: RE: [patch 0/2] policy capability support
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Todd Miller <Tmiller@tresys.com>, Joshua Brindle <method@manicmethod.com>,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1196959681.27508.84.camel@moss-spartans.epoch.ncsc.mil>
References: <20071205184848.180973622@tresys.com>
	 <200712051421.39624.paul.moore@hp.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
	 <4757073B.70907@manicmethod.com>
	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FEE@exchange.columbia.tresys.com>
	 <1196955882.12626.50.camel@gorn.columbia.tresys.com>
	 <1196959681.27508.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 13:34:30 -0500
Message-Id: <1196966070.12626.77.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-06 at 11:48 -0500, Stephen Smalley wrote:
> On Thu, 2007-12-06 at 10:44 -0500, Christopher J. PeBenito wrote:
> > On Wed, 2007-12-05 at 16:41 -0500, Todd Miller wrote:
> > > Stephen Smalley wrote:
> > > > Yes, I'm still against (automatic, default) unioning of the
> > > > capabilities by the linker - that is clearly not a safe default. 
> > > > semodule could possibly override that behavior based on an option
> > > > though, at which point the %post scriptlet in the policy rpm could
> > > > use that option if we wanted to force it w/o user intervention.
> > > 
> > > What do we want the behavior of this option to be?  As I see it we
> > > have two choices:
> > > 
> > > 1) perform a union instead of requiring equivalence
> > > 
> > > 2) add capabilities as needed to binary modules in the store.
> > > 
> > > The advantage of 2) is that it would only need to happen once which
> > > makes it more "upgrade friendly".
> > 
> > I now think that the answer is intersection (with a little change to the
> > userland design).
> > 
> > 1. capabilities are enabled only if the policy _fully_ supports them
> > union: no
> > intersection: yes
> > equivalence: yes
> > 
> > 2. modules with mismatched capability sets can be inserted (eg upgrade)
> > union: yes; all defined caps are enabled
> > intersection: yes; common caps are enabled (warnings on disabled caps)
> > equivalence: no
> > 
> > 3. policy writing implication
> > union: only modules that care about the cap will enable it
> > intersection: all modules must enable it
> > equivalence: all modules must enable it
> > 
> > Going along with this, I think the way caps are handled should be
> > augmented.  There should be conditional blocks, which allows relevant
> > policy to be affected
> > 
> > ifcap(fine_grained_netlink) {
> > 	allow foo_t self:netlink_selinux_socket create;
> > } else {
> > 	allow foo_t self:netlink_socket create;
> > }
> > 
> > I don't imagine this will be a common case, so most of the time we
> > wouldn't be using the conditional part of the support.  For the peersid
> > example, we'd just add the rules and turn on the capability in
> > refpolicy.  If a 3rd party module doesn't have the capability, the
> > kernel checks turn off and we have a few extra rules, which doesn't
> > hurt.
> 
> Supposing that we took the above approach, some questions remain:
> - Where do the policycap statements originate for each module?  By
> explicit declaration within each individual module?  By uniform
> inheritance from refpolicy for all modules via policy_module()?  By
> selective inheritance from individual refpolicy interfaces as needed,
> e.g. picking up policycap network_peer_controls; from the refpolicy
> network interfaces?

Most likely via policy_module().

> - If we go with the first or the last options, what about modules that
> don't actually care about a given capability - e.g. a module that
> doesn't have any networking rules wouldn't pick up the
> network_peer_controls capability from a refpolicy interface nor would
> its author think to declare it, so the module would appear to not
> support the capability.  We don't seem to have a way of distinguishing
> dont-care from disable.

I would put forth that the idea of dont-care doesn't really exist.  If
you know about it but don't care about it, whats the difference between
dont-care and enable?  If you don't know about it, then you can't say
that you don't care, and making dont-care the default would be bad,
since that would tend towards enabling new caps, causing the problems
we're trying to avoid :)

> - The intersection behavior assumes that new policy will always preserve
> compatibility with policies that lack newer capabilities by keeping
> around legacy rules in some form, even if conditional.  Is that a
> reasonable restriction for policy maintenance?

I suppose it depends on how people (ab)use the caps.  Josh made the case
to me that some people might want to intentionally disable controls
because they don't care about them or they want to try to boost
performance (e.g. networking pieces).

Beyond that, I suppose it depends on how far back we want to go.  For
example, RHEL4 is ancient by SELinux standards, but its going to be
around for a long time, so we have some distro_rhel4 blocks in
refpolicy.  Eventually RHEL4 will be out of support, and then we can
drop them.  I don't have a problem with it, but I also don't know how
many and how fast we're going to gain caps.

>   How do we ultimately
> drop dead rules altogether?

Move them out of conditionals?  Or are you suggesting having a way to
make warnings into errors after a reasonable amount of upgrade time?

>   Will all such capabilities be amenable to
> such compatibility behavior?

Good question.  I forgot my crystal ball at home :(  Will things beyond
permission changes be supported under this?

> - I'd tend to expect most users to not notice the disabled caps warning
> upon upgrade, so that means we'd have a fair number of users continuing
> to operate under the legacy controls indefinitely even after upgrading
> their policies to ones that would have supported the new capabilities.
> Is that reasonable?

Perhaps Dan or some of the other RH people can comment on this, but I
was under the impression that unusual console messages tend to be
noticed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
