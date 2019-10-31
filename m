Return-Path: <SRS0=943q=YY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF5DCA9ECB
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E302080F
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 19:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EHrOmzsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfJaTP3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:15:29 -0400
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:8938 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfJaTP3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Oct 2019 15:15:29 -0400
X-EEMSG-check-017: 22837766|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,252,1569283200"; 
   d="scan'208";a="22837766"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Oct 2019 19:15:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572549327; x=1604085327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=52Z0F6DiAsRKMKu79bS6AyJvXkIaay98zSgH8yz6HUA=;
  b=EHrOmzsHK7HHGdo6PzrQ/SaAoKTeQORz5F0CNwX+DGfXmSca3tj3pgxL
   adsOViCucnyUIvv6X1R936FdWPH+zChDQenk8G7fScFvojY8g7QbOrJ3j
   /F0fxaNJumDCm0+sgp7dhEHhctrETYfJ8Q5pWDY8k7gl2K1fDHy55sSel
   +q/uQRNAIfkl+IMQ4wlKqhvefhPo7Z8zSln4VSV3xsQmhui6nmS40J67w
   WfLUGT9/kOGqQDZ5nFxeJn8ISBacZSZUG3LCeXSBOnpRi/9UPF1h1aS/F
   Nq8CZ6m3qQTShwf9qK2pieXZj2wWEaP4cCv3zvXUWnZBKwYXi9n1YVLzI
   w==;
X-IronPort-AV: E=Sophos;i="5.68,252,1569283200"; 
   d="scan'208";a="29631006"
IronPort-PHdr: =?us-ascii?q?9a23=3AExul/xOfa9pHMvOqcmol6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0Ivj8rarrMEGX3/hxlliBBdydt6sfzbOO7uu5AD1IyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQnNtsQajpZuJrs1xx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBuzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?ohDw/IwQIuEdEJvnvbo9v4L7seXOOvwaXU1zjPc+9a1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumarHK58u3r4wlp?=
 =?us-ascii?q?0JvUTFAiD2g1n5gLWTdkUl/uik8+XnYrP4qZ+AL4J4lw7zP6s0lsG/HOg0KB?=
 =?us-ascii?q?YCUmeF9eimybHv5Uj5T69Ljv0ynKnZqpfaJcEDq66iHgBVyZ0u6wq/Dji60N?=
 =?us-ascii?q?QYmmMLLFReeB2dlYTpNFbOIO7gAfeln1usiCtrx+zBPrD5GpXCNGXDkLP6cL?=
 =?us-ascii?q?Zl8UFc1Q4zwcla55JTDbEBOuz8VlXtu9zfCx8zKxa0zPr/CNVhyoMeXnqCAr?=
 =?us-ascii?q?SHP6PWsF+I4P8vIuaXaY8LtzbyNeIl6+TtjXAng18de7em3Z8NZHC/BPRmLB?=
 =?us-ascii?q?bRXX25mdoFEGEXriIgQ+Hwzl6PSzheYzC1Ra1vyCs8DdedEYrbRo2ryIeE1S?=
 =?us-ascii?q?O/E4weMntKEXiQAHzocMOCQP5KZyWMdJwy2gcYXKSsHtdynSqlsxX3nv8+c7?=
 =?us-ascii?q?vZ?=
X-IPAS-Result: =?us-ascii?q?A2BLAADdMbtd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWkHA?=
 =?us-ascii?q?QELAYFzLC0/VTIqjEuHIRkBAQEGgTIBiWaPNoF7CQEBAQEBAQEBARsIEQECA?=
 =?us-ascii?q?QGEQIN2JDQJDgIMAQEBBAEBAQEBBQMBAWyFNwyCOykBgyUBRjCBIYJXDD8Bg?=
 =?us-ascii?q?lIlsk6FToM8gUiBNgGHN4RZGHiBB4ERg1CCSYE2hjQEjH4RimCWAYIugjOEX?=
 =?us-ascii?q?o4YDBuCPIIxiVeGcYQsqg05gVgrCAIYCCEPgycJRxAUgxIXhFSJayUDMIEFA?=
 =?us-ascii?q?QGLNYIwAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 31 Oct 2019 19:15:25 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9VJFO3f021945;
        Thu, 31 Oct 2019 15:15:25 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Aaron Goidel <acgoide@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3] selinux-testsuite: add tests for fsnotify
Date:   Thu, 31 Oct 2019 15:15:20 -0400
Message-Id: <20191031191520.2849-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Aaron Goidel <acgoide@tycho.nsa.gov>

Added a suite to test permissions for setting inotify and fanotify watches
on filesystem objects. Tests watch, watch_with_perm, and watch_reads
permissions.

Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
[sds@tycho.nsa.gov: fix whitespace, check-syntax -f, policy cleanup]
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile              |   4 ++
 policy/test_notify.te        |  94 +++++++++++++++++++++++++
 tests/Makefile               |   4 ++
 tests/notify/Makefile        |   5 ++
 tests/notify/test            | 133 +++++++++++++++++++++++++++++++++++
 tests/notify/test_fanotify.c | 109 ++++++++++++++++++++++++++++
 tests/notify/test_inotify.c  |  43 +++++++++++
 7 files changed, 392 insertions(+)
 create mode 100644 policy/test_notify.te
 create mode 100644 tests/notify/Makefile
 create mode 100755 tests/notify/test
 create mode 100644 tests/notify/test_fanotify.c
 create mode 100644 tests/notify/test_inotify.c

diff --git a/policy/Makefile b/policy/Makefile
index 5c2c4384cc86..ff651537df49 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -86,6 +86,10 @@ ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && e
 TARGETS += test_keys.te
 endif
 
+ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS+=test_notify.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
diff --git a/policy/test_notify.te b/policy/test_notify.te
new file mode 100644
index 000000000000..922b5f09cf82
--- /dev/null
+++ b/policy/test_notify.te
@@ -0,0 +1,94 @@
+####################################################
+# Policy for testing inoftify and fanotify watches #
+####################################################
+
+attribute test_notify_domain;
+
+# Type for the file on which we want to set a watch
+type test_notify_file_t;
+files_type(test_notify_file_t)
+
+# Domain for the process which CAN set a non-permission watch
+type test_watch_t;
+domain_type(test_watch_t)
+unconfined_runs_test(test_watch_t)
+
+typeattribute test_watch_t test_notify_domain;
+typeattribute test_watch_t testdomain;
+
+allow test_notify_domain self:capability sys_admin;
+
+allow test_watch_t test_notify_file_t:file { read write open watch };
+
+# Domain for the process which CAN set a NON-access watch on a file
+type test_perm_watch_t;
+domain_type(test_perm_watch_t)
+unconfined_runs_test(test_perm_watch_t)
+
+typeattribute test_perm_watch_t test_notify_domain;
+typeattribute test_perm_watch_t testdomain;
+
+allow test_perm_watch_t test_notify_file_t:file { read write open watch watch_with_perm };
+
+# Domain which CAN set a NON-perm watch which MAY read accesses
+type test_read_watch_t;
+domain_type(test_read_watch_t)
+unconfined_runs_test(test_read_watch_t)
+
+typeattribute test_read_watch_t test_notify_domain;
+typeattribute test_read_watch_t testdomain;
+
+allow test_read_watch_t test_notify_file_t:file { read write open watch watch_reads };
+
+# Domain which CAN set any watch which CAN read accesses
+type test_perm_read_watch_t;
+domain_type(test_perm_read_watch_t)
+unconfined_runs_test(test_perm_read_watch_t)
+
+typeattribute test_perm_read_watch_t test_notify_domain;
+typeattribute test_perm_read_watch_t testdomain;
+
+allow test_perm_read_watch_t test_notify_file_t:file { read write open watch watch_with_perm watch_reads };
+
+# Domain which CANNOT set any watches
+type test_no_watch_t;
+domain_type(test_no_watch_t)
+unconfined_runs_test(test_no_watch_t)
+
+typeattribute test_no_watch_t test_notify_domain;
+typeattribute test_no_watch_t testdomain;
+
+allow test_no_watch_t test_notify_file_t:file { read write open };
+
+# Domain which allows for mount watches
+type test_mount_watch_t;
+domain_type(test_mount_watch_t)
+unconfined_runs_test(test_mount_watch_t)
+
+typeattribute test_mount_watch_t test_notify_domain;
+typeattribute test_mount_watch_t testdomain;
+
+allow test_mount_watch_t test_notify_file_t:dir { read write open watch_mount };
+
+# Domain which allows for mount perm watches
+type test_mount_perm_t;
+domain_type(test_mount_perm_t)
+unconfined_runs_test(test_mount_perm_t)
+
+typeattribute test_mount_perm_t test_notify_domain;
+typeattribute test_mount_perm_t testdomain;
+
+allow test_mount_perm_t test_notify_file_t:dir { read write open watch_mount watch_with_perm };
+
+# Domain which has no write access but can watch
+type test_rdonly_t;
+domain_type(test_rdonly_t)
+unconfined_runs_test(test_rdonly_t)
+
+typeattribute test_rdonly_t test_notify_domain;
+typeattribute test_rdonly_t testdomain;
+
+allow test_rdonly_t test_notify_file_t:dir { read open watch };
+
+miscfiles_domain_entry_test_files(test_notify_domain)
+userdom_sysadm_entry_spec_domtrans_to(test_notify_domain)
diff --git a/tests/Makefile b/tests/Makefile
index 42f7f4026e4a..00215905c7ec 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -64,6 +64,10 @@ ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
 SUBDIRS += cgroupfs_label
 endif
 
+ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS+=notify
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/notify/Makefile b/tests/notify/Makefile
new file mode 100644
index 000000000000..d23733851759
--- /dev/null
+++ b/tests/notify/Makefile
@@ -0,0 +1,5 @@
+TARGETS=test_inotify test_fanotify
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/notify/test b/tests/notify/test
new file mode 100755
index 000000000000..77db8c29161a
--- /dev/null
+++ b/tests/notify/test
@@ -0,0 +1,133 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 18 }    # number of tests to run
+
+# help the test script locate itself
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+# Get rid of a testfile and dir from last run if it's there (just in case)
+system("rm -f $basedir/watch_me");
+system("rm -rf $basedir/watch_dir");
+
+# Create a new test file
+system("touch $basedir/watch_me");
+system("chcon -t test_notify_file_t $basedir/watch_me");
+
+# Create test dir
+system("mkdir $basedir/watch_dir");
+system("chcon -t test_notify_file_t $basedir/watch_dir");
+
+## TESTS
+
+## TEST BASIC WATCH PERMISSION
+# Should be able to set inotify watch
+$exit_val =
+  system("runcon -t test_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
+ok( $exit_val, 0 );
+
+# Should be able to set non-permissions based fanotify watch
+$exit_val = system(
+    "runcon -t test_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
+ok( $exit_val, 0 );
+
+# Should NOT be able to set permission based fanotify watch
+$exit_val = system(
+    "runcon -t test_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1");
+ok($exit_val);    # this should fail
+
+# Should NOT be able to set read based fanotify watch
+$exit_val = system(
+    "runcon -t test_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1");
+ok($exit_val);    # this should fail
+
+# Should NOT be able to set read based inotify watch
+$exit_val = system(
+    "runcon -t test_watch_t $basedir/test_inotify -r $basedir/watch_me 2>&1");
+ok($exit_val);    # this should fail
+
+## TEST PERM WATCH
+# Should be able to set permission based fanotify watch
+$exit_val = system(
+"runcon -t test_perm_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1"
+);
+ok( $exit_val, 0 );
+
+# Should NOT be able to set watch of accesses
+$exit_val = system(
+"runcon -t test_perm_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1"
+);
+ok($exit_val);    # this should fail
+
+## TEST READ NO PERM WATCH PERMSISSIONS
+# Should NOT be able to set read and perm watch
+$exit_val = system(
+"runcon -t test_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
+);
+ok($exit_val);    # should fail
+
+# Should be able to set read inotify watch
+$exit_val = system(
+"runcon -t test_read_watch_t $basedir/test_inotify -r $basedir/watch_me 2>&1"
+);
+ok( $exit_val, 0 );
+
+## TEST READ WITH PERM WATCH PERMSISSIONS
+# Should be able to set read and perm watch
+$exit_val = system(
+"runcon -t test_perm_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
+);
+ok( $exit_val, 0 );
+
+## TEST NO WATCH PERMSISSIONS
+# Should NOT be able to set inotify watch
+$exit_val = system(
+    "runcon -t test_no_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
+ok($exit_val);    # this should fail
+
+# Should NOT be able to set any fanotify watch
+$exit_val = system(
+    "runcon -t test_no_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
+ok($exit_val);    # this should fail
+
+## TEST READ ONLY
+# Should NOT be able to get read-write descriptor
+$exit_val = system(
+    "runcon -t test_rdonly_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
+ok($exit_val);    # this should fail
+
+# Should be able to get read-write descriptor
+$exit_val = system(
+    "runcon -t test_watch_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
+ok( $exit_val, 0 );
+
+## TEST MOUNT WATCHES
+# Should NOT be able to set a watch on a mount point
+$exit_val = system(
+    "runcon -t test_watch_t $basedir/test_fanotify -m $basedir/watch_dir 2>&1");
+ok($exit_val);    # this should fail
+
+# Should be able to set a watch on mount point
+$exit_val = system(
+"runcon -t test_mount_watch_t $basedir/test_fanotify -m $basedir/watch_dir 2>&1"
+);
+ok( $exit_val, 0 );
+
+# Should NOT be able to set a perm watch on a mount
+$exit_val = system(
+"runcon -t test_mount_watch_t $basedir/test_fanotify -m -p $basedir/watch_dir 2>&1"
+);
+ok($exit_val);    # this should fail
+
+# Should be able to set a perm watch on a mount object
+$exit_val = system(
+"runcon -t test_mount_perm_t $basedir/test_fanotify -p -m $basedir/watch_dir 2>&1"
+);
+ok( $exit_val, 0 );
+
+# Clean up test file
+system("rm -f $basedir/watch_me");
+
+# Clean up test dir
+system("rm -rf $basedir/watch_dir");
diff --git a/tests/notify/test_fanotify.c b/tests/notify/test_fanotify.c
new file mode 100644
index 000000000000..bc3b4c33fc55
--- /dev/null
+++ b/tests/notify/test_fanotify.c
@@ -0,0 +1,109 @@
+#define _GNU_SOURCE 1
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <getopt.h>
+
+#include <fcntl.h>
+#include <poll.h>
+#include <sys/fanotify.h>
+#include <unistd.h>
+
+void printUsage()
+{
+	fprintf(stderr, "Usage: test_fanotify [-p] [-r] [-l] [-m] file_name\n");
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 2) {
+		printUsage();
+	}
+
+	int fd, ret, arg;
+	int mask = FAN_OPEN;  // default mask
+	int flags = FAN_MARK_ADD;
+	int listening = 0;
+
+	// the -p flag will test for watch_with_perm
+	// the mask used at mark will contain FAN_OPEN_PERM
+	//
+	// the -r flag will test for watching accesses to files for reads
+	// the mask will contain FAN_ACCESS
+	while ((arg = getopt(argc, argv, "prlm")) != -1) {
+		switch (arg) {
+		case 'p':
+			mask |= FAN_OPEN_PERM;
+			break;
+		case 'r':
+			mask |= FAN_ACCESS;
+			break;
+		case 'l':
+			listening = 1;
+			break;
+		case 'm':
+			flags |= FAN_MARK_MOUNT;
+			break;
+		default:
+			printUsage();
+		}
+	}
+
+	// get file descriptor for new fanotify event queue
+	fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
+	if (fd < 0) {
+		perror("fanotify_init:bad file descriptor");
+		exit(1);
+	}
+
+	// mark a filesystem object and add mark to event queue
+	// get notifications on file opens, accesses, and closes
+	// use current working directory as base dir
+	ret = fanotify_mark(fd, flags, mask, AT_FDCWD, argv[optind]);
+
+	if (ret < 0) {
+		perror("test_fanotify:watch denied");
+		exit(1);
+	}
+
+	// logic to actually listen for an event if the -l flag is passed
+	// this is used to test if an app with read-only access can get a read/write
+	// handle to the watched file
+	if (listening) {
+		if (fork() == 0) {  // fork a child process to cause an event on the file
+			FILE *f;
+
+			f = fopen(argv[optind], "r");  // open file for reading
+			fgetc(f);                      // read char from file
+
+			fclose(f);
+		} else {  // logic to watch for events and try to access file read/write
+			struct pollfd fds;
+			fds.fd = fd;
+			fds.events = POLLIN;
+
+			while (listening) {
+				int polled = poll(&fds, 1, 1);
+				if (polled > 0) {
+					if (fds.revents & POLLIN) {
+						struct fanotify_event_metadata buff[200];
+
+						size_t len = read(fd, (void *)&buff, sizeof(buff));
+						if (len == -1) {
+							perror("test_fanotify:can't open file");
+							exit(1);
+						} else {
+							listening = 0;
+							break;
+						}
+					}
+				} else if (polled == -1) {
+					listening = 0;
+				}
+			}
+		}
+	}
+	exit(0);
+}
diff --git a/tests/notify/test_inotify.c b/tests/notify/test_inotify.c
new file mode 100644
index 000000000000..17c3565b8bfd
--- /dev/null
+++ b/tests/notify/test_inotify.c
@@ -0,0 +1,43 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/inotify.h>
+#include <getopt.h>
+
+int main(int argc, char *argv[])
+{
+	if (argc < 2) {
+		fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
+		exit(1);
+	}
+
+	int fd, wd, arg;
+	int mask = IN_MODIFY;
+
+	while ((arg = getopt(argc, argv, "pr")) != -1) {
+		switch (arg) {
+		case 'r':
+			mask |= IN_ACCESS;
+			break;
+		default:
+			fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
+			exit(1);
+		}
+	}
+
+	// get new file descriptor for inotify access
+	fd = inotify_init();
+	if (fd < 0) {
+		perror("inotify_init:bad file descriptor");
+		exit(1);
+	}
+
+	// set watch on file and get watch descriptor for accessing events on it
+	wd = inotify_add_watch(fd, argv[optind], mask);
+
+	if (wd < 0) {
+		perror("test_inotify:watch denied");
+		exit(1);
+	}
+
+	exit(0);
+}
-- 
2.23.0

