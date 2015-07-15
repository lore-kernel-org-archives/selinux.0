Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FKaSiO000695
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 16:36:28 -0400
Message-ID: <55A6C448.5050902@schaufler-ca.com>
Date: Wed, 15 Jul 2015 13:36:24 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/15/2015 12:46 PM, Seth Forshee wrote:
> These are the first in a larger set of patches that I've been working on
> (with help from Eric Biederman) to support mounting ext4 and fuse
> filesystems from within user namespaces. I've pushed the full series to:
>
>   git://kernel.ubuntu.com/sforshee/linux.git userns-mounts
>
> Taking the series as a whole, the strategy is to handle as much of the
> heavy lifting as possible in the vfs so the filesystems don't have to
> handle weird edge cases. If you look at the full series you'll find that
> the changes in ext4 to support user namespace mounts turn out to be
> fairly minimal (fuse is a bit more complicated though as it must deal
> with translating ids for a userspace process which is running in pid and
> user namespaces).
>
> The patches I'm sending today lay some of the groundwork in the vfs and
> related code. They fall into two broad groups:
>
>  1. Patches 1-2 add s_user_ns and simplify MNT_NODEV handling. These are
>     pretty straightforward, and Eric has expressed interest in merging
>     these patches soon. Note that patch 2 won't apply cleanly without
>     Eric's noexec patches for proc and sys [1].
>
>  2. Patches 2-7 tighten down security for mounts with s_user_ns !=
>     &init_user_ns. This includes updates to how file caps and suid are
>     handled and LSM updates to ignore security labels on superblocks
>     from non-init namespaces.
>
>     The LSM changes in particular may not be optimal, as I don't have a
>     lot of familiarity with this code, so I'd be especially appreciative
>     of review of these changes and suggestions on how to improve them.

Lukasz Pawelczyk <l.pawelczyk@samsung.com> proposed
LSM support in user namespaces ([RFC] lsm: namespace hooks)
that make a whole lot more sense than just turning off
the option of using labels on files. Gutting the ability
to use MAC in a namespace is a step down the road of
making MAC and namespaces incompatible.



>
> Subsequent patches will update the vfs for id translation, handling
> various corner cases, giving privileges to the user namsepace which owns
> a superblock, and finally supporting user namespace mounts for ext4 and
> fuse.
>
> Thanks,
> Seth
>
> [1] http://lkml.kernel.org/r/87mvz4yomp.fsf_-_@x220.int.ebiederm.org
>
>
> Andy Lutomirski (1):
>   fs: Treat foreign mounts as nosuid
>
> Eric W. Biederman (1):
>   userns: Simpilify MNT_NODEV handling.
>
> Seth Forshee (5):
>   fs: Add user namesapace member to struct super_block
>   fs: Ignore file caps in mounts from other user namespaces
>   security: Restrict security attribute updates for userns mounts
>   selinux: Ignore security labels on user namespace mounts
>   smack: Don't use security labels for user namespace mounts
>
>  fs/block_dev.c                 |  2 +-
>  fs/exec.c                      |  2 +-
>  fs/namei.c                     |  9 ++++++++-
>  fs/namespace.c                 | 34 ++++++++++++++++++++--------------
>  fs/proc/root.c                 |  3 ++-
>  fs/super.c                     | 38 +++++++++++++++++++++++++++++++++-----
>  include/linux/fs.h             |  9 +++++++++
>  include/linux/mount.h          |  1 +
>  include/linux/user_namespace.h |  8 ++++++++
>  kernel/user_namespace.c        | 14 ++++++++++++++
>  security/commoncap.c           |  4 +++-
>  security/security.c            | 10 +++++++++-
>  security/selinux/hooks.c       | 16 +++++++++++++++-
>  security/smack/smack_lsm.c     | 12 ++++++++++--
>  14 files changed, 134 insertions(+), 28 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
