Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECA36073C
	for <selinux@vger.kernel.org>; Fri,  6 Feb 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403009; cv=none; b=bGS5PtClzW1RkxCjOwRsb3EL7D5qZHL0vXxp93wMhOYj1mTQGBF1B85T0tcDD8IGYg96Llvt+8QalTB3BKCyNHwGs9y1705a0DLeB7FHUbAvAtZ9wJC01KlRu6uw+DyW/BdXzOTWvMDQZRmr2ULt70oajF/xjRF4KokmcuRrz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403009; c=relaxed/simple;
	bh=2Dm4zvIGvVs1FRi5h11aOQ97MzfjkHbl7fd66BbST2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6YG/N21m+pM00rnGNdHH8rKe1HbBcTD/2Qc4Ifm+zgE0+UyW83CnTOWS8xLUReWbIWreSyrmoaBpmrnK9aJ9WDNi9TbnyXuO7WYbgN8le6YujL1O2TxwRLGVNOBbL1imU6GL0riIBH1SbEjf326hTx9jpfvG2B9o9GyqamtzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHsWrpz1; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHsWrpz1"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-895341058b1so12536806d6.3
        for <selinux@vger.kernel.org>; Fri, 06 Feb 2026 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770403007; x=1771007807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lgkQy4ESCJ/0FTZsGs92gMBzoOO5+GdHWZoRzDBM2MI=;
        b=CHsWrpz1R9VDbffTpPeLN20NvQTx4YdkLf01cE68xeh0oMfgjvIoO5k/s7jJdafpcY
         bXfpIbGeqaJygkY+3iHf1lQaG6Wym505SXG2cqO48wfjEIJgxvOoZjrVP0RT5IQa+dfT
         d4Y/6fTmECT044EeC3vC490W3BfqJKesPCX3jmculJDMhH0CsHG6pPD2cDufMdgoKOK3
         Rk9pTccbmd39DdM6tEZSG2cBr8c1fXjRTRYaQdNHHITuCQal06jZlNrRnnOxrNw1o0iG
         qZQ4suudvXTJw3yuaydmeHdzhl8rASYAZYV4kbx89U4OMOzUXqMs2rPbXpKJPwPJKH15
         56Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770403007; x=1771007807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgkQy4ESCJ/0FTZsGs92gMBzoOO5+GdHWZoRzDBM2MI=;
        b=bjExOl2d3S5GQk6DdA+fikYUPYOh/TCzHcBV+eTOHNMKyaRbTzW1p1e1ttO5yoMlB8
         n7HJ7ALjM2VSHN0MhtNMhINO6rNZVprFNoENJdyUWCfMpMKIxjuUrTJFZotKiIyWT/lD
         +5g6XIhFsQC6X9f3tNB0ocToRDxCBdq9BGvoWAvtwOeeQlY7aJxpSSvfj/ZnxC4IVyGm
         lCaqYEk6gSjxRxwb+UN5B68OGsp+4oAC9MXcn2OnHPCw+9JKJFsajeqiD1/S5XqqO6+F
         HlTGP0GZYx/gM5ej0Kh7F2OgGBUmXMu6Ob+aPQot8rLzt1xmR6Nq9kvvQoSNyOctzDlW
         BusQ==
X-Gm-Message-State: AOJu0YyV4L/ka8jHTFDCcBYmVcKVcvNE5qJVPBdmjj++txdcFcewpxit
	lkjwpoCND84JboCWMNjxSLqqsw6TEEFybc4gdclt2sgrWDrUPJ8aZFgfmdpVqeeM
X-Gm-Gg: AZuq6aLXWiJ+Yfg8GHhBEQcfi08zZjih2hLAKp3yH4OvPsWwUC8nTgjt7Fz4PWSw/GV
	3lMoJke+olawkkpcOynOXKQoAqpGg5wspE61WfUZNi6E6JOG+ino0o9HokLnJtQgTH1CfQ0ZTYH
	dhvdbUL8M05qPfT6ah2QaX1edWi6MtmSRWEEd6sLoGbH+MvnuYCdC3/tGsVbGKGBw8tpHqLDDeN
	TmlFuhe3jXFX8qIG/EiQoWp8ZorOVdacBFGI78a/2ilr+NjhfANkXooz8BAZtz9HSlMTx73xdip
	7HVojjMcW2KbBcy3YXbKD0AQMI3lHGvv0ZdVj5Cn9/cxO/TDyAWBf+6DFvCaT4c6h6fsvEPY/de
	8qpSTq7b3K1iYz7XMwZhijYGilXZlV+Tkn5SLxhDbXYwE7gftGCjLx9Vpz2ZhgS3prGQA2t1j2z
	ci7vXNEzcXreuOwJoB5U0fRwe+E8Bcu8vhlTELcydJOHmAWKo3HGybSoqt5v/aKxRf7QYtjCniP
	apIdWusLhDRAOuk
X-Received: by 2002:a05:622a:646:b0:4ee:4a3a:bd00 with SMTP id d75a77b69052e-50639a1a19dmr48114631cf.71.1770403007446;
        Fri, 06 Feb 2026 10:36:47 -0800 (PST)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c057799sm21933946d6.42.2026.02.06.10.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:36:47 -0800 (PST)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [PATCH testsuite] Add tests for pidfds
Date: Fri,  6 Feb 2026 18:36:18 +0000
Message-ID: <20260206183618.16065-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Added two tests to exercise accesss controls on pidfd_getinfo(),
as introduced in the corresponding kernel patch.

Link: https://lore.kernel.org/selinux/20260206180248.12418-1-danieldurning.work@gmail.com
Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 policy/Makefile          |   2 +-
 policy/test_pidfd.te     |  30 +++++++++++
 tests/Makefile           |   2 +-
 tests/pidfd/.gitignore   |   1 +
 tests/pidfd/Makefile     |   5 ++
 tests/pidfd/pidfd_test.c | 112 +++++++++++++++++++++++++++++++++++++++
 tests/pidfd/test         |  49 +++++++++++++++++
 7 files changed, 199 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_pidfd.te
 create mode 100644 tests/pidfd/.gitignore
 create mode 100644 tests/pidfd/Makefile
 create mode 100644 tests/pidfd/pidfd_test.c
 create mode 100755 tests/pidfd/test

diff --git a/policy/Makefile b/policy/Makefile
index a43883f..870b45b 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -22,7 +22,7 @@ TARGETS = \
 	test_entrypoint.te test_execshare.te test_exectrace.te \
 	test_execute_no_trans.te test_fdreceive.te test_file.te \
 	test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te \
-	test_open.te test_ptrace.te test_readlink.te \
+	test_open.te test_ptrace.te test_pidfd.te test_readlink.te \
 	test_relabel.te test_rename.te test_rxdir.te test_setattr.te \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
diff --git a/policy/test_pidfd.te b/policy/test_pidfd.te
new file mode 100644
index 0000000..89b3c00
--- /dev/null
+++ b/policy/test_pidfd.te
@@ -0,0 +1,30 @@
+#
+################# pidfd selinux-testsuite policy module ###################
+#
+
+attribute pidfddomain;
+
+################################### Main ##################################
+type test_pidfd_t;
+testsuite_domain_type(test_pidfd_t)
+typeattribute test_pidfd_t pidfddomain;
+
+allow test_pidfd_t self:file read;
+
+############################### Deny fd read ##############################
+type test_pidfd_deny_read_t;
+testsuite_domain_type(test_pidfd_deny_read_t)
+typeattribute test_pidfd_deny_read_t pidfddomain;
+
+allow test_pidfd_deny_read_t self:file read;
+
+############################### Process type ##############################
+type test_pidfd_process_t;
+testsuite_domain_type(test_pidfd_process_t)
+typeattribute test_pidfd_process_t pidfddomain;
+
+# For writing to flag file
+allow test_pidfd_process_t test_file_t:fifo_file rw_file_perms;
+
+# Allow the main domain to read the process info
+allow test_pidfd_t test_pidfd_process_t:file read;
\ No newline at end of file
diff --git a/tests/Makefile b/tests/Makefile
index 6df220c..7cd80f6 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -22,7 +22,7 @@ POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
 FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) > /dev/null 2>&1 && echo $(fs)))
 
 SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
-	fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
+	fdreceive inherit link mkdir msg open ptrace pidfd readlink relabel rename \
 	rxdir sem setattr setnice shm sigkill stat sysctl task_create \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
diff --git a/tests/pidfd/.gitignore b/tests/pidfd/.gitignore
new file mode 100644
index 0000000..42604c5
--- /dev/null
+++ b/tests/pidfd/.gitignore
@@ -0,0 +1 @@
+pidfd_test
\ No newline at end of file
diff --git a/tests/pidfd/Makefile b/tests/pidfd/Makefile
new file mode 100644
index 0000000..d4d3d48
--- /dev/null
+++ b/tests/pidfd/Makefile
@@ -0,0 +1,5 @@
+TARGETS = pidfd_test
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS) flag
diff --git a/tests/pidfd/pidfd_test.c b/tests/pidfd/pidfd_test.c
new file mode 100644
index 0000000..b937a5d
--- /dev/null
+++ b/tests/pidfd/pidfd_test.c
@@ -0,0 +1,112 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <linux/pidfd.h>
+
+#ifndef PIDFD_GET_INFO
+#include <stdint.h>
+
+struct pidfd_info {
+	uint64_t mask;
+	uint64_t cgroupid;
+	uint32_t pid;
+	uint32_t tgid;
+	uint32_t ppid;
+	uint32_t ruid;
+	uint32_t rgid;
+	uint32_t euid;
+	uint32_t egid;
+	uint32_t suid;
+	uint32_t sgid;
+	uint32_t fsuid;
+	uint32_t fsgid;
+	uint32_t spare0[1];
+};
+
+#define PIDFD_GET_INFO	_IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
+#endif
+
+enum pidfd_op_types {
+	GET_INFO = 1
+};
+
+static int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(SYS_pidfd_open, pid, flags);
+}
+
+int getinfo(int pidfd)
+{
+    struct pidfd_info info;
+
+    return ioctl(pidfd, PIDFD_GET_INFO, &info);
+}
+
+static void usage(char *argv[])
+{
+	fprintf(stderr,
+		"Usage: %s -i [-v] <pid>\n"
+		"Where:\n\t"
+		"-i Attempt pidfd_getinfo.\n\t"
+		"-v Print information.\n", argv[0]);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+    int pid, pidfd, ret = 0, opt, verbose = 0;
+	char *addr = NULL;
+    enum pidfd_op_types op = 0;
+
+    while ((opt = getopt(argc, argv, "vi")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = 1;
+			break;
+		case 'i':
+			op = GET_INFO;
+			break;
+		case '?':
+			usage(argv);
+			break;
+		default:
+			exit(-1);
+		}
+	}
+
+	if (argc < 3)
+		usage(argv);
+
+	pid = atoi(argv[optind]);
+
+    ret = pidfd_open(pid, 0);
+    if (ret < 0) {
+		perror("pidfd_open");
+        goto out;
+	}
+    pidfd = ret;
+
+    switch (op) {
+    case GET_INFO:
+        if (verbose)
+            printf("Attempting to get info from pidfd...\n");
+        ret = getinfo(pidfd);
+		if (verbose) {
+			if (ret)
+				printf("Pidfd get info failed\n");
+			else
+				printf("Got info successfully\n");
+		}
+        break;
+	default:
+        exit(-1);
+    }
+
+out:
+	close(pidfd);
+    return ret;
+}
\ No newline at end of file
diff --git a/tests/pidfd/test b/tests/pidfd/test
new file mode 100755
index 0000000..3585a57
--- /dev/null
+++ b/tests/pidfd/test
@@ -0,0 +1,49 @@
+#!/usr/bin/perl
+
+use Test::More;
+
+BEGIN {
+    plan tests => 2;
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # Allow info to be shown during tests
+    $v = $ARGV[0];
+    if ($v) {
+        if ( $v ne "-v" ) {
+            plan skip_all => "Invalid option (use -v)";
+        }
+    }
+    else {
+        $v = " ";
+    }
+}
+
+# Create child process with process test type
+system("mkfifo $basedir/flag");
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"exec runcon -t test_pidfd_process_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+    exit;
+}
+
+# Wait for it to start
+open( my $f, "<", "$basedir/flag" );
+my $rin = '';
+vec( $rin, fileno($f), 1 ) = 1;
+select( $rin, undef, undef, 5 );
+close($f);
+
+# Test that process info read is allowed under default type
+$result = system "runcon -t test_pidfd_t $basedir/pidfd_test $v -i $pid";
+ok( $result eq 0 );
+
+# Test that process info read is denied under deny type
+$result = system "runcon -t test_pidfd_deny_read_t $basedir/pidfd_test $v -i $pid";
+ok($result);
+
+# Clean up
+kill KILL, $pid;
+system "rm -f $basedir/flag";
+
+exit;
-- 
2.52.0

