Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0UHWtuU017000
 for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2018 12:32:55 -0500
Received: by mail-lf0-f47.google.com with SMTP id g72so16526972lfg.5
 for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2018 09:32:49 -0800 (PST)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2018 12:32:47 -0500
Message-ID: <CAHC9VhRN1bsCBh4mada12fYSvGrcKhi0LrVGmSO0J+rZ-kzkbw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [GIT PULL] SELinux patches for v4.16
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Linus,

A small pull request this time, just three patches, and one of these
is just a comment update (swap the FSF physical address for a URL).
The other two patches are small bug fixes found by szybot/syzkaller;
they individual patch descriptions should tell you all you ever wanted
to know.

All the patches pass the selinux-testsuite, and it looks to merge
cleanly on top of your tree (as of right now anyway).

Please pull, thanks.
-Paul
--
The following changes since commit 5794ed762ac2125299644494766704da94168ec0:

 selinux: remove extraneous initialization of slots_used and max_chain_len
          (2017-10-16 18:40:09 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
       tags/selinux-pr-20180130

for you to fetch changes up to 4b14752ec4e0d87126e636384cf37c8dd9df157c:

 selinux: skip bounded transition processing if the policy isn't loaded
          (2017-12-05 17:17:43 -0500)

----------------------------------------------------------------
selinux/stable-4.16 PR 20180130

----------------------------------------------------------------
Martin Kepplinger (1):
     security: replace FSF address with web source in license notices

Paul Moore (2):
     selinux: ensure the context is NUL terminated in security_context_to_sid_c
ore()
     selinux: skip bounded transition processing if the policy isn't loaded

security/selinux/include/netlabel.h |  3 +--
security/selinux/netlabel.c         |  3 +--
security/selinux/ss/services.c      | 21 +++++++++++----------
3 files changed, 13 insertions(+), 14 deletions(-)

-- 
paul moore
www.paul-moore.com
