Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9NAFHwK030259
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2013 06:15:17 -0400
From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Cc: serge@hallyn.com, jburke@redhat.com
Subject: [PATCH selinux-testsuite] fix policy Makefile for RHEL4/5
Date: Wed, 23 Oct 2013 12:14:50 +0200
Message-Id: <7dd07b1a5263ee8cc76ff43ba483f4c45b422167.1382523003.git.jstancek@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

commit 7c31f1c7a64635b5216996dd0e4de014af762a79 breaks build for RHEL4/5:
  make[2]: Leaving directory
  `/root/selinux-testsuite/policy/redhat/5/test_policy'
  make[1]: *** No rule to make target `exit'.  Stop.
  make[1]: Leaving directory `/root/selinux-testsuite/policy/redhat/5'

There are 2 problems:
  1. missing semi-colon before exit
  2. exit won't stop target execution, so it continues and tries to build
     general policy

This patch removes duplicate tests for RHEL version and defines
rhel/general variant of build/load/unload. The only remaining ifeq test
then decides which variant will be used.

Tested on RHEL5.3, RHEL6.0, RHEL6.4, RHEL-7.0-20131018.0(pre-beta)

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 policy/Makefile |   42 +++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 3a8a10d..a0a6c88 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -25,14 +25,28 @@ ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
 endif
 
-all: build
 
-build: $(TARGETS)
 ifeq (x$(RHEL_VERS),$(filter x$(RHEL_VERS),x4 x5))
-	# RHEL specific policy build
-	$(MAKE) -C redhat/$(RHEL_VERS) all \
-	exit $$?
+	BUILD_TARGET := build_rhel
+	LOAD_TARGET := load_rhel
+	UNLOAD_TARGET := unload_rhel
+else
+	BUILD_TARGET := build_general
+	LOAD_TARGET := load_general
+	UNLOAD_TARGET := unload_general
 endif
+
+all: build
+
+build: $(BUILD_TARGET)
+load: $(LOAD_TARGET)
+unload: $(UNLOAD_TARGET)
+
+build_rhel: $(TARGETS)
+	# RHEL specific policy build
+	$(MAKE) -C redhat/$(RHEL_VERS) all
+
+build_general: $(TARGETS)
 	# General policy build
 	@if [ -d $(POLDEV) ]; then \
 		mkdir -p test_policy; \
@@ -44,22 +58,20 @@ endif
 		echo "ERROR: You must have selinux-policy-devel installed."; \
 	fi
 
-load: all
-ifeq (x$(RHEL_VERS),$(filter x$(RHEL_VERS),x4 x5))
+load_rhel: all
 	# RHEL specific policy load
-	$(MAKE) -C redhat/$(RHEL_VERS) load \
-	exit $$?
-endif
+	$(MAKE) -C redhat/$(RHEL_VERS) load
+
+load_general: all
 	# General policy load
 	/usr/sbin/setsebool allow_domain_fd_use=0
 	$(SEMODULE) -i test_policy/test_policy.pp
 
-unload:
-ifeq (x$(RHEL_VERS),$(filter x$(RHEL_VERS),x4 x5))
+unload_rhel:
 	# RHEL specific policy unload
-	$(MAKE) -C redhat/$(RHEL_VERS) unload \
-	exit $$?
-endif
+	$(MAKE) -C redhat/$(RHEL_VERS) unload
+
+unload_general:
 	# General policy unload
 	/usr/sbin/setsebool allow_domain_fd_use=1
 	$(SEMODULE) -r test_policy
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
