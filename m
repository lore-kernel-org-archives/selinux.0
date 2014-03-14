Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2EKKurk020907
 for <selinux@tycho.nsa.gov>; Fri, 14 Mar 2014 16:20:56 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.15
Date: Fri, 14 Mar 2014 16:20:51 -0400
Message-ID: <2794067.Wx0yCIiBrQ@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Here are the SELinux patches for 3.15.  There are three patches here, the 
first and last are obvious fixes and the middle patch is a straightforward 
DAC-before-MAC fix.  They should merge into the linux-security tree without 
problem.

Enjoy,
-Paul

---
The following changes since commit 41be702a542a0d14bb0b1c16e824fa9ed27616ec:

  Merge tag 'v3.13' into next (2014-01-23 15:52:06 -0500)

are available in the git repository at:


  git://git.infradead.org/users/pcmoore/selinux next

for you to fetch changes up to eee3094683fbc7fe6bcdaef58c1ef31f8460cdca:

  selinux: correctly label /proc inodes in use before the policy is loaded 
(2014-03-05 15:54:57 -0500)

----------------------------------------------------------------
Paul Moore (3):
      selinux: fix the output of ./scripts/get_maintainer.pl for SELinux
      selinux: put the mmap() DAC controls before the MAC controls
      selinux: correctly label /proc inodes in use before the policy is loaded

 MAINTAINERS              |  5 ++---
 security/selinux/hooks.c | 56 +++++++++++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 24 deletions(-)

-- 
paul moore
security and virtualization @ redhat
