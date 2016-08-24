Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7OCqiGc021774
 for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2016 08:52:44 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] allow disabling "security.restorecon_last" extended
 attribute.
Date: Wed, 24 Aug 2016 13:52:34 +0100
Message-Id: <1472043154-28818-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Allow the "security.restorecon_last" extended attribute to be ignored.
Setting this flag/option will not check or update any directory SHA1 digests.
Use this option to effectively disable usage of the security.restorecon_last
extended attribute. Note that setting this flag will override the
SELINUX_RESTORECON_IGNORE_DIGEST flag.

Richard Haines (2):
  libselinux: Ignore restorecon_last in selinux_restorecon(3)
  policycoreutils: setfiles - Add option to ignore restorecon_last

 libselinux/include/selinux/restorecon.h  |  4 ++++
 libselinux/man/man3/selinux_restorecon.3 | 20 +++++++++++++++++---
 libselinux/src/selinux_restorecon.c      |  9 ++++++++-
 libselinux/utils/selinux_restorecon.c    |  9 +++++++--
 policycoreutils/setfiles/restore.c       |  5 +++--
 policycoreutils/setfiles/restore.h       |  2 ++
 policycoreutils/setfiles/restorecon.8    | 14 ++++++++++++--
 policycoreutils/setfiles/setfiles.8      | 12 +++++++++++-
 policycoreutils/setfiles/setfiles.c      | 19 ++++++++++++-------
 9 files changed, 76 insertions(+), 18 deletions(-)

-- 
2.7.4
