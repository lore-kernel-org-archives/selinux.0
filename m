Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45MQEKX006649
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 18:26:14 -0400
Received: by mail-qk0-f171.google.com with SMTP id r184so51396857qkc.1
 for <selinux@tycho.nsa.gov>; Thu, 05 May 2016 15:26:11 -0700 (PDT)
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.7
Date: Thu, 05 May 2016 18:26:09 -0400
Message-ID: <2920315.ICEJRqPiXG@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

A good chunk of SELinux patches for 4.7, eleven in total.  Of the eleven, two 
are bug fixes, six are performance improvements relating to the inode label 
revalidation code, and three introduce improved functionality: kernel module 
loading restrictions, better handling for userns capability checks, and 
execstack checking on thread stacks.

All the patches pass the selinux-testsuite, have been in the pcmoore/kernel-
secnext builds, and as of a few minutes ago applied cleanly on top of linux-
security#next.  Please apply.

-Paul

---
The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.7

for you to fetch changes up to c2316dbf124257ae19fd2e29cb5ec51060649d38:

  selinux: apply execstack check on thread stacks (2016-04-26 15:47:57 -0400)

----------------------------------------------------------------
Janak Desai (1):
      netlabel: fix a problem with netlbl_secattr_catmap_setrng()

Jeff Vander Stoep (1):
      selinux: restrict kernel module loading

Paul Moore (6):
      selinux: don't revalidate inodes in selinux_socket_getpeersec_dgram()
      selinux: simply inode label states to INVALID and INITIALIZED
      selinux: consolidate the ptrace parent lookup code
      selinux: don't revalidate an inode's label when explicitly setting it
      selinux: delay inode label lookup as long as possible
      selinux: check ss_initialized before revalidating an inode label

Prarit Bhargava (1):
      selinux: Change bool variable name to index.

Stephen Smalley (2):
      selinux: distinguish non-init user namespace capability checks
      selinux: apply execstack check on thread stacks

 net/netlabel/netlabel_kapi.c           |   2 +-
 security/selinux/hooks.c               | 144 +++++++++++++++++++++---------
 security/selinux/include/classmap.h    |  30 ++++---
 security/selinux/include/conditional.h |   2 +-
 security/selinux/include/objsec.h      |   5 +-
 security/selinux/ss/services.c         |   6 +-
 6 files changed, 128 insertions(+), 61 deletions(-)

-- 
paul moore
security @ redhat
