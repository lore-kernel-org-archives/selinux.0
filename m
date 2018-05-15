From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 15 May 2018 17:03:42 -0400
Message-ID: <152641822270.15123.8804483748550258349.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [RFC PATCH] selinux-testsuite: check the "expand-check"
 setting in semanage.conf
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

If expand-check is non-zero in semanage.conf the policy load will likely fail,
try to provide a more helpful error to users running the tests.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/Makefile |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 8ed5e46..cc022e3 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -87,6 +87,14 @@ build: $(BUILD_TARGET)
 load: $(LOAD_TARGET)
 unload: $(UNLOAD_TARGET)
 
+expand_check:
+	# Test for "expand-check = 0" in /etc/selinux/semanage.conf
+	@cat /etc/selinux/semanage.conf | \
+		sed -n 's/^[ \t]*expand-check[ \t]*=[ \t]*0/OK/p' | \
+		grep -q "OK" || \
+		(echo "ERROR: set 'expand-check = 0' in semanage.conf"; \
+		 /bin/false)
+
 build_rhel: $(TARGETS)
 	# RHEL specific policy build
 	$(MAKE) -C redhat/$(RHEL_VERS) all
@@ -103,11 +111,11 @@ build_general: $(TARGETS)
 		echo "ERROR: You must have selinux-policy-devel installed."; \
 	fi
 
-load_rhel: all
+load_rhel: expand_check all
 	# RHEL specific policy load
 	$(MAKE) -C redhat/$(RHEL_VERS) load
 
-load_general: all
+load_general: expand_check all
 	# General policy load
 	@-/usr/sbin/setsebool allow_domain_fd_use=0
 	$(SEMODULE) -i test_policy/test_policy.pp
