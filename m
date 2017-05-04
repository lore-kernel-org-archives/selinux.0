Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44Kjoqf031752
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 16:45:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id 142so6511565wma.1
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 13:45:47 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] sestatus: show checkreqprot status
Date: Thu,  4 May 2017 22:45:36 +0200
Message-Id: <20170504204538.17853-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

v2:
  rename security_checkreqprot to security_get_checkreqprot
  add O_CLOEXEC open flag
  improve man page description and fix wrong placement
  hopefully improve sestatus output readability

Christian Göttsche (2):
  libselinux: add security_get_checkreqprot
  sestatus: show checkreqprot status

 libselinux/include/selinux/selinux.h      |  3 +++
 libselinux/man/man3/security_getenforce.3 |  9 ++++++-
 libselinux/src/checkreqprot.c             | 40 +++++++++++++++++++++++++++++++
 libselinux/src/selinux_internal.h         |  1 +
 policycoreutils/sestatus/sestatus.c       | 14 +++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/src/checkreqprot.c

-- 
2.11.0
