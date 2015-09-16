Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8GK3eNu026669
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 16:03:41 -0400
Received: by ioii196 with SMTP id i196so206094ioi.3
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 13:03:36 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3 0/7] Initial support for user namespace owned mounts
Date: Wed, 16 Sep 2015 15:02:36 -0500
Message-Id: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is the third revision of the patch series to introduce the concept
of superblocks owned by user namespaces. These are nearly identical to
the v2 patches; the only changes are resolving conflicts from rebasing
onto 4.3-rc1 and reverting a change I inadvertantly introduced in v2.

These are the first in a larger set of patches, with the goal of
eventually allowing some regular filesystem types to be mounted in
unprivileged containers. The full series is available at:

  git://kernel.ubuntu.com/sforshee/linux.git userns-mounts

The strategy for this series is to do as much of the heavy lifting as
possible in the vfs to minimize the need to handle edge cases in
individual filesystems. The patches that follow lay some of the
groundwork and fall into two groups:

 1. Patches 1-2 add s_user_ns to struct superblock and use it to
    simplify MNT_NODEV handling.

 2. Patches 3-7 tighten down security for mounts with s_user_ns !=
    &init_user_ns.

Note that these patches only address security at the vfs level. As has
been discussed previously, individual filesystems may still be
vulnerable to attacks via malicious metadata in the backing store. The
goal is to find a small set of filesystems which can be hardened from
attacks from below. I am initially targeting fuse, which has been
designed to resist such attacks, and ext4, which is so far standing up
quite well to fuzzing.

Changes since v2:
 - Resolved conflicts from rebasing onto 4.3-rc1.
 - Reverted a change in the v2 patches which made fs_fully_visible use
   current_user_ns instead of s_user_ns when deciding whether to filter
   out MNT_LOCK_NODEV.

Andy Lutomirski (1):
  fs: Treat foreign mounts as nosuid

Eric W. Biederman (1):
  userns: Simpilify MNT_NODEV handling.

Seth Forshee (5):
  fs: Add user namesapace member to struct super_block
  fs: Verify access of user towards block device file when mounting
  fs: Limit file caps to the user namespace of the super block
  Smack: Add support for unprivileged mounts from user namespaces
  selinux: Add support for unprivileged mounts from user namespaces

 drivers/mtd/mtdsuper.c         |  7 +++++-
 fs/block_dev.c                 | 54 +++++++++++++++++++++++++++++++++---------
 fs/exec.c                      |  2 +-
 fs/namei.c                     |  9 ++++++-
 fs/namespace.c                 | 34 +++++++++++++++-----------
 fs/proc/root.c                 |  3 ++-
 fs/super.c                     | 38 +++++++++++++++++++++++++----
 include/linux/fs.h             | 11 ++++++++-
 include/linux/mount.h          |  1 +
 include/linux/user_namespace.h |  8 +++++++
 kernel/user_namespace.c        | 14 +++++++++++
 security/commoncap.c           |  4 +++-
 security/selinux/hooks.c       | 25 ++++++++++++++++++-
 security/smack/smack.h         |  6 +++++
 security/smack/smack_lsm.c     | 35 ++++++++++++++++++++-------
 15 files changed, 206 insertions(+), 45 deletions(-)
