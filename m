Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CM0qVG030674
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 18:00:52 -0400
Received: by mail-wm0-f43.google.com with SMTP id u2so33989313wmu.0
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 15:00:51 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] show checkreqprot status in sestatus
Date: Thu, 13 Apr 2017 00:00:36 +0200
Message-Id: <20170412220038.9792-1-cgzones@googlemail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: cgzones <cgzones@googlemail.com>

V2
added O_CLOEXEC to open()

cgzones (2):
  libselinux: add security_checkreqprot
  sestatus: show checkreqprot status

 libselinux/include/selinux/selinux.h      |  3 +++
 libselinux/man/man3/security_getenforce.3 |  8 ++++++-
 libselinux/man/man3/selinux_status_open.3 | 11 +++++++--
 libselinux/src/checkreqprot.c             | 40 +++++++++++++++++++++++++++++++
 libselinux/src/selinux_internal.h         |  1 +
 policycoreutils/sestatus/sestatus.c       | 14 +++++++++++
 6 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100644 libselinux/src/checkreqprot.c

-- 
2.11.0
