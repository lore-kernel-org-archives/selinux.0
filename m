Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8BGQi4U020359
 for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2018 12:26:45 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKLM <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, John Johansen
 <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Message-ID: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
Date: Tue, 11 Sep 2018 09:26:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A
 and Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

LSM: Module stacking in support of S.A.R.A and Landlock

v2: Reduce the patchset to what is required to support
    the proposed S.A.R.A. and LandLock security modules

The S.A.R.A. security module is intended to be used
in conjunction with other security modules. It requires
state to be maintained for the credential, which
in turn requires a mechanism for sharing the credential
security blob. The module also requires mechanism for
user space manipulation of the credential information,
hence an additional subdirectory in /proc/.../attr.

The LandLock security module provides user configurable
policy in the secmark mechanism. It requires data in
the credential, file and inode security blobs. For this
to be used along side the existing "major" security
modules mechanism for sharing these blobs is provided.

A side effect of providing sharing of the crendential
security blob is that the TOMOYO module can be used at
the same time as the other "major" modules.

The mechanism for configuring which security modules are
enabled has to change when stacking in enabled. Any
module that uses just the security blobs that are shared
can be selected. Additionally, one other "major" module
can be selected.

The security module stacking issues around networking and
IPC are not addressed here as they are beyond what is
required for TOMOYO, S.A.R.A and LandLock.

git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst |  23 ++-
 fs/proc/base.c                          |  64 ++++++-
 fs/proc/internal.h                      |   1 +
 include/linux/lsm_hooks.h               |  20 ++-
 include/linux/security.h                |  15 +-
 kernel/cred.c                           |  13 --
 security/Kconfig                        |  92 ++++++++++
 security/apparmor/domain.c              |   2 +-
 security/apparmor/include/cred.h        |  24 ++-
 security/apparmor/include/file.h        |   9 +-
 security/apparmor/include/lib.h         |   4 +
 security/apparmor/lsm.c                 |  53 ++++--
 security/apparmor/task.c                |   6 +-
 security/security.c                     | 293 ++++++++++++++++++++++++++++++--
 security/selinux/hooks.c                | 215 ++++++++---------------
 security/selinux/include/objsec.h       |  37 +++-
 security/selinux/selinuxfs.c            |   5 +-
 security/selinux/xfrm.c                 |   4 +-
 security/smack/smack.h                  |  42 ++++-
 security/smack/smack_access.c           |   4 +-
 security/smack/smack_lsm.c              | 283 +++++++++++-------------------
 security/smack/smackfs.c                |  18 +-
 security/tomoyo/common.h                |  31 +++-
 security/tomoyo/domain.c                |   4 +-
 security/tomoyo/securityfs_if.c         |  15 +-
 security/tomoyo/tomoyo.c                |  57 +++++--
 26 files changed, 899 insertions(+), 435 deletions(-)
