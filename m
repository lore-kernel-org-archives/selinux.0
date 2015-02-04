Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t14KCXOw026853
 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2015 15:12:34 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.20
Date: Wed, 04 Feb 2015 15:12:25 -0500
Message-ID: <5744455.kXAUaHeggX@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

This time around we've got four SELinux patches for 3.20.  All four patches 
are fairly small, see the diffstat below, with two of the patches being 
trivial (remove some dead code, squelch a notification message).  The two 
patches that are substantive are straightforward: one fixes a problem where we 
weren't propagating an error code and one adds in-core xattr support for 
pstore and debugfs.

All patches pass the SELinux testsuite and are based on the security#next 
branch.

Enjoy,
-Paul

---
The following changes since commit 11cd64a234d5a1a7111627ef947beb0e5fad9e71:

  ima: /proc/keys is now mandatory (2015-02-02 13:19:48 +1100)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 6eb4e2b41b264f57ee02d16ee61683952945484d:

  SELinux: fix error code in policydb_init() (2015-02-04 11:34:30 -0500)

----------------------------------------------------------------
Dan Carpenter (1):
      SELinux: fix error code in policydb_init()

Mark Salyzyn (1):
      selinux: add security in-core xattr support for pstore and debugfs

Paul Moore (1):
      selinux: quiet the filesystem labeling behavior message

Rickard Strandqvist (1):
      selinux: Remove unused function avc_sidcmp()

 security/selinux/avc.c         |  5 -----
 security/selinux/hooks.c       | 29 ++++++++---------------------
 security/selinux/ss/policydb.c |  8 ++++++--
 3 files changed, 14 insertions(+), 28 deletions(-)

-- 
paul moore
security @ redhat
