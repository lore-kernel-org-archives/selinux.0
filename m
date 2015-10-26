Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9QLFgiU009697
 for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2015 17:15:42 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 0/7] Inode security label invalidation
Date: Mon, 26 Oct 2015 22:15:21 +0100
Message-Id: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Here is another version of the patch queue to make gfs2 and similar file
systems work with SELinux.  As suggested by Stephen Smalley [*], the relevant
uses of inode->security are wrapped in function calls that try to revalidate
invalid labels.

  [*] http://marc.info/?l=linux-kernel&m=144416710207686&w=2

The patches are looking good from my point of view; is there anything else that
needs addressing?

Does SELinux have test suites that these patches could be tested agains?

Thanks,
Andreas

Andreas Gruenbacher (7):
  selinux: Remove unused variable in selinux_inode_init_security
  selinux: Add accessor functions for inode->i_security
  selinux: Get rid of file_path_has_perm
  selinux: Push dentry down from {dentry,path,file}_has_perm
  security: Add hook to invalidate inode security labels
  selinux: Revalidate invalid inode security labels
  gfs2: Invalide security labels of inodes when they go invalid

 fs/gfs2/glops.c                   |   2 +
 include/linux/lsm_hooks.h         |   6 ++
 include/linux/security.h          |   5 +
 security/security.c               |   8 ++
 security/selinux/hooks.c          | 213 ++++++++++++++++++++++----------------
 security/selinux/include/objsec.h |   6 ++
 6 files changed, 152 insertions(+), 88 deletions(-)

-- 
2.5.0
