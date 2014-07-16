Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6G2csnU030678
 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2014 22:38:55 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux fix for 3.16-rcX
Date: Tue, 15 Jul 2014 22:38:19 -0400
Message-ID: <2092564.8lACVUTXtn@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

A single fix for the upcoming 3.16 release.  This patch is worth pushing up 
for 3.16, despite the late stage of the release, because without this patch 
SELinux systems with the latest version of cryptsetup may not be able to 
access their encrypted volumes (more details in the patch description) which 
could prevent the system from booting properly, users accessing their home 
directories, etc.

The patch is fairly minor and passes the SELinux testsuite.

-Paul

---
The following changes since commit 170b5910d9fbea79de1bb40df22eda5f98250c0c:

  Merge tag 'v3.15' into next (2014-06-17 17:30:23 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-3.16

for you to fetch changes up to 4da6daf4d3df5a977e4623963f141a627fd2efce:

  selinux: fix the default socket labeling in sock_graft()
           (2014-07-10 10:17:48 -0400)

----------------------------------------------------------------
Paul Moore (1):
      selinux: fix the default socket labeling in sock_graft()

 include/linux/security.h |  5 ++++-
 security/selinux/hooks.c | 13 +++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
paul moore
security and virtualization @ redhat
