Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v21LGPZU013206
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 16:16:25 -0500
Received: by mail-lf0-f44.google.com with SMTP id a6so25279487lfa.0
 for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2017 13:16:24 -0800 (PST)
MIME-Version: 1.0
From: Paul Moore <pmoore@redhat.com>
Date: Wed, 1 Mar 2017 16:16:22 -0500
Message-ID: <CAGH-Kgu-d5J7hP1cPGZk4OFE+7XXB1NLAgAt9=XZf4tRrwBJcQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for 4.11 (#1)
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

One small patch to wrap the SELinux cgroup labeling support with a
policy capability; this helps prevents breakage on Android and perhaps
other userspaces as well.  Everything passes the selinux-testsuite,
please merge and pass along to Linus.

Thanks,
-Paul

---
The following changes since commit 1ea0ce40690dff38935538e8dab7b12683ded0d3:

  selinux: allow changing labels for cgroupfs (2017-02-07 22:17:47 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.11

for you to fetch changes up to 6b65b78139acf0b5984bcab8c2dfd001d45683c0:

  selinux: wrap cgroup seclabel support with its own policy capability
(2017-02-28 16:41:44 -0500)

----------------------------------------------------------------
Stephen Smalley (1):
      selinux: wrap cgroup seclabel support with its own policy capability

 security/selinux/hooks.c            | 7 ++++---
 security/selinux/include/security.h | 2 ++
 security/selinux/selinuxfs.c        | 3 ++-
 security/selinux/ss/services.c      | 4 ++++
 4 files changed, 12 insertions(+), 4 deletions(-)

-- 
paul moore
security @ redhat
