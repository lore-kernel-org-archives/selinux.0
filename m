Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4AFLhYS026072
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 11:21:43 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Update setfiles/restorecon to support selinux_restorecon
Date: Tue, 10 May 2016 16:21:29 +0100
Message-Id: <1462893689-9455-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

These patches:
1) Add additional services to selinux_restorecon(3) so that setfiles(8)
functionality can be supported.
2) Modify setfiles(8) and restorecon(8) to make use of the new libselinux
functions.

I've supported all options except -q of the current restorecon(8) and
setfiles(8) in selinux_restorecon_* services, however I'm not sure they are
all really needed.
There is a new option of -I to ignore the digest as explained in the updated
man pages.

The output from these commands should be much the same as before (with some
minor wording changes), the only exceptions being:
1) The -p option does not output the percentage, just * for every 1000 files
(but does state approx file count if mass relabel and verbose).
2) Does not report warnings on paths without default labels.

Richard Haines (3):
  libselinux: Evaluate inodes in selinux_restorecon(3)
  libselinux: Add setfiles support to selinux_restorecon(3)
  policycoreutils: setfiles - Modify to use selinux_restorecon

 libselinux/include/selinux/restorecon.h            |  21 +
 libselinux/man/man3/selinux_restorecon.3           |  18 +-
 .../man/man3/selinux_restorecon_set_alt_rootpath.3 |  34 ++
 libselinux/src/matchpathcon.c                      | 139 +----
 libselinux/src/selinux_restorecon.c                | 445 ++++++++++++--
 libselinux/utils/selinux_restorecon.c              |  38 +-
 policycoreutils/setfiles/restore.c                 | 665 +++------------------
 policycoreutils/setfiles/restore.h                 |  49 +-
 policycoreutils/setfiles/restorecon.8              |  74 ++-
 policycoreutils/setfiles/setfiles.8                |  75 ++-
 policycoreutils/setfiles/setfiles.c                | 188 +++---
 11 files changed, 852 insertions(+), 894 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3

-- 
2.5.5
