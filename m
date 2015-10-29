Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9T0lfPf011960
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 20:47:42 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 0/7] Inode security label invalidation
Date: Thu, 29 Oct 2015 01:47:08 +0100
Message-Id: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Here is another version of the patch queue to make gfs2 and similar file
systems work with SELinux.

In this version, dentry_security() helper has been renamed to
backing_inode_security() to make it more obvious that it revalidates the
backing inode of its dentry argument.  The file_path_has_perm and
file_has_perm functions no longer revalidate inode security labels; callers
that may sleep can call inode_security_revalidate() themselves instead.
The revalidation functions now make use of might_sleep() when appropriate
so that any remaining bugs should turn up soon.

With this version of the patch queue, the SELinux test suite passes:

  https://github.com/SELinuxProject/selinux-testsuite

Could you please review?

Thanks,
Andreas

Andreas Gruenbacher (7):
  selinux: Remove unused variable in selinux_inode_init_security
  security: Make inode argument of inode_getsecurity non-const
  security: Make inode argument of inode_getsecid non-const
  selinux: Add accessor functions for inode->i_security
  security: Add hook to invalidate inode security labels
  selinux: Revalidate invalid inode security labels
  gfs2: Invalide security labels of inodes when they go invalid

 fs/gfs2/glops.c                   |   2 +
 include/linux/audit.h             |   8 +-
 include/linux/lsm_hooks.h         |  10 +-
 include/linux/security.h          |  13 ++-
 kernel/audit.c                    |   2 +-
 kernel/audit.h                    |   2 +-
 kernel/auditsc.c                  |   6 +-
 security/security.c               |  12 ++-
 security/selinux/hooks.c          | 197 +++++++++++++++++++++++++++-----------
 security/selinux/include/objsec.h |   6 ++
 security/smack/smack_lsm.c        |   4 +-
 11 files changed, 186 insertions(+), 76 deletions(-)

-- 
2.5.0
