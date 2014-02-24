Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1OM0JYM011630
 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2014 17:00:19 -0500
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] security: Use a more current logging style
Date: Mon, 24 Feb 2014 13:59:53 -0800
Message-Id: <cover.1393279025.git.joe@perches.com>
Cc: linux-security-module@vger.kernel.org, keyrings@linux-nfs.org,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Mostly trivial cleanups of security modules

Joe Perches (8):
  security: Use a more current logging style
  security: apparmor: Use a more current logging style
  security: integrity: Use a more current logging style
  security: keys: Use a more current logging style
  security: selinux: Use a more current logging style
  security: smack: Use a more current logging style
  security: tomoyo: Use a more current logging style
  security: yama: Use a more current logging style

 security/apparmor/apparmorfs.c           |   2 +
 security/apparmor/crypto.c               |   2 +
 security/apparmor/include/apparmor.h     |   2 +-
 security/apparmor/lib.c                  |   4 +-
 security/apparmor/lsm.c                  |   2 +
 security/apparmor/match.c                |   5 +-
 security/apparmor/policy.c               |   2 +
 security/apparmor/procattr.c             |   2 +
 security/capability.c                    |  16 ++--
 security/commoncap.c                     |  15 ++--
 security/integrity/evm/evm_crypto.c      |   4 +-
 security/integrity/evm/evm_main.c        |   6 +-
 security/integrity/evm/evm_secfs.c       |   6 +-
 security/integrity/ima/ima_crypto.c      |   4 +-
 security/integrity/ima/ima_init.c        |   5 +-
 security/integrity/ima/ima_queue.c       |   8 +-
 security/integrity/ima/ima_template.c    |   5 +-
 security/keys/encrypted-keys/encrypted.c |  70 ++++++++---------
 security/keys/encrypted-keys/encrypted.h |   2 +-
 security/keys/key.c                      |   2 +
 security/keys/trusted.c                  |  42 +++++-----
 security/keys/trusted.h                  |  20 ++---
 security/security.c                      |   4 +-
 security/selinux/avc.c                   |   7 +-
 security/selinux/hooks.c                 | 130 +++++++++++++------------------
 security/selinux/netif.c                 |  14 ++--
 security/selinux/netlink.c               |   5 +-
 security/selinux/netnode.c               |   6 +-
 security/selinux/netport.c               |   7 +-
 security/selinux/selinuxfs.c             |  19 ++---
 security/selinux/ss/avtab.c              |  39 +++++-----
 security/selinux/ss/conditional.c        |  18 +++--
 security/selinux/ss/ebitmap.c            |  21 +++--
 security/selinux/ss/policydb.c           | 109 ++++++++++++--------------
 security/selinux/ss/services.c           | 101 ++++++++++--------------
 security/selinux/ss/sidtab.c             |   8 +-
 security/smack/smack_lsm.c               |   7 +-
 security/smack/smackfs.c                 |  25 +++---
 security/tomoyo/common.c                 |  23 +++---
 security/tomoyo/domain.c                 |   8 +-
 security/tomoyo/load_policy.c            |   9 ++-
 security/tomoyo/memory.c                 |   7 +-
 security/tomoyo/tomoyo.c                 |   4 +-
 security/tomoyo/util.c                   |   7 +-
 security/yama/yama_lsm.c                 |  18 ++---
 45 files changed, 404 insertions(+), 418 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty
