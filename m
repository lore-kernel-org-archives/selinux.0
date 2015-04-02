Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t322ncW4024100
 for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2015 22:49:38 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 4.1
Date: Wed, 01 Apr 2015 22:49:27 -0400
Message-ID: <1978116.cNUKEOv2T8@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Five patches this time around: three patches to improve and enlarge the the 
avtab hash table, one to cleanup some MLS label import code, and one to 
cleanup some of the avc code.  All of the patches are pretty small and 
straightforward.  The two cleanup patches are trivially understandable and the 
avtab code is well documented.

As usual, all patches pass the SELinux testsuite.

Enjoy,
-Paul

---
The following changes since commit 6436a123a147db51a0b06024a8350f4c230e73ff:

  selinux: fix sel_write_enforce broken return value
           (2015-03-25 16:55:06 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 9b43e04b188a1f715429604cca32b846e5a48cd2:

  Merge branch 'next' into upstream in preparation for v4.1
  (2015-04-01 22:24:51 -0400)

----------------------------------------------------------------
Jeff Vander Stoep (1):
      selinux: remove unnecessary pointer reassignment in 
               avc_has_perm_noaudit()

John Brooks (1):
      selinux: Use a better hash function for avtab

Paul Moore (2):
      selinux: reconcile security_netlbl_secattr_to_sid() and 
               mls_import_netlbl_cat()
      Merge branch 'next' into upstream in preparation for v4.1

Stephen Smalley (2):
      selinux: convert avtab hash table to flex_array
      selinux: increase avtab max buckets

 security/selinux/avc.c         |  6 ++--
 security/selinux/ss/avtab.c    | 72 +++++++++++++++++++++++++++++++---------
 security/selinux/ss/avtab.h    |  8 +++--
 security/selinux/ss/mls.c      | 10 ++----
 security/selinux/ss/services.c |  6 +---
 5 files changed, 67 insertions(+), 35 deletions(-)

-- 
paul moore
security @ redhat
