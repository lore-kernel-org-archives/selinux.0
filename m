Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76CBC43334
	for <selinux@archiver.kernel.org>; Tue, 28 Jun 2022 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbiF1Oed (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbiF1Oe2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jun 2022 10:34:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E527FCB
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 07:34:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so26123186ejc.11
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mZ3NzjaPaS2gsXSdz9MAAR73ADnnEhl7YsngVzrl/Ig=;
        b=m89Xcu7V/M68Q9OEQI8alXF42edQU4enYavrj6+/Azt+uoQRtCXyTqpnjCd+ORzTrI
         2cUPk1ri4Auhurqiv439ypYSzQ4GwMt1OD/L9K0MNOdFdVtguEljiz5JlSDiTRksjD4v
         psjda1synQ8NJPioYxVJ0wpSzqMWuItN79GmNe41iOLheDu08whGGFQr+2Q/m/Yqc5gV
         3FctlhN1L5vQNYz0KlGN4XgLyPpJ/X5FxOGKCSx9NZuNqftLSpSFBi65XI754UpbQ6F1
         A9yTxvohwpn/sRtsZyNZcAhoRXYazUU69n+hkCy4Xr1TeefyW7Inz7byoZRLv/pEg3OS
         u+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZ3NzjaPaS2gsXSdz9MAAR73ADnnEhl7YsngVzrl/Ig=;
        b=rB43SeXBoc1qHUE7QkIFHNplUX3vkiyUCIDH6JWGE3KlEPisgp87naPxTgtxGg/Fgr
         7txeL+1klo37H7L0jsr9RQL1BHSxbsr9K0Mcth2DeLZsjWiYWeUCqWQVvqo8m5Y3kDHa
         LcohBjvam87XzO3x0RomSCJbHgyG9kbwtYYLYGdiPtiM/j4PpaUqMg6npZLwRKXpBXXo
         DaxXWq0z0dYLWyMuRo5JAZ0kcuUvs8L/sYrbjwdKqRvtGdfH4yXNxMaaiAxKs0U3qy7y
         RZJi1th35FU3QHlb20Jg8L/VJ6D6sluAwCxAE0l7+MsSjZ27LyBZGuy7cXhOLSI1K+WQ
         Hoiw==
X-Gm-Message-State: AJIora+wM5yCYrNgCs896RH9kwMLwIeE738ldEtj8vjz2rF/v/b8u8FG
        6N7fDCoeNudGmzPz4LDQPWAh/lRWAMEhzw==
X-Google-Smtp-Source: AGRyM1sZTtZMwp2bwKNRNDNhe3+joPCWt/ZeRu5Vta/Y+cK06l7Hba8+pJbge+qN44G9cWHif5ImjQ==
X-Received: by 2002:a17:907:7255:b0:718:cbb7:4b5c with SMTP id ds21-20020a170907725500b00718cbb74b5cmr18402594ejc.231.1656426865038;
        Tue, 28 Jun 2022 07:34:25 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-156-187.77.8.pool.telefonica.de. [77.8.156.187])
        by smtp.gmail.com with ESMTPSA id n7-20020a05640205c700b0043575ae2051sm9418096edx.62.2022.06.28.07.34.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:34:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 1/4] support Dash as default shell
Date:   Tue, 28 Jun 2022 16:34:08 +0200
Message-Id: <20220628143408.76329-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615122711.9895-1-cgzones@googlemail.com>
References: <20220615122711.9895-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Debian uses Dash as default shell and switching via

    dpkg-reconfigure dash

has become deprecated.

* Use POSIX compliant `> target 2>&1` instead of `>& target`.
* Call runcon via exec to avoid a fork within the Debian version of
  Dash, which breaks tests requiring to not change the PID of executing
  commands
* Use bash explicitly for non POSIX read option -t

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   perpend runcon by exec instead of splitting arguments
v2:
   use system("bash -c ...") instead of `bash -c ...`
---
 README.md                      |  7 -------
 tests/Makefile                 |  2 +-
 tests/binder/test              |  2 +-
 tests/bpf/test                 |  4 ++--
 tests/fdreceive/test           |  2 +-
 tests/filesystem/Filesystem.pm | 14 +++++++-------
 tests/inet_socket/test         |  2 +-
 tests/ptrace/test              |  4 ++--
 tests/sctp/test                |  2 +-
 tests/sigkill/test             |  2 +-
 tests/task_getpgid/test        |  4 ++--
 tests/task_getscheduler/test   |  4 ++--
 tests/task_getsid/test         |  4 ++--
 tests/task_setnice/test        |  4 ++--
 tests/task_setscheduler/test   |  4 ++--
 tests/unix_socket/test         |  2 +-
 tests/vsock_socket/test        |  2 +-
 17 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/README.md b/README.md
index 29e3421..e90a20d 100644
--- a/README.md
+++ b/README.md
@@ -147,13 +147,6 @@ On Debian prior to version 11 (bullseye) you need to build and install netlabel_
     # make
     # sudo make install
 
-Debian further requires reconfiguring the default /bin/sh to be bash
-to support bashisms employed in the testsuite Makefiles and scripts:
-
-    # dpkg-reconfigure dash
-
-Select "No" when asked if you want to use dash as the default system shell.
-
 #### Other Distributions
 
 The testsuite requires a pre-existing base policy configuration of SELinux,
diff --git a/tests/Makefile b/tests/Makefile
index c384e11..8abd438 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -19,7 +19,7 @@ MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
 POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
 
 # Filter out unavailable filesystems
-FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) &>/dev/null && echo $(fs)))
+FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) > /dev/null 2>&1 && echo $(fs)))
 
 SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
diff --git a/tests/binder/test b/tests/binder/test
index 14f2096..9b6f377 100755
--- a/tests/binder/test
+++ b/tests/binder/test
@@ -80,7 +80,7 @@ sub service_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/$flag");
+    system("bash -c 'read -t 5 <>$basedir/$flag'");
     return $pid;
 }
 
diff --git a/tests/bpf/test b/tests/bpf/test
index 6ab7686..44b4f03 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -106,7 +106,7 @@ if ( ( $pid = fork() ) == 0 ) {
 }
 
 # Wait for it to initialize.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Test BPF map & prog fd on transfer:
 $result = system
@@ -149,7 +149,7 @@ sub service_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/$flag");
+    system("bash -c 'read -t 5 <>$basedir/$flag'");
     return $pid;
 }
 
diff --git a/tests/fdreceive/test b/tests/fdreceive/test
index 2415361..ec2d9bc 100755
--- a/tests/fdreceive/test
+++ b/tests/fdreceive/test
@@ -22,7 +22,7 @@ if ( ( $pid = fork() ) == 0 ) {
 }
 
 # Wait for it to initialize.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_fdreceive_server_t can receive a rw fd to the test_file
 # from test_fdreceive_client_t.
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index c14e760..e3cd8ee 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -49,12 +49,12 @@ sub udisks2_stop {
     $status = 0;
 
     if ( -e "/usr/bin/systemctl" ) {
-        $u_status_cmd = "/usr/bin/systemctl status udisks2 >& /dev/null";
-        $u_stop_cmd   = "/usr/bin/systemctl stop udisks2 >& /dev/null";
+        $u_status_cmd = "/usr/bin/systemctl status udisks2 > /dev/null 2>&1";
+        $u_stop_cmd   = "/usr/bin/systemctl stop udisks2 > /dev/null 2>&1";
     }
     elsif ( -e "/usr/sbin/service" ) {
-        $u_status_cmd = "/usr/sbin/service udisks2 status >& /dev/null";
-        $u_stop_cmd   = "/usr/sbin/service udisks2 stop >& /dev/null";
+        $u_status_cmd = "/usr/sbin/service udisks2 status > /dev/null 2>&1";
+        $u_stop_cmd   = "/usr/sbin/service udisks2 stop > /dev/null 2>&1";
     }
 
     if ($u_status_cmd) {
@@ -78,10 +78,10 @@ sub udisks2_restart {
     if ( $status eq 3 ) {
         print "Restarting udisks2 service.\n";
         if ( -e "/usr/bin/systemctl" ) {
-            system("/usr/bin/systemctl start udisks2 >& /dev/null");
+            system("/usr/bin/systemctl start udisks2 > /dev/null 2>&1");
         }
         elsif ( -e "/usr/sbin/service" ) {
-            system("/usr/sbin/service udisks2 start >& /dev/null");
+            system("/usr/sbin/service udisks2 start > /dev/null 2>&1");
         }
     }
 }
@@ -133,7 +133,7 @@ sub make_fs {
     attach_dev( $mk_dev, $mk_dir );
 
     print "Make $mk_type filesystem on $mk_dev\n";
-    $result = system("yes | mkfs.$mk_type $mk_dev >& /dev/null");
+    $result = system("yes | mkfs.$mk_type $mk_dev > /dev/null 2>&1");
     if ( $result != 0 ) {
         system("losetup -d $mk_dev 2>/dev/null");
         print "mkfs.$mk_type failed to create filesystem on $mk_dev\n";
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index f09b4e3..df883d9 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -59,7 +59,7 @@ sub server_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/flag");
+    system("bash -c 'read -t 5 <>$basedir/flag'");
     return $pid;
 }
 
diff --git a/tests/ptrace/test b/tests/ptrace/test
index 78589c6..2de3a3c 100755
--- a/tests/ptrace/test
+++ b/tests/ptrace/test
@@ -10,12 +10,12 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
     exec
-"runcon -t test_ptrace_traced_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+"exec runcon -t test_ptrace_traced_t sh -c 'echo >$basedir/flag; while :; do :; done'";
     exit;
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that the nottracer domain cannot attach to the process.
 # Should fail on the ptrace permission check.
diff --git a/tests/sctp/test b/tests/sctp/test
index e28d214..13358ae 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -120,7 +120,7 @@ sub server_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/flag");
+    system("bash -c 'read -t 5 <>$basedir/flag'");
     return $pid;
 }
 
diff --git a/tests/sigkill/test b/tests/sigkill/test
index 6c7289a..e90af13 100755
--- a/tests/sigkill/test
+++ b/tests/sigkill/test
@@ -13,7 +13,7 @@ if ( ( $pid = fork() ) == 0 ) {
 }
 
 # Wait for it to initialize.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_kill_signal_t cannot send CHLD, STOP, or KILL to the server.
 $result = system "runcon -t test_kill_signal_t -- kill -s CHLD $pid 2>&1";
diff --git a/tests/task_getpgid/test b/tests/task_getpgid/test
index ff9ccc6..4b675e9 100755
--- a/tests/task_getpgid/test
+++ b/tests/task_getpgid/test
@@ -10,11 +10,11 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
     exec
-"runcon -t test_getpgid_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+"exec runcon -t test_getpgid_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_getpgid_yes_t can get the target's process group ID.
 $result = system "runcon -t test_getpgid_yes_t -- $basedir/source $pid 2>&1";
diff --git a/tests/task_getscheduler/test b/tests/task_getscheduler/test
index ce7f047..6c58ff1 100755
--- a/tests/task_getscheduler/test
+++ b/tests/task_getscheduler/test
@@ -10,11 +10,11 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
     exec
-"runcon -t test_getsched_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+"exec runcon -t test_getsched_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_getsched_yes_t can get the scheduling.
 # SCHED_OTHER	0	priority must == 0
diff --git a/tests/task_getsid/test b/tests/task_getsid/test
index 16190c5..125060d 100755
--- a/tests/task_getsid/test
+++ b/tests/task_getsid/test
@@ -10,11 +10,11 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
     exec
-"runcon -t test_getsid_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+"exec runcon -t test_getsid_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_getsid_yes_t can get the session ID.
 $result = system "runcon -t test_getsid_yes_t -- $basedir/source $pid 2>&1";
diff --git a/tests/task_setnice/test b/tests/task_setnice/test
index 09352ed..2dbb18c 100755
--- a/tests/task_setnice/test
+++ b/tests/task_setnice/test
@@ -10,11 +10,11 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
     exec
-"runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+"exec runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_setsched_yes_t can change the priority up and down.
 $result = system "runcon -t test_setsched_yes_t -- renice +10 -p $pid 2>&1";
diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
index fa7d9cb..4bd7710 100755
--- a/tests/task_setscheduler/test
+++ b/tests/task_setscheduler/test
@@ -10,11 +10,11 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
     exec
-"runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do sleep 1; done'";
+"exec runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do sleep 1; done'";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 $cgroup_cpu = "/sys/fs/cgroup/cpu/tasks";
 if ( -w $cgroup_cpu ) {
diff --git a/tests/unix_socket/test b/tests/unix_socket/test
index c48d1ad..fc3ddf7 100755
--- a/tests/unix_socket/test
+++ b/tests/unix_socket/test
@@ -38,7 +38,7 @@ sub server_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/flag");
+    system("bash -c 'read -t 5 <>$basedir/flag'");
     return $pid;
 }
 
diff --git a/tests/vsock_socket/test b/tests/vsock_socket/test
index 41d9bc8..70fde70 100755
--- a/tests/vsock_socket/test
+++ b/tests/vsock_socket/test
@@ -34,7 +34,7 @@ sub server_start {
     }
 
     # Wait for it to initialize, read port number.
-    my $port = `read -t 5 <>$basedir/flag; echo \$REPLY`;
+    my $port = `bash -c 'read -t 5 <>$basedir/flag; echo \$REPLY'`;
 
     return ( $pid, $port );
 }
-- 
2.36.1

