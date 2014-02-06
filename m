Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s16Dkcsj015150
 for <selinux@tycho.nsa.gov>; Thu, 6 Feb 2014 08:46:38 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux fixes for 3.14-rc1
Date: Thu, 06 Feb 2014 08:46:31 -0500
Message-ID: <4721677.KRkL7WUpch@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Two small fixes for 3.14-rc1: a patch to check for setting empty security 
contexts, and a patch to add a SELinux netlink definition for the 
SOCK_DIAG_BY_FAMILY message.  Both patches pass the SELinux testsuite and are 
very trivial.  I don't expect any merge problems.

Enjoy,
-Paul

---

The following changes since commit 825e587af2e90e9b953849f3347a01d8f383d577:

  Merge tag 'v3.13' into stable-3.14 (2014-02-05 10:39:48 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-3.14

for you to fetch changes up to 2172fa709ab32ca60e86179dc67d0857be8e2c98:

  SELinux:  Fix kernel BUG on empty security contexts. (2014-02-05 12:20:51 
-0500)

----------------------------------------------------------------
Paul Moore (1):
      selinux: add SOCK_DIAG_BY_FAMILY to the list of netlink message types

Stephen Smalley (1):
      SELinux:  Fix kernel BUG on empty security contexts.

 security/selinux/nlmsgtab.c    | 2 ++
 security/selinux/ss/services.c | 4 ++++
 2 files changed, 6 insertions(+)

-- 
paul moore
security and virtualization @ redhat
