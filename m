Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5MN5U3b018018
 for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2017 19:05:31 -0400
Received: by mail-lf0-f67.google.com with SMTP id f28so4470077lfi.3
 for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2017 16:05:23 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jun 2017 19:05:21 -0400
Message-ID: <CAHC9VhQBMBgH16Lo8dFYvLZ5k3zhr0ENXThzTtY=WWtQSqxHmg@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v4.13
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

While we're down to 21 patches for v4.13 (it was 31 for v4.12), the
diffstat jumps up tremendously with over 2k of line changes.  Almost
all of these changes are the SELinux/IB work done by Daniel Jurgens;
some other noteworthy changes include a NFS v4.2 labeling fix, a new
file:map permission, and reporting of policy capabilities on policy
load.  As usual, everything passes the selinux-testsuite and merges
cleanly with your current linux-security/next branch; please apply.

Thanks,
-Paul
---
The following changes since commit d68c51e0b377838dd31b37707813bb62089f399c:

 Sync to mainline for security submaintainers to work against (2017-05-22 16:32
:40 +1000)

are available in the git repository at:

 git://git.infradead.org/users/pcmoore/selinux stable-4.13

for you to fetch changes up to 6a3911837da0a90ed599fd0a9836472f5e7ddf1b:

 selinux: enable genfscon labeling for tracefs (2017-06-20 15:53:34 -0400)

----------------------------------------------------------------
Daniel Jurgens (9):
     IB/core: IB cache enhancements to support Infiniband security
     IB/core: Enforce PKey security on QPs
     selinux lsm IB/core: Implement LSM notification system
     IB/core: Enforce security on management datagrams
     selinux: Create policydb version for Infiniband support
     selinux: Allocate and free infiniband security hooks
     selinux: Implement Infiniband PKey "Access" access vector
     selinux: Add IB Port SMP access vector
     selinux: Add a cache for quicker retreival of PKey SIDs

Florian Westphal (1):
     selinux: use pernet operations for hook registration

Jeff Vander Stoep (1):
     selinux: enable genfscon labeling for tracefs

Junil Lee (1):
     selinux: use kmem_cache for ebitmap

Markus Elfring (2):
     selinux: Return directly after a failed memory allocation in
              policydb_index()
     selinux: Return an error code only as a constant in sidtab_insert()

Matthias Kaehlcke (1):
     selinux: Remove redundant check for unknown labeling behavior

Scott Mayhew (1):
     security/selinux: allow security_sb_clone_mnt_opts to enable/disable
                       native labeling behavior

Stephen Smalley (4):
     selinux: only invoke capabilities and selinux for CAP_MAC_ADMIN checks
     selinux: add a map permission check for mmap
     selinux: do not check open permission on sockets
     selinux: log policy capability state when a policy is loaded

Tetsuo Handa (1):
     selinux: Use task_alloc hook rather than task_create hook

drivers/infiniband/core/Makefile     |   3 +-
drivers/infiniband/core/cache.c      |  43 ++-
drivers/infiniband/core/core_priv.h  | 115 ++++++
drivers/infiniband/core/device.c     |  86 +++++
drivers/infiniband/core/mad.c        |  52 ++-
drivers/infiniband/core/security.c   | 705 +++++++++++++++++++++++++++++++++
drivers/infiniband/core/uverbs_cmd.c |  15 +-
drivers/infiniband/core/verbs.c      |  27 +-
fs/nfs/super.c                       |  17 +-
include/linux/lsm_audit.h            |  15 +
include/linux/lsm_hooks.h            |  39 +-
include/linux/security.h             |  58 ++-
include/rdma/ib_mad.h                |   4 +
include/rdma/ib_verbs.h              |  49 +++
security/Kconfig                     |   9 +
security/lsm_audit.c                 |  16 +
security/security.c                  |  55 ++-
security/selinux/Makefile            |   2 +-
security/selinux/hooks.c             | 212 +++++++++--
security/selinux/ibpkey.c            | 245 ++++++++++++
security/selinux/include/classmap.h  |   6 +-
security/selinux/include/ibpkey.h    |  31 ++
security/selinux/include/objsec.h    |  11 +
security/selinux/include/security.h  |   9 +-
security/selinux/selinuxfs.c         |  15 +-
security/selinux/ss/ebitmap.c        |  26 +-
security/selinux/ss/ebitmap.h        |   3 +
security/selinux/ss/policydb.c       | 127 +++++--
security/selinux/ss/policydb.h       |  27 +-
security/selinux/ss/services.c       | 108 ++++++
security/selinux/ss/sidtab.c         |  27 +-
31 files changed, 2028 insertions(+), 129 deletions(-)
create mode 100644 drivers/infiniband/core/security.c
create mode 100644 security/selinux/ibpkey.c
create mode 100644 security/selinux/include/ibpkey.h

-- 
paul moore
www.paul-moore.com
