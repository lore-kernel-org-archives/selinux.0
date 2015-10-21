Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9LLvWpA018460
 for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2015 17:57:39 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.4
Date: Wed, 21 Oct 2015 17:57:27 -0400
Message-ID: <2506963.zmKhoxexGn@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Nine SELinux patches in total for v4.4, although six of those patches are 
either trivial, minor cleanups, or both.  The remaining three patches aren't 
too bad: one changes the CHECKREQPROT default to check the actual memory 
protections, one stops us from checking file:open on ftruncate() calls, and 
one converts the file_security_struct over to kmem_cache.

All pass the SELinux testsuite and should apply cleanly on top of your next 
branch.

Enjoy,
-Paul

---
The following changes since commit 09302fd19efbff9569eaad3f78ead8f411defd87:

  Merge branch 'smack-for-4.4' of https://github.com/cschaufler/smack-next 
    into next (2015-10-21 10:49:29 +1100)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 63205654c0e05e5ffa1c6eef2fbef21dcabd2185:

  selinux: Use a kmem_cache for allocation struct file_security_struct
    (2015-10-21 17:44:30 -0400)

----------------------------------------------------------------
Geliang Tang (1):
      selinux: ioctl_has_perm should be static

Jeff Vander Stoep (1):
      selinux: do not check open perm on ftruncate call

Paul Moore (1):
      selinux: change CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default

Rasmus Villemoes (5):
      selinux: introduce security_context_str_to_sid
      selinux: remove pointless cast in selinux_inode_setsecurity()
      selinux: use kmemdup in security_sid_to_context_core()
      selinux: use kstrdup() in security_get_bools()
      selinux: use sprintf return value

Sangwoo (1):
      selinux: Use a kmem_cache for allocation struct file_security_struct

 security/selinux/Kconfig            |  4 ++--
 security/selinux/hooks.c            | 27 ++++++++++++++-------------
 security/selinux/include/security.h |  2 ++
 security/selinux/selinuxfs.c        | 26 +++++++++-----------------
 security/selinux/ss/services.c      | 22 +++++++++-------------
 5 files changed, 36 insertions(+), 45 deletions(-)

-- 
paul moore
security @ redhat
