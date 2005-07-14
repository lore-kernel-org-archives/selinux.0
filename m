Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6E3bcgA000374
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 23:37:38 -0400 (EDT)
Received: from web31611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j6E3XYZr027741
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 03:33:35 GMT
Message-ID: <20050714033414.97168.qmail@web31611.mail.mud.yahoo.com>
Date: Wed, 13 Jul 2005 20:34:14 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: MCS/Targeted Policy...
To: James Morris <jmorris@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0507132104400.10789-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- James Morris <jmorris@redhat.com> wrote:

> On Wed, 13 Jul 2005, Casey Schaufler wrote:
> 
> > I expect that you're going to have an
> > uphill battle explaining how this is
> > superior to ACLs.
> 
> I would not claim that MCS is superior to ACLs
> (whatever superior is 
> supposed to mean).

In this context I would suggest that superior
means that if Linux were only going to support
one general purpose DAC mechanism it would
be the superior one.

> MCS categories, as initially envisioned, are
> functionally similar to ACLs, 
> but not equivalent.

Yes, I can see that. They are based on
attributes other than user id and group
membership.

> There are some fundamental differences between the
> systems; here are some
> very basic definitions:
> 
> - ACLs govern discretionary access rights to an
> object.
> - MCS constrains DAC and TE access rights to an
> object.

Discretionary Type Enforcement? Is that
really what you want to propose?

> ACLs impose a specific set of access rights (rwx)
> and semantics, which are
> not necessarily appropriate to our needs.

POSIX ACLs are carefully designed to allow
for extension beyond rwx. While existing
implementations may not make this obvious,
the spec has no restrictions.

> For example, TE provides a
> richer set of permissions and security
> abstractions,

Perhaps not the adjective I'd have chosen,
but fundamentally true...

> which MCS can readily constrain.

Right. I get that. Given the richness
of the SELinux policy scheme it seems
there could be the opportunity here to
add just a little bit more flavor to
the soup.

> MCS can also operate on TE attributes.

Giving users descretionary control over
TE attributes seems counter to the "SELinux
is a MAC scheme" position I've heard
fairly regularly, but it is a logical
extension.

> ACL labeling semantics are fixed.  Examples:
> - ACLs must be copied from a directory's default ACL
> list for files
>   created in that directory.

Well yeah. It's nice to know how the facility
is going to work in advance!

> - If a user has newgrp'd to a supplementary group,
> files created by the
>   user will be created with that group.

File system semantics permitting. Again, I
feel secure when I know what's going to happen!

> We don't necessarily want these things to always
> happen, and in fact,
> definitely don't under the initial model.

OKay. Gosh, it would have helped to have
you around when we were doing the initial
work on LSM. Maybe we could have gotten
authoritative hooks in.

> MCS labeling semantics could be
> more flexible, if required, via policy
> specification and/or changes in fs
> labeling behavior.

Of course. On the other hand, you could
throw out all OS based access control and
leave it to the applications to work out.
That would be flexible, too.

> ACLs are limited to a small set of file type OS
> objects.  MCS could be
> applied to any of the objects which SELinux
> controls, including userspace
> components.

ACLs on sockets have been done in the past,
you know, just as has MLS.

> Down the track, MCS could be useful for
> things like Security
> Enhanced X and Postgresql.

The problem with network service applications
is the transmission of attributes, not the
implementation of policy upon the attributes.
MCS will be no more or less useful to these
environments than the existing TE scheme or
a good B&L.

> MCS seems to provide far
> more extensibility
> and scope as an SELinu-based technology.

Yes, it does seem a somewhat obvious
branch to the TE mindset.

> MCS may not always be as simple DAC mechanism.  This
> is how it is
> initially envisioned, but via SELinux policy, its
> behavior can be changed.

Yeah. Additional sophistication.

> Note that MCS is merely a simplified MLS policy (but
> should not be
> considered in any way to actually be MLS of course:
> I'm referring to the
> technology base).  It is essentially a filesystem
> relabel and a policy
> change which makes use of existing or planned MLS
> components.

Yes, I can see that. While it may help
exercise some of the code paths, don't
think that it will help you understand
MLS. As Mr. Smalley will not doubt attest,
MAC has a whole different set of issues.

> MCS would be more closely integrated with both
> SELinux and CAPP audit,
> and better leverage existing technologies and
> efforts in these areas.

Which still won't help with a mode bit failure.

> An ACL failure, by default, will not be audited.

It would be on all the audit systems I ever
worked on!

> An MCS failure will be
> audited as an SELinux denial, which will contain
> important security
> information, such as security contexts containing
> category labels.

That's good.

> Auditing can be further enhanced if necessary with
> auditallow rules, and
> ultimately, enabling auditd.  Adding an audit rule
> for ACL controlled
> operations is not as useful: neither the object's
> ACL nor the subject's
> supplementary groups are included in audit records.

That's a bug in the audit system, not
a flaw in ACLs.

> If ACLs were to be considered as an alternative to
> MCS, setting aside the 
> relative inflexibility, reduced integration with
> CAPP/SELinux and fixed 
> semantics as discussed above, there are still issues
> such as:
> 
> - ACL functionality needs to be mapped to basic MCS
> functionality. e.g.
>   higher level tools than get/setfacl would be
> needed ensure that the
>   effective rights mask is set correctly and that
> 'rwx' is always set.

ANy time you have two ways to do the same
thing each camp can come up with scenarios
that are easier using their mechanism.

>   It's simpler just to use MCS directly.

If you understand the domains and privileges
involved and can be trusted to set your MCS
attributes appropriately, yes. There's a reason
that the traditional Unix policy is limited
in what the user is allowed to specify.

> - What happens if SELinux is disabled on the system?
> ACLs will still be in 
>   effect, and security could be seriously degraded
> without TE in place, as 
>   ACLs are a privilege escalation mechanism.

What! This you've got to explain.

> In the
> case of MCS, the 
>   category labels would do nothing without SELinux
> enabled.

Ah. The POSIX ACL group made sure that adding
an ACL to a file would not interfere with the
mode bits, nor encourage users to set them
"wide open" and count on the ACL alone.

Imagine a system with MCS. If everything
and everyone used MCS, all the mode bits
could be 777, and you might do that so they
would not interfere with the desired MCS
activity. Bring that up without SELinux.

> - Re-using ACLs for this purpose may also clash with
> other uses of ACLs 
>   and Unix groups on the same system.  We'd be kind
> of hijacking ACLs.

Well, enhancing is the positive way to put it.
And yes, you would have to convince the ACL
maintainers it's a good thing.

In review, MCS is a logical extension to
SELinux. I expect you'll have to put more
limits on its flexibility than you think.
I expect to enjoy watching the experiment.
 


Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
