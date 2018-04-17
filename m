Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3HFxTWB025785
 for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2018 11:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7E02414DF30
 for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2018 15:59:26 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 17 Apr 2018 11:59:25 -0400
Message-ID: <152398076587.32632.8154318980575216690.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux-testsuite: only add the infiniband tests to
 SUBDIRS if they are enabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

It was difficult to tell if the InfiniBand tests were actually being
run as they were always added to SUBDIRS regardless of the
configuration; this patch should make this more obvious.

It is worth nothing that most of the changes to the tests themselves
are simply due to reformatting (./tools/check-syntax -f) due to the
removal of the enabled check.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/Makefile                 |   11 +++-
 tests/infiniband_endport/test  |   52 ++++++++---------
 tests/infiniband_pkey/Makefile |    9 ---
 tests/infiniband_pkey/test     |  121 ++++++++++++++++++----------------------
 4 files changed, 90 insertions(+), 103 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index f2291b2..27ed6eb 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -10,8 +10,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-        inet_socket overlay checkreqprot mqueue mac_admin infiniband_pkey \
-	infiniband_endport atsecure
+        inet_socket overlay checkreqprot mqueue mac_admin atsecure
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
@@ -31,6 +30,14 @@ ifeq ($(shell grep -q getrlimit $(POLDEV)/include/support/all_perms.spt && echo
 SUBDIRS += prlimit
 endif
 
+ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
+SUBDIRS += infiniband_endport
+endif
+
+ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.conf | cut -d'=' -f 2),1)
+SUBDIRS += infiniband_pkey
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/infiniband_endport/test b/tests/infiniband_endport/test
index 9e1f3f9..0021e0d 100755
--- a/tests/infiniband_endport/test
+++ b/tests/infiniband_endport/test
@@ -2,7 +2,7 @@
 
 use Test;
 
-BEGIN { plan tests => 2 }
+BEGIN { plan tests => 3 }
 
 $basedir = $0;
 $basedir =~ s|(.*)/[^/]*|$1|;
@@ -17,39 +17,37 @@ while ( $r = <$f> ) {
     $conf{$k} = $v;
 }
 
-if ( $conf{SELINUX_INFINIBAND_ENDPORT_TEST} eq 1 ) {
-    @allowed_device_port =
-      split( /,/, $conf{SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED} );
-    @denied_device_port =
-      split( /,/, $conf{SELINUX_INFINIBAND_ENDPORT_TEST_DENIED} );
+# verify that we really want to run these tests
+ok( $conf{SELINUX_INFINIBAND_ENDPORT_TEST} eq 1 );
 
-    foreach (@allowed_device_port) {
-        @dev_port_pair = split( / /, $_ );
+@allowed_device_port =
+  split( /,/, $conf{SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED} );
+@denied_device_port =
+  split( /,/, $conf{SELINUX_INFINIBAND_ENDPORT_TEST_DENIED} );
 
-        system "semanage ibendport -a -t test_ibendport_t -z $_ 2>/dev/null";
-        $result = system
+foreach (@allowed_device_port) {
+    @dev_port_pair = split( / /, $_ );
+
+    system "semanage ibendport -a -t test_ibendport_t -z $_ 2>/dev/null";
+    $result = system
 "runcon -t test_ibendport_manage_subnet_t smpquery PKeyTable -C $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
-        system "semanage ibendport -d -t test_ibendport_t -z $_ 2>/dev/null";
-        if ( $result ne 0 ) {
-            last;
-        }
+    system "semanage ibendport -d -t test_ibendport_t -z $_ 2>/dev/null";
+    if ( $result ne 0 ) {
+        last;
     }
-    ok( $result, 0 );
+}
+ok( $result, 0 );
 
-    foreach (@denied_device_port) {
-        @dev_port_pair = split( / /, $_ );
-        $result = system
+foreach (@denied_device_port) {
+    @dev_port_pair = split( / /, $_ );
+    $result = system
 "runcon -t test_ibendport_manage_subnet_t smpquery PKeyTable -C $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
 
-        if ( $result >> 8 eq 0 ) {
-            last;
-        }
+    if ( $result >> 8 eq 0 ) {
+        last;
     }
-
-    ok( int( $result >> 8 ) ne 0 );
-}
-else {
-    ok(1);
-    ok(1);
 }
+
+ok( int( $result >> 8 ) ne 0 );
+
 exit;
diff --git a/tests/infiniband_pkey/Makefile b/tests/infiniband_pkey/Makefile
index 4fa6fb2..b1a39a8 100644
--- a/tests/infiniband_pkey/Makefile
+++ b/tests/infiniband_pkey/Makefile
@@ -2,14 +2,7 @@ TARGETS=create_modify_qp
 
 LDLIBS+= -libverbs
 
-RESULT=$(shell grep "SELINUX_INFINIBAND_PKEY_TEST=0" ./ibpkey_test.conf)
-
-ifeq  ($(RESULT), )
-    all: $(TARGETS)
-else
-    all:
-	@echo "Infiniband test disabled"
-endif
+all: $(TARGETS)
 
 clean:
 	rm -f $(TARGETS)
diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
index fcfebdb..3ee4d13 100755
--- a/tests/infiniband_pkey/test
+++ b/tests/infiniband_pkey/test
@@ -2,7 +2,7 @@
 
 use Test;
 
-BEGIN { plan tests => 3 }
+BEGIN { plan tests => 4 }
 
 $basedir = $0;
 $basedir =~ s|(.*)/[^/]*|$1|;
@@ -18,86 +18,75 @@ while ( $r = <$f> ) {
 }
 close($f);
 
-if ( $conf{SELINUX_INFINIBAND_PKEY_TEST} eq 1 ) {
-    $device = $conf{SELINUX_INFINIBAND_PKEY_TEST_DEV};
-    $port   = $conf{SELINUX_INFINIBAND_PKEY_TEST_PORT};
+# Verify that we really want to run these tests.
+ok( $conf{SELINUX_INFINIBAND_PKEY_TEST} eq 1 );
 
-    # Read GID 0, to get the subnet prefix.
-    $gid_path =
-      "/sys/class/infiniband/" . $device . "/ports/" . $port . "/gids/0";
-    open( $f, $gid_path ) or die("Couldn't open $gid_path");
-    $gid = <$f>;
-    close($f);
+$device = $conf{SELINUX_INFINIBAND_PKEY_TEST_DEV};
+$port   = $conf{SELINUX_INFINIBAND_PKEY_TEST_PORT};
+
+# Read GID 0, to get the subnet prefix.
+$gid_path = "/sys/class/infiniband/" . $device . "/ports/" . $port . "/gids/0";
+open( $f, $gid_path ) or die("Couldn't open $gid_path");
+$gid = <$f>;
+close($f);
 
-    # The gid sysfs shows a fully expanded ipv6 address, just take the
-    # top half.
-    @tmp = unpack( '(a20)*', $gid );
-    $subnet_prefix = $tmp[0] . ":";
+# The gid sysfs shows a fully expanded ipv6 address, just take the
+# top half.
+@tmp = unpack( '(a20)*', $gid );
+$subnet_prefix = $tmp[0] . ":";
 
-    @labeled_pkeys = split( /,/, $conf{SELINUX_INFINIBAND_TEST_LABELED_PKEYS} );
-    @unlabeled_pkeys =
-      split( /,/, $conf{SELINUX_INFINIBAND_TEST_UNLABELED_PKEYS} );
+@labeled_pkeys = split( /,/, $conf{SELINUX_INFINIBAND_TEST_LABELED_PKEYS} );
+@unlabeled_pkeys =
+  split( /,/, $conf{SELINUX_INFINIBAND_TEST_UNLABELED_PKEYS} );
 
-    foreach (@unlabeled_pkeys) {
-        $result = system
+foreach (@unlabeled_pkeys) {
+    $result = system
 "runcon -t test_ibpkey_access_t $basedir/create_modify_qp $device $port $_";
-        if ( $result ne 0 ) {
-            last;
-        }
-    }
-    if (@unlabeled_pkeys) {
-        ok( $result, 0 );
-    }
-    else {
-        ok(1);
+    if ( $result ne 0 ) {
+        last;
     }
+}
+if (@unlabeled_pkeys) {
+    ok( $result, 0 );
+}
+else {
+    ok(1);
+}
 
-    foreach (@unlabeled_pkeys) {
-        $pkey_path =
-            "/sys/class/infiniband/"
-          . $device
-          . "/ports/"
-          . $port
-          . "/pkeys/"
-          . $_;
-        open( $f, $pkey_path ) or die("Couldn't open $pkey_path");
-        $pkey_val = <$f>;
-        close($f);
+foreach (@unlabeled_pkeys) {
+    $pkey_path =
+      "/sys/class/infiniband/" . $device . "/ports/" . $port . "/pkeys/" . $_;
+    open( $f, $pkey_path ) or die("Couldn't open $pkey_path");
+    $pkey_val = <$f>;
+    close($f);
 
-        system
-          "semanage ibpkey -a -t test_ibpkey_t -x $subnet_prefix $pkey_val";
-        $result = system
+    system "semanage ibpkey -a -t test_ibpkey_t -x $subnet_prefix $pkey_val";
+    $result = system
 "runcon -t test_ibpkey_access_t $basedir/create_modify_qp $device $port $_";
-        system
-          "semanage ibpkey -d -t test_ibpkey_t -x $subnet_prefix $pkey_val";
-        if ( $result >> 8 ne 13 ) {
-            last;
-        }
-    }
-    if (@unlabeled_pkeys) {
-        ok( $result >> 8, 13 );
-    }
-    else {
-        ok(1);
+    system "semanage ibpkey -d -t test_ibpkey_t -x $subnet_prefix $pkey_val";
+    if ( $result >> 8 ne 13 ) {
+        last;
     }
+}
+if (@unlabeled_pkeys) {
+    ok( $result >> 8, 13 );
+}
+else {
+    ok(1);
+}
 
-    foreach (@labeled_pkeys) {
-        $result = system
+foreach (@labeled_pkeys) {
+    $result = system
 "runcon -t test_ibpkey_access_t $basedir/create_modify_qp $device $port $_";
-        if ( $result >> 8 ne 13 ) {
-            last;
-        }
-    }
-    if (@labeled_pkeys) {
-        ok( $result >> 8, 13 );
-    }
-    else {
-        ok(1);
+    if ( $result >> 8 ne 13 ) {
+        last;
     }
 }
+if (@labeled_pkeys) {
+    ok( $result >> 8, 13 );
+}
 else {
     ok(1);
-    ok(1);
-    ok(1);
 }
+
 exit;
