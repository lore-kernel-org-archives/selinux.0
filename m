From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 19 Jul 2017 11:26:51 -0400
Message-Id: <20170719152651.15105-1-sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: Add tests for AT_SECURE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add tests for the AT_SECURE auxv flag to ensure that its value
is set correctly based on whether noatsecure permission is allowed
between the old domain and the new domain.

Also test that the dynamic linker ignores LD_PRELOAD when AT_SECURE
is set to 1.

AT_SECURE has been supported since Linux 2.6.0, so these tests should
work on all SELinux systems and do not need to be conditionally enabled.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile           |  2 +-
 policy/test_atsecure.te   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile            |  3 ++-
 tests/atsecure/Makefile   |  9 +++++++++
 tests/atsecure/atsecure.c | 10 ++++++++++
 tests/atsecure/evil.c     | 10 ++++++++++
 tests/atsecure/good.c     | 10 ++++++++++
 tests/atsecure/test       | 31 +++++++++++++++++++++++++++++++
 8 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_atsecure.te
 create mode 100644 tests/atsecure/Makefile
 create mode 100644 tests/atsecure/atsecure.c
 create mode 100644 tests/atsecure/evil.c
 create mode 100644 tests/atsecure/good.c
 create mode 100755 tests/atsecure/test

diff --git a/policy/Makefile b/policy/Makefile
index c062009..b728a9e 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -23,7 +23,7 @@ TARGETS = \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_inet_socket.te test_unix_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te test_mac_admin.te \
-	test_ibpkey.te
+	test_ibpkey.te test_atsecure.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff --git a/policy/test_atsecure.te b/policy/test_atsecure.te
new file mode 100644
index 0000000..7255553
--- /dev/null
+++ b/policy/test_atsecure.te
@@ -0,0 +1,46 @@
+#################################
+#
+# Policy for testing the setting of the
+# AT_SECURE auxv flag based on noatsecure permission
+#
+
+attribute atsecuredomain;
+
+# Domain for process that is not allowed noatsecure to the new domain.
+type test_atsecure_denied_t;
+domain_type(test_atsecure_denied_t)
+unconfined_runs_test(test_atsecure_denied_t)
+typeattribute test_atsecure_denied_t atsecuredomain;
+typeattribute test_atsecure_denied_t testdomain;
+
+# Domain for process that is allowed noatsecure to the new domain.
+type test_atsecure_allowed_t;
+domain_type(test_atsecure_allowed_t)
+unconfined_runs_test(test_atsecure_allowed_t)
+typeattribute test_atsecure_allowed_t atsecuredomain;
+typeattribute test_atsecure_allowed_t testdomain;
+
+# New domain for the process after the transition.
+type test_atsecure_newdomain_t;
+domain_type(test_atsecure_newdomain_t)
+unconfined_runs_test(test_atsecure_newdomain_t)
+typeattribute test_atsecure_newdomain_t atsecuredomain;
+typeattribute test_atsecure_newdomain_t testdomain;
+
+# Allow the domain entrypoints and transitions.
+corecmd_bin_entry_type(atsecuredomain)
+corecmd_shell_entry_type(atsecuredomain)
+corecmd_exec_bin(atsecuredomain)
+domain_entry_file(test_atsecure_newdomain_t, test_file_t)
+domain_trans(test_atsecure_denied_t, test_file_t, test_atsecure_newdomain_t)
+domain_trans(test_atsecure_allowed_t, test_file_t, test_atsecure_newdomain_t)
+allow test_atsecure_newdomain_t test_atsecure_denied_t:fd use;
+allow test_atsecure_newdomain_t test_atsecure_allowed_t:fd use;
+allow_map(atsecuredomain, test_file_t, file)
+
+# Only allow the allowed domain noatsecure permission to the
+# new domain.
+allow test_atsecure_allowed_t test_atsecure_newdomain_t:process noatsecure;
+
+# Allow all of these domains to be entered from the sysadm domain.
+userdom_sysadm_entry_spec_domtrans_to(atsecuredomain)
diff --git a/tests/Makefile b/tests/Makefile
index 369b678..f42fe7e 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -10,7 +10,8 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp mmap unix_socket inet_socket \
-	overlay checkreqprot mqueue mac_admin infiniband_pkey infiniband_endport
+	overlay checkreqprot mqueue mac_admin infiniband_pkey \
+	infiniband_endport atsecure
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/atsecure/Makefile b/tests/atsecure/Makefile
new file mode 100644
index 0000000..6c08055
--- /dev/null
+++ b/tests/atsecure/Makefile
@@ -0,0 +1,9 @@
+TARGETS=atsecure good evil.so
+
+all: $(TARGETS)
+
+evil.so: evil.c
+	$(CC) -shared -o $@ -fPIC $<
+
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/atsecure/atsecure.c b/tests/atsecure/atsecure.c
new file mode 100644
index 0000000..329c124
--- /dev/null
+++ b/tests/atsecure/atsecure.c
@@ -0,0 +1,10 @@
+#include <sys/auxv.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(void)
+{
+	return getauxval(AT_SECURE);
+
+}
diff --git a/tests/atsecure/evil.c b/tests/atsecure/evil.c
new file mode 100644
index 0000000..4fac90b
--- /dev/null
+++ b/tests/atsecure/evil.c
@@ -0,0 +1,10 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+uid_t getuid(void)
+{
+	printf("Evil code ran!\n");
+	exit(1);
+}
diff --git a/tests/atsecure/good.c b/tests/atsecure/good.c
new file mode 100644
index 0000000..7a250f5
--- /dev/null
+++ b/tests/atsecure/good.c
@@ -0,0 +1,10 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+int main(void)
+{
+	printf("%u\n", getuid());
+	exit(0);
+}
diff --git a/tests/atsecure/test b/tests/atsecure/test
new file mode 100755
index 0000000..59ba3a4
--- /dev/null
+++ b/tests/atsecure/test
@@ -0,0 +1,31 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 4 }
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+# Verify that AT_SECURE is 1 when noatsecure permission is not allowed.
+$result = system(
+"runcon -t test_atsecure_denied_t -- runcon -t test_atsecure_newdomain_t $basedir/atsecure"
+);
+ok($result);
+
+# Verify that AT_SECURE is 0 when noatsecure permission is allowed.
+$result = system(
+"runcon -t test_atsecure_allowed_t -- runcon -t test_atsecure_newdomain_t $basedir/atsecure"
+);
+ok( $result, 0 );
+
+# Verify that LD_PRELOAD is ignored when noatsecure permission is not allowed.
+$result = system(
+"runcon -t test_atsecure_denied_t -- bash -c 'LD_PRELOAD=$basedir/evil.so runcon -t test_atsecure_newdomain_t $basedir/good'"
+);
+ok( $result, 0 );
+
+# Verify that LD_PRELOAD is honored when noatsecure permission is allowed.
+$result = system(
+"runcon -t test_atsecure_allowed_t -- bash -c 'LD_PRELOAD=$basedir/evil.so runcon -t test_atsecure_newdomain_t $basedir/good'"
+);
+ok($result);
-- 
2.9.4
