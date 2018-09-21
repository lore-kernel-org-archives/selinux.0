Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8LNxVfD007243
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:59:31 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Date: Fri, 21 Sep 2018 16:59:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

v4: Finer granularity in the patches and other
    cleanups suggested by Kees Cook.
    Removed dead code created by the removal of SELinux
    credential blob poisoning.
v3: Add ipc blob for SARA and task blob for Landlock.
    Removing the SELinux cred blob pointer poisoning
    results selinux_is_enabled() being unused, so it and
    all it's overhead has been removed.
    Broke up the cred infrastructure patch.
v2: Reduce the patchset to what is required to support
    the proposed SARA and LandLock security modules

The SARA security module is intended to be used
in conjunction with other security modules. It requires
state to be maintained for the credential, which
in turn requires a mechanism for sharing the credential
security blob. It also uses the ipc security blob. The
module also requires mechanism for user space manipulation
of the credential information, hence an additional
subdirectory in /proc/.../attr.

The LandLock security module provides user configurable
policy in the secmark mechanism. It requires data in
the credential, file, inode and task security blobs. For
this to be used along side the existing "major" security
modules mechanism for sharing these blobs are provided.

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
required for TOMOYO, SARA and LandLock.

git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock-v4

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst |  23 +-
 fs/proc/base.c                          |  64 ++++-
 fs/proc/internal.h                      |   1 +
 include/linux/cred.h                    |   1 -
 include/linux/lsm_hooks.h               |  24 +-
 include/linux/security.h                |  15 +-
 include/linux/selinux.h                 |  35 ---
 kernel/cred.c                           |  13 -
 security/Kconfig                        |  92 +++++++
 security/apparmor/domain.c              |   2 +-
 security/apparmor/include/cred.h        |  24 +-
 security/apparmor/include/file.h        |   9 +-
 security/apparmor/include/lib.h         |   4 +
 security/apparmor/include/task.h        |  18 +-
 security/apparmor/lsm.c                 |  68 +++--
 security/apparmor/task.c                |   6 +-
 security/security.c                     | 438 ++++++++++++++++++++++++++++++--
 security/selinux/Makefile               |   2 +-
 security/selinux/exports.c              |  23 --
 security/selinux/hooks.c                | 333 +++++++-----------------
 security/selinux/include/audit.h        |   3 -
 security/selinux/include/objsec.h       |  48 +++-
 security/selinux/selinuxfs.c            |   4 +-
 security/selinux/ss/services.c          |   1 -
 security/selinux/xfrm.c                 |   4 +-
 security/smack/smack.h                  |  55 +++-
 security/smack/smack_access.c           |   4 +-
 security/smack/smack_lsm.c              | 315 ++++++++---------------
 security/smack/smackfs.c                |  18 +-
 security/tomoyo/common.h                |  26 +-
 security/tomoyo/domain.c                |   4 +-
 security/tomoyo/securityfs_if.c         |  15 +-
 security/tomoyo/tomoyo.c                |  57 ++++-
 33 files changed, 1098 insertions(+), 651 deletions(-)
