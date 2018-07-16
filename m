Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6GHsgSf015508
 for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2018 13:54:42 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Date: Mon, 16 Jul 2018 10:53:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v1 00/22] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

LSM: Full security module stacking

I'm calling this v1 not because it's the first version
I've put out but because it's the first version I'm getting
serious external pressure to get upstream. 

The blob management part (through "LSM: Sharing of security blobs")
is ready for prime-time. These changes move the management of
security blobs out of the security modules and into the security
module infrastructure. With this change the proposed S.A.R.A,
LandLock and PTAGS security modules could co-exist with any of
the existing "major" security modules. The changes reduce some
code duplication. 

Beyond the blob management there's a bit of clean-up.
Mounting filesystems had to be changed so that options 
a security module doesn't recognize won't be considered
a fatal error. The mount infrastructure is somewhat
more complex than one might assume. 

If there are two possible ways to do a thing you will
find them both in the networking code. AF_UNIX, netfilter,
SO_PEERSEC and netlabel each has its own clever ways
to manipulate security information. I think I nailed
them all, but I'm not betting more than a beer on it.

SELinux and Smack have different ideas regarding how
IP packet labels should be treated. SELinux will use
CIPSO to include the multilevel security (MLS) component
of the security context, but only under certain conditions.
Smack will encode the label into the CIPSO option unless
explicitly told not to. SELinux is typically configured
to use unlabled networking. Smack uses labeled networing
by default. As a result configuring a system with these
two security modules to make IP networking useful is a
challenge. This patch set makes the combination safe, but
making it strictly useful is a challenge. 

There could be issues in the audit code, although nothing
jumped out immediately. The same goes for the integrity
subsystem. I haven't tried Infiniband or very many
filesystem types that don't com standard with Fedora or
Ubuntu.

Tested primarily on virtual machines.
	Fedora 25-27 - SELinux, Smack and the two together
	Ubuntu 17.04 - AppArmor and AppArmor + Smack

The SELinux test suite completes successfully unless
you add in Smack, in which case it fails where you would
expect it to due to the different use models for netlabel.
Smack tests work as well. AppArmor was tested by booting
Ubuntu, but not beyond.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Casey Schaufler (22):
  procfs: add smack subdir to attrs
  Smack: Abstract use of cred security blob
  SELinux: Abstract use of cred security blob
  LSM: Infrastructure management of the cred security blob
  SELinux: Abstract use of file security blob
  LSM: Infrastructure management of the file security blob
  LSM: Infrastructure management of the task security blob
  SELinux: Abstract use of inode security blob
  Smack: Abstract use of inode security blob
  LSM: Infrastructure management of the inode security
  LSM: Infrastructure management of the superblock security blob
  LSM: Infrastructure management of the sock security
  LSM: Infrastructure management of the ipc security blob
  LSM: Infrastructure management of the key security blob
  LSM: Mark security blob allocation failures as unlikely
  LSM: Sharing of security blobs
  LSM: Allow mount options from multiple security modules
  LSM: Use multiple secids in security module interfaces
  LSM: Use multiple secids in LSM interfaces
  Move common usercopy into security_getpeersec_stream
  LSM: Multiple concurrent major security modules
  Netfilter: Add a selection for Smack

 Documentation/admin-guide/LSM/index.rst   |  23 +-
 fs/btrfs/super.c                          |  10 +-
 fs/proc/base.c                            |  63 +-
 fs/proc/internal.h                        |   1 +
 include/linux/cred.h                      |   3 +-
 include/linux/lsm_hooks.h                 |  85 +-
 include/linux/security.h                  | 214 +++--
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
 net/core/filter.c                         |   4 +-
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
 net/xfrm/xfrm_state.c                     |   3 +-
 security/Kconfig                          |  80 ++
 security/Makefile                         |   1 +
 security/apparmor/audit.c                 |   4 +-
 security/apparmor/domain.c                |   2 +-
 security/apparmor/include/audit.h         |   2 +-
 security/apparmor/include/cred.h          |  24 +-
 security/apparmor/include/file.h          |   9 +-
 security/apparmor/include/lib.h           |   4 +
 security/apparmor/include/net.h           |  10 +-
 security/apparmor/include/secid.h         |   5 +-
 security/apparmor/include/task.h          |  22 +-
 security/apparmor/lsm.c                   | 135 ++-
 security/apparmor/secid.c                 |   9 +-
 security/apparmor/task.c                  |   6 +-
 security/integrity/ima/ima.h              |  10 +-
 security/integrity/ima/ima_api.c          |   5 +-
 security/integrity/ima/ima_appraise.c     |   4 +-
 security/integrity/ima/ima_main.c         |  22 +-
 security/integrity/ima/ima_policy.c       |  11 +-
 security/security.c                       | 989 ++++++++++++++++++++--
 security/selinux/hooks.c                  | 673 ++++++---------
 security/selinux/include/audit.h          |   2 +-
 security/selinux/include/objsec.h         |  87 +-
 security/selinux/include/xfrm.h           |   9 +-
 security/selinux/netlabel.c               |  33 +-
 security/selinux/selinuxfs.c              |   5 +-
 security/selinux/ss/services.c            |  13 +-
 security/selinux/xfrm.c                   |  29 +-
 security/smack/smack.h                    |  90 +-
 security/smack/smack_access.c             |   8 +-
 security/smack/smack_lsm.c                | 710 +++++++---------
 security/smack/smack_netfilter.c          |  19 +-
 security/smack/smackfs.c                  |  32 +-
 security/stacking.c                       | 119 +++
 security/tomoyo/common.h                  |  31 +-
 security/tomoyo/domain.c                  |   4 +-
 security/tomoyo/securityfs_if.c           |  15 +-
 security/tomoyo/tomoyo.c                  |  57 +-
 70 files changed, 2764 insertions(+), 1294 deletions(-)
 create mode 100644 security/stacking.c

-- 
2.17.1
