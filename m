Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBOGPRqe021609
 for <selinux@tycho.nsa.gov>; Thu, 24 Dec 2015 11:25:27 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.5
Date: Thu, 24 Dec 2015 11:25:01 -0500
Message-ID: <1964478.KPgA55cFSS@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Nine patches for v4.5; there are a handful of minor fixes (constify 
parameters, warning rate-limits, etc.) but there are a couple of significant 
patches that invalidate/revalidate inode labels (needed for gfs2) and make 
validate_trans decisions visible via selinuxfs.  All the patches pass the 
selinux-testsuite and have been included in the pcmoore/kernel-secnext Fedora 
COPR repository[1] for some time now, all looks good.

As of about five minutes ago, selinux#upstream applied cleanly on top of 
linux-security#next so I don't expect you should have any problems merging the 
code.

Happy holidays and merry merging,
-Paul

[1] https://copr.fedoraproject.org/coprs/pcmoore/kernel-secnext

---
The following changes since commit ebd68df3f24b318d391d15c458d6f43f340ba36a:

  Sync to Linus v4.4-rc2 for LSM developers. (2015-11-23 22:46:28 +1100)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 76319946f321e30872dd72af7de867cb26e7a373:

  selinux: rate-limit netlink message warnings in selinux_nlmsg_perm() 
(2015-12-24 11:09:41 -0500)

----------------------------------------------------------------
Andreas Gruenbacher (7):
      selinux: Remove unused variable in selinux_inode_init_security
      security: Make inode argument of inode_getsecurity non-const
      security: Make inode argument of inode_getsecid non-const
      selinux: Add accessor functions for inode->i_security
      security: Add hook to invalidate inode security labels
      selinux: Revalidate invalid inode security labels
      gfs2: Invalid security labels of inodes when they go invalid

Andrew Perepechko (1):
      selinux: export validatetrans decisions

Vladis Dronov (1):
      selinux: rate-limit netlink message warnings in selinux_nlmsg_perm()

 fs/gfs2/glops.c                     |   2 +
 include/linux/audit.h               |   8 +-
 include/linux/lsm_hooks.h           |  10 +-
 include/linux/security.h            |  13 ++-
 kernel/audit.c                      |   2 +-
 kernel/audit.h                      |   2 +-
 kernel/auditsc.c                    |   6 +-
 security/security.c                 |  12 ++-
 security/selinux/hooks.c            | 206 ++++++++++++++++++++++++----------
 security/selinux/include/classmap.h |   2 +-
 security/selinux/include/objsec.h   |   6 ++
 security/selinux/include/security.h |   3 +
 security/selinux/selinuxfs.c        |  80 ++++++++++++++
 security/selinux/ss/services.c      |  34 ++++--
 security/smack/smack_lsm.c          |   4 +-
 15 files changed, 302 insertions(+), 88 deletions(-)

-- 
paul moore
security @ redhat
