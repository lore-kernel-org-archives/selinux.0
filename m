Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1MJrb1X022836
 for <selinux@tycho.nsa.gov>; Mon, 22 Feb 2016 14:53:40 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux fixes for 4.5 (#2)
Date: Mon, 22 Feb 2016 14:53:33 -0500
Message-ID: <2013440.Fs5UDgiGs4@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

One more straightforward patch to fix a problem with the inode invalidation 
changes.  The fix passes the selinux-testsuite and applies cleanly on top of 
your current linux-security#next branch; please apply.

-Paul

---
The following changes since commit b197367ed1ba81b0d26f7e7f76f61731ac6e5842:

  selinux: Inode label revalidation performance fix
           (2016-01-08 16:24:27 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.5

for you to fetch changes up to e817c2f33efb4aa7f02c98dfab9a5f8ff383ea7e:

  selinux: Don't sleep inside inode_getsecid hook (2016-02-19 16:29:19 -0500)

----------------------------------------------------------------
Andreas Gruenbacher (1):
      selinux: Don't sleep inside inode_getsecid hook

 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
security @ redhat
