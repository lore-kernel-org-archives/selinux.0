Subject: [PATCH] Update ltp selinux testsuite README
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ltp-list <ltp-list@lists.sf.net>,
        Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 06 May 2009 15:09:39 -0400
Message-Id: <1241636979.27629.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update the ltp selinux testsuite README.  Changes include:
- Explain the two different locations of test policy up front and then
use $POLICYDIR for subsequent references.
- Expand and clarify the kernel configuration options.
- Add a section summarizing the SELinux policy and userland
dependencies.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 testcases/kernel/security/selinux-testsuite/README |  123 +++++++++++++++------
 1 file changed, 88 insertions(+), 35 deletions(-)

Index: testcases/kernel/security/selinux-testsuite/README
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/README,v
retrieving revision 1.6
diff -u -r1.6 README
--- testcases/kernel/security/selinux-testsuite/README	7 Nov 2008 09:19:07 -0000	1.6
+++ testcases/kernel/security/selinux-testsuite/README	6 May 2009 19:11:19 -0000
@@ -11,7 +11,18 @@
 in your /etc/selinux/semanage.conf file as the test policy will violate some 
 of the neverallow rules in the base policy.  This line may already be present
 depending on your distribution; if not, add it before running the test suite
-and remove it when done.
+and remove it when done (the test_selinux.sh script does this automatically).
+
+A test policy module is added to the base policy during the execution
+of the test cases and then removed.  The test policy sources for
+systems using the SELinux reference policy (e.g. Fedora 5 and later,
+RHEL 5 and later) are located under the selinux-testsuite/refpolicy
+directory, while the test policy sources for systems using the older
+SELinux example policy (e.g. RHEL 4) are located in the
+selinux-testsuite/policy directory.  All further references to the
+test policy directory in this README will use the $POLICYDIR notation
+to refer to whichever test policy is appropriate for the system.  The
+test_selinux.sh script sets POLICYDIR to one of these locations.
 
 There are two ways to run the SELinux testcases:
 	1. testsuite - all testcases
@@ -39,15 +50,14 @@
 to the testscripts directory and from the command line execute,
 	./test_selinux.sh
 
-This script builds the test policy in the selinux-testsuite/refpolicy
-directory and runs the testsuite. After the testcases have completed, 
-the test policy will be removed and the original policy will be 
-restored. Thus, if the test_selinux.sh script is not allowed 
-to complete, you may manually have to restore your system's 
-original policy. This can be done by changing to the the 
-selinux-testsuite/refpolicy directory and from the commandline,
-issue a "make cleanup" to remove the test policy and restore the 
-original policy.
+This script builds the test policy in the $POLICYDIR directory and
+runs the testsuite. After the testcases have completed, the test
+policy will be removed and the original policy will be restored. Thus,
+if the test_selinux.sh script is not allowed to complete, you may
+manually have to restore your system's original policy. This can be
+done by changing to the $POLICYDIR directory and from the
+commandline, issue a "make cleanup" to remove the test policy and
+restore the original policy.
 
 Results of the test run can be found in the results directory,
 which resides in the top-level LTP directory (cd to $LTPROOT/results).
@@ -69,13 +79,11 @@
 Run Individual Testcases
 --------------------------
 First build the test policy manually. Do this by first changing 
-to the selinux-testsuite refpolicy directory (cd to 
-$LTPROOT/testcases/kernel/security/selinux-testsuite/refpolicy)
-and build the policy by doing a, 
+to the $POLICYDIR directory and build the policy by doing:
 	make load
 
 This will build and install the test policy files. Once the 
-policy has been installed, individuall testcases can be run. 
+policy has been installed, individual testcases can be run. 
 To run an individual selinux testcase, change to the tests directory 
 (cd to $LTPROOT/testcases/kernel/security/selinux-testsuite/tests)
 and execute,
@@ -94,44 +102,89 @@
 a "set -x" can be added to the top of the *.sh file in the 
 testcase directory of the testcase being debugged.	
 
-To remove the test policy and restore original policy,
-cd to selinux-testsuite/refpolicy directory and execute,
-	make cleanup
+To remove the test policy and restore original policy, run:
+        cd $POLICYDIR && make cleanup
 
 Remember to remove test policy and restore original policy after
 running/debugging individual testcases and it is desired to restore
 system policy. None of the testscripts will do this for you when 
 running in "individual" mode.
 
-Your Kernel should have been built with the following options to
+
+Kernel Configuration
+--------------------
+
+Your kernel should have been built with the following options to
 test SELinux:
 
+# Minimal dependencies.
+CONFIG_AUDIT=y
+CONFIG_NET=y
+CONFIG_INET=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
-CONFIG_SECURITY_NETWORK_XFRM=y
-CONFIG_SECURITY_FILE_CAPABILITIES=y
+CONFIG_SECURITY_SELINUX=y
 
-CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
-This has to be set to a positive value if you want to test this check.
-Fedora kernels set it to 65536.
+# Filesystem security labeling support.
+# Only need to enable the ones for the filesystems on which you are testing.
+# reiserfs is not supported.
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_JFS_SECURITY=y
+CONFIG_XFS_SECURITY=y
+CONFIG_JFFS2_FS_SECURITY=y
 
-CONFIG_SECURITY_SELINUX=y
+The following config options are not required by the tests but
+are typical settings for SELinux kernel configuration:
+CONFIG_SECURITY_NETWORK_XFRM=y
+CONFIG_NETLABEL=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
+CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_SELINUX_DEVELOP=y
-CONFIG_SECURITY_SELINUX_AVC_STATS=y
 CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
 CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=y
+CONFIG_SECURITY_SELINUX_AVC_STATS=y
 
-CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX=y
-You don't want this one unless you are running Fedora 3 or 4.
-On anything newer, it will cause unnecessary policy expansion.
+Do not set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX; it is an
+option for legacy distributions (Fedora 3 and 4).
 
-CONFIG_SECURITY_SMACK=y
-CONFIG_SECURITY_SELINUX=y
+The capabilities module and the file capability support may be enabled
+simultaneously with SELinux with no conflicts if you wish to also exercise
+their ltp tests:
+CONFIG_SECURITY_CAPABILITIES=y # Removed in 2.6.27 and later.
+CONFIG_SECURITY_FILE_CAPABILITIES=y
 
-By default, if you boot with multiple LSMs compiled into the kernel, the
-kernel won't boot succesfully - there can be only one (aside from
-explicit internal "stacking" e.g. as is done for combining SELinux or
-Smack with capabilities).  Unless you use the security= option to select
-one at boot.  SELinux and Smack will honor the security= option.
+Otherwise, you should not enable any other security modules in your
+kernel configuration unless you use the security= option to select a
+module at boot time.  Only one primary security module may be active
+at a time.
+
+
+SELinux Policy and Userland
+---------------------------
+
+The testsuite requires a pre-existing base policy configuration of
+SELinux, using either the old example policy or the reference policy
+as the baseline.  It also requires the core SELinux userland packages
+(libsepol, checkpolicy, libselinux, policycoreutils, and if using
+reference policy, libsemanage) to be installed.  The test scripts also
+rely upon the SELinux extensions being integrated into the coreutils
+package, with support for the chcon and runcon commands as well as the
+SELinux options to existing utilities such as ls and mkdir.
+
+On systems whose policy was derived from the old example policy
+(e.g. RHEL 4), the base policy sources must be installed on the
+system, e.g. the selinux-policy-targeted-sources package in RHEL 4.
+The test policy will look in $SELINUX_SRC as defined in
+selinux-testsuite/policy/Makefile for the base policy sources.
+
+On systems whose policy is derived from the reference policy
+(e.g. RHEL 5, Fedora 5 or later), the policy module development files
+(Makefile and include tree) must be installed on the system, e.g. the
+selinux-policy-devel package in RHEL 5, subsequently folded into the
+base selinux-policy package in Fedora 10 and later.  The test policy
+will look in $POLICYDEVEL as defined in
+selinux-testsuite/refpolicy/Makefile for the policy module development
+files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
