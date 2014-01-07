Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s07JAOeP026962
 for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2014 14:10:24 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.14 (part two)
Date: Tue, 07 Jan 2014 14:10:18 -0500
Message-ID: <3613128.CelVDdi87u@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Another pull request for 3.14; this time just a single patch that fixes a 
memory leak.  The tree below is the exact same as the first 3.14 pull request 
with the patch below added.  I don't expect any merge problems.

Enjoy,
-Paul

---
The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:

  Linux 3.12 (2013-11-03 15:41:51 -0800)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux master

for you to fetch changes up to 8ed814602876bec9bad2649ca17f34b499357a1c:

  SELinux: Fix memory leak upon loading policy (2014-01-07 10:21:44 -0500)

----------------------------------------------------------------
Tetsuo Handa (1):
      SELinux: Fix memory leak upon loading policy

-- 
paul moore
security and virtualization @ redhat
