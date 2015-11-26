Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAQ0XseL013972
 for <selinux@tycho.nsa.gov>; Wed, 25 Nov 2015 19:33:54 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux fixes for 4.4 (#1)
Date: Wed, 25 Nov 2015 19:33:41 -0500
Message-ID: <3155281.PYyyu1IbYA@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

A single SELinux fix for 4.4 that corrects a problem with SELinux's 
conditional rules handling.  The fix is small, easily understood, and passes 
the SELinux testsuite.  Please pull and send to Linus.

As of a few minutes ago, selinux#upstream applied cleanly on top of linux-
security#next.

Thanks,
-Paul

---
The following changes since commit 63205654c0e05e5ffa1c6eef2fbef21dcabd2185:

  selinux: Use a kmem_cache for allocation struct file_security_struct
           (2015-10-21 17:44:30 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to f3bef67992e8698897b584616535803887c4a73e:

  selinux: fix bug in conditional rules handling (2015-11-24 13:44:32 -0500)

----------------------------------------------------------------
Stephen Smalley (1):
      selinux: fix bug in conditional rules handling

 security/selinux/ss/conditional.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
paul moore
security @ redhat
