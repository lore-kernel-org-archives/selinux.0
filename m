Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C65C43334
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 10:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbiFNKUn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353921AbiFNKUl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 06:20:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3389C47551
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fu3so16207631ejc.7
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8v3lOwdOL3F0eEbpP5W4KoI3XA83qxbQy2tuMQ8utlY=;
        b=L9wFGIOS7/pPJgf45hwLQ6SNVwMzZuFDGXRL3XXXBdrG8eFmp6oBTIkURAEBrcWJXq
         uLzboPlWNvgSKsS4SXU4554WhYK8xn6piyBtuHbOZKRt1h9W721usmrfNmnigDmgwlnB
         3Y9WrDE+A2HeFCDZad/e/vVOr9XzAnBQJon7BUfTNYMkGYV7aCz+mViyyKmlJ/92SOAI
         JgwlS1l2uSirAgX6qEAEQQaZnDdELY8FdhHnS9l3BhNjp6qlsFlv8RjLVLY2xRjLZu0C
         9RvJilJtnMCWbV6hH/oTm4VYOsbXWRZniCCMn/I1ZeihAG2CWx38EJlpMgmYuNBgzv7T
         zx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8v3lOwdOL3F0eEbpP5W4KoI3XA83qxbQy2tuMQ8utlY=;
        b=1QTNFxoGsj8eJW3plRJFIH/HfjXMgLerDUEGkPCCc/XhGPoDO5QBdbB/w5hEMmuBCl
         44VeoPn7xWoFFQSJdh2eSWZkRGIpU6AxyJClowhXF8J1/3kuv5PhKetSG5fWNboYOq8c
         aeyaFTgzdgdN0dXc0mMIVlLKOiR2UJQPi8W0jyhAcAZ8QNXpvSCIkmLhtNR0egYuDu2K
         xTWG3kSHZdjDIItTFRa7J3rk6YjdxW1/j0A7RBzEt7K2KjRNYbGUIaQvqEQPfxS7N9Fp
         GB3Gswl3fqRr98XKERMOBGuaR/gqh0mk61tcnyMihS6UsPsS3lqFtKrvioSFTBhFFVv3
         6Idw==
X-Gm-Message-State: AOAM530zyhmnhtF7pZ7cSK9VBUQ56I23TaPjYhbmJvRR+Nk+M0DSHiRA
        MkH4yurwOYL8TYCs22/9pr0wJYTu+3k=
X-Google-Smtp-Source: ABdhPJyz/hcofYIx8f4lFf+DEFN8K0+6lqtpFggXv1W9/3kOGx8tMWBIwc8j93JUNXyeTexUvaapyQ==
X-Received: by 2002:a17:906:73de:b0:715:784d:2cdd with SMTP id n30-20020a17090673de00b00715784d2cddmr3572644ejl.273.1655202037678;
        Tue, 14 Jun 2022 03:20:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-087-232.77.1.pool.telefonica.de. [77.1.87.232])
        by smtp.gmail.com with ESMTPSA id gv17-20020a170906f11100b006febc1e9fc8sm4871186ejb.47.2022.06.14.03.20.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:20:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] support perf_event_paranoid=3
Date:   Tue, 14 Jun 2022 12:20:27 +0200
Message-Id: <20220614102029.13006-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614102029.13006-1-cgzones@googlemail.com>
References: <20220614102029.13006-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Debian uses a downstream patch[1] to allow further restriction of
perf_event_open, which requires CAP_SYS_ADMIN for all perf_event_open(2)
operations.

[1]: https://salsa.debian.org/kernel-team/linux/-/blob/debian/5.17.3-1/debian/patches/features/all/security-perf-allow-further-restriction-of-perf_event_open.patch

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policy/test_perf_event.te | 29 +++++++++++++++++++++++------
 tests/perf_event/test     | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
index fb05120..dc2b49f 100644
--- a/policy/test_perf_event.te
+++ b/policy/test_perf_event.te
@@ -10,18 +10,29 @@ unconfined_runs_test(test_perf_t)
 typeattribute test_perf_t testdomain;
 typeattribute test_perf_t perfdomain;
 
+allow test_perf_t self:capability { sys_admin };
 allow test_perf_t self:capability2 { perfmon };
 allow test_perf_t self:perf_event { open cpu kernel tracepoint read write };
 allow_lockdown_confidentiality(test_perf_t)
 
 ################# Deny capability2 { perfmon } ##########################
-type test_perf_no_cap_t;
-domain_type(test_perf_no_cap_t)
-unconfined_runs_test(test_perf_no_cap_t)
-typeattribute test_perf_no_cap_t testdomain;
-typeattribute test_perf_no_cap_t perfdomain;
+type test_perf_no_cap_perfmon_t;
+domain_type(test_perf_no_cap_perfmon_t)
+unconfined_runs_test(test_perf_no_cap_perfmon_t)
+typeattribute test_perf_no_cap_perfmon_t testdomain;
+typeattribute test_perf_no_cap_perfmon_t perfdomain;
 
-allow test_perf_no_cap_t self:perf_event { open cpu kernel tracepoint read write };
+allow test_perf_no_cap_perfmon_t self:perf_event { open cpu kernel tracepoint read write };
+
+################# Deny capability { sys_admin } ##########################
+type test_perf_no_cap_sysadmin_t;
+domain_type(test_perf_no_cap_sysadmin_t)
+unconfined_runs_test(test_perf_no_cap_sysadmin_t)
+typeattribute test_perf_no_cap_sysadmin_t testdomain;
+typeattribute test_perf_no_cap_sysadmin_t perfdomain;
+
+allow test_perf_no_cap_sysadmin_t self:capability2 { perfmon };
+allow test_perf_no_cap_sysadmin_t self:perf_event { open cpu kernel tracepoint read write };
 
 ################# Deny perf_event { open } ##########################
 type test_perf_no_open_t;
@@ -30,6 +41,7 @@ unconfined_runs_test(test_perf_no_open_t)
 typeattribute test_perf_no_open_t testdomain;
 typeattribute test_perf_no_open_t perfdomain;
 
+allow test_perf_no_open_t self:capability { sys_admin };
 allow test_perf_no_open_t self:capability2 { perfmon };
 allow test_perf_no_open_t self:perf_event { cpu kernel tracepoint read write };
 
@@ -40,6 +52,7 @@ unconfined_runs_test(test_perf_no_cpu_t)
 typeattribute test_perf_no_cpu_t testdomain;
 typeattribute test_perf_no_cpu_t perfdomain;
 
+allow test_perf_no_cpu_t self:capability { sys_admin };
 allow test_perf_no_cpu_t self:capability2 { perfmon };
 allow test_perf_no_cpu_t self:perf_event { open kernel tracepoint read write };
 allow_lockdown_confidentiality(test_perf_no_cpu_t)
@@ -51,6 +64,7 @@ unconfined_runs_test(test_perf_no_kernel_t)
 typeattribute test_perf_no_kernel_t testdomain;
 typeattribute test_perf_no_kernel_t perfdomain;
 
+allow test_perf_no_kernel_t self:capability { sys_admin };
 allow test_perf_no_kernel_t self:capability2 { perfmon };
 allow test_perf_no_kernel_t self:perf_event { open cpu tracepoint read write };
 
@@ -61,6 +75,7 @@ unconfined_runs_test(test_perf_no_tracepoint_t)
 typeattribute test_perf_no_tracepoint_t testdomain;
 typeattribute test_perf_no_tracepoint_t perfdomain;
 
+allow test_perf_no_tracepoint_t self:capability { sys_admin };
 allow test_perf_no_tracepoint_t self:capability2 { perfmon };
 allow test_perf_no_tracepoint_t self:perf_event { open cpu kernel read write };
 allow_lockdown_confidentiality(test_perf_no_tracepoint_t)
@@ -72,6 +87,7 @@ unconfined_runs_test(test_perf_no_read_t)
 typeattribute test_perf_no_read_t testdomain;
 typeattribute test_perf_no_read_t perfdomain;
 
+allow test_perf_no_read_t self:capability { sys_admin };
 allow test_perf_no_read_t self:capability2 { perfmon };
 allow test_perf_no_read_t self:perf_event { open cpu kernel tracepoint write };
 allow_lockdown_confidentiality(test_perf_no_read_t)
@@ -83,6 +99,7 @@ unconfined_runs_test(test_perf_no_write_t)
 typeattribute test_perf_no_write_t testdomain;
 typeattribute test_perf_no_write_t perfdomain;
 
+allow test_perf_no_write_t self:capability { sys_admin };
 allow test_perf_no_write_t self:capability2 { perfmon };
 allow test_perf_no_write_t self:perf_event { open cpu kernel tracepoint read };
 allow_lockdown_confidentiality(test_perf_no_write_t)
diff --git a/tests/perf_event/test b/tests/perf_event/test
index c336477..5aacdf9 100755
--- a/tests/perf_event/test
+++ b/tests/perf_event/test
@@ -5,8 +5,8 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
-    $test_count = 8;
-    $capability = 0;
+    $cap_perfmon  = 0;
+    $cap_sysadmin = 0;
 
     # allow info to be shown during tests
     $v = $ARGV[0];
@@ -22,8 +22,10 @@ BEGIN {
     $level = `cat /proc/sys/kernel/perf_event_paranoid`;
     chomp($level);
     if ( $level >= 2 ) {    # These tests require CAP_PERFMON
-        $test_count += 1;
-        $capability = 1;
+        $cap_perfmon = 1;
+    }
+    if ( $level >= 3 ) {    # These tests require CAP_SYS_ADMIN
+        $cap_sysadmin = 1;
     }
 
     if ( $v eq "-v" ) {
@@ -32,12 +34,15 @@ BEGIN {
             print "\tNot paranoid\n";
         }
         elsif ( $level eq 0 ) {
-            print "\tDisallow raw tracepoint/ftrace without CAP_SYS_ADMIN\n";
+            print "\tDisallow raw tracepoint/ftrace without CAP_PERFMON\n";
         }
         elsif ( $level eq 1 ) {
-            print "\tDisallow CPU event access without CAP_SYS_ADMIN\n";
+            print "\tDisallow CPU event access without CAP_PERFMON\n";
         }
         elsif ( $level eq 2 ) {
+            print "\tDisallow kernel profiling without CAP_PERFMON\n";
+        }
+        elsif ( $level eq 3 ) {
             print "\tDisallow kernel profiling without CAP_SYS_ADMIN\n";
         }
         else {
@@ -45,7 +50,7 @@ BEGIN {
         }
     }
 
-    plan tests => $test_count;
+    plan tests => 10;
 }
 
 # find some CPU that is online
@@ -67,13 +72,25 @@ print "Test perf_event\n";
 $result = system "runcon -t test_perf_t $basedir/perf_event $v $cpu $event_id";
 ok( $result eq 0 );
 
-if ($capability) {
+# Deny capability { perfmon } - EACCES perf_event_open(2) if perf_event_paranoid >= 2
+$result = system
+"runcon -t test_perf_no_cap_perfmon_t $basedir/perf_event $v $cpu $event_id 2>&1";
+if ($cap_perfmon) {
+    ok( $result >> 8 eq 1 );
+}
+else {
+    ok( $result eq 0 );
+}
 
-    # Deny capability { perfmon } - EACCES perf_event_open(2)
-    $result = system
-      "runcon -t test_perf_no_cap_t $basedir/perf_event $v $cpu $event_id 2>&1";
+# Deny capability { sys_admin } - EACCES perf_event_open(2) if perf_event_paranoid >= 3
+$result = system
+"runcon -t test_perf_no_cap_sysadmin_t $basedir/perf_event $v $cpu $event_id 2>&1";
+if ($cap_sysadmin) {
     ok( $result >> 8 eq 1 );
 }
+else {
+    ok( $result eq 0 );
+}
 
 # Deny perf_event { open } - EACCES perf_event_open(2)
 $result =
-- 
2.36.1

