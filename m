Message-ID: <48B64526.2070003@ak.jp.nec.com>
Date: Thu, 28 Aug 2008 15:26:46 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [LTP][PATCH 1/2] Replacement of deprecated interfaces
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>	 <4897EB5A.1040404@ak.jp.nec.com>	 <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>	 <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com>	 <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil>	 <48B2A669.7040800@ak.jp.nec.com>	 <alpine.LRH.1.10.0808262015360.6838@tundra.namei.org>	 <alpine.LRH.1.10.0808262046000.6838@tundra.namei.org>	 <48B50A97.8050404@ak.jp.nec.com> <1219839256.5708.15.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219839256.5708.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040405030606030408080105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040405030606030408080105
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2008-08-27 at 17:04 +0900, KaiGai Kohei wrote:
>> James Morris wrote:
>>> Could you also please add tests for this (at least one which should fail 
>>> and one which should succeed) to the Linux Test Project?
>>>
>>>
>>> - James
>> Policies stored in ltp/testcases/kernel/security/selinux-testsuite/refpolicy/
>> invokes massive deprecated interfaces on selinux-policy-3.5.4.
>>
>> This patch fixes them according to the warning messages which encourage to
>> replace older ones.
>>
>> BTW, I'm not happy with the test_policy.pp does not allow to invoke test
>> scripts from unconfined_t domain. Is it to be fixed?
> 
> I don't quite follow.  Did you follow the instructions in the
> selinux-testsuite README?

I didn't read the README file carefully, Oops.

The update_refpolicy.sh fixes some of deprecated interfaces and
inject an interface to kick test script from unconfined domain.
So, I can run the testsuite which includs bounds test without
any problems on Rawhide.

# However, I got some warnings for deprecated interfaces/macros
# like r_dir_perms, userdom_sysadm_bin_spec_domtrans_to or
# userdom_use_sysadm_ptys.

The attached patch is a new test case of the boundary feature,
which contains six tests, as follows:

test01: It tries to invoke setcon() with bounded domain in a multi-threaded
        process. The expected result is success.
test02: It tries to invoke setcon() with unrelated domain in a multi-threaded
        process. The expected result is fail.
test03: It makes a bounded domain try to read a file, when its bounds domain
        can read the file. The expected result is success.
test04: It makes a bounded domain try to write a file, when its bounds domain
        cannot write the file. The expected result is fail, because write
        permission is boundary violated.
test05: It tries to write a bounded type, even if the domain cannot write to
        its bounds type. The expected result is fail.
test06: It makes a bounded domain try to set an attribute of bounded type.

Thanks,

> I can run the test scripts either using the
> test_selinux.sh script or by manually loading the policy and then
> individually running them as described in the README.  Watch out that
> your patch doesn't disturb the existing misc/sbin_deprecated.patch that
> gets applied by test_selinux.sh.  Keep in mind that this testsuite gets
> run on everything from RHEL4 to F9.

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------040405030606030408080105
Content-Type: text/x-patch;
 name="ltp-selinux-bounds-tests.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ltp-selinux-bounds-tests.2.patch"

Index: ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile	(working copy)
@@ -3,7 +3,7 @@
 ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
     SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
 else
-    SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrace dyntrans
+    SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrace dyntrans bounds
 endif
 
 all: 
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds_thread.c
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds_thread.c	(revision 0)
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds_thread.c	(revision 0)
@@ -0,0 +1,84 @@
+/*
+ * Copyright (c) 2008 NEC Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <pthread.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+
+static int thread_status = 0;
+
+static void *worker(void *datap)
+{
+	security_context_t security_context = datap;
+	int rc;
+
+	rc = setcon(security_context);
+	if (rc < 0)
+		thread_status = errno;
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	security_context_t security_context;
+	context_t context;
+	pthread_t thread;
+	int rc;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s <new domain>\n", argv[0]);
+		return 1;
+	}
+
+	rc = getcon(&security_context);
+	if (rc < 0) {
+		fprintf(stderr, "%s: unable to get my context\n", argv[0]);
+		return 1;
+	}
+
+	context = context_new(security_context);
+	if (!context) {
+		fprintf(stderr, "%s: unable to create context structure\n", argv[0]);
+		return 1;
+	}
+
+	if (context_type_set(context, argv[1])) {
+		fprintf(stderr, "%s: unable to set new type\n", argv[0]);
+		return 1;
+        }
+
+	freecon(security_context);
+	security_context = context_str(context);
+	if (!security_context) {
+		fprintf(stderr, "%s: unable to obtain new context string\n", argv[0]);
+		return 1;
+	}
+
+	rc = pthread_create(&thread, NULL, worker, security_context);
+	if (rc) {
+		fprintf(stderr, "%s: unable to kick a new thread\n", argv[0]);
+		return 1;
+	}
+
+	rc = pthread_join(thread, NULL);
+	if (rc) {
+		fprintf(stderr, "%s: unable to join its thread\n", argv[0]);
+		return 1;
+	}
+
+	fprintf(stderr, "%s: setcon('%s') : %s\n",
+		argv[0], argv[1], strerror(thread_status));
+
+	return thread_status;
+}
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh	(revision 0)
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh	(revision 0)
@@ -0,0 +1,166 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 NEC Corporation
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the Free
+# Software Foundation; either version 2 of the License, or (at your option)
+# any later version.
+#
+
+setup()
+{
+	export TCID="setup"
+	export TST_COUNT=0
+	export TST_TOTAL=4
+
+	# Remove any leftover test directories from prior failed runs.
+	rm -rf $SELINUXTMPDIR/bounds_file*
+
+	# Create test files
+	dd if=/dev/zero of=$SELINUXTMPDIR/bounds_file      count=1
+	dd if=/dev/zero of=$SELINUXTMPDIR/bounds_file_red  count=1
+        dd if=/dev/zero of=$SELINUXTMPDIR/bounds_file_blue count=1
+	chcon -t test_bounds_file_t      $SELINUXTMPDIR/bounds_file
+	chcon -t test_bounds_file_red_t  $SELINUXTMPDIR/bounds_file_red
+	chcon -t test_bounds_file_blue_t $SELINUXTMPDIR/bounds_file_blue
+}
+
+test01()
+{
+	TCID="test01"
+	TST_COUNT=1
+	RC=0
+
+	runcon -t test_bounds_parent_t \
+	       -- selinux_bounds_thread test_bounds_child_t 2>&1
+	RC=$?
+	if [ $RC -eq 0 ];
+	then
+		echo "$TCID   PASS : thread dyntrans passed."
+	else
+		echo "$TCID   FAIL : thread dynstrans failed."
+	fi
+	return $RC
+}
+
+test02()
+{
+	TCID="test02"
+	TST_COUND=2
+	RC=0
+
+	runcon -t test_bounds_parent_t \
+	       -- selinux_bounds_thread test_bounds_unbound_t 2>&1
+	RC=$?
+	if [ $RC -ne 0 ];	# we expect this to fail
+	then
+		echo "$TCID   PASS : thread dyntrans to unbound domain failed."
+		RC=0
+	else
+		echo "$TCID   FAIL : thread dyntrans to unbound domain succeeded."
+		RC=1
+	fi
+	return $RC
+}
+
+test03()
+{
+	TCID="test03"
+	TST_COUND=3
+	RC=0
+
+	runcon -t test_bounds_child_t \
+		-- dd if=$SELINUXTMPDIR/bounds_file of=/dev/null count=1
+	RC=$?
+	if [ $RC -eq 0 ];
+	then
+		echo "$TCID   PASS : unbounded action to be allowed."
+	else
+		echo "$TCID   FAIL : unbounded action to be allowed."
+	fi
+	return $RC
+}
+
+test04()
+{
+	TCID="test04"
+	TST_COUNT=4
+	RC=0
+
+	runcon -t test_bounds_child_t \
+		-- dd if=/dev/zero of=$SELINUXTMPDIR/bounds_file count=1
+	RC=$?
+	if [ $RC -ne 0 ];	# we expect this to fail
+	then
+		echo "$TCID   PASS : bounded action to be denied."
+		RC=0
+	else
+		echo "$TCID   FAIL : bounded action to be denied."
+		RC=1
+	fi
+	return $RC
+}
+
+test05()
+{
+	TCID="test05"
+	TST_COUNT=5
+	RC=0
+
+	runcon -t test_bounds_parent_t \
+	       -- dd if=/dev/zero of=$SELINUXTMPDIR/bounds_file_red count=1
+	RC=$?
+	if [ $RC -ne 0 ];	# we expect this to fail
+	then
+		echo "$TCID   PASS : actions to bounded type to be denied."
+		RC=0
+	else
+		echo "$TCID   FAIL : actions to bounded type to be denied."
+		RC=1
+	fi
+	return $RC
+}
+
+test06()
+{
+	TCID="test06"
+	TST_COUNT=6
+	RC=0
+
+	runcon -t test_bounds_child_t -- chmod 0777 $SELINUXTMPDIR/bounds_file_blue
+	RC=$?
+	if [ $RC -eq 0 ];
+	then
+		echo "$TCID   PASS : bounds of subject can setattr bounds of target"
+	else
+		echo "$TCID   FAIL : bounds of subject can setattr bounds of target"
+	fi
+	return $RC
+}
+
+cleanup()
+{
+	# Cleanup
+	rm -rf $SELINUXTMPDIR/bounds_file*
+}
+
+# Function:	main
+#
+# Description:	- Execute all tests, exit with test status.
+#
+# Exit:		- zero on success
+#		- non-zero on failure.
+#
+RC=0	# Return value from setup, and test functions.
+EXIT_VAL=0
+
+setup
+test01 || EXIT_VAL=$RC
+test02 || EXIT_VAL=$RC
+test03 || EXIT_VAL=$RC
+test04 || EXIT_VAL=$RC
+test05 || EXIT_VAL=$RC
+test06 || EXIT_VAL=$RC
+cleanup
+exit $EXIT_VAL

Property changes on: ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh
___________________________________________________________________
Added: svn:executable
   + *

Index: ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile	(revision 0)
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile	(revision 0)
@@ -0,0 +1,11 @@
+TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+LDLIBS += -lselinux -lpthread
+
+all: $(TARGETS)
+
+install:
+	@set -e; for i in $(TARGETS); do ln -f $$i ../../../../../bin/$$i; done
+	ln -f selinux_bounds.sh ../../../../../bin/
+
+clean:
+	rm -f $(TARGETS)
\ No newline at end of file
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	(revision 1)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	(working copy)
@@ -1,7 +1,7 @@
 POLICYDEVEL = /usr/share/selinux/devel
 SEMODULE = /usr/sbin/semodule
 
-TARGETS=test_global.te test_capable_file.te test_capable_net.te \
+TARGETS=test_global.te test_bounds.te test_capable_file.te test_capable_net.te \
 test_capable_sys.te test_dyntrace.te test_dyntrans.te test_entrypoint.te \
 test_execshare.te test_exectrace.te test_execute_no_trans.te \
 test_fdreceive.te test_file.te test_inherit.te test_ioctl.te test_ipc.te \
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_bounds.te
===================================================================
--- ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_bounds.te	(revision 0)
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_bounds.te	(revision 0)
@@ -0,0 +1,57 @@
+#################################
+#
+# Policy for testing boundary features
+#
+
+attribute test_bounds_domain;
+unconfined_runs_test(test_bounds_domain)
+corecmd_bin_entry_type(test_bounds_domain)
+
+# Type for test files
+type test_bounds_file_t;
+files_type(test_bounds_file_t)
+
+# Bounded type for files
+type test_bounds_file_red_t;
+files_type(test_bounds_file_red_t)
+
+type test_bounds_file_blue_t;
+files_type(test_bounds_file_blue_t)
+
+# Domain for process that allows to other domains
+type test_bounds_parent_t;
+domain_type(test_bounds_parent_t)
+typeattribute test_bounds_parent_t test_bounds_domain;
+typeattribute test_bounds_parent_t testdomain;
+
+allow test_bounds_parent_t test_bounds_file_t : file { read_file_perms setattr };
+allow test_bounds_parent_t test_bounds_file_red_t : file { rw_file_perms };
+
+# Domain for process that has a bounds type
+type test_bounds_child_t;
+domain_type(test_bounds_child_t)
+typeattribute test_bounds_child_t test_bounds_domain;
+typeattribute test_bounds_child_t testdomain;
+
+allow test_bounds_child_t test_bounds_file_t : file { rw_file_perms };
+allow test_bounds_child_t test_bounds_file_blue_t : file { getattr setattr };
+
+# Domain for process that does not have any bounds type
+type test_bounds_unbound_t;
+domain_type(test_bounds_unbound_t)
+typeattribute test_bounds_unbound_t test_bounds_domain;
+typeattribute test_bounds_unbound_t testdomain;
+
+allow test_bounds_unbound_t test_bounds_file_t : file { rw_file_perms };
+
+# Definition of boundary relationship
+typebounds test_bounds_parent_t test_bounds_child_t;
+typebounds test_bounds_file_t test_bounds_file_red_t, test_bounds_file_blue_t;
+
+# Allow the test_bounds_parent_t to dyntrans
+allow test_bounds_parent_t test_bounds_child_t   : process { dyntransition };
+allow test_bounds_parent_t test_bounds_unbound_t : process { dyntransition };
+
+# Allow all of these domains to be entered from sysadm domain
+miscfiles_domain_entry_test_files(test_bounds_domain)
+sysadm_entry_spec_domtrans(test_bounds_domain)

--------------040405030606030408080105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
