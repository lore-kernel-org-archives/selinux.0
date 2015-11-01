Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA1HOfFP002493
 for <selinux@tycho.nsa.gov>; Sun, 1 Nov 2015 12:24:45 -0500
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 0/7] Inode security label invalidation
Date: Sun,  1 Nov 2015 18:24:26 +0100
Message-Id: <1446398673-886-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Here is another version of the patch queue to make gfs2 and similar file
systems work with SELinux.  Previous posting:

  http://www.spinics.net/lists/selinux/msg17969.html

Changes since the previous version:

 * Use inode_security_novalidate instead of inode_security on all the
   SOCK_INODE(sock) inodes.

This patch queue is also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/agruen/linux.git selinux-wip

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
