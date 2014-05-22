Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4MFPbeN019842
 for <selinux@tycho.nsa.gov>; Thu, 22 May 2014 11:25:37 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.16
Date: Thu, 22 May 2014 11:25:33 -0400
Message-ID: <5872296.eRu4qP8SMB@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Here are the SELinux patches for 3.16.  A total of four patches: two to fix a 
problem when loading policy on slow machines, one to make it easier to 
determine permissive mode in the AVC audit messages, and one to block cause 
setexeccon() to fail on filesystems mounted with nosuid.  None of the patches 
are very substantial (see the diffstat below), all pass the SELinux testsuite, 
and the branch applied cleanly on top of your current #next.

Enjoy,
-Paul

---
The following changes since commit 6d32c850621b0be75777b9102b14f6268bbd9f0f:

  Merge tag 'v3.14' into next (2014-03-31 09:49:07 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux next

for you to fetch changes up to 47dd0b76ace953bd2c0479076db0d3e3b9594003:

  selinux: conditionally reschedule in hashtab_insert while loading selinux
           policy (2014-05-15 17:07:55 -0400)

----------------------------------------------------------------
Dave Jones (2):
      selinux: conditionally reschedule in mls_convert_context while loading 
               selinux policy
      selinux: conditionally reschedule in hashtab_insert while loading 
               selinux policy

Paul Moore (1):
      selinux: reject setexeccon() on MNT_NOSUID applications with -EACCES

Stephen Smalley (1):
      selinux:  Report permissive mode in avc: denied messages.

 security/selinux/avc.c         |  7 ++++++-
 security/selinux/hooks.c       | 11 +++++++----
 security/selinux/include/avc.h |  4 ++--
 security/selinux/ss/hashtab.c  |  3 +++                                        
 security/selinux/ss/mls.c      |  2 ++                                         
 5 files changed, 20 insertions(+), 7 deletions(-)

-- 
paul moore
security and virtualization @ redhat
