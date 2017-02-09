Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v19LvrLD025005
 for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2017 16:57:53 -0500
Received: by mail-ot0-f169.google.com with SMTP id 32so14122941oth.3
 for <selinux@tycho.nsa.gov>; Thu, 09 Feb 2017 13:57:52 -0800 (PST)
MIME-Version: 1.0
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 9 Feb 2017 16:57:51 -0500
Message-ID: <CAGH-Kgv0mCgc_1zY6sF6omA248Av=pPJykyAe2uJAu05nKHBQQ@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for 4.11
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Eleven SELinux patches for v4.11 with a mix of cleanups, fixes, and
new functionality (object classes and filesystem support).  Everything
passes the selinux-testsuite and applied cleanly to the
linux-security/next branch as of a few minutes ago; please apply.

Thanks,
-Paul

---

The following changes since commit 916cafdc95843fb9af5fd5f83ca499d75473d107:

  samples/seccomp: fix 64-bit comparison macros (2017-01-09 17:22:03 +1100)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.11

for you to fetch changes up to 1ea0ce40690dff38935538e8dab7b12683ded0d3:

  selinux: allow changing labels for cgroupfs (2017-02-07 22:17:47 -0500)

----------------------------------------------------------------
Antonio Murdaca (1):
      selinux: allow changing labels for cgroupfs

Gary Tierney (2):
      selinux: log errors when loading new policy
      selinux: default to security isid in sel_make_bools() if no sid is found

Stephen Smalley (7):
      selinux: support distinctions among all network address families
      selinux: handle ICMPv6 consistently with ICMP
      selinux: allow context mounts on tmpfs, ramfs, devpts within
user namespaces
      selinux: clean up cred usage and simplify
      proc,security: move restriction on writing /proc/pid/attr nodes to proc
      selinux: drop unused socket security classes
      security,selinux,smack: kill security_task_wait hook

Yongqin Liu (1):
      selinux: add security in-core xattr support for tracefs

 fs/proc/base.c                      |  13 +-
 include/linux/lsm_hooks.h           |  10 +-
 include/linux/security.h            |  10 +-
 kernel/exit.c                       |  19 +-
 security/apparmor/lsm.c             |   7 +-
 security/security.c                 |  10 +-
 security/selinux/hooks.c            | 379 ++++++++++++++++++------------------
 security/selinux/include/classmap.h |  62 ++++++
 security/selinux/include/objsec.h   |  10 +
 security/selinux/include/security.h |   3 +-
 security/selinux/selinuxfs.c        |  98 ++++++----
 security/selinux/ss/services.c      |   3 +
 security/smack/smack_lsm.c          |  31 +--
 13 files changed, 341 insertions(+), 314 deletions(-)

-- 
paul moore
security @ redhat
