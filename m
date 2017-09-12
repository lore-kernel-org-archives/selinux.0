Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CHwWTB020952
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 13:58:33 -0400
Received: by mail-lf0-f67.google.com with SMTP id l196so5677313lfl.3
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 10:35:01 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Sep 2017 13:33:54 -0400
Message-ID: <CAHC9VhQr8R-=Sgqb7biFkz3G_dAAQG-PRMGe+Lp7SvoHKM=v+w@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [GIT PULL] SELinux patches for v4.14
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As discussed on the linux-security pull request thread, this is the
direct SELinux pull request; the content/tag is the same as what I
sent to James/linux-security earlier:

"A relatively quiet period for SELinux, 11 patches with only two/three
 having any substantive changes.  These noteworthy changes include
 another tweak to the NNP/nosuid handling, per-file labeling for
 cgroups, and an object class fix for AF_UNIX/SOCK_RAW sockets; the
 rest of the changes are minor tweaks or administrative updates
 (Stephen's email update explains the file explosion in the diffstat).
 Everything passes the selinux-testsuite and merged cleanly on top of
 the linux-security/next branch from earlier today."

---
The following changes since commit 31368ce83c59a5422ee621a38aeea98142d0ecf7:

 tomoyo: Update URLs in Documentation/admin-guide/LSM/tomoyo.rst
  (2017-07-25 11:00:26 +1000)

are available in the git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
  tags/selinux-pr-20170831

for you to fetch changes up to 0c3014f22dec0e1d14c8298551bfb6434638bdd9:

 selinux: constify nf_hook_ops (2017-08-28 17:33:19 -0400)

----------------------------------------------------------------
selinux/stable-4.14 PR 20170831

----------------------------------------------------------------
Antonio Murdaca (1):
     selinux: allow per-file labeling for cgroupfs

Arvind Yadav (1):
     selinux: constify nf_hook_ops

Luis Ressel (1):
     selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets

Michal Hocko (1):
     selinux: use GFP_NOWAIT in the AVC kmem_caches

Paul Moore (3):
     credits: update Paul Moore's info
     selinux: update the selinux info in MAINTAINERS
     MAINTAINERS: update the NetLabel and Labeled Networking information

Stephen Smalley (4):
     selinux: genheaders should fail if too many permissions are defined
     selinux: Generalize support for NNP/nosuid SELinux domain transitions
     selinux: update my email address
     lsm_audit: update my email address

CREDITS                                 |  8 ++---
MAINTAINERS                             | 29 ++++++++++-------
include/linux/lsm_audit.h               |  2 +-
scripts/selinux/genheaders/genheaders.c |  7 ++++-
security/lsm_audit.c                    |  2 +-
security/selinux/avc.c                  | 16 +++++-----
security/selinux/hooks.c                | 56 ++++++++++++++++++++---------
security/selinux/include/avc.h          |  2 +-
security/selinux/include/avc_ss.h       |  2 +-
security/selinux/include/classmap.h     |  2 ++
security/selinux/include/objsec.h       |  2 +-
security/selinux/include/security.h     |  4 ++-
security/selinux/ss/avtab.c             |  2 +-
security/selinux/ss/avtab.h             |  2 +-
security/selinux/ss/constraint.h        |  2 +-
security/selinux/ss/context.h           |  2 +-
security/selinux/ss/ebitmap.c           |  2 +-
security/selinux/ss/ebitmap.h           |  2 +-
security/selinux/ss/hashtab.c           |  2 +-
security/selinux/ss/hashtab.h           |  2 +-
security/selinux/ss/mls.c               |  2 +-
security/selinux/ss/mls.h               |  2 +-
security/selinux/ss/mls_types.h         |  2 +-
security/selinux/ss/policydb.c          |  2 +-
security/selinux/ss/policydb.h          |  2 +-
security/selinux/ss/services.c          |  9 ++++--
security/selinux/ss/services.h          |  2 +-
security/selinux/ss/sidtab.c            |  2 +-
security/selinux/ss/sidtab.h            |  2 +-
security/selinux/ss/symtab.c            |  2 +-
security/selinux/ss/symtab.h            |  2 +-
31 files changed, 106 insertions(+), 71 deletions(-)

-- 
paul moore
www.paul-moore.com
