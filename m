Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51184C433FE
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 11:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34753615E0
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 11:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350372AbhI3L20 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350517AbhI3L20 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Sep 2021 07:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633001203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q7O+xml7JEbkOxFlD5x74LCfWMKlJUal6oDoSVxjSlY=;
        b=JyAPDc//kUp3SM0l87Leu+8FJapqkqei2mzCxSBpcI8EGCEfzr8HqB2DFtRr4ysZ6xCWp5
        dbV2IEH36uObS95LYxD27Qjexu73XPwIOR3NSOHaO7+JQ8AFnPqjFowwVBiKlEAX83shQB
        FOTBkAujuqoEHWMzWoX8IeX4qW+NFRg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-w4hSL4lSMl6SeuCNusW8kA-1; Thu, 30 Sep 2021 07:26:42 -0400
X-MC-Unique: w4hSL4lSMl6SeuCNusW8kA-1
Received: by mail-wm1-f70.google.com with SMTP id n30-20020a05600c3b9e00b002fbbaada5d7so4175079wms.7
        for <selinux@vger.kernel.org>; Thu, 30 Sep 2021 04:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7O+xml7JEbkOxFlD5x74LCfWMKlJUal6oDoSVxjSlY=;
        b=0Pz9qz2bLPhOkZOX2pNvYbCBzkWkeu5LAkBxEmRepJUvthJCWzKK0czKkXgh8Fgf+/
         Qnf/wY4p1JNXeSp13/Qdz/LOyPhtLg0bRYbwkqx22NdgrmiyiVOxNaxheUtTGbdPQ+XT
         w0TOG/R+QatEX2WiLl+WkyGSG49L8w6+WnLS94fzFLDJrWJjac6T63q8xvgXkseXgRuR
         rlKW/YP5At8V3U9imaQcq7CUD5E1clZBh+dcsqOOqfw9LVYwsisE+iWUXotYqHR1ETS0
         ktGhUTRS3zssz/cVVYOEFSF7CZKNbByI6uchuQrvwSJ9ew/j12aeuKS/2dVH+rViW847
         UwGA==
X-Gm-Message-State: AOAM53380UD+/rfRt7Kto1ruJjgzLmihDRzP1MkQt4qhj6XSsOXwU/dP
        hdwzqZIhC2gU8fR7FOhNdemoA4jxzoQ2fW6OIQ2/EoH9dO2YS62L7Eyh4dCcupITrEPSbAv5iWd
        cgnkjVO9knLuBqOiW8xY/4byx/On7siw9z0TT7jjDx5idoavRBZDLnu3oEgNAwzFF/qlU1g==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr2437501wmj.183.1633001200778;
        Thu, 30 Sep 2021 04:26:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXUgyM2JgSqrAIYywWYYVb625aXxcYm7BAixOy/t04KBbGV2PxqI117rTJExnh1IyCCLGhYg==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr2437464wmj.183.1633001200330;
        Thu, 30 Sep 2021 04:26:40 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c18sm2696391wmb.27.2021.09.30.04.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:26:39 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite] Remove the lockdown test
Date:   Thu, 30 Sep 2021 13:26:39 +0200
Message-Id: <20210930112639.657328-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The lockdown class is about to be removed from the mainline kernel due
to the difficulty of ensuring that a relevant subject context is
available during each call to the locked_down hook.

Hence remove the lockdown test from the testsuite.

Note that the module_load and perf_event test policy still conditionally
provides rules involving the lockdown class so that these tests can
still work on older kernels.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile         |  3 ++-
 policy/test_lockdown.te | 54 -----------------------------------------
 policy/test_policy.if   | 17 -------------
 tests/Makefile          |  4 ---
 tests/lockdown/Makefile |  2 --
 tests/lockdown/test     | 47 -----------------------------------
 6 files changed, 2 insertions(+), 125 deletions(-)
 delete mode 100644 policy/test_lockdown.te
 delete mode 100644 tests/lockdown/Makefile
 delete mode 100755 tests/lockdown/test

diff --git a/policy/Makefile b/policy/Makefile
index 5e5ccda..66734c6 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -143,8 +143,9 @@ TARGETS += test_perf_event.te
 endif
 endif
 
+# Older kernels may still have the legacy lockdown class, so we need to add
+# the appropriate rules when the policy declares it.
 ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
-TARGETS += test_lockdown.te
 export M4PARAM += -Dlockdown_defined
 endif
 
diff --git a/policy/test_lockdown.te b/policy/test_lockdown.te
deleted file mode 100644
index 1ec985e..0000000
--- a/policy/test_lockdown.te
+++ /dev/null
@@ -1,54 +0,0 @@
-#################################
-#
-# Policy for testing lockdown
-#
-
-attribute lockdowndomain;
-
-# Domain for lockdown (all operations allowed)
-type test_lockdown_all_t;
-domain_type(test_lockdown_all_t)
-unconfined_runs_test(test_lockdown_all_t)
-typeattribute test_lockdown_all_t lockdowndomain;
-typeattribute test_lockdown_all_t testdomain;
-
-testsuite_read_debugfs_nolockdown(test_lockdown_all_t)
-testsuite_read_tracefs_nolockdown(test_lockdown_all_t)
-corecmd_bin_entry_type(test_lockdown_all_t)
-allow test_lockdown_all_t self:lockdown integrity;
-allow test_lockdown_all_t self:lockdown confidentiality;
-
-# Domain for integrity
-type test_lockdown_integrity_t;
-domain_type(test_lockdown_integrity_t)
-unconfined_runs_test(test_lockdown_integrity_t)
-typeattribute test_lockdown_integrity_t lockdowndomain;
-typeattribute test_lockdown_integrity_t testdomain;
-
-testsuite_read_debugfs_nolockdown(test_lockdown_integrity_t)
-testsuite_read_tracefs_nolockdown(test_lockdown_integrity_t)
-corecmd_bin_entry_type(test_lockdown_integrity_t)
-allow test_lockdown_integrity_t self:lockdown integrity;
-
-# Domain for confidentiality
-type test_lockdown_confidentiality_t;
-domain_type(test_lockdown_confidentiality_t)
-unconfined_runs_test(test_lockdown_confidentiality_t)
-typeattribute test_lockdown_confidentiality_t lockdowndomain;
-typeattribute test_lockdown_confidentiality_t testdomain;
-
-testsuite_read_debugfs_nolockdown(test_lockdown_confidentiality_t)
-testsuite_read_tracefs_nolockdown(test_lockdown_confidentiality_t)
-corecmd_bin_entry_type(test_lockdown_confidentiality_t)
-allow test_lockdown_confidentiality_t self:lockdown confidentiality;
-
-# Domain for lockdown (all operations denied)
-type test_lockdown_none_t;
-domain_type(test_lockdown_none_t)
-unconfined_runs_test(test_lockdown_none_t)
-typeattribute test_lockdown_none_t lockdowndomain;
-typeattribute test_lockdown_none_t testdomain;
-
-testsuite_read_debugfs_nolockdown(test_lockdown_none_t)
-testsuite_read_tracefs_nolockdown(test_lockdown_none_t)
-corecmd_bin_entry_type(test_lockdown_none_t)
diff --git a/policy/test_policy.if b/policy/test_policy.if
index 7023e30..e3c01c8 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -87,20 +87,3 @@ interface(`userdom_search_admin_dir', `
 ifdef(`kernel_request_load_module', `', ` dnl
 interface(`kernel_request_load_module', `')
 ')
-
-# We need to open-code these interfaces, because the system-provided ones will
-# likely grant the lockdown permissions we want to test.
-interface(`testsuite_read_debugfs_nolockdown',`
-	gen_require(`
-		type debugfs_t;
-	')
-
-	read_files_pattern($1, debugfs_t, debugfs_t)
-')
-interface(`testsuite_read_tracefs_nolockdown',`
-	gen_require(`
-		type tracefs_t;
-	')
-
-	read_files_pattern($1, tracefs_t, tracefs_t)
-')
diff --git a/tests/Makefile b/tests/Makefile
index cbff490..3f7cae3 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -112,10 +112,6 @@ SUBDIRS += perf_event
 endif
 endif
 
-ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
-SUBDIRS += lockdown
-endif
-
 ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
 SUBDIRS += $(addprefix filesystem/,$(FILESYSTEMS))
 ifeq ($(shell grep -q all_filesystem_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
diff --git a/tests/lockdown/Makefile b/tests/lockdown/Makefile
deleted file mode 100644
index e7c006f..0000000
--- a/tests/lockdown/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-all:
-clean:
diff --git a/tests/lockdown/test b/tests/lockdown/test
deleted file mode 100755
index a86c988..0000000
--- a/tests/lockdown/test
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/usr/bin/perl
-
-use Test;
-BEGIN { plan tests => 8 }
-
-$integrity_cmd       = "head -c 1 /sys/kernel/debug/fault_around_bytes";
-$confidentiality_cmd = "head -c 1 /sys/kernel/debug/tracing/tracing_on";
-
-# everything is allowed
-$result =
-  system "runcon -t test_lockdown_all_t -- $integrity_cmd > /dev/null 2>&1";
-ok( $result, 0 );
-
-$result =
-  system
-  "runcon -t test_lockdown_all_t -- $confidentiality_cmd > /dev/null 2>&1";
-ok( $result, 0 );
-
-# only integrity operations allowed
-$result = system
-  "runcon -t test_lockdown_integrity_t -- $integrity_cmd > /dev/null 2>&1";
-ok( $result, 0 );
-
-$result = system
-"runcon -t test_lockdown_integrity_t -- $confidentiality_cmd > /dev/null 2>&1";
-ok($result);
-
-# only confidentiality operations allowed
-$result = system
-"runcon -t test_lockdown_confidentiality_t -- $integrity_cmd > /dev/null 2>&1";
-ok($result);
-
-$result = system
-"runcon -t test_lockdown_confidentiality_t -- $confidentiality_cmd > /dev/null 2>&1";
-ok( $result, 0 );
-
-# nothing is allowed
-$result =
-  system "runcon -t test_lockdown_none_t -- $integrity_cmd > /dev/null 2>&1";
-ok($result);
-
-$result =
-  system
-  "runcon -t test_lockdown_none_t -- $confidentiality_cmd > /dev/null 2>&1";
-ok($result);
-
-exit;
-- 
2.31.1

