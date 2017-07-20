Message-ID: <1500555858.22177.3.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris PeBenito <pebenito@ieee.org>, selinux@tycho.nsa.gov
Date: Thu, 20 Jul 2017 09:04:18 -0400
In-Reply-To: <e8789b40-79e0-d19b-9278-14cec89cf674@ieee.org>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <20170716151512.GA4615@meriadoc.perfinion.com>
 <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
 <1500383878.18445.1.camel@tycho.nsa.gov>
 <1500405609.18445.14.camel@tycho.nsa.gov>
 <CAHC9VhQz686zC06smDZHf_GYF8EmHpErX5xXnx9bifU51EkwrQ@mail.gmail.com>
 <03f326bc-599c-0074-0cc2-7f46808673a1@ieee.org>
 <20170719071233.GA7053@julius.enp8s0.d30>
 <20170719204946.GA2890@julius.enp8s0.d30>
 <20170719213141.GB2890@julius.enp8s0.d30>
 <e8789b40-79e0-d19b-9278-14cec89cf674@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid SELinux
 domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-07-19 at 21:17 -0400, Chris PeBenito wrote:
> On 07/19/2017 05:31 PM, Dominick Grift wrote:
> > On Wed, Jul 19, 2017 at 10:49:46PM +0200, Dominick Grift wrote:
> > > On Wed, Jul 19, 2017 at 09:12:33AM +0200, Dominick Grift wrote:
> > > > On Tue, Jul 18, 2017 at 09:07:45PM -0400, Chris PeBenito wrote:
> > > > > On 07/18/2017 05:26 PM, Paul Moore wrote:
> > > > > > On Tue, Jul 18, 2017 at 3:20 PM, Stephen Smalley <sds@tycho
> > > > > > .nsa.gov> wrote:
> > > > > > > On Tue, 2017-07-18 at 09:17 -0400, Stephen Smalley wrote:
> > > > > > > > On Mon, 2017-07-17 at 15:54 -0400, Paul Moore wrote:
> > > > > > > > > On Sun, Jul 16, 2017 at 11:15 AM, Jason Zaman <jason@
> > > > > > > > > perfinion.com>
> > > > > > > > > wrote:
> > > > > > 
> > > > > > ...
> > > > > > 
> > > > > > > > > > Why do we want to disallow type-bounds to work even
> > > > > > > > > > with the
> > > > > > > > > > capability?
> > > > > > > > > > it seems sensible to me to allow typebounds to
> > > > > > > > > > transition even in
> > > > > > > > > > the
> > > > > > > > > > future. If we do then we probably dont need the
> > > > > > > > > > policycap which
> > > > > > > > > > seems
> > > > > > > > > > less complicated.
> > > > > > > > > 
> > > > > > > > > The suggestion to continue to support bounded domain
> > > > > > > > > transitions
> > > > > > > > > seems
> > > > > > > > > reasonable to me, although we would need to worry
> > > > > > > > > about which check
> > > > > > > > > to
> > > > > > > > > do first (bounded transition or
> > > > > > > > > process:nnp_nosuid_transition), and
> > > > > > > > > how to limit the auditing/reporting so admins are
> > > > > > > > > confused by the
> > > > > > > > > first check failing, yet the transition still taking
> > > > > > > > > place.  None
> > > > > > > > > of
> > > > > > > > > these are unsolvable problems, but it will likely
> > > > > > > > > need a bit more
> > > > > > > > > work.
> > > > > > > > > 
> > > > > > > > > I'm sure Stephen has some thoughts on this as well.
> > > > > > > > 
> > > > > > > > Others (e.g. Dominick) seemed to take the opposite view
> > > > > > > > on the
> > > > > > > > earlier
> > > > > > > > RFC discussion, i.e. that we should only check the new
> > > > > > > > permission if
> > > > > > > > the capability is enabled.  I specifically raised that
> > > > > > > > as a question
> > > > > > > > there.
> > > > > > > > 
> > > > > > > > I'm willing to change it to fallback to checking for a
> > > > > > > > bounded type,
> > > > > > > > but that will mean two audit messages (I don't think we
> > > > > > > > can just hide
> > > > > > > > one of them) when neither is allowed.  That said, it is
> > > > > > > > unlikely to
> > > > > > > > cause much confusion in practice because users
> > > > > > > > typically only look
> > > > > > > > for
> > > > > > > > and pay attention to AVC messages, and anyone using
> > > > > > > > audit2allow will
> > > > > > > > just end up allowing the permission, not the bounds.
> > > > > > > 
> > > > > > > As Jason noted, if we fallback to checking for a bounded
> > > > > > > type, then we
> > > > > > > don't strictly need a policy capability for it.
> > > > > > 
> > > > > > It seems as though Dominick is okay with the fallback, what
> > > > > > do the
> > > > > > rest of the policy folks think about that approach?
> > > > 
> > > > I am okay with the faillback
> > > > 
> > > > > > 
> > > > > > I'm of the opinion that changes which don't require a new
> > > > > > policy
> > > > > > capability are slightly more favorable, but since one of
> > > > > > the goals
> > > > > > with this change is to make policy development easier, I
> > > > > > want to make
> > > > > > sure we are actually doing that.  It would appear we are,
> > > > > > but a few
> > > > > > explicit nods from the policy folks would be nice to see.
> > > > > 
> > > > > With my coder hat on, I can see the value of having the
> > > > > existing behavior be
> > > > > available for anyone who currently uses it, so it makes
> > > > > sense.
> > > > 
> > > > I agree, its only that I believe that no one is using it
> > > > because it is impractical (except for mod_selinux users, and
> > > > people that currently use type_bounds to deal with nosuid),,
> > > > mainly because the nnp flag is inherited.
> > > > The only scenario currently where, I believe, type_bounds might
> > > > be prefered is containers since container process types do not
> > > > change and the inheritance aspect is not much of a problem.
> > > > 
> > > > > 
> > > > > With my policy hat on, I don't have an opinion on a
> > > > > fallback.  What I do
> > > > > know is I don't like typebounds, avoid it as much as
> > > > > possible, and strongly
> > > > > prefer it not be forced on me.  There are no typebounds in
> > > > > refpolicy.
> > > > > 
> > > > > In fact, I think NNP should not affecting SELinux at all as
> > > > > NNP is
> > > > > discretionary and SELinux is mandatory.  NNP makes sense
> > > > > where you start out
> > > > > with lots of privileges and have to shed them, (i.e. the
> > > > > Linux
> > > > > DAC/capabilities perspective) whereas you have no privileges
> > > > > in SELinux
> > > > > except what is explicitly allowed.
> > > > > 
> > > > > Once this permission is implemented I'll likely add the
> > > > > permission across
> > > > > most if not all transitions out of systemd.
> > > > 
> > > > Yes but do not expect that to ,always, be enough due to the
> > > > inheritance aspect. A process may have inherited the NNP flag,
> > > > not because its started by systemd but because its started by a
> > > > process that inherited the NNP flag because it was started by
> > > > systemd.
> 
> That just makes me want to apply the permission to all transitions
> for 
> all domains.  Not that I'm planning to do it in refpolicy.  I'm 
> definitely inclined to be very liberal in applying the permission in 
> refpolicy.  For my personal systems, I'd probably do an:
> 
> allow domain domain:process nnp_nosuid_transition;
> 
> so I don't ever have to think about it again.

Caveats:

1. It would mean that transitions on any removable media would be
possible, even when marked nosuid.  So, for example, if you were to
mount (or have auto-mounted) removable media with nosuid but without
noexec, and the removable media had been maliciously crafted with a
file with an entrypoint type, then a user could use it to transition to
a potentially more privileged SELinux domain, even though it could not
gain capabilities or uid-0 that way (or, if the user can induce another
process to execute from this filesystem, then this could produce a
domain transition that would normally have been prevented).  Ditto for
network filesystems.  This is perhaps an argument for introducing a
separate check on nosuid; could be done via a file-based additional
check (Can domain D nosuid_transition on file type T?) in addition to
the nnp_nosuid_transition process-based permission check or by adding a
process2 class and splitting nnp_nosuid_transition into
nosuid_transition and nnp_transition process-based permissions.

2. It would mean that all domains could enable NNP, install seccomp
filters (allowed for unprivileged processes if NNP is enabled), and
execve a domain-changing program with those filters in effect, which
could potentially lead to subverting the new domain.  It is exactly for
this reason that domain transitions under NNP were originally not
allowed, and then only allowed for bounded transitions.  Also note that
NNP is intended to be used to open up other previously unsafe actions
for unprivileged processes, so this could be extended to more than just
seccomp in the future (examples given in the past have included chroot,
certain unshare/clone flags, etc, although it seems like some of this
has been obsoleted/replaced by user namespaces).

So from a safety POV, you really only want to allow this when the
calling domain is more trusted than the callee domain; think of it as
being similar (but not equivalent) to noatsecure and/or dyntransition.
