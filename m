Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5JJakhF030377
 for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2016 15:36:46 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V2 0/3] Update setfiles/restorecon to support
 selinux_restorecon
Date: Sun, 19 Jun 2016 20:36:26 +0100
Message-Id: <1466364986-7989-1-git-send-email-richard_c_haines@btinternet.com>
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
setfiles(8) in selinux_restorecon_* services.

There is a new option of -I to ignore the digest as explained in the updated
man pages.

The output from these commands should be much the same as before (some minor
wording changes).

Changes for V2
1) All requested changes have been completed as per [1], [2] and [3].
2) As selinux_restorecon_set_alt_rootpath(3) and
selinux_restorecon_set_exclude_list(3) now allocate memory etc. they return
errors (they were void).

[1] http://marc.info/?l=selinux&m=146470027405908&w=2
[2] http://marc.info/?l=selinux&m=146470835908849&w=2
[3] http://marc.info/?l=selinux&m=146470720008392&w=2

Richard Haines (3):
  libselinux: Evaluate inodes in selinux_restorecon(3)
  libselinux: Add setfiles support to selinux_restorecon(3)
  policycoreutils: setfiles - Modify to use selinux_restorecon

 libselinux/include/selinux/restorecon.h            | 109 +++-
 libselinux/man/man3/selinux_restorecon.3           |  80 ++-
 .../man/man3/selinux_restorecon_set_alt_rootpath.3 |  35 +
 .../man/man3/selinux_restorecon_set_exclude_list.3 |  16 +-
 .../man/man3/selinux_restorecon_set_sehandle.3     |   4 +-
 libselinux/src/selinux_restorecon.c                | 710 ++++++++++++++++++--
 libselinux/utils/selinux_restorecon.c              |  52 +-
 policycoreutils/setfiles/restore.c                 | 718 ++-------------------
 policycoreutils/setfiles/restore.h                 |  51 +-
 policycoreutils/setfiles/restorecon.8              |  74 ++-
 policycoreutils/setfiles/setfiles.8                |  75 ++-
 policycoreutils/setfiles/setfiles.c                | 198 +++---
 12 files changed, 1201 insertions(+), 921 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3

-- 
2.5.5
