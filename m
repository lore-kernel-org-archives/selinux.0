Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54Kad52020016
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 16:36:39 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 4.2
Date: Thu, 04 Jun 2015 16:36:35 -0400
Message-ID: <2158515.KYehkOGLZJ@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Six SELinux patches for 4.2: two to add better labeling support for three 
pseudo filesystems, one netlink update, a __flush_signals() removal/fix, and a 
couple of minor cleanup patches.  Nothing too scary or large this time.

All patches pass the SELinux testsuite and the selinux#upstream branch is 
based on your linux-security#next branch as of about an hour ago.

Enjoy,
-Paul

---
The following changes since commit e6e29a4eae335059d2cc44ac543de7556ff7ac09:

  Merge branch 'smack-for-4.2-stacked' of 
    https://github.com/cschaufler/smack-next into next
    (2015-06-03 19:10:29 +1000)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 42a9699a9fa179c0054ea3cf5ad3cc67104a6162:

  selinux: Remove unused permission definitions (2015-06-04 16:22:17 -0400)

----------------------------------------------------------------
Marek Milkovic (1):
      selinux: Print 'sclass' as string when unrecognized netlink message 
occurs

Oleg Nesterov (1):
      signals: don't abuse __flush_signals() in selinux_bprm_committed_creds()

Stephen Smalley (4):
      selinux: update netlink socket classes
      selinux: enable per-file labeling for debugfs files.
      selinux: enable genfscon labeling for sysfs and pstore files
      selinux: Remove unused permission definitions

 include/linux/sched.h               |  1 -
 kernel/signal.c                     | 13 ++-----
 security/selinux/hooks.c            | 76 +++++++++++++++++++++--------------
 security/selinux/include/classmap.h | 44 +++++++++++----------
 security/selinux/include/security.h |  1 +
 5 files changed, 75 insertions(+), 60 deletions(-)

-- 
paul moore
security @ redhat
