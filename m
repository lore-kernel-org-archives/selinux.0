Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8OGXdn1027564
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2013 12:33:39 -0400
Subject: [selinux-testsuite RFC PATCH 3/4] test_policy: use RHEL instead of
 REDHAT in Makefile
To: serge@hallyn.com
From: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 24 Sep 2013 12:33:33 -0400
Message-ID: <20130924163333.27393.21897.stgit@localhost>
In-Reply-To: <20130924162401.27393.70353.stgit@localhost>
References: <20130924162401.27393.70353.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We also rework some of the if statements to make it easier to add
additional distributions, e.g. Fedora.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 policy/Makefile |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 5dbb655..8763143 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -3,8 +3,8 @@ POLDEV = /usr/share/selinux/devel
 SEMODULE = /usr/sbin/semodule
 CHECKPOLICY = /usr/bin/checkpolicy
 
-REDHAT_RELEASE=$(shell rpm -q redhat-release)
-REDHAT_VERS=$(shell echo $(REDHAT_RELEASE) | cut -f3 -d"-" | sed -e "s/[^0-9]*//g")
+RHEL_REL=$(shell rpm -q redhat-release)
+RHEL_VERS=$(shell echo $(RHEL_REL) | cut -f3 -d"-" | sed -e "s/[^0-9]*//g")
 
 POL_VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
 
@@ -26,9 +26,12 @@ TARGETS += test_bounds.te
 endif
 
 all: $(TARGETS)
-ifeq (x$(REDHAT_VERS),$(filter x$(REDHAT_VERS),x4 x5))
-	$(MAKE) -C redhat/$(REDHAT_VERS) all
-else
+ifeq (x$(RHEL_VERS),$(filter x$(RHEL_VERS),x4 x5))
+	# RHEL specific policy build
+	$(MAKE) -C redhat/$(RHEL_VERS) all \
+	exit $$?
+endif
+	# General policy build
 	@if [ -d $(POLDEV) ]; then \
 		mkdir -p test_policy; \
 		cp test_policy.if test_policy; \
@@ -38,23 +41,26 @@ else
 	else \
 		echo "ERROR: You must have selinux-policy-devel installed."; \
 	fi
-endif
 
 load: all
-ifeq (x$(REDHAT_VERS),$(filter x$(REDHAT_VERS),x4 x5))
-	$(MAKE) -C redhat/$(REDHAT_VERS) load
-else
+ifeq (x$(RHEL_VERS),$(filter x$(RHEL_VERS),x4 x5))
+	# RHEL specific policy load
+	$(MAKE) -C redhat/$(RHEL_VERS) load \
+	exit $$?
+endif
+	# General policy load
 	/usr/sbin/setsebool allow_domain_fd_use=0
 	$(SEMODULE) -i test_policy/test_policy.pp
-endif
 
 unload:
-ifeq (x$(REDHAT_VERS),$(filter x$(REDHAT_VERS),x4 x5))
-	$(MAKE) -C redhat/$(REDHAT_VERS) unload
-else
+ifeq (x$(RHEL_VERS),$(filter x$(RHEL_VERS),x4 x5))
+	# RHEL specific policy unload
+	$(MAKE) -C redhat/$(RHEL_VERS) unload \
+	exit $$?
+endif
+	# General policy unload
 	/usr/sbin/setsebool allow_domain_fd_use=1
 	$(SEMODULE) -r test_policy
-endif
 
 clean:
 	rm -rf test_policy tmp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
