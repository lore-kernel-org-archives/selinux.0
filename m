Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6IJbWg6000846
 for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2014 15:37:32 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.17
Date: Fri, 18 Jul 2014 15:37:19 -0400
Message-ID: <3135081.Nfbulyq9MG@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Here are the SELinux patches for 3.17.  A total of eight patches, none 
particularly controversial: a few cleanups, a few bug fixes, and a minor tweak 
to reduce the SELinux overhead during boot.  One nice thing is that we remove 
more code than we add in 3.17, so if nothing else we're doing our part to 
fight code bloat :)

All the patches pass the SELinux testsuite and apply cleanly on top of linux-
security #next.

Enjoy,
-Paul

---
The following changes since commit 170b5910d9fbea79de1bb40df22eda5f98250c0c:

  Merge tag 'v3.15' into next (2014-06-17 17:30:23 -0400)

are available in the git repository at:


  git://git.infradead.org/users/pcmoore/selinux next

for you to fetch changes up to 615e51fdda6f274e94b1e905fcaf6111e0d9aa20:

  selinux: reduce the number of calls to synchronize_net() when flushing
           caches (2014-06-26 14:33:56 -0400)

----------------------------------------------------------------
Gideon Israel Dsouza (1):
      security: Used macros from compiler.h instead of __attribute__((...))

Himangi Saraogi (1):
      SELinux: use ARRAY_SIZE

Masahiro Yamada (1):
      selinux, kbuild: remove unnecessary $(hostprogs-y) from clean-files

Namhyung Kim (3):
      selinux: introduce str_read() helper
      selinux: simple cleanup for cond_read_node()
      selinux: fix a possible memory leak in cond_read_node()

Paul Moore (1):
      selinux: reduce the number of calls to synchronize_net() when flushing
               caches

Waiman Long (1):
      selinux: no recursive read_lock of policy_rwlock in security_genfs_sid()

 scripts/selinux/genheaders/Makefile |   1 -
 scripts/selinux/mdp/Makefile        |   2 +-
 security/selinux/hooks.c            |  14 ++++
 security/selinux/include/netif.h    |   2 +
 security/selinux/include/netnode.h  |   2 +
 security/selinux/include/netport.h  |   2 +
 security/selinux/include/security.h |   3 +-
 security/selinux/netif.c            |  15 +---
 security/selinux/netnode.c          |  15 +---
 security/selinux/netport.c          |  15 +---
 security/selinux/ss/conditional.c   |  11 +--
 security/selinux/ss/policydb.c      | 141 ++++++++++------------------------
 security/selinux/ss/services.c      |  41 ++++++++---
 13 files changed, 102 insertions(+), 162 deletions(-)

-- 
paul moore
security and virtualization @ redhat
