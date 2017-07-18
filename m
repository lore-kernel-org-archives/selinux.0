Message-ID: <1500383878.18445.1.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>, Jason Zaman <jason@perfinion.com>
Cc: selinux@tycho.nsa.gov, luto@amacapital.net
Date: Tue, 18 Jul 2017 09:17:58 -0400
In-Reply-To: <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <20170716151512.GA4615@meriadoc.perfinion.com>
 <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid SELinux
 domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-07-17 at 15:54 -0400, Paul Moore wrote:
> On Sun, Jul 16, 2017 at 11:15 AM, Jason Zaman <jason@perfinion.com>
> wrote:
> > On Fri, Jul 14, 2017 at 12:46:47PM -0400, Stephen Smalley wrote:
> > > As systemd ramps up enabling NNP (NoNewPrivileges) for system
> > > services,
> > > it is increasingly breaking SELinux domain transitions for those
> > > services
> > > and their descendants.  systemd enables NNP not only for services
> > > whose
> > > unit files explicitly specify NoNewPrivileges=yes but also for
> > > services
> > > whose unit files specify any of the following options in
> > > combination with
> > > running without CAP_SYS_ADMIN (e.g. specifying User= or a
> > > CapabilityBoundingSet= without CAP_SYS_ADMIN): SystemCallFilter=,
> > > SystemCallArchitectures=, RestrictAddressFamilies=,
> > > RestrictNamespaces=,
> > > PrivateDevices=, ProtectKernelTunables=, ProtectKernelModules=,
> > > MemoryDenyWriteExecute=, or RestrictRealtime= as per the
> > > systemd.exec(5)
> > > man page.
> > > 
> > > The end result is bad for the security of both SELinux-disabled
> > > and
> > > SELinux-enabled systems.  Packagers have to turn off these
> > > options in the unit files to preserve SELinux domain
> > > transitions.  For
> > > users who choose to disable SELinux, this means that they miss
> > > out on
> > > at least having the systemd-supported protections.  For users who
> > > keep
> > > SELinux enabled, they may still be missing out on some
> > > protections
> > > because it isn't necessarily guaranteed that the SELinux policy
> > > for
> > > that service provides the same protections in all cases.
> > > 
> > > commit 7b0d0b40cd78 ("selinux: Permit bounded transitions under
> > > NO_NEW_PRIVS or NOSUID.") allowed bounded transitions under NNP
> > > in
> > > order to support limited usage for sandboxing programs.  However,
> > > defining typebounds for all of the affected service domains
> > > is impractical to implement in policy, since typebounds requires
> > > us
> > > to ensure that each domain is allowed everything all of its
> > > descendant
> > > domains are allowed, and this has to be repeated for the entire
> > > chain
> > > of domain transitions.  There is no way to clone all allow rules
> > > from
> > > descendants to their ancestors in policy currently, and doing so
> > > would
> > > be undesirable even if it were practical, as it requires leaking
> > > permissions to objects and operations into ancestor domains that
> > > could
> > > weaken their own security in order to allow them to the
> > > descendants
> > > (e.g. if a descendant requires execmem permission, then so do all
> > > of
> > > its ancestors; if a descendant requires execute permission to a
> > > file,
> > > then so do all of its ancestors; if a descendant requires read to
> > > a
> > > symbolic link or temporary file, then so do all of its
> > > ancestors...).
> > > SELinux domains are intentionally not hierarchical / bounded in
> > > this
> > > manner normally, and making them so would undermine their
> > > protections
> > > and least privilege.
> > > 
> > > We have long had a similar tension with SELinux transitions and
> > > nosuid
> > > mounts, albeit not as severe.  Users often have had to choose
> > > between
> > > retaining nosuid on a mount and allowing SELinux domain
> > > transitions on
> > > files within those mounts.  This likewise leads to unfortunate
> > > tradeoffs
> > > in security.
> > > 
> > > Decouple NNP/nosuid from SELinux transitions, so that we don't
> > > have to
> > > make a choice between them. Introduce a nnp_nosuid_transition
> > > policy
> > > capability that causes the ability to transition under NNP/nosuid
> > > to
> > > be based on a nnp_nosuid_transition permission between the old
> > > and new
> > > contexts rather than typebounds.  Domain transitions can then be
> > > allowed
> > > in policy without requiring the parent to be a strict superset of
> > > all of
> > > its children.
> > > 
> > > With this change, systemd unit files can be left unmodified from
> > > upstream.
> > > SELinux-disabled and SELinux-enabled users will benefit from
> > > retaining any
> > > of the systemd-provided protections.  SELinux policy will only
> > > need to
> > > be adapted to enable the new policy capability and to allow the
> > > new permission between domain pairs as appropriate.
> > 
> > A few things, the name is pretty awkward. my main issue with it is
> > what
> > if some other similar kind of thing is added in the future then
> > we'll
> > have nnp_nosuid_transition that should also cover it but the name
> > wont
> > cover it.
> 
> Yes, I don't think anyone is in love with the name, but no one
> offered
> anything better; see the previous patch posting for some of that
> discussion.  If you have a better suggestion I would love to hear it.

Agreed, although I'm skeptical that there will be any "other similar
kind of thing" added in the future that we would want to cover under
the same permission.

> 
> > Why do we want to disallow type-bounds to work even with the
> > capability?
> > it seems sensible to me to allow typebounds to transition even in
> > the
> > future. If we do then we probably dont need the policycap which
> > seems
> > less complicated.
> 
> The suggestion to continue to support bounded domain transitions
> seems
> reasonable to me, although we would need to worry about which check
> to
> do first (bounded transition or process:nnp_nosuid_transition), and
> how to limit the auditing/reporting so admins are confused by the
> first check failing, yet the transition still taking place.  None of
> these are unsolvable problems, but it will likely need a bit more
> work.
> 
> I'm sure Stephen has some thoughts on this as well.

Others (e.g. Dominick) seemed to take the opposite view on the earlier
RFC discussion, i.e. that we should only check the new permission if
the capability is enabled.  I specifically raised that as a question
there.

I'm willing to change it to fallback to checking for a bounded type,
but that will mean two audit messages (I don't think we can just hide
one of them) when neither is allowed.  That said, it is unlikely to
cause much confusion in practice because users typically only look for
and pay attention to AVC messages, and anyone using audit2allow will
just end up allowing the permission, not the bounds.

> 
> > also how are we thinking to do this in refpol? only add it
> > specifically
> > as needed? or would it be added to the execute_file_perms type
> > macros?
> > Although, grep typebounds is nowhere to be found currently in
> > either
> > refpol and gentoo's repo.
> 
> I'm *really* hoping this new permission is only granted where
> absolutely needed, which I hope should be rather small (see the patch
> description and the discussion regarding systemd unit files).

Actually, I'm not clear on that.  If systemd continues to expand the
usage of these options in its unit files (which seems likely), then I
could see this ultimately affecting all service domains and all of
their descendants.  If it was only going to be a handful of domains,
then the typebounds solution might be more tractable, albeit painful.
