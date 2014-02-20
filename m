Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1KKLH83023056
 for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2014 15:21:17 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux fixes for 3.14-rcX
Date: Thu, 20 Feb 2014 15:21:08 -0500
Message-ID: <2647376.QzqO8bTHze@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Just a single patch to fix a SELinux problem on big endian systems.  The patch 
is trivial, easily understood, and passes the SELinux testsuite.  I don't 
expect any merge problems.

Enjoy,
-Paul

---
The following changes since commit 2172fa709ab32ca60e86179dc67d0857be8e2c98:

  SELinux:  Fix kernel BUG on empty security contexts.
		   (2014-02-05 12:20:51 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-3.14

for you to fetch changes up to 9085a6422900092886da8c404e1c5340c4ff1cbf:

  SELinux: bigendian problems with filename trans rules
           (2014-02-20 12:07:58 -0500)

----------------------------------------------------------------
Eric Paris (1):
      SELinux: bigendian problems with filename trans rules

 security/selinux/ss/policydb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
paul moore
security and virtualization @ redhat
