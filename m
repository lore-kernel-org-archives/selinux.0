From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: capable_file: Add dac_override and
 dac_read_search tests
Date: Thu,  2 Mar 2017 11:16:18 -0500
Message-Id: <1488471378-24460-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add dac_override and dac_read_search tests to the existing
capable_file tests.  This required removing dac_override and
dac_read_search from all test domains, previously allowed in
order to permit reading/writing of the test directories and files
when they are not root-owned, which in turn required setting
the ownership of the test directories and files to root before
running the tests. This does assume that the path to the tests
subdirectory is searchable by root without requiring dac_read_search.

Document the audit output for each test case in the comments,
both with existing kernels and with the pending "fs: switch order of
CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH checks" kernel patch applied.
This audit output has been confirmed manually.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_global.te   |  4 ----
 tests/Makefile          |  1 +
 tests/capable_file/test | 63 +++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 9114abf..f7d1335 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -22,10 +22,6 @@ role system_r types testdomain;
 # This allows read and write sysadm ttys and ptys.
 term_use_all_terms(testdomain)
 
-# Allow the test domains to access the test directory and files
-# even if they are not root owned.
-allow testdomain self:capability { dac_override dac_read_search };
-
 # Let sysadm_t use runcon to run the test programs in various domains.
 #allow sysadm_t self:process setexec;
 #selinux_get_fs_mount(sysadm_t)
diff --git a/tests/Makefile b/tests/Makefile
index 11008a9..5a6c76f 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -54,6 +54,7 @@ all:
 
 test: all
 	chcon -R -t test_file_t .
+	chown -R root .
 	@SUBDIRS="$(SUBDIRS)" PATH=/usr/bin:/bin:/usr/sbin:/sbin ./runtests.pl
 
 clean:
diff --git a/tests/capable_file/test b/tests/capable_file/test
index 9d89dfd..fcb864d 100755
--- a/tests/capable_file/test
+++ b/tests/capable_file/test
@@ -4,7 +4,7 @@
 #
 
 use Test;
-BEGIN { plan tests => 10 }
+BEGIN { plan tests => 16 }
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -34,7 +34,7 @@ if( $mode eq (stat($fn))[2] ) {
   $result = 0;
 }
 # prior mode should not be same as current mode
-ok($result); 
+ok($result);
 
 # CAP_LEASE
 $result = system "runcon -t test_fcap_t --  $basedir/test_lease $basedir/temp_file 2>&1";
@@ -70,7 +70,7 @@ if( $mode eq (stat($fn))[2] ) {
   $result = 0;
 }
 # prior mode should be same as current mode
-ok($result, 0); 
+ok($result, 0);
 
 # CAP_LEASE - Needs DAC_OVERRIDE
 $result = system "runcon -t test_resfcap_t --  $basedir/test_lease $basedir/temp_file 2>&1";
@@ -78,9 +78,64 @@ ok($result);
 
 # CAP_MKNOD - Domain needs CAP_DAC_OVERRIDE
 $result = system "runcon -t test_resfcap_t -- mknod $basedir/temp_file2 c 5 5 2>&1";
-ok($result); 
+ok($result);
 
+# Cleanup
 system "rm -f $basedir/temp_file 2>&1";
 system "rm -f $basedir/temp_file2 2>&1";
 
+#
+# Tests for CAP_DAC_OVERRIDE vs CAP_DAC_READ_SEARCH vs neither
+#
+
+# Create temp file for testing.
+system "touch $basedir/temp_file 2>&1";
+
+#
+# In the below comments,
+# patch is "fs: switch order of CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH checks"
+
+# Test that a domain with dac_override can read an unreadable file.
+# Audit with -linus: none
+# Audit with patch:  dac_read_search
+system "chmod 200 $basedir/temp_file 2>&1";
+$result = system "runcon -t test_resfcap_t -- cat $basedir/temp_file 2>&1";
+ok($result, 0);
+
+# Test that a domain with dac_read_search can read an unreadable file.
+# Audit with -linus: dac_override
+# Audit with patch:  none
+system "chmod 200 $basedir/temp_file 2>&1";
+$result = system "runcon -t test_res2fcap_t -- cat $basedir/temp_file 2>&1";
+ok($result, 0);
+
+# Test that a domain with no dac_* permissions cannot read an unreadable file.
+#                    Enforcing                       Permissive
+# Audit with -linus: dac_override,dac_read_search    dac_override
+# Audit with patch:  dac_read_search,dac_override    dac_read_search
+system "chmod 200  $basedir/temp_file 2>&1";
+$result = system "runcon -t test_nofcap_t -- cat $basedir/temp_file 2>&1";
+ok($result);
+
+# Test that a domain with dac_override can write an unwritable file.
+# Audit: none
+system "chmod 400 $basedir/temp_file 2>&1";
+$result = system "runcon -t test_resfcap_t -- dd if=/dev/zero of=$basedir/temp_file count=1 2>&1";
+ok($result, 0);
+
+# Test that a domain with dac_read_search only cannot write an unwritable file.
+# Audit: dac_override
+system "chmod 400 $basedir/temp_file 2>&1";
+$result = system "runcon -t test_res2fcap_t -- dd if=/dev/zero of=$basedir/temp_file count=1 2>&1";
+ok($result);
+
+# Test that a domain with no dac_* permissions cannot write an unwritable file.
+# Audit: dac_override
+system "chmod 400 $basedir/temp_file 2>&1";
+$result = system "runcon -t test_nofcap_t -- dd if=/dev/zero of=$basedir/temp_file count=1 2>&1";
+ok($result);
+
+# Cleanup
+system "rm -f $basedir/temp_file 2>&1";
+
 exit;
-- 
2.7.4
