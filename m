Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w560ToJM024027
 for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2018 20:29:50 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so6341192lfn.10
 for <selinux@tycho.nsa.gov>; Tue, 05 Jun 2018 17:29:46 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Jun 2018 20:29:45 -0400
Message-ID: <CAHC9VhRwb_bg_6HJyKc1UutodES3WVF5zoq5A5BqS9sZoCF7cA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [GIT PULL] SELinux patches for v4.18
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Linus,

SELinux is back with a quiet pull request for v4.18.  Three patches,
all small: two cleanups of the SELinux audit records, and one to
migrate to a newly defined type (vm_fault_t).

Everything passes our test suite, and as of about five minutes ago it
merged cleanly with your tree.

Please pull, thanks.
-Paul
--
The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

 Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180605

for you to fetch changes up to d141136f523a3a6372d22981bdff7a8906f36fea:

 audit: normalize MAC_POLICY_LOAD record (2018-04-17 17:54:11 -0400)

----------------------------------------------------------------
selinux/stable-4.18 PR 20180605

----------------------------------------------------------------
Richard Guy Briggs (2):
     audit: normalize MAC_STATUS record
     audit: normalize MAC_POLICY_LOAD record

Souptick Joarder (1):
     security: selinux: Change return type to vm_fault_t

security/selinux/selinuxfs.c | 18 ++++++++++++------
1 file changed, 12 insertions(+), 6 deletions(-)

-- 
paul moore
www.paul-moore.com
