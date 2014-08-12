Message-ID: <53EA692A.1030705@tycho.nsa.gov>
Date: Tue, 12 Aug 2014 15:21:14 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] selinux: Permit bounded transitions under NO_NEW_PRIVS
 or NOSUID.
References: <1407173809-3477-1-git-send-email-sds@tycho.nsa.gov>
 <53EA578A.3090907@tycho.nsa.gov>
 <CALCETrV=MbtkRR8qk-Eu++pn3z3gZ9sEp2RUZXyhKj_-kzOEpw@mail.gmail.com>
 <1781230.AAtiyApM3R@sifl>
In-Reply-To: <1781230.AAtiyApM3R@sifl>
Content-Type: multipart/mixed; boundary="------------000602060406020103050307"
Cc: SELinux-NSA <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------000602060406020103050307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08/12/2014 03:08 PM, Paul Moore wrote:
> On Tuesday, August 12, 2014 11:56:42 AM Andy Lutomirski wrote:
>> On Aug 12, 2014 11:07 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>>> On 08/12/2014 02:01 PM, Andy Lutomirski wrote:
>>>> On Mon, Aug 4, 2014 at 10:36 AM, Stephen Smalley wrote:
>>>>> If the callee SID is bounded by the caller SID, then allowing
>>>>> the transition to occur poses no risk of privilege escalation and we
>>>>> can therefore safely allow the transition to occur.  Add this exemption
>>>>> for both the case where a transition was explicitly requested by the
>>>>> application and the case where an automatic transition is defined in
>>>>> policy.
>>>>
>>>> This still wants something like security_bounded_transition_noaudit,
>>>> right?  (Or just a parameter about whether to audit -- there will only
>>>> be two callers, I think.)
>>>
>>> I think generating an audit record is correct in this case; the
>>> operation would have succeeded if the type were bounded, so it is
>>> correct and helpful to report this to the audit log for diagnosing
>>> failures.  I think Paul's prior objection was that you could end up with
>>> an audit record even when the operation succeeded when we allowed the
>>> transitions on either a bounded transition or dyntransition permission,
>>> but that is no longer the case.
>>
>> Fair enough.
> 
> Yes, the audit problem is no longer an issue and the comments look good to me.
> 
>> Does this have any chance of making 3.17?
> 
> No.  That ship has sailed.
> 
> However, I would still like to see some more Reviewed-by/Tested-by mails 
> before we merge this for 3.18.  Andy, based on discussion on this thread and 
> previous threads, I assume you're happy with this patch?

Attached is the patch for the selinux-testsuite,
against git://git.selinuxproject.org/~serge/selinux-testsuite.
Once it goes into a kernel I can make the test kernel version-specific
and thus ensure it passes on old and new kernels.




--------------000602060406020103050307
Content-Type: text/x-patch;
 name="0001-Add-tests-for-bounded-transitions-under-NO_NEW_PRIVS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-tests-for-bounded-transitions-under-NO_NEW_PRIVS.pa";
 filename*1="tch"

>From b9df9e4ed35e036603143c4ead39c26a3af5787d Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 13 Jun 2014 12:40:16 -0400
Subject: [PATCH] Add tests for bounded transitions under NO_NEW_PRIVS.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile      |  2 +-
 policy/test_nnp.te   | 33 +++++++++++++++++++++++++++++++++
 tests/Makefile       |  2 +-
 tests/nnp/Makefile   |  7 +++++++
 tests/nnp/checkcon.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/nnp/execnnp.c  | 25 +++++++++++++++++++++++++
 tests/nnp/test       | 42 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_nnp.te
 create mode 100644 tests/nnp/Makefile
 create mode 100644 tests/nnp/checkcon.c
 create mode 100644 tests/nnp/execnnp.c
 create mode 100755 tests/nnp/test

diff --git a/policy/Makefile b/policy/Makefile
index a0a6c88..683f454 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -14,7 +14,7 @@ TARGETS = \
 	test_entrypoint.te test_execshare.te test_exectrace.te \
 	test_execute_no_trans.te test_fdreceive.te test_file.te \
 	test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te \
-	test_open.te test_ptrace.te test_readlink.te \
+	test_nnp.te test_open.te test_ptrace.te test_readlink.te \
 	test_relabel.te test_rename.te test_rxdir.te test_setattr.te \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
diff --git a/policy/test_nnp.te b/policy/test_nnp.te
new file mode 100644
index 0000000..55eccd8
--- /dev/null
+++ b/policy/test_nnp.te
@@ -0,0 +1,33 @@
+#################################
+#
+# Policy for testing NO_NEW_PRIVS transitions.
+#
+
+# A domain bounded by the unconfined domain.
+type test_nnp_bounded_t;
+domain_type(test_nnp_bounded_t)
+typeattribute test_nnp_bounded_t testdomain;
+typebounds unconfined_t test_nnp_bounded_t;
+
+# The entrypoint type for this domain.
+type test_nnp_bounded_exec_t;
+files_type(test_nnp_bounded_exec_t)
+domain_entry_file(test_nnp_bounded_t, test_nnp_bounded_exec_t)
+
+# Run it!  This should succeed on patched kernels, fail on old ones.
+unconfined_runs_test(test_nnp_bounded_t)
+unconfined_run_to(test_nnp_bounded_t, test_nnp_bounded_exec_t)
+
+# A domain that is not bounded by the calling domain.
+type test_nnp_notbounded_t;
+domain_type(test_nnp_notbounded_t)
+typeattribute test_nnp_notbounded_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nnp_notbounded_exec_t;
+files_type(test_nnp_notbounded_exec_t)
+domain_entry_file(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
+
+# Run it!  This should fail always.
+unconfined_runs_test(test_nnp_notbounded_t)
+unconfined_run_to(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
diff --git a/tests/Makefile b/tests/Makefile
index 5886403..4cfecdf 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,6 +1,6 @@
 REDHAT_RELEASE=$(shell rpm -q redhat-release)
 
-SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrans dyntrace bounds
+SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg nnp open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrans dyntrace bounds
 #SUBDIRS=socket unix_socket unix_secure
 
 ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
diff --git a/tests/nnp/Makefile b/tests/nnp/Makefile
new file mode 100644
index 0000000..4e8e400
--- /dev/null
+++ b/tests/nnp/Makefile
@@ -0,0 +1,7 @@
+TARGETS=execnnp checkcon
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/nnp/checkcon.c b/tests/nnp/checkcon.c
new file mode 100644
index 0000000..1967506
--- /dev/null
+++ b/tests/nnp/checkcon.c
@@ -0,0 +1,40 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+
+int main(int argc, char **argv)
+{
+    char *con = NULL;
+    context_t c;
+    const char *type;
+    int rc;
+
+    if (argc != 2) {
+        fprintf(stderr, "usage:  %s expected-type\n", argv[0]);
+        exit(-1);
+    }
+
+    if (getcon(&con) < 0) {
+        perror("getcon");
+        exit(-1);
+    }
+
+    c = context_new(con);
+    if (!c) {
+        perror("context_new");
+        exit(-1);
+    }
+
+    type = context_type_get(c);
+    if (!type) {
+        perror("context_type_get");
+        exit(-1);
+
+    }
+
+    rc = strcmp(type, argv[1]);
+    exit(rc);
+}
diff --git a/tests/nnp/execnnp.c b/tests/nnp/execnnp.c
new file mode 100644
index 0000000..9de5967
--- /dev/null
+++ b/tests/nnp/execnnp.c
@@ -0,0 +1,25 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+
+int main(int argc, char **argv)
+{
+    int rc;
+
+    if (argc < 2) {
+	fprintf(stderr, "usage:  %s command [args...]\n", argv[0]);
+	exit(-1);
+    }
+
+    rc = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+    if (rc < 0) {
+        perror("prctl PR_SET_NO_NEW_PRIVS");
+        exit(-1);
+    }
+
+    execvp(argv[1], &argv[1]);
+    perror(argv[1]);
+    exit(1);
+}
diff --git a/tests/nnp/test b/tests/nnp/test
new file mode 100755
index 0000000..4ac961a
--- /dev/null
+++ b/tests/nnp/test
@@ -0,0 +1,42 @@
+#!/usr/bin/perl
+
+# Depends on kernel patch with the following subject line:
+# selinux:  Permit bounded transitions under NO_NEW_PRIVS or NOSUID.
+
+use Test;
+BEGIN { plan tests => 4}
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+# Remove any leftover programs from prior failed runs.
+system("rm -f $basedir/true");
+
+# Set entrypoint type for bounded domain.
+system("chcon -t test_nnp_bounded_exec_t $basedir/checkcon");
+
+# Transition to bounded type via setexec.
+$result = system("$basedir/execnnp runcon -t test_nnp_bounded_t $basedir/checkcon test_nnp_bounded_t 2>&1");
+ok($result,0); #this should pass
+
+# Automatic transition to bounded domain via exec.
+$result = system("$basedir/execnnp $basedir/checkcon test_nnp_bounded_t 2>&1");
+ok($result,0); #this should pass
+
+# Use true as an entrypoint program to test ability to exec at all.
+system("cp /bin/true $basedir/true");
+
+# Set entrypoint type for notbounded domain.
+system("chcon -t test_nnp_notbounded_exec_t $basedir/checkcon $basedir/true");
+
+# Transition to notbounded domain via setexec.
+$result = system("$basedir/execnnp runcon -t test_nnp_notbounded_t $basedir/true 2>&1");
+ok($result); #this should fail
+
+# Automatic transition to notbounded domain via exec.
+$result = system("$basedir/execnnp $basedir/checkcon test_nnp_notbounded_t 2>&1");
+ok($result); #this should fail
+
+# Cleanup.
+system("rm -f $basedir/true");
+
+exit;
-- 
1.9.3


--------------000602060406020103050307--
