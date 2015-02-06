Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t16MYtDx005897
 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2015 17:34:55 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t16MYQCB024377
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2015 17:34:26 -0500
Subject: [PATCH] selinux-testsuite: fix RHEL detection
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 06 Feb 2015 17:34:24 -0500
Message-ID: <20150206223424.13392.21940.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The redhat-release package is not consistently named across RHEL
releases, use the /etc/redhat-release instead to detect the RHEL
version.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 tests/Makefile |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index 3838e14..7c27787 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,18 +1,19 @@
-REDHAT_RELEASE=$(shell rpm -q redhat-release)
+RHEL_VER=$(shell cat /etc/redhat-release)
+RHEL_VER_PREFIX=Red Hat Enterprise Linux Server release 
 
 SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
 
 SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp
 
-ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
+ifeq ($(RHEL_VER_PREFIX)4, $(findstring $(RHEL_VER_PREFIX)4, $(RHEL_VER)))
     SUBDIRS:=$(SUBDIRS_COMMON)
 endif
 
-ifeq (redhat-release-5, $(findstring redhat-release-5, $(REDHAT_RELEASE)))
+ifeq ($(RHEL_VER_PREFIX)5, $(findstring $(RHEL_VER_PREFIX)5, $(RHEL_VER)))
     SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans
 endif
 
-ifeq (redhat-release-6, $(findstring redhat-release-6, $(REDHAT_RELEASE)))
+ifeq ($(RHEL_VER_PREFIX)6, $(findstring $(RHEL_VER_PREFIX)6, $(RHEL_VER)))
     SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans bounds
 endif
 
