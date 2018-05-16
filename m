Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4GKvCr3011406
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 16:57:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 40mRZZ5BL8z2Vp9C
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 20:57:10 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 40mRZY72ZCz2Vp98
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 20:57:09 +0000 (UTC)
Received: by mail-wr0-f196.google.com with SMTP id v60-v6so3335328wrc.7
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 13:57:08 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 16 May 2018 16:56:07 -0400
Message-ID: <CAHC9VhQfFXGXqx9seQy-EdTHauyqarYnCVChjd3s6BexQ+tE6A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [GIT PULL] SELinux fixes for v4.17 (#1)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Linus,

A small pull request to fix a few regressions in the SELinux/SCTP code
with applications that call bind() with AF_UNSPEC/INADDR_ANY.  The
individual commit descriptions have more information, but the commits
themselves should be self explanatory.  Please merge.

Thanks,
-Paul

--
The following changes since commit 6b6bc6205d98796361962ee282a063f18ba8dc57:

 selinux: wrap AVC state (2018-03-20 16:58:17 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180516

for you to fetch changes up to 4152dc91b5932e7fe49a5afed62a068b2f31d196:

 selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()
   (2018-05-14 15:20:59 -0400)

----------------------------------------------------------------
selinux/stable-4.17 PR 20180516

----------------------------------------------------------------
Alexey Kodanev (3):
     selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()
     selinux: fix address family in bind() and connect() to match address/port
     selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()

security/selinux/hooks.c | 50 +++++++++++++++++++++++++++---------------------
1 file changed, 28 insertions(+), 22 deletions(-)

-- 
paul moore
www.paul-moore.com
