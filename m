Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8OGXXbc027550
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2013 12:33:33 -0400
Subject: [selinux-testsuite RFC PATCH 2/4] test_policy: general Makefile
 cleanup
To: serge@hallyn.com
From: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 24 Sep 2013 12:33:27 -0400
Message-ID: <20130924163327.27393.12285.stgit@localhost>
In-Reply-To: <20130924162401.27393.70353.stgit@localhost>
References: <20130924162401.27393.70353.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 policy/Makefile |   51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 6fb9578..5dbb655 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -1,36 +1,40 @@
-REDHAT_RELEASE=$(shell rpm -q redhat-release)
-REDHAT_VERS=$(shell echo $(REDHAT_RELEASE) | cut -f3 -d"-" | sed -e "s/[^0-9]*//g")
 
-POLICYDEVEL = /usr/share/selinux/devel
+POLDEV = /usr/share/selinux/devel
 SEMODULE = /usr/sbin/semodule
 CHECKPOLICY = /usr/bin/checkpolicy
-VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
-
-TARGETS=test_global.te test_capable_file.te test_capable_net.te \
-test_capable_sys.te test_dyntrace.te test_dyntrans.te test_entrypoint.te \
-test_execshare.te test_exectrace.te test_execute_no_trans.te \
-test_fdreceive.te test_file.te test_inherit.te test_ioctl.te test_ipc.te \
-test_link.te test_mkdir.te test_open.te test_ptrace.te test_readlink.te \
-test_relabel.te test_rename.te test_rxdir.te test_setattr.te test_setnice.te \
-test_sigkill.te test_stat.te test_sysctl.te test_task_create.te \
-test_task_getpgid.te test_task_getsched.te test_task_getsid.te \
-test_task_setpgid.te test_task_setsched.te test_transition.te test_wait.te
-
-VERS_GE_24 := $(shell [ $(VERS) -ge 24 ] && echo true )
-
-ifeq ($(VERS_GE_24),true)
-TARGETS+= test_bounds.te
+
+REDHAT_RELEASE=$(shell rpm -q redhat-release)
+REDHAT_VERS=$(shell echo $(REDHAT_RELEASE) | cut -f3 -d"-" | sed -e "s/[^0-9]*//g")
+
+POL_VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
+
+TARGETS = \
+	test_global.te test_capable_file.te test_capable_net.te \
+	test_capable_sys.te test_dyntrace.te test_dyntrans.te \
+	test_entrypoint.te test_execshare.te test_exectrace.te \
+	test_execute_no_trans.te test_fdreceive.te test_file.te \
+	test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te \
+	test_open.te test_ptrace.te test_readlink.te \
+	test_relabel.te test_rename.te test_rxdir.te test_setattr.te \
+	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
+	test_task_create.te test_task_getpgid.te test_task_getsched.te \
+	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
+	test_transition.te test_wait.te
+
+ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
+TARGETS += test_bounds.te
 endif
 
 all: $(TARGETS)
 ifeq (x$(REDHAT_VERS),$(filter x$(REDHAT_VERS),x4 x5))
 	$(MAKE) -C redhat/$(REDHAT_VERS) all
 else
-	@if [ -d $(POLICYDEVEL) ]; then \
+	@if [ -d $(POLDEV) ]; then \
 		mkdir -p test_policy; \
 		cp test_policy.if test_policy; \
-		set -e; rm -f test_policy.te; cat $(TARGETS) > test_policy/test_policy.te; \
-		cd test_policy && $(MAKE) -f $(POLICYDEVEL)/Makefile test_policy.pp; \
+		set -e; rm -f test_policy.te; \
+		cat $(TARGETS) > test_policy/test_policy.te; \
+		$(MAKE) -C test_policy -f $(POLDEV)/Makefile test_policy.pp; \
 	else \
 		echo "ERROR: You must have selinux-policy-devel installed."; \
 	fi
@@ -44,7 +48,7 @@ else
 	$(SEMODULE) -i test_policy/test_policy.pp
 endif
 
-unload:	
+unload:
 ifeq (x$(REDHAT_VERS),$(filter x$(REDHAT_VERS),x4 x5))
 	$(MAKE) -C redhat/$(REDHAT_VERS) unload
 else
@@ -54,4 +58,3 @@ endif
 
 clean:
 	rm -rf test_policy tmp
-


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
