Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46D92Bb002069
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 09:09:02 -0400
Received: by mail-wm0-f48.google.com with SMTP id 142so26102053wma.1
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 06:08:55 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] sestatus: show checkreqprot status
Date: Sat,  6 May 2017 15:08:46 +0200
Message-Id: <20170506130848.9128-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

v3:
  improved man-page and sestatus output wording; thanks to Stephen

v2:
  rename security_checkreqprot to security_get_checkreqprot
  add O_CLOEXEC open flag
  improve man page description and fix wrong placement
  hopefully improve sestatus output readability

Christian Göttsche (2):
  libselinux: add security_get_checkreqprot
  sestatus: show checkreqprot status

 libselinux/include/selinux/selinux.h      |  3 +++
 libselinux/man/man3/security_getenforce.3 | 11 ++++++++-
 libselinux/src/checkreqprot.c             | 40 +++++++++++++++++++++++++++++++
 libselinux/src/selinux_internal.h         |  1 +
 policycoreutils/sestatus/sestatus.8       |  2 ++
 policycoreutils/sestatus/sestatus.c       | 14 +++++++++++
 6 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/src/checkreqprot.c

-- 
2.11.0
