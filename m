Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1FC43333
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E709664EC3
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhCCEJc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349654AbhCBLBe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Mar 2021 06:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614682765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d2tTfbp98Gdjj/oFSYChzTqiZwvI/CUYfUkGGTcVKYA=;
        b=XpsAfMS6CJJcm6N3HVsUOyyKHM3radgOYCeXRpAhazpkFY+gAXbM+UNBZyEdCLXlLGC4dE
        KMDEUnkHZiN2uqLqcZMqBq/dKfXqWQYThv8Iuo/BzSVas/Na5Qg36b1kEb9jNpqLzJqnCF
        nMeydruFq7YEzuC8RKPPlApd6hdAXIU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-zpdwrpOfNPyQVvzGRO1_Rg-1; Tue, 02 Mar 2021 05:59:22 -0500
X-MC-Unique: zpdwrpOfNPyQVvzGRO1_Rg-1
Received: by mail-ej1-f72.google.com with SMTP id ml13so8287537ejb.2
        for <selinux@vger.kernel.org>; Tue, 02 Mar 2021 02:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2tTfbp98Gdjj/oFSYChzTqiZwvI/CUYfUkGGTcVKYA=;
        b=pey6Oe9F8JJL98QPykT5Ngl8twfwoYv01MjmeEXhNJG+FBL9CaQMsrGcgaPq5+k1oU
         JTlLoKvABdMFbDJLUi0wz/UwUUCjL9OxWhcsFa2l6CGETVXRYkjDiS1Hq1ZvoLELVLxi
         F+YdBMLle6mmAK8I8lkgi07M/88kGpYLwe00XnfLtuv2QMQ8lLtTybccvCih+UY0Zp41
         9p9Ia92Mm6Fg9YQ19lAbt4Wvq1PThmjDH8ZFoP5OLdNzGgs2gORHC9E1gAaOt3wp40tU
         ElEPQxGwgAXKh2MjZwQz0OTqOhfEXbQtQp8usz6/BGsZPpvPPbnGraOWIgbZ2X7OChqJ
         5pIA==
X-Gm-Message-State: AOAM532zHq1xFctVoKcjvOhn2t0i33uUI+mztL72eRdERz8OdlVmLcJs
        bQrBoVJMR/DUhME5ZtO8wOjvDrDoETYThCbfT0FEWpoV0mqRdiU81kf91BWDjKWSMJ2s1EBGEAx
        sfg0s90+N7TzeldvJUVWJWH45lsEdnnNcglHfJ6kyCfPblViWwY5RreVsE4RNUiSoFMrurw==
X-Received: by 2002:a17:906:3fc3:: with SMTP id k3mr20438109ejj.522.1614682760462;
        Tue, 02 Mar 2021 02:59:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCRmPP6AQAGa+BMvoPE14/V5uO9YMLPtD8E88CjVUEX5kDo+jPlI8CZV9SCRnF8P0lOOWd/A==
X-Received: by 2002:a17:906:3fc3:: with SMTP id k3mr20438096ejj.522.1614682760227;
        Tue, 02 Mar 2021 02:59:20 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id n2sm17789267ejl.1.2021.03.02.02.59.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:59:19 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] lockdown: use debugfs/tracefs to test lockdown permissions
Date:   Tue,  2 Mar 2021 11:59:17 +0100
Message-Id: <20210302105917.402896-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The system policy interfaces for things that require lockdown
permissions will likely grant those permissions, too, so we need to
open-code them. Thus, use tracefs/debugfs access to test lockdown, as
the interfaces for these are easier to open-code.

With this patch, the lockdown test passes with latest Fedora policy in
Rawhide.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 defconfig               |  5 +++++
 policy/test_lockdown.te | 16 ++++++++--------
 policy/test_policy.if   | 17 +++++++++++++++++
 tests/lockdown/test     | 21 +++++++++++++--------
 4 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/defconfig b/defconfig
index 46eb673..ca7a877 100644
--- a/defconfig
+++ b/defconfig
@@ -117,3 +117,8 @@ CONFIG_VFAT_FS=m
 # They are not required for SELinux operation itself.
 CONFIG_WATCH_QUEUE=y
 CONFIG_KEY_NOTIFICATIONS=y
+
+# Test lockdown permissions (via tracefs and debugfs).
+# This is not required for SELinux operation itself.
+CONFIG_TRACING=y
+CONFIG_DEBUG_FS=y
diff --git a/policy/test_lockdown.te b/policy/test_lockdown.te
index a7a4b6b..1ec985e 100644
--- a/policy/test_lockdown.te
+++ b/policy/test_lockdown.te
@@ -12,8 +12,8 @@ unconfined_runs_test(test_lockdown_all_t)
 typeattribute test_lockdown_all_t lockdowndomain;
 typeattribute test_lockdown_all_t testdomain;
 
-dev_read_raw_memory(test_lockdown_all_t)
-kernel_read_core_if(test_lockdown_all_t)
+testsuite_read_debugfs_nolockdown(test_lockdown_all_t)
+testsuite_read_tracefs_nolockdown(test_lockdown_all_t)
 corecmd_bin_entry_type(test_lockdown_all_t)
 allow test_lockdown_all_t self:lockdown integrity;
 allow test_lockdown_all_t self:lockdown confidentiality;
@@ -25,8 +25,8 @@ unconfined_runs_test(test_lockdown_integrity_t)
 typeattribute test_lockdown_integrity_t lockdowndomain;
 typeattribute test_lockdown_integrity_t testdomain;
 
-dev_read_raw_memory(test_lockdown_integrity_t)
-kernel_read_core_if(test_lockdown_integrity_t)
+testsuite_read_debugfs_nolockdown(test_lockdown_integrity_t)
+testsuite_read_tracefs_nolockdown(test_lockdown_integrity_t)
 corecmd_bin_entry_type(test_lockdown_integrity_t)
 allow test_lockdown_integrity_t self:lockdown integrity;
 
@@ -37,8 +37,8 @@ unconfined_runs_test(test_lockdown_confidentiality_t)
 typeattribute test_lockdown_confidentiality_t lockdowndomain;
 typeattribute test_lockdown_confidentiality_t testdomain;
 
-dev_read_raw_memory(test_lockdown_confidentiality_t)
-kernel_read_core_if(test_lockdown_confidentiality_t)
+testsuite_read_debugfs_nolockdown(test_lockdown_confidentiality_t)
+testsuite_read_tracefs_nolockdown(test_lockdown_confidentiality_t)
 corecmd_bin_entry_type(test_lockdown_confidentiality_t)
 allow test_lockdown_confidentiality_t self:lockdown confidentiality;
 
@@ -49,6 +49,6 @@ unconfined_runs_test(test_lockdown_none_t)
 typeattribute test_lockdown_none_t lockdowndomain;
 typeattribute test_lockdown_none_t testdomain;
 
-dev_read_raw_memory(test_lockdown_none_t)
-kernel_read_core_if(test_lockdown_none_t)
+testsuite_read_debugfs_nolockdown(test_lockdown_none_t)
+testsuite_read_tracefs_nolockdown(test_lockdown_none_t)
 corecmd_bin_entry_type(test_lockdown_none_t)
diff --git a/policy/test_policy.if b/policy/test_policy.if
index e3c01c8..7023e30 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -87,3 +87,20 @@ interface(`userdom_search_admin_dir', `
 ifdef(`kernel_request_load_module', `', ` dnl
 interface(`kernel_request_load_module', `')
 ')
+
+# We need to open-code these interfaces, because the system-provided ones will
+# likely grant the lockdown permissions we want to test.
+interface(`testsuite_read_debugfs_nolockdown',`
+	gen_require(`
+		type debugfs_t;
+	')
+
+	read_files_pattern($1, debugfs_t, debugfs_t)
+')
+interface(`testsuite_read_tracefs_nolockdown',`
+	gen_require(`
+		type tracefs_t;
+	')
+
+	read_files_pattern($1, tracefs_t, tracefs_t)
+')
diff --git a/tests/lockdown/test b/tests/lockdown/test
index 0b81cb1..6694a4c 100755
--- a/tests/lockdown/test
+++ b/tests/lockdown/test
@@ -3,40 +3,45 @@
 use Test;
 BEGIN { plan tests => 8 }
 
+$integrity_cmd       = "head -c 1 /sys/kernel/debug/sched_features";
+$confidentiality_cmd = "head -c 1 /sys/kernel/debug/tracing/tracing_on";
+
 # everything is allowed
 $result =
-  system "runcon -t test_lockdown_all_t -- head /dev/mem > /dev/null 2>&1";
+  system "runcon -t test_lockdown_all_t -- $integrity_cmd > /dev/null 2>&1";
 ok( $result, 0 );
 
 $result =
-  system "runcon -t test_lockdown_all_t -- head /proc/kcore > /dev/null 2>&1";
+  system
+  "runcon -t test_lockdown_all_t -- $confidentiality_cmd > /dev/null 2>&1";
 ok( $result, 0 );
 
 # only integrity operations allowed
 $result = system
-  "runcon -t test_lockdown_integrity_t -- head /dev/mem > /dev/null 2>&1";
+  "runcon -t test_lockdown_integrity_t -- $integrity_cmd > /dev/null 2>&1";
 ok( $result, 0 );
 
 $result = system
-  "runcon -t test_lockdown_integrity_t -- head /proc/kcore > /dev/null 2>&1";
+"runcon -t test_lockdown_integrity_t -- $confidentiality_cmd > /dev/null 2>&1";
 ok($result);
 
 # only confidentiality operations allowed
 $result = system
-  "runcon -t test_lockdown_confidentiality_t -- head /dev/mem > /dev/null 2>&1";
+"runcon -t test_lockdown_confidentiality_t -- $integrity_cmd > /dev/null 2>&1";
 ok($result);
 
 $result = system
-"runcon -t test_lockdown_confidentiality_t -- head /proc/kcore > /dev/null 2>&1";
+"runcon -t test_lockdown_confidentiality_t -- $confidentiality_cmd > /dev/null 2>&1";
 ok( $result, 0 );
 
 # nothing is allowed
 $result =
-  system "runcon -t test_lockdown_none_t -- head /dev/mem > /dev/null 2>&1";
+  system "runcon -t test_lockdown_none_t -- $integrity_cmd > /dev/null 2>&1";
 ok($result);
 
 $result =
-  system "runcon -t test_lockdown_none_t -- head /proc/kcore > /dev/null 2>&1";
+  system
+  "runcon -t test_lockdown_none_t -- $confidentiality_cmd > /dev/null 2>&1";
 ok($result);
 
 exit;
-- 
2.29.2

