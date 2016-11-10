From: Andreas Gruenbacher <agruenba@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, selinux@tycho.nsa.gov
Subject: [PATCH 0/4] selinux: Fix invalidate deadlock with GFS2
Date: Thu, 10 Nov 2016 22:18:26 +0100
Message-Id: <1478812710-17190-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This set of four patches fixes a deadlock between selinux and GFS2 when GFS2
invalidates a security label.  Please review and consider for the next merge
cycle.

Thanks,
Andreas

Andreas Gruenbacher (4):
  selinux: Minor cleanups
  proc: Pass file mode to proc_pid_make_inode
  selinux: Clean up initialization of isec->sclass
  selinux: Convert isec->lock into a spinlock

 fs/proc/base.c                    |  23 +++----
 fs/proc/fd.c                      |   6 +-
 fs/proc/internal.h                |   2 +-
 fs/proc/namespaces.c              |   3 +-
 security/selinux/hooks.c          | 122 ++++++++++++++++++++++++--------------
 security/selinux/include/objsec.h |   5 +-
 security/selinux/selinuxfs.c      |   4 +-
 7 files changed, 94 insertions(+), 71 deletions(-)

-- 
2.7.4
