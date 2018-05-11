Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0UrbF032379
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:30:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 40hrbv4H6Kz1wyJT
 for <selinux@tycho.nsa.gov>; Fri, 11 May 2018 00:30:51 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 40hrbt6nvXz1wyJg
 for <selinux@tycho.nsa.gov>; Fri, 11 May 2018 00:30:50 +0000 (UTC)
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Date: Thu, 10 May 2018 17:30:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 00/23] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 00/23] LSM: Full security module stacking

Here it is, the whole nine yards, broken into mostly
review friendly pieces. I believe that it would make
a good deal of sense to take this in two bites, with
the infrastructure managed blobs going first and the
secid conversion coming later. I hope there will be some
debate around that.

The blob management part is pretty clean by now. I
welcome serious review on that. The secid part is more
wobbly, but I am convinced that it's the right direction
if not perhaps always the best possible implementation.
AppArmor in in the process of a major overhaul, and that
slowed me down a bit as I had to do new work to convert
it to use the new mechanisms.

I had experimented with secid "tokens" in the hope of
minimizing API changes. That doesn't work. Changing
the APIs to use a struct secids pointer in place of a
u32 is brutal to the diffstat, but reduces the amount
of active code that has to change, and really makes
data management easier.

If there are two possible ways to do a thing you will
find them both in the networking code. AF_UNIX, netfilter,
SO_PEERSEC and netlabel each has its own clever ways
to manipulate security information. I think I nailed
them all, but I'm not betting more than a beer on it.

There could be issues in the audit code, although nothing
jumped out immediately. The same goes for the integrity
subsystem. I haven't tried Infiniband or very many
filesystem types that don't com standard with Fedora or
Ubuntu.

I have fixed everything I've found. If you find something
(please look!) let me know.

Tested primarily on virtual machines.
	Fedora 25-27 - SELinux, Smack and the two together
	Ubuntu 17.04 - AppArmor and AppArmor + Smack

The SELinux test suite completes successfully unless
you add in Smack, in which case it fails where you would
expect it to due to the different use models for netlabel.
Smack tests work as well. AppArmor was tested by booting
Ubuntu, but not beyond.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 Documentation/admin-guide/LSM/index.rst   |  23 +-
 fs/btrfs/super.c                          |  10 +-
 fs/proc/base.c                            |  63 +-
 fs/proc/internal.h                        |   1 +
 include/linux/cred.h                      |   3 +-
 include/linux/lsm_hooks.h                 |  85 ++-
 include/linux/security.h                  | 211 +++++--
 include/net/flow.h                        |   5 +-
 include/net/netlabel.h                    |  16 +-
 include/net/scm.h                         |   4 +-
 include/uapi/linux/netfilter/xt_SECMARK.h |   1 +
 include/uapi/linux/prctl.h                |   4 +
 kernel/audit.c                            |  25 +-
 kernel/audit.h                            |   9 +-
 kernel/auditfilter.c                      |   4 +-
 kernel/auditsc.c                          |  44 +-
 kernel/cred.c                             |  19 +-
 kernel/fork.c                             |   3 +
 net/ipv4/cipso_ipv4.c                     |  19 +-
 net/ipv4/ip_sockglue.c                    |   6 +-
 net/netfilter/nf_conntrack_netlink.c      |  22 +-
 net/netfilter/nf_conntrack_standalone.c   |  11 +-
 net/netfilter/nfnetlink_queue.c           |  14 +-
 net/netfilter/xt_SECMARK.c                |  44 +-
 net/netlabel/netlabel_kapi.c              |  52 +-
 net/netlabel/netlabel_unlabeled.c         |  30 +-
 net/netlabel/netlabel_unlabeled.h         |   2 +-
 net/netlabel/netlabel_user.c              |   4 +-
 net/unix/af_unix.c                        |  19 +-
 net/xfrm/xfrm_policy.c                    |   5 +-
 net/xfrm/xfrm_state.c                     |   2 +-
 security/Kconfig                          |  80 +++
 security/Makefile                         |   1 +
 security/apparmor/domain.c                |   2 +-
 security/apparmor/include/cred.h          |  24 +-
 security/apparmor/include/file.h          |   9 +-
 security/apparmor/include/lib.h           |   4 +
 security/apparmor/include/net.h           |  10 +-
 security/apparmor/include/task.h          |  22 +-
 security/apparmor/lsm.c                   | 131 ++--
 security/apparmor/task.c                  |   6 +-
 security/integrity/ima/ima.h              |  10 +-
 security/integrity/ima/ima_api.c          |   5 +-
 security/integrity/ima/ima_appraise.c     |   4 +-
 security/integrity/ima/ima_main.c         |  22 +-
 security/integrity/ima/ima_policy.c       |  11 +-
 security/security.c                       | 973 +++++++++++++++++++++++++++---
 security/selinux/hooks.c                  | 658 ++++++++------------
 security/selinux/include/audit.h          |   2 +-
 security/selinux/include/objsec.h         |  87 ++-
 security/selinux/include/xfrm.h           |   9 +-
 security/selinux/netlabel.c               |  33 +-
 security/selinux/selinuxfs.c              |   5 +-
 security/selinux/ss/services.c            |  13 +-
 security/selinux/xfrm.c                   |  29 +-
 security/smack/smack.h                    |  90 ++-
 security/smack/smack_access.c             |   6 +-
 security/smack/smack_lsm.c                | 673 ++++++++++-----------
 security/smack/smack_netfilter.c          |  19 +-
 security/smack/smackfs.c                  |  32 +-
 security/tomoyo/common.h                  |  31 +-
 security/tomoyo/domain.c                  |   4 +-
 security/tomoyo/securityfs_if.c           |  15 +-
 security/tomoyo/tomoyo.c                  |  57 +-
 64 files changed, 2581 insertions(+), 1256 deletions(-)
