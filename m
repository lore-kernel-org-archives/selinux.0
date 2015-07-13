From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: Clean up prerequisites/dependencies.
Date: Mon, 13 Jul 2015 16:28:27 -0400
Message-Id: <1436819307-32093-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Under kernel configuration, add CONFIG_IP_NF_SECURITY as this is
used by the iptables SECMARK tests, drop options not required by the
tests since they are unnecessary and not always desirable, and drop
capabilities options as they are obsolete.

Under userland and base policy, summarize the list of extra packages
needed at the beginning and drop some legacy text.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README | 46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/README b/README
index 568ebb8..7de74c0 100644
--- a/README
+++ b/README
@@ -21,6 +21,7 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_NETLABEL=y
+CONFIG_IP_NF_SECURITY=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
@@ -36,24 +37,9 @@ CONFIG_JFS_SECURITY=y
 CONFIG_XFS_SECURITY=y
 CONFIG_JFFS2_FS_SECURITY=y
 
-The following config options are not required by the tests but
-are typical settings for SELinux kernel configuration:
-CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
-CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_SECURITY_SELINUX_DEVELOP=y
-CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
-CONFIG_SECURITY_SELINUX_AVC_STATS=y
-
 Do not set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX; it is an
 option for legacy distributions (Fedora 3 and 4).
 
-The capabilities module and the file capability support may be enabled
-simultaneously with SELinux with no conflicts if you wish to also exercise
-their ltp tests:
-CONFIG_SECURITY_CAPABILITIES=y # Removed in 2.6.27 and later.
-CONFIG_SECURITY_FILE_CAPABILITIES=y
-
 Otherwise, you should not enable any other security modules in your
 kernel configuration unless you use the security= option to select a
 module at boot time.  Only one primary security module may be active
@@ -61,9 +47,14 @@ at a time.
 
 Userland and Base Policy
 ------------------------
-
-The testsuite depends on the perl test harness, which you can
-install on Fedora via yum install perl-Test-Harness.
+The testsuite has the following userspace dependencies on Fedora
+or RHEL beyond a minimal install:
+perl-Test-Harness # test harness used by the testsuite
+selinux-policy-devel # to build the test policy
+libselinux-devel # to build some of the test programs
+netlabel_tools # to load NetLabel configuration during inet_socket tests
+ipsec-tools # to load IPSEC configuration during inet_socket tests
+iptables # to load iptables SECMARK rules during inet_socket tests
 
 The testsuite requires a pre-existing base policy configuration of
 SELinux, using either the old example policy or the reference policy
@@ -74,25 +65,6 @@ rely upon the SELinux extensions being integrated into the coreutils
 package, with support for the chcon and runcon commands as well as the
 SELinux options to existing utilities such as ls and mkdir.
 
-The inet_socket tests depend on netlabel_tools, ipsec-tools, and
-iptables in order to load the relevant configurations for testing
-netlabel peer labeling, labeled IPSEC peer labeling, and SECMARK
-packet labeling.
-
-In addition to the libselinux shared library, the libselinux headers
-are required in order to build certain testcases.  These can be found in 
-the libselinux-devel package in Fedora or RHEL.
-
-On systems whose policy was derived from the old example policy
-(e.g. RHEL 4), the base policy sources must be installed on the
-system, e.g. the selinux-policy-targeted-sources package in RHEL 4.
-
-On systems whose policy is derived from the reference policy
-(e.g. RHEL 5, Fedora 5 or later), the policy module development files
-(Makefile and include tree) must be installed on the system, e.g. the
-selinux-policy-devel package in RHEL 5, subsequently folded into the
-base selinux-policy package in Fedora 10 and later.
-
 If the base distribution does not include the SELinux userland, then
 the source code for the core SELinux userland packages can be obtained from:
 https://github.com/SELinuxProject/selinux/wiki/Releases
-- 
2.1.0
