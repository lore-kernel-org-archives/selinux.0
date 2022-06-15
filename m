Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91599C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 12:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiFOM1Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348483AbiFOM1V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 08:27:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15D42496
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq6so22879028ejb.11
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PT0gnIdyqzvvHf8lbqq/E54d3Q5OywAp4K3MJ0E/XxU=;
        b=RnZM+2jGpca6aUEaHJp1g6tp++0wS34dHwxmRRXD4XHzcRkurXQiVBP7erzouXVpT/
         DhPEbqwf2lb6LdJrI2Vw0alo5M/qhmolB54ZTG2cE1ZBtu2kC33JUY2+/JFBrUFGrWzB
         lvg12sC0i6CNvgwCYVBcPSkDCNTMDrvedx6HwdSpj977Q2K0LSozqi2QBZyUA6wz5CHw
         LdlZhe+29QXGyrWjQd5beabp/E5xaMKCit3ZUOycNh1iehr8xnIUvN7yqlmAE3QB2sK3
         ZNQ1mjsKOR/fX6249EQWwS9ae4lmRANOwAKVdSCHXyEyhfD4y9CS05H1r+TionSBK085
         Xd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PT0gnIdyqzvvHf8lbqq/E54d3Q5OywAp4K3MJ0E/XxU=;
        b=IDOGu6rVgXlnml43hwn58ZQL0vR2rYe4MTOeDpBkEuq9MURJUN26Y8dE7T36hNP18p
         PXLufnQOAnPIuIESRotNuYUr8lVtyH/er1F2DCwWYH1sWyIE1BiBALC8u0MyLoU7EyTW
         Vg+OUtSoQ4qgkaAvuPjCIrYGJOGL9srSKWI5PD7cjQqS0Ra2+KuluDOW3qGBW7x09Z3V
         aQd9b7ZusYpGA6aLVKLGbJ95NjrjhvjMja18zwXiTIdaTPEMGjXfIYIc8O02p+VXuKP1
         9cIf9yhiEYPDLTccdPT4cUqt6E/sdBvS+tSppj97VlIdNmWSKXileA88M68s1nwG0NGo
         hRtw==
X-Gm-Message-State: AOAM531q8to1ikBzwD95oGbrzi0JleL3DHsVeCzh3o2k8ObZfepKTJg6
        8dJ028EMHmfmumwjTLafZBLJGMsPb3s=
X-Google-Smtp-Source: ABdhPJwUAlrZVU/cHILP3GMw71YY6JqhwhgyTRf1UIwm3w07S6nJRCt2tdASBAF/mYenphJ6lpp8EA==
X-Received: by 2002:a17:906:9f1e:b0:711:d8bc:bbc6 with SMTP id fy30-20020a1709069f1e00b00711d8bcbbc6mr8682287ejc.266.1655296037462;
        Wed, 15 Jun 2022 05:27:17 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402028900b0042dd3bf1403sm9190336edv.54.2022.06.15.05.27.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:27:17 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/4] support Dash as default shell
Date:   Wed, 15 Jun 2022 14:27:08 +0200
Message-Id: <20220615122711.9895-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614102029.13006-1-cgzones@googlemail.com>
References: <20220614102029.13006-1-cgzones@googlemail.com>
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
* Call runcon directly to avoid a fork within Dash, which breaks tests
  requiring to not change the PID of executing commands
* Use bash explicitly for non POSIX read option -t

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
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
 tests/ptrace/test              |  6 +++---
 tests/sctp/test                |  2 +-
 tests/sigkill/test             |  2 +-
 tests/task_getpgid/test        |  6 +++---
 tests/task_getscheduler/test   |  6 +++---
 tests/task_getsid/test         |  6 +++---
 tests/task_setnice/test        |  6 +++---
 tests/task_setscheduler/test   |  6 +++---
 tests/unix_socket/test         |  2 +-
 tests/vsock_socket/test        |  2 +-
 17 files changed, 35 insertions(+), 42 deletions(-)

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
index 78589c6..117f260 100755
--- a/tests/ptrace/test
+++ b/tests/ptrace/test
@@ -9,13 +9,13 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 # Start the process to be traced.
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
-    exec
-"runcon -t test_ptrace_traced_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+    exec 'runcon', '-t', 'test_ptrace_traced_t', 'sh', '-c',
+      "echo >$basedir/flag; while :; do :; done";
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
index ff9ccc6..e2032e3 100755
--- a/tests/task_getpgid/test
+++ b/tests/task_getpgid/test
@@ -9,12 +9,12 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 # Start the target process.
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
-    exec
-"runcon -t test_getpgid_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+    exec 'runcon', '-t', 'test_getpgid_target_t', 'sh', '-c',
+      "echo >$basedir/flag; while :; do :; done";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_getpgid_yes_t can get the target's process group ID.
 $result = system "runcon -t test_getpgid_yes_t -- $basedir/source $pid 2>&1";
diff --git a/tests/task_getscheduler/test b/tests/task_getscheduler/test
index ce7f047..909dfa3 100755
--- a/tests/task_getscheduler/test
+++ b/tests/task_getscheduler/test
@@ -9,12 +9,12 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 # Start the target process.
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
-    exec
-"runcon -t test_getsched_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+    exec 'runcon', '-t', 'test_getsched_target_t', 'sh', '-c',
+      "echo >$basedir/flag; while :; do :; done";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_getsched_yes_t can get the scheduling.
 # SCHED_OTHER	0	priority must == 0
diff --git a/tests/task_getsid/test b/tests/task_getsid/test
index 16190c5..2b6350f 100755
--- a/tests/task_getsid/test
+++ b/tests/task_getsid/test
@@ -9,12 +9,12 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 # Start the target process.
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
-    exec
-"runcon -t test_getsid_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+    exec 'runcon', '-t', 'test_getsid_target_t', 'sh', '-c',
+      "echo >$basedir/flag; while :; do :; done";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_getsid_yes_t can get the session ID.
 $result = system "runcon -t test_getsid_yes_t -- $basedir/source $pid 2>&1";
diff --git a/tests/task_setnice/test b/tests/task_setnice/test
index 09352ed..8c101d8 100755
--- a/tests/task_setnice/test
+++ b/tests/task_setnice/test
@@ -9,12 +9,12 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 # Start the process that will have its priority changed.
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
-    exec
-"runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do :; done'";
+    exec 'runcon', '-t', 'test_setsched_target_t', 'sh', '-c',
+      "echo >$basedir/flag; while :; do :; done";
 }
 
 # Wait for it to start.
-system("read -t 5 <>$basedir/flag");
+system("bash -c 'read -t 5 <>$basedir/flag'");
 
 # Verify that test_setsched_yes_t can change the priority up and down.
 $result = system "runcon -t test_setsched_yes_t -- renice +10 -p $pid 2>&1";
diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
index fa7d9cb..0cfb498 100755
--- a/tests/task_setscheduler/test
+++ b/tests/task_setscheduler/test
@@ -9,12 +9,12 @@ $basedir =~ s|(.*)/[^/]*|$1|;
 # Start the process that will have its priority and scheduling changed.
 system("mkfifo $basedir/flag");
 if ( ( $pid = fork() ) == 0 ) {
-    exec
-"runcon -t test_setsched_target_t sh -c 'echo >$basedir/flag; while :; do sleep 1; done'";
+    exec 'runcon', '-t', 'test_setsched_target_t', 'sh', '-c',
+      "echo >$basedir/flag; while :; do sleep 1; done";
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

