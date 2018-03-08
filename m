Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w281j778028069
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 20:45:07 -0500
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 SMACK-announce@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
Date: Wed, 7 Mar 2018 17:44:40 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 0/8] LSM: Security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 0/8] LSM: Security module stacking

Move the management of Linux Security Module (LSM) data blobs
out of the individual modules and into the LSM infrastructure.
The modules are now required to declare how much space they need
for each sort of blob used. This will allow modules that use
security blobs to be stacked so long as they aren't using hooks
that require secids. Several proposed modules, including S.A.R.A.,
PTAGS and Landlock, meet these criteria.

Change the way that "secids" are treated outside of the security
modules. Use a structure that contains the secid for each available
module rather than a single u32. This works for everything except
netfilter secmarks, which require a mapping between secid sets and
a single u32 be maintained.

A process may chose which security module is reported using SO_PEERSEC
with a prctl() option. This is the simplest way to address the variety
of mechanism between UDS, TCP/IP and UDP/IP.

Netlabel has been augmented with an API to compare lsm secattrs.
This is used to determine if all security modules agree on what
label to put on IP packets. Attempting to set incompatible labels
results in an error. As a result, using SELinux and Smack together
results in disappointing, but safe, network behavior using their
default configurations. 

Tested with Fedora 24 and 27, and Ubuntu 17.04. Passes the
SELinux test suite unless Smack is also running, in which case
the errors are explained by the netlabel conflicts between the
two modules.

1/8: Add the smack subdirectory to /proc/.../attr
2/8: Move management of cred security blobs to the LSM infrastructure
3/8: Move management of file security blobs to the LSM infrastructure
4/8: Move management of task security blobs to the LSM infrastructure
5/8: Move management of the remaining security blobs to the LSM infrastructure
6/8: Change the configuration controls for security stacking
7/8: Allow multiple modules to provide mount options
8/8: Maintain and use compound secids instead of a single integer

Also available git://github.com/cschaufler/lsm_stacking.git#stacking-4.17

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst |  23 +-
 fs/btrfs/super.c                        |  10 +-
 fs/proc/base.c                          |  63 ++-
 fs/proc/internal.h                      |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  78 ++-
 include/linux/security.h                | 220 ++++++--
 include/net/flow.h                      |   5 +-
 include/net/netlabel.h                  |  16 +-
 include/net/scm.h                       |   4 +-
 include/uapi/linux/prctl.h              |   4 +
 kernel/audit.c                          |  23 +-
 kernel/audit.h                          |   9 +-
 kernel/auditfilter.c                    |   4 +-
 kernel/auditsc.c                        |  42 +-
 kernel/cred.c                           |  19 +-
 kernel/fork.c                           |   3 +
 kernel/signal.c                         |   1 +
 net/ipv4/cipso_ipv4.c                   |  19 +-
 net/ipv4/ip_sockglue.c                  |   6 +-
 net/netfilter/nf_conntrack_netlink.c    |  12 +-
 net/netfilter/nf_conntrack_standalone.c |   6 +-
 net/netfilter/nfnetlink_queue.c         |   9 +-
 net/netfilter/xt_SECMARK.c              |   7 +-
 net/netlabel/netlabel_kapi.c            |  52 +-
 net/netlabel/netlabel_unlabeled.c       |  30 +-
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |   4 +-
 net/unix/af_unix.c                      |  22 +-
 net/xfrm/xfrm_policy.c                  |   6 +-
 net/xfrm/xfrm_state.c                   |   3 +-
 security/Kconfig                        |  80 +++
 security/Makefile                       |   1 +
 security/apparmor/context.c             |   2 -
 security/apparmor/include/context.h     |  24 +-
 security/apparmor/include/file.h        |   2 +-
 security/apparmor/lsm.c                 |  71 ++-
 security/integrity/ima/ima_policy.c     |   7 +-
 security/security.c                     | 943 +++++++++++++++++++++++++++++---
 security/selinux/hooks.c                | 678 +++++++++--------------
 security/selinux/include/audit.h        |   2 +-
 security/selinux/include/objsec.h       |  87 ++-
 security/selinux/include/xfrm.h         |   9 +-
 security/selinux/netlabel.c             |  25 +-
 security/selinux/selinuxfs.c            |   5 +-
 security/selinux/ss/services.c          |  13 +-
 security/selinux/xfrm.c                 |  29 +-
 security/smack/smack.h                  |  95 +++-
 security/smack/smack_access.c           |   6 +-
 security/smack/smack_lsm.c              | 764 +++++++++++---------------
 security/smack/smack_netfilter.c        |  28 +-
 security/smack/smackfs.c                |  32 +-
 security/tomoyo/common.h                |  31 +-
 security/tomoyo/domain.c                |   4 +-
 security/tomoyo/securityfs_if.c         |  15 +-
 security/tomoyo/tomoyo.c                |  57 +-
 56 files changed, 2463 insertions(+), 1253 deletions(-)
