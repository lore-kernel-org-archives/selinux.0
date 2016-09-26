Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8QFTooE032704
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 11:29:54 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] selinux: Add features to find security.restorecon_last
 entries
Date: Mon, 26 Sep 2016 16:29:09 +0100
Message-Id: <1474903749-4941-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch adds a new selinux_restorecon_xattr(3) function and a
supporting utility restorecon_xattr(8) to find and/or remove
security.restorecon_last entries added by setfiles(8) or
restorecon(8).

Richard Haines (2):
  libselinux: Add function to find security.restorecon_last entries
  policycoreutils: setfiles - Utility to find security.restorecon_last
    entries

 libselinux/include/selinux/restorecon.h            |  48 +++++
 libselinux/man/man3/selinux_restorecon.3           |   2 +
 .../man/man3/selinux_restorecon_default_handle.3   |   6 +-
 .../man/man3/selinux_restorecon_set_alt_rootpath.3 |   4 +-
 .../man/man3/selinux_restorecon_set_exclude_list.3 |   4 +-
 .../man/man3/selinux_restorecon_set_sehandle.3     |   9 +-
 libselinux/man/man3/selinux_restorecon_xattr.3     | 170 ++++++++++++++++
 libselinux/src/selinux_restorecon.c                | 207 +++++++++++++++++++
 policycoreutils/setfiles/Makefile                  |  10 +-
 policycoreutils/setfiles/restore.h                 |   1 +
 policycoreutils/setfiles/restorecon_xattr.8        | 119 +++++++++++
 policycoreutils/setfiles/restorecon_xattr.c        | 221 +++++++++++++++++++++
 12 files changed, 789 insertions(+), 12 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_xattr.3
 create mode 100644 policycoreutils/setfiles/restorecon_xattr.8
 create mode 100644 policycoreutils/setfiles/restorecon_xattr.c

-- 
2.7.4
