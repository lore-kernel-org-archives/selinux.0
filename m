Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OD9aqn012870
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 09:09:36 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [RFC PATCH 0/1] libselinux: Add support for selinux_check_access_flags
Date: Mon, 24 Apr 2017 14:09:19 +0100
Message-Id: <20170424130919.5286-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Only wanted the avd flags to check whether the domain was permissive
or not using an selinux_check_access() type call.

As a consequence of implementing selinux_check_access_flags, additional
calls have been added to avc.c: avc_has_perm_flags() and
avc_has_perm_noaudit_flags(). Added man page entries for them but not sure
if they should be hidden.

Richard Haines (1):
  libselinux: Add support for selinux_check_access_flags

 libselinux/include/selinux/avc.h                 |  68 +++++++
 libselinux/include/selinux/selinux.h             |  32 +++
 libselinux/man/man3/avc_has_perm.3               |  37 +++-
 libselinux/man/man3/security_compute_av.3        |  21 +-
 libselinux/man/man3/selinux_check_access_flags.3 |   1 +
 libselinux/src/avc.c                             |  44 ++++-
 libselinux/src/avc_internal.h                    |   1 +
 libselinux/src/checkAccess.c                     |  63 +++---
 libselinux/utils/.gitignore                      |   2 +
 libselinux/utils/avc_has_perm.c                  | 235 +++++++++++++++++++++++
 libselinux/utils/selinux_check_access.c          | 189 ++++++++++++++++++
 11 files changed, 660 insertions(+), 33 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_check_access_flags.3
 create mode 100644 libselinux/utils/avc_has_perm.c
 create mode 100644 libselinux/utils/selinux_check_access.c

-- 
2.9.3
