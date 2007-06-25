Subject: Re: regarding privilege granting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <736334.35671.qm@web51504.mail.re2.yahoo.com>
References: <736334.35671.qm@web51504.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 12:44:05 -0400
Message-Id: <1182789845.5636.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-25 at 08:22 -0700, Steve G wrote:
> >> 1) Education. We've been telling users all along that SE Linux does not 
> >> grant permissions. It adds restrictions on top of DAC. To change that 
> >> now would likely confusion the casual user.
> >
> >Being able to fully manage privileges/capabilities based on Role-Based
> >Access Control and Type Enforcement has been a design goal from day one,
> >and was identified as such back in 2000.
> 
> Even if it was a design goal, that does not help with what everyone has been
> trained to understand. We've been telling people that SE Linux is safe to use
> since it does not grant any permissions, it just takes away.

The notion that a restrictive-only security mechanism is "safe to use"
is rather flawed.  Any new security mechanism has the potential to make
the system less secure, e.g.
- There may be flaws in the code (both kernel and userland) of the new
security mechanism, and that code presents a new attack surface.
- Given a more flexible and powerful security mechanism, users will
often choose to use it to replace less flexible or powerful mechanisms.
As an example, people have used selinux to supplant use of chroot in
some instances (even within Red Hat's distribution - e.g. see named(8)
NOTES).  I have not encouraged that practice, as defense-in-depth is
useful, but realistically, if people can't take advantage of newer
mechanisms in this manner, then those newer mechanisms are less valuable
to the end user and won't actually get significant usage.

The notion that an authoritative security mechanism is necessarily less
safe is also flawed.  It comes down to policy configuration, and this
extension to selinux has been designed such that no permissions are
granted authoritatively without a new allow rule on the new cap_override
class.  So it is easy to disable this feature in policy, audit for its
use, etc.  Further, as this new mechanism can replace the current use of
setuid root programs, it can actually provide greater safety and easier
analysis/auditing.

> >  In fact, people new to SELinux are often surprised that we don't already
> > provide them with a way to give capabilities to specific programs without
> > them running as uid 0 (even initially);
> 
> I think they are surprised because the assume the worst and later are relieved to
> find out that DAC still has first vote and they still understand their system and
> can control access rights without having to learn SE Linux policy.

No, we often find people disappointed and looking for other solutions to
the problem of how to grant capabilities to non-root processes when we
tell them that SELinux cannot do that by itself.  This is what drives
people to things like file capabilities, which have their own set of
issues (e.g. hardcoded capability evolution logic, distributed
protection state).  As well as to userland role-based schemes that are
in fact implemented entirely via trusted programs (sudo-like) with
inadequate kernel support to provide real protection.

> >> 2) Nothing security relavent happens without root. All of the trusted 
> >> databases require uid 0 to write to them. In some cases to read. All 
> >> applications that need special permissions have been carefully arranged to
> >> start as root and drop capabilities as they can.
> >
> >Many users don't want to have to run everything security-relevant as
> >root (even initially);
> 
> They all do. The system will not work any other way. Do you realize how many apps
> do a capability check by: if (getuid() != 0)   all those apps would break in a 
> new privilege granting scheme.

Such hardcoded checks in applications are undesirable, as is making uid
0 all powerful, just as in the kernel.  We have already extended a
number of those applications to also apply an orthogonal SELinux
permission check so that we can limit what even uid 0 processes can do
via such applications, in the same way that we modified the kernel to
apply a SELinux check whenever a capability was checked.  Further
enhancing those applications to allow similar overrides based entirely
on SELinux policy would be the next logical step after this kernel
enhancement is made.  Again, think of how you would actually want a real
role-based system to work - you want users logging in as themselves and
creating a session in a desired role, then performing operations in that
role without needing to separately switch to uid 0.

> >Again, this is not fundamentally different than file capabilities in terms 
> >of non-root have privs.
> 
> I don't care for that either. But its probably more likely to meet compliance
> issues since it can probably be worked into a 'find' command to scan the system
> for programs with elevated privileges.

So can searching for file entrypoint types for domains allowed
cap_override permissions.  It might not be a trivial command line today,
but that's because this is newly proposed kernel functionality.
Shouldn't be a difficult extension to sesearch to extract those file
entrypoint types and then feed that list to a find command.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
