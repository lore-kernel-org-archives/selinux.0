Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u23KFolW024319
 for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2016 15:15:50 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.6
Date: Thu, 03 Mar 2016 15:15:46 -0500
Message-ID: <3791404.FF7yCft6NU@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Just a single SELinux patch for 4.6, and it's a trivial build patch too.  The 
patch passes the selinux-testsuite (surprise, surprise) and merges cleanly 
with the current linux-security#next branch; please apply.

-Paul

---
The following changes since commit 76319946f321e30872dd72af7de867cb26e7a373:

  selinux: rate-limit netlink message warnings in selinux_nlmsg_perm() 
           (2015-12-24 11:09:41 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.6

for you to fetch changes up to 9090a2d5e3e6f1f1f1aabd44f9335ff873239b60:

  selinux: use absolute path to include directory (2016-01-28 10:37:15 -0500)

----------------------------------------------------------------
Andy Shevchenko (1):
      selinux: use absolute path to include directory

 security/selinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
security @ redhat
