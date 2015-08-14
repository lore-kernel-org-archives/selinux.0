Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7EK0dmO002930
 for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2015 16:00:40 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.3
Date: Fri, 14 Aug 2015 16:00:33 -0400
Message-ID: <10215896.YrxoRqX6qm@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

A relatively big SELinux patchset compared to the last few releases, but the 
vast majority of the changes are due to the new ioctl controls which allow 
SELinux to control access to individual ioctls; a very welcome addition.  
Beyond that, it's all just the usual bug fixes and cleanups, nothing 
particularly spectacular or worrisome.

The patchset passes the selinux-testsuite with flying colors, and as of a few 
hours ago merged cleanly with the linux-security#next branch.

Enjoy,
-Paul

---
The following changes since commit 892e8cac99a71f6254f84fc662068d912e1943bf:

  selinux: fix mprotect PROT_EXEC regression caused by mm change
           (2015-07-10 16:45:29 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux next

for you to fetch changes up to fda4d578ed0a7e1d116f56a15efea0e4ba78acad:

  selinux: explicitly declare the role "base_r" (2015-07-13 13:32:00 -0400)

----------------------------------------------------------------
David Howells (1):
      selinux: Create a common helper to determine an inode label [ver #3]

Jeff Vander Stoep (2):
      security: add ioctl specific auditing to lsm_audit
      selinux: extended permissions for ioctls

Laurent Bigonville (1):
      selinux: explicitly declare the role "base_r"

Stephen Smalley (2):
      selinux: initialize sock security class to default value
      selinux: Augment BUG_ON assertion for secclass_map.

Waiman Long (1):
      selinux: reduce locking overhead in inode_free_security()

 include/linux/lsm_audit.h           |   7 +
 scripts/selinux/mdp/mdp.c           |   1 +
 security/lsm_audit.c                |  15 ++
 security/selinux/avc.c              | 418 ++++++++++++++++++++++++++++++++--
 security/selinux/hooks.c            | 147 ++++++++-----
 security/selinux/include/avc.h      |   6 +
 security/selinux/include/security.h |  32 ++-
 security/selinux/ss/avtab.c         | 104 +++++++--
 security/selinux/ss/avtab.h         |  33 ++-
 security/selinux/ss/conditional.c   |  32 ++-
 security/selinux/ss/conditional.h   |   6 +-
 security/selinux/ss/policydb.c      |   5 +
 security/selinux/ss/services.c      | 213 ++++++++++++++++--
 security/selinux/ss/services.h      |   6 +
 14 files changed, 915 insertions(+), 110 deletions(-)

-- 
paul moore
security @ redhat
