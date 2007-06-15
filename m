Subject: Re: regarding privilege granting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20842.17629.qm@web51509.mail.re2.yahoo.com>
References: <20842.17629.qm@web51509.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 14:30:14 -0400
Message-Id: <1181932214.17547.882.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-15 at 08:41 -0700, Steve G wrote:
> Hi,
> 
> I'm not sure I really like the idea of SE Linux getting in the business of
> granting permissions. I want to make sure that we have a full discussion about
> all aspects of the change. Some of these items I know can be decided by policy,
> but I think you will hear things like this when it goes up for wider review. I
> want to state them here so that we have answers later.

Hi Steve,

Have you read the RFC v2 patch description?  I think it addresses many
of these concerns.  But I'll go through them one-by-one below.

> 1) Education. We've been telling users all along that SE Linux does not grant
> permissions. It adds restrictions on top of DAC. To change that now would likely
> confusion the casual user.

Being able to fully manage privileges/capabilities based on Role-Based
Access Control and Type Enforcement has been a design goal from day one,
and was identified as such back in 2000.  In fact, people new to SELinux
are often surprised that we don't already provide them with a way to
give capabilities to specific programs without them running as uid 0
(even initially); they want to do that, and they have been asking to be
able to do that ever since basic capability support went into the
mainline kernel.  There are two ways of achieving that end:  the file
capabilities patch already in -mm, or enabling security modules to fully
manage the capabilities.  FreeBSD is already doing the latter.  We think
that the latter offers some advantages over the former, as explained in
the patch description, but we aren't excluding the file capabilities
support from being used either.

> 2) Nothing security relavent happens without root. All of the trusted databases
> require uid 0 to write to them. In some cases to read. All applications that need
> special permissions have been carefully arranged to start as root and drop
> capabilities as they can.

Many users don't want to have to run everything security-relevant as
root (even initially); they want to be able to assign privileges to
users based role, and they want to be able to assign privileges to
applications without requiring them to be fully privileged at startup.
The Oracle folks specifically didn't want their software to have to run
as root on Linux (discussion on lkml a long time ago).  Again, this is
not fundamentally different than file capabilities in terms of non-root
have privs.

> 3) In the few places where setuid must be used, these programs have undergone
> review dozens of times for flaws. No one allows them without much review. If SE
> Linux gets into the business of granting privs, then I doubt people would give
> the apps the extra amount of review that they should get.

Writing SELinux policy is not easier / more prone to abuse than setting
the suid bit on a binary or setting file capabilities on it.  And it has
nothing to do with the level of review (which I think you overestimate,
especially for third party and in-house apps).

> 4) Setuid apps are also given special protection by the runtime linker. Without
> having the equivalent ability, you are opening the door to attacks in ways that
> were probably not imagined.

Um, do you not know about AT_SECURE?
http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/0105.html
We've had equivalent ability for a long time now.
And file capabilities leverages it too.

> 5) Apps could work when SE Linux is enabled and suddenly malfunction if selinux
> is disabled. I could see a case where an app had a certain power and loses it
> while its running (depending on what permissive means) and leaves the system in
> an unsafe state.

Yes, the application will lose any privileges granted in this manner if
SELinux is permissive or disabled, as noted in the patch description.
Which means that in general purpose distros (like Fedora), you won't be
able to apply this approach to your core system applications anytime
soon (until/unless we get to the point where no one even asks to turn
selinux off and policy generation is as easy to do in enforcing as
permissive).  But it can be applied incrementally even in such distros,
and it can be applied wholesale to security-oriented specialized distros
and custom builds, some of which already disable the SELinux kernel
support for disabling SELinux or making it permissive because they don't
want that to be possible. 

> 6) What would permissive mode look like? Would any app that wants any capability
> automatically get it? If you enforce old capability model then it isn't
> permissive since you won't be able to collect all the permissions that an app
> needs.

I think you need to go back and read the patch description - the above
is not correct.  Permissive situation is same as disabled, and these
rules will not and don't have to be auto generated.

> 7) It will be hard to find for compliance auditing any applications that have
> been granted special privileges.

Um, no - they will be explicitly called out by the cap_override rules in
policy.  Very easy to search for in policy, much more so than scanning
the filesystem for suid binaries or file capabilities.

> 8) Backdoors can be planted into systems with the aid of selinux policy. People
> have no way of comparing what is in memory against what is on disk. Modifying
> policy in memory will become an attack point since it now can grant capabilities
> instead of impose restrictions. Rootkit detectors will not be able to find this
> attack vector.

If you can write to kernel memory, you've won, and your "rootkit
detectors" can never reliably detect anything unless they run in a
separate VM protected from the potentially broken OS.  And overwriting
the task's uid/gid/capability bitmasks is no harder than injecting bad
rules into the avtab or entries into AVC.

> 9) Allowing SE Linux to override DAC restrictions means that we go from 2 layers
> of security to 1 layer. All analysis would have to be done from a selinux
> perspective. I seriously doubt the average admin will be able to analyze the
> security implications on a server given the tools available. You would need to
> have commandline tools that lets an admin make some basic discoveries about
> access. They will need to be able to find all apps with elevated privileges, what
> capabilities does it have. Given a file, what accounts & domain can access or
> alter it, given a file and domain what actions can be performed? I think this
> will tremendously complicate understanding security for your machine.

It actually makes it possible to understand the security of your system,
unlike the suid model or even the file capability model.  Centralized
and analyzable policy.

> 10) Simple commandline tools will need to be available for people to remove the
> granted capability if they disagree with it. Think about times when people chmod
> a program to remove the setuid bit so that it only runs for the admin.

We have talked about allowing people to insert a local module that
actually deletes any matching allow rules from the base policy, not only
for this purpose but to generally allow stripping permissions.

> 11) What about signal/ptrace attacks. If apps started as a user do not change
> uid, the user has control over them. Some operations follow uid rules when the
> kernel is deciding whether or not to allow an interaction. If SE Linux elevates
> the privs, then the user may have a new way to attack a previously unassailable
> target.

All controlled (and much more comprehensively) based on SELinux security
context/domain already.  

> There are likely many unforeseen attack vectors that this opens the door to.
> There would have to be new analytical tools created to allow people to understand
> what they are deploying. This has to be carefully considered by a wider audience
> before proceeding.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
