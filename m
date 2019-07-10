Return-Path: <SRS0=qgEa=VH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F20C74A21
	for <selinux@archiver.kernel.org>; Wed, 10 Jul 2019 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001DF20651
	for <selinux@archiver.kernel.org>; Wed, 10 Jul 2019 13:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="b/auTvoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGJNtv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:49:51 -0400
Received: from usfb19pa14.eemsg.mail.mil ([214.24.26.85]:6223 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfGJNtv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jul 2019 09:49:51 -0400
X-Greylist: delayed 622 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 09:49:50 EDT
X-EEMSG-check-017: 170676249|USFB19PA14_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jul 2019 13:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562765965; x=1594301965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BN2limgbcOzNuIGX45WiEYfgqqXIzQvGdWMEhmza+Z0=;
  b=b/auTvooMLfvpNFuNFfN3xuTIijukv6NVtuSI0z26HSqzCZq2j7Vl5Sk
   /3MtgM2vCY7AGBOnMhdxlRYt4Y4c9cGykczHcBTzPLte19J6sev1VDPUZ
   bvBvnmGaHXjtFhxkrmtd3OWrMnPGowTZBOKu9Lc9eWCu543ukvnfkpqkD
   yf7i64I29CM2DYTJp6+9TwicnviYWyPFJPrpcPLkRnd3btXUyiS8kSx8L
   IdkTQGpm0nljx/qoaLbYC3ZhTg8fJQbwkQEC5M/D6OSFYMuuTm7LD1+W9
   fNTiPYDHXsQGj3XwHaXecIgVlXStYPKyGaGMYeZVEkF7BSVFFx4v/pNjt
   g==;
X-IronPort-AV: E=Sophos;i="5.63,474,1557187200"; 
   d="scan'208";a="25553448"
IronPort-PHdr: =?us-ascii?q?9a23=3AiGOIfRDAZtFBfBGPcnnfUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT7oMbcNUDSrc9gkEXOFd2Cra4d0ayK7eu+BiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Nhq7oATeusQXg4ZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLmhycdMz4y7X/ZhMp+gqlGpB6tvhxyzorRbIyTKfFwfL7SfckCSG?=
 =?us-ascii?q?RBQMhfSiJPDIC7YYQAAOQMJvpUoornqlcStxayGRWgCeXywTFInH/22qg63v?=
 =?us-ascii?q?w9HA7cxgwgGNQOu2nVotXyNacdTP66zK3VxjjEdfxZxTj96I/Jch88v/6BRq?=
 =?us-ascii?q?5wcMrNxkkvEAPJlFOQqZf/MD+P2eQNtHab4vNmWOmyiGAnsxl8riWgy8ojkI?=
 =?us-ascii?q?XEhp8Zxkra+Sh23oo5P8C0RUhmatC+CpRQrTuVN45uT8MnRGFnpTg1x6UduZ?=
 =?us-ascii?q?6+YCgK0JMnxwPDa/Cfc4iH/BbjVOGJLDdknn1lYrO/hwup8US61u39VtW70F?=
 =?us-ascii?q?ZNriZflNnDqmsN2ADJ5siCS/t9+l+t2TeJ1w/N9uFJOV04mKXUJpI7wrM8i4?=
 =?us-ascii?q?AfvVrMEyPogkn6kbeadkA+9eip7+TnbK/mppiZN4JskA7xLqsumsu+AeslLA?=
 =?us-ascii?q?cDRHSb+OSg273j+k31WrNKjuYsnaXDv5DaItobqrajAwBJyoYj9wq/DzC+3d?=
 =?us-ascii?q?QDg3YHKFNFeBSaj4nmIFzOPv/4Aumlg1i2kzdk2erGPrv/DZXJNHTDl63hfb?=
 =?us-ascii?q?ll4U5G1AUz1cxf545TCrwZOPL8QFLxtNjDAx8hKQO03uLnBMx41oMZXmKPGL?=
 =?us-ascii?q?GWPLnOvl+P4+J8a9WLMZccpTLVM/E447vringjlBkWeqz684EQbSWRF+5hJQ?=
 =?us-ascii?q?22Znvgj9NJRW4BsQ0/QOHClEyJUTkVYW27Ga07+GdoW8qdEY7fS9X10/S61y?=
 =?us-ascii?q?ChE8gTOzFL?=
X-IPAS-Result: =?us-ascii?q?A2CDAAAq6SVd/wHyM5BlHQEBBQEHBQGBVQYBCwGBbCotP?=
 =?us-ascii?q?VEBMiiXLxYBAQEBAQEGgTIBiWCPGYF7CQEBAQEBAQEBARsIEQECAQGEQIJQI?=
 =?us-ascii?q?zYHDgEDAQEBBAEBAQEEAQFshTwMgjopgyABRoFRglcMPwGBdhSvSIVHgyqBR?=
 =?us-ascii?q?4E0AYcHhFcXeIEHgRGDUIJIgTaGKASMBxGJfpRACYIbhleNIwwbgiyCKIkFh?=
 =?us-ascii?q?iKEBAGmbgsmgVgrCAIYCCEPgycJgkQXhFKJayMDMIEGAQGMG4JDAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jul 2019 13:39:23 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6ADdN6j029984;
        Wed, 10 Jul 2019 09:39:23 -0400
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, sds@tycho.nsa.gov,
        Aaron Goidel <acgoide@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: add tests for fsnotify
Date:   Wed, 10 Jul 2019 09:39:17 -0400
Message-Id: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Added a suite to test permissions for setting inotify and fanotify watches
on filesystem objects. Tests watch, watch_with_perm, and watch_reads permissions.

Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
---
 policy/Makefile              |   4 ++
 policy/test_notify.te        |  74 ++++++++++++++++++++++++
 tests/Makefile               |   4 ++
 tests/notify/Makefile        |   5 ++
 tests/notify/test            | 101 +++++++++++++++++++++++++++++++++
 tests/notify/test_fanotify.c | 105 +++++++++++++++++++++++++++++++++++
 tests/notify/test_inotify.c  |  43 ++++++++++++++
 7 files changed, 336 insertions(+)
 create mode 100644 policy/test_notify.te
 create mode 100644 tests/notify/Makefile
 create mode 100755 tests/notify/test
 create mode 100644 tests/notify/test_fanotify.c
 create mode 100644 tests/notify/test_inotify.c

diff --git a/policy/Makefile b/policy/Makefile
index 305b572..65f88c5 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -71,6 +71,10 @@ ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
 TARGETS += test_sctp.te
 endif
 
+ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS+=test_notify.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_notify.te b/policy/test_notify.te
new file mode 100644
index 0000000..8ba6f1a
--- /dev/null
+++ b/policy/test_notify.te
@@ -0,0 +1,74 @@
+####################################################
+# Policy for testing inoftify and fanotify watches #
+####################################################
+
+attribute test_notify_domain;
+
+# Type for the file on which we want to set a watch
+type test_notify_file_t;
+files_type(test_notify_file_t);
+
+# Domain for the process which CAN set a non-permission watch
+type test_watch_t;
+domain_type(test_watch_t);
+unconfined_runs_test(test_watch_t);
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
+domain_type(test_perm_watch_t);
+unconfined_runs_test(test_perm_watch_t);
+
+typeattribute test_perm_watch_t test_notify_domain;
+typeattribute test_perm_watch_t testdomain;
+
+allow test_perm_watch_t test_notify_file_t:file { read write open watch watch_with_perm };
+
+# Domain which CAN set a NON-perm watch which MAY read accesses
+type test_read_watch_t;
+domain_type(test_read_watch_t);
+unconfined_runs_test(test_read_watch_t);
+
+typeattribute test_read_watch_t test_notify_domain;
+typeattribute test_read_watch_t testdomain;
+
+allow test_read_watch_t test_notify_file_t:file { read write open watch watch_reads };
+
+# Domain which CAN set any watch which CAN read accesses
+type test_perm_read_watch_t;
+domain_type(test_perm_read_watch_t);
+unconfined_runs_test(test_perm_read_watch_t);
+
+typeattribute test_perm_read_watch_t test_notify_domain;
+typeattribute test_perm_read_watch_t testdomain;
+
+allow test_perm_read_watch_t test_notify_file_t:file { read write open watch watch_with_perm watch_reads };
+
+# Domain which CANNOT set any watches
+type test_no_watch_t;
+domain_type(test_no_watch_t);
+unconfined_runs_test(test_no_watch_t);
+
+typeattribute test_no_watch_t test_notify_domain;
+typeattribute test_no_watch_t testdomain;
+
+allow test_no_watch_t test_notify_file_t:file { read write open };
+
+# Domain which has no write access but can watch
+type test_rdonly_t;
+domain_type(test_rdonly_t);
+unconfined_runs_test(test_rdonly_t);
+
+typeattribute test_rdonly_t test_notify_domain;
+typeattribute test_rdonly_t testdomain;
+
+allow test_rdonly_t test_notify_file_t:file { read open watch };
+
+miscfiles_domain_entry_test_files(test_notify_domain);
+userdom_sysadm_entry_spec_domtrans_to(test_notify_domain);
diff --git a/tests/Makefile b/tests/Makefile
index 63aa325..b99c96e 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -50,6 +50,10 @@ ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.
 SUBDIRS += infiniband_pkey
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
index 0000000..78c4b3b
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
index 0000000..21f03de
--- /dev/null
+++ b/tests/notify/test
@@ -0,0 +1,101 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 14 }    # number of tests to run
+
+# help the test script locate itself
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+# Get rid of a testfile from last run if it's there (just in case)
+system("rm -f $basedir/watch_me");
+
+# Create a new test file
+system("touch $basedir/watch_me");
+system("chcon -t test_notify_file_t $basedir/watch_me");
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
+# Clean up test file
+system("rm -f $basedir/watch_me");
diff --git a/tests/notify/test_fanotify.c b/tests/notify/test_fanotify.c
new file mode 100644
index 0000000..fff773f
--- /dev/null
+++ b/tests/notify/test_fanotify.c
@@ -0,0 +1,105 @@
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
+	fprintf(stderr, "Usage: test_fanotify [-p] [-r] [-l] file_name\n");
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
+	int listening = 0;
+
+	// the -p flag will test for watch_with_perm
+	// the mask used at mark will contain FAN_OPEN_PERM
+	//
+	// the -r flag will test for watching accesses to files for reads
+	// the mask will contain FAN_ACCESS
+	while ((arg = getopt(argc, argv, "prl")) != -1) {
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
+	ret = fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, argv[optind]);
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
index 0000000..17c3565
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
2.21.0

