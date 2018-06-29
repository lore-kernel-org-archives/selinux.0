Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5TLlWMg029049
 for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2018 17:47:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 41HVcK5qM1z2Sj4Z
 for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2018 21:47:29 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 41HVcK1TfTz2Sj45
 for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2018 21:47:29 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id g3-v6so8381152ljk.12
 for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2018 14:47:27 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Jun 2018 17:47:15 -0400
Message-ID: <CAHC9VhQZ+zRQ+LER=BCx1_Z-Z+LQuYaeEUxQ8YMQoNdNgt=cwg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [GIT PULL] SELinux fixes for v4.18 (#1)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Linus,

One fairly straightforward patch to fix a longstanding issue where a
process could stall while accessing files in selinuxfs and block
everyone else due to a held mutex.  The patch passes all our tests and
looks to apply cleanly to your current tree.  Please pull this as a
fix for v4.18.

Thanks,
-Paul
--
The following changes since commit d141136f523a3a6372d22981bdff7a8906f36fea:

 audit: normalize MAC_POLICY_LOAD record (2018-04-17 17:54:11 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180629

for you to fetch changes up to 0da74120c5341389b97c4ee27487a97224999ee1:

 selinux: move user accesses in selinuxfs out of locked regions
   (2018-06-28 20:39:54 -0400)

----------------------------------------------------------------
selinux/stable-4.18 PR 20180629

----------------------------------------------------------------
Jann Horn (1):
     selinux: move user accesses in selinuxfs out of locked regions

security/selinux/selinuxfs.c | 78 +++++++++++++++++-----------------------
1 file changed, 33 insertions(+), 45 deletions(-)

-- 
paul moore
www.paul-moore.com
