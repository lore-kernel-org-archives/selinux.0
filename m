Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E01CCA480
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353921AbiFNKUq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241060AbiFNKUn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 06:20:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08284754D
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s12so16246298ejx.3
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyEGGrynwPPAJH0lUD5qlNsw/KMP8bFHuEGs0AaiA6k=;
        b=gbzqOeOu5UdpR56ajFbHTgql9/wLdhl4l1qLL2qyvzZFIIdJdBbwTfLQh0sGnX2ra/
         79BNBPTtzGK/2p0r9opQ2s42v1WSHX/ksvYBTh2Egd8uS/6IVgtp9A6TzNMiuTdic2k5
         iI59lGnx1XWt4S6IbnJOSQBjtAoZNpN17yd6cVEEbYF4njsXMMwqU9LAzsofcgccQYO7
         lsl+puzug5wFIlsJa2P4/GfAr7JxxAPdCOpEmUDfhHRl3WdsAt3g9UP5pHwYfBo+aVFM
         4BMrGnp+d6bc4Z+1ZMwK5D8RG7cXWyqIZzOvzZCDIHWmqCWCH7kisGMiEm1x7ljcABnA
         EbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyEGGrynwPPAJH0lUD5qlNsw/KMP8bFHuEGs0AaiA6k=;
        b=J0i0WB+EeUh2csIvb2QozkWSvWKcSUjMHzIZC+wg/dQWvpX1g3diSY6Ss+utq1TSkR
         KxFYHwc7O39OmeR9wY2bMQ1xdZnBaqlkSOvMH+UA5IecTbCb6b1PDBYmmU5DjRMOYlad
         lH3za3NphNLREDJEV3RRYdiU5AfuQ21nwSNP7Wc/pbJhvFoJcDCm2ZHycCDX3ZyGhP2F
         8+SvZ8UVHpX4Wr3mpaoF5gYhUCHi0BxUYfQe55FeGILmkgLTi+OvvX+1bJy5SnFUtiqp
         KozSvVkVoYKka0FRQ80f66oSKSCBgX/bRdfJemaIkxbKdHbglIkBbLL83gprYqFJke9y
         H7qA==
X-Gm-Message-State: AOAM531rofyj/csbrZavjn5Nr4iatp8rFqjpc4dcGzbUbkajsoaxClBQ
        s4/dRz7m0s7xkKMZpcioL6Efo8g71IA=
X-Google-Smtp-Source: AGRyM1u3nqQbYAe5Nxt3EV1ShEUzcb2v0GI1PH46r85F5VxMvtbXnoewZ/wTWevOcFclqslSeLGHDg==
X-Received: by 2002:a17:906:7c0c:b0:6f9:1fc:ebf3 with SMTP id t12-20020a1709067c0c00b006f901fcebf3mr3667096ejo.403.1655202037095;
        Tue, 14 Jun 2022 03:20:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-087-232.77.1.pool.telefonica.de. [77.1.87.232])
        by smtp.gmail.com with ESMTPSA id gv17-20020a170906f11100b006febc1e9fc8sm4871186ejb.47.2022.06.14.03.20.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:20:36 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] support Dash as default shell
Date:   Tue, 14 Jun 2022 12:20:26 +0200
Message-Id: <20220614102029.13006-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
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
 README.md                      |  7 -------
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
 16 files changed, 34 insertions(+), 41 deletions(-)

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
diff --git a/tests/binder/test b/tests/binder/test
index 14f2096..b35aee1 100755
--- a/tests/binder/test
+++ b/tests/binder/test
@@ -80,7 +80,7 @@ sub service_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/$flag");
+    `bash -c 'read -t 5 <>$basedir/$flag'`;
     return $pid;
 }
 
diff --git a/tests/bpf/test b/tests/bpf/test
index 6ab7686..f3147a8 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -106,7 +106,7 @@ if ( ( $pid = fork() ) == 0 ) {
 }
 
 # Wait for it to initialize.
-system("read -t 5 <>$basedir/flag");
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 # Test BPF map & prog fd on transfer:
 $result = system
@@ -149,7 +149,7 @@ sub service_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/$flag");
+    `bash -c 'read -t 5 <>$basedir/$flag'`;
     return $pid;
 }
 
diff --git a/tests/fdreceive/test b/tests/fdreceive/test
index 2415361..4451f7d 100755
--- a/tests/fdreceive/test
+++ b/tests/fdreceive/test
@@ -22,7 +22,7 @@ if ( ( $pid = fork() ) == 0 ) {
 }
 
 # Wait for it to initialize.
-system("read -t 5 <>$basedir/flag");
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
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
index f09b4e3..18b1014 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -59,7 +59,7 @@ sub server_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/flag");
+    `bash -c 'read -t 5 <>$basedir/flag'`;
     return $pid;
 }
 
diff --git a/tests/ptrace/test b/tests/ptrace/test
index 78589c6..dbbfe5f 100755
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
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 # Verify that the nottracer domain cannot attach to the process.
 # Should fail on the ptrace permission check.
diff --git a/tests/sctp/test b/tests/sctp/test
index e28d214..078f762 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -120,7 +120,7 @@ sub server_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/flag");
+    `bash -c 'read -t 5 <>$basedir/flag'`;
     return $pid;
 }
 
diff --git a/tests/sigkill/test b/tests/sigkill/test
index 6c7289a..cd50952 100755
--- a/tests/sigkill/test
+++ b/tests/sigkill/test
@@ -13,7 +13,7 @@ if ( ( $pid = fork() ) == 0 ) {
 }
 
 # Wait for it to initialize.
-system("read -t 5 <>$basedir/flag");
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 # Verify that test_kill_signal_t cannot send CHLD, STOP, or KILL to the server.
 $result = system "runcon -t test_kill_signal_t -- kill -s CHLD $pid 2>&1";
diff --git a/tests/task_getpgid/test b/tests/task_getpgid/test
index ff9ccc6..d1d1847 100755
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
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 # Verify that test_getpgid_yes_t can get the target's process group ID.
 $result = system "runcon -t test_getpgid_yes_t -- $basedir/source $pid 2>&1";
diff --git a/tests/task_getscheduler/test b/tests/task_getscheduler/test
index ce7f047..e38dd9e 100755
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
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 # Verify that test_getsched_yes_t can get the scheduling.
 # SCHED_OTHER	0	priority must == 0
diff --git a/tests/task_getsid/test b/tests/task_getsid/test
index 16190c5..30efbfc 100755
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
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 # Verify that test_getsid_yes_t can get the session ID.
 $result = system "runcon -t test_getsid_yes_t -- $basedir/source $pid 2>&1";
diff --git a/tests/task_setnice/test b/tests/task_setnice/test
index 09352ed..ed25884 100755
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
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 # Verify that test_setsched_yes_t can change the priority up and down.
 $result = system "runcon -t test_setsched_yes_t -- renice +10 -p $pid 2>&1";
diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
index fa7d9cb..42a161a 100755
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
+`bash -c 'read -t 5 <>$basedir/flag'`;
 
 $cgroup_cpu = "/sys/fs/cgroup/cpu/tasks";
 if ( -w $cgroup_cpu ) {
diff --git a/tests/unix_socket/test b/tests/unix_socket/test
index c48d1ad..600fc99 100755
--- a/tests/unix_socket/test
+++ b/tests/unix_socket/test
@@ -38,7 +38,7 @@ sub server_start {
     }
 
     # Wait for it to initialize.
-    system("read -t 5 <>$basedir/flag");
+    `bash -c 'read -t 5 <>$basedir/flag'`;
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

