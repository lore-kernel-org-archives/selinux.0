Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLKNkBY019461
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 15:23:46 -0500
Received: by mail-oi0-f42.google.com with SMTP id 128so25981741oig.0
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 12:23:42 -0800 (PST)
MIME-Version: 1.0
From: Paul Moore <pmoore@redhat.com>
Date: Wed, 21 Dec 2016 15:23:41 -0500
Message-ID: <CAGH-KgsF7Dp=qt7CghKs3RqitYpKrx2cmHFhQLT+sHozfZof7Q@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for 4.10 (#1)
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

A small SELinux patch to fix some clang/llvm compiler warnings and
ensure the tools under scripts work well in the face of kernel
changes. As of a few minutes ago the selinux/stable-4.10 branch merged
cleanly on top of your linux-security/next branch.

Please merge for v4.10, if you can't get it to Linux before -rc1,
please send it up as a fix to the -rcX series.

Thanks,
-Paul

---
The following changes since commit 9287aed2ad1ff1bde5eb190bcd6dccd5f1cf47d3:

  selinux: Convert isec->lock into a spinlock (2016-11-22 17:44:02 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.10

for you to fetch changes up to bfc5e3a6af397dcf9c99a6c1872458e7867c4680:

  selinux: use the kernel headers when building scripts/selinux
           (2016-12-21 10:39:25 -0500)

----------------------------------------------------------------

Paul Moore (1):
      selinux: use the kernel headers when building scripts/selinux

scripts/selinux/genheaders/Makefile | 4 +++-
scripts/selinux/genheaders/genheaders.c | 4 ++++
scripts/selinux/mdp/Makefile | 4 +++-
scripts/selinux/mdp/mdp.c | 4 ++++
security/selinux/include/classmap.h | 2 ++
5 files changed, 16 insertions(+), 2 deletions(-)

-- 
paul moore
security @ redhat
