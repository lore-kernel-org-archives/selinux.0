Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t19N6W4K025087
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:32 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t19N6UTC001526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:30 -0500
Subject: [PATCH 1/4] selinux-testsuite: add improved OS detection
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 09 Feb 2015 18:06:29 -0500
Message-ID: <20150209230629.2579.64390.stgit@localhost>
In-Reply-To: <20150209230426.2579.84520.stgit@localhost>
References: <20150209230426.2579.84520.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a script which will handle OS/distribution detection.  The initial
version of the script is very basic, handling only different RHEL
versions, but it is easily expanded as needed.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 0 files changed

diff --git a/tests/Makefile b/tests/Makefile
index 7c27787..e9d4646 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,19 +1,18 @@
-RHEL_VER=$(shell cat /etc/redhat-release)
-RHEL_VER_PREFIX=Red Hat Enterprise Linux Server release 
+DISTRO=$(shell ./os_detect)
 
 SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
 
 SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp
 
-ifeq ($(RHEL_VER_PREFIX)4, $(findstring $(RHEL_VER_PREFIX)4, $(RHEL_VER)))
+ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(SUBDIRS_COMMON)
 endif
 
-ifeq ($(RHEL_VER_PREFIX)5, $(findstring $(RHEL_VER_PREFIX)5, $(RHEL_VER)))
+ifeq ($(DISTRO),RHEL5)
     SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans
 endif
 
-ifeq ($(RHEL_VER_PREFIX)6, $(findstring $(RHEL_VER_PREFIX)6, $(RHEL_VER)))
+ifeq ($(DISTRO),RHEL6)
     SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans bounds
 endif
 
diff --git a/tests/os_detect b/tests/os_detect
new file mode 100755
index 0000000..cddcb85
--- /dev/null
+++ b/tests/os_detect
@@ -0,0 +1,9 @@
+#!/bin/bash
+
+if [[ -r /etc/redhat-release ]]; then
+	ver=$(cat /etc/redhat-release | sed -ne '/^Red Hat Enterprise Linux/p')
+	if [[ -n $ver ]]; then
+		echo "$ver" | \
+			sed -e 's/Red Hat Enterprise Linux[ \ta-zA-Z]*\([0-9]\+\).*/RHEL\1/'
+	fi
+fi
