MIME-Version: 1.0
In-Reply-To: <4CFB4191.3090106@schaufler-ca.com>
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
	<4CF9C1A1.7050603@schaufler-ca.com>
	<1291498481.4929.77.camel@localhost.localdomain>
	<4CFB4191.3090106@schaufler-ca.com>
Date: Tue, 7 Dec 2010 08:43:41 -0500
Message-ID: <AANLkTinm_Or+G=BjOU7Tdher-6YnOZXdtb43nGX4N+Et@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fs/vfs/security: pass last path component to LSM
 on inode creation
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Paris <eparis@redhat.com>, penguin-kernel@i-love.sakura.ne.jp,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Dec 5, 2010 at 2:38 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The end to which the controls are put does not change the character
> of those controls. If the attribute of the file being used is the
> name component of the name/inode pair in a directory entry than what
> you have is a pathname based control mechanism. It will have all of
> the downsides, including mount points and hard links, that any other
> name based scheme will suffer from.

I think this is a misunderstanding.
The mechanism that Eric is proposing (which btw is something that has
long since been discussed among the SELinux developers and agreed to
in principle, so this is not a point of contention among SELinux
developers) is to allow the last component name of a newly created
file to be used as an optional additional input into the decision
logic for computing the new label of that inode.  You can already use
the security contexts of the creating process and the parent directory
along with the type of file (security class) as inputs into that
logic, so this merely adds one additional factor that can be leveraged
by policy writers.  It is only used as an input when the file is
created (file access is still based solely on its previously
determined security context) and namespace manipulation has no effect
on it (creating a hard link to the file does not involve this logic,
nor does renaming it nor mounting the containing filesystem
elsewhere).

> These "userspace hacks" are no "worse" than restorecond from a
> security perspective. They have the unpleasant characteristic that
> they are outside the control of the primary distributor of SELinux.
> I will admit that the suggested changes will make SELinux better.
> That does not make them any less pathname based.

I don't follow this logic.  restorecond and udev relabeling of
kernel-created dev nodes are inherently racy - the file is not created
in the desired security context initially, and must be relabeled by
some userspace component that notices that the file has been created.
Kernel support for incorporating the last component name as an
additional input enables us to label certain files correctly upon
creation and thus avoids that problem entirely.  And as for being
outside the control of a given distributor, I think that is both a
fallacy (it is no harder to replace or extend userspace than it is to
replace/extend policy) and irrelevant.

> Initial labeling of objects is critical. There is no point in
> talking about the access control decision if you can't say good
> things about how the label gets set initially.

That's true, and precisely why this is beneficial - it gives us an
additional input to use when labeling objects initially that improves
our accuracy of labeling at file creation time.  BTW, this isn't as
novel to SELinux as you seem to think.  That fact that we are already
using the parent directory context as an input in computing the
security context of a new files means that our file labeling logic is
already "path-based" in a certain sense.  It isn't solely path-based
(either before or after this change), but it is already taking into
account the placement of the file when it is created.  This just
refines the granularity at which we can make such decisions.

> My point is roughly centered around the distinction between a Linux
> kernel with SELinux configured and a policy installed and an SELinux
> system with the aforementioned and a complete SELinux runtime that
> includes goodies like restorecond. The former is strictly label based,
> while the latter is definitely not. I really think that you should
> leave the name based bits in userspace unless you are willing to
> accept their general value in the kernel.

SELinux remains label-based in its access control enforcement
mechanism in the kernel even after this change.  In any event, you are
free to configure your policy to not use this extension just as you
are free to not ship/run restorecond - there is no real difference
there.

With regard to the pathname hooks, they aren't suitable because they
don't have anything to do with assigning labels to new inodes - they
are about enforcing access control upon file accesses based on the
pathname used to reach the file.  That doesn't support what we want.

The only real question for this particular patch IMHO is whether the
changes being made here are sensible from a vfs and fs point of view.
Most of your comments seem more directed at whether or not SELinux
should be extended in this manner (i.e. the 2nd patch), and that's a
question for the SELinux developers, who have already come to
consensus on the matter.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
