Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAD41SJa010157
 for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2014 23:01:28 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.18 #3
Date: Wed, 12 Nov 2014 23:01:21 -0500
Message-ID: <8435198.rL4hIZhD3f@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

One more small SELinux fix that should go into the next v3.18 release; it's a 
small patch to convert a WARN_ONCE() into a printk() so we don't end up 
scaring users with a nasty error message and backtrace whenever an errant 
netlink message hits the kernel.

It applies cleanly on top of your next branch.

Enjoy,
-Paul

---
The following changes since commit 923190d32de4428afbea5e5773be86bea60a9925:

  selinux: fix inode security list corruption (2014-10-15 10:37:02 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-3.18

for you to fetch changes up to d950f84c1c6658faec2ecbf5b09f7e7191953394:

  selinux: convert WARN_ONCE() to printk() in selinux_nlmsg_perm() (2014-11-12 
16:14:02 -0500)

----------------------------------------------------------------
Richard Guy Briggs (1):
      selinux: convert WARN_ONCE() to printk() in selinux_nlmsg_perm()

 security/selinux/hooks.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
paul moore
security and virtualization @ redhat
