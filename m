Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F2C4332B
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0382311B
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 17:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392107AbhALRDk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392105AbhALRDk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 12:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610470932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xEvdA70b+DzeIvzpotiBo1OMz/nPUew1K+0LEtImoGM=;
        b=WyTa4IPH/j2vK2Uy2ZkcG7JobOsfG2ztLJvcvGIGPKkqweIhSceuerKzbVjbRODB/BtU9+
        SaWi1iEisNjt5ldJTslCL07w0rCuIyrAyDPyNZAzMbMX6TDoqiaD2qz3s5HOXsTo/Z6EYh
        qjIKyXd/MSvSzJCV4r94b30J3STPp1E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-6ZeeAPd5NMC3VFvoPcd8lA-1; Tue, 12 Jan 2021 12:02:11 -0500
X-MC-Unique: 6ZeeAPd5NMC3VFvoPcd8lA-1
Received: by mail-ed1-f72.google.com with SMTP id cm4so1288063edb.0
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 09:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEvdA70b+DzeIvzpotiBo1OMz/nPUew1K+0LEtImoGM=;
        b=FeTnaYPXeTqpsssucN8OuTo4rxJQygQGekiCt6Fcg+2vqXhR1Un/zmDHGMRoa5OVOP
         uGc1R7m6cMkkt2OFimx9QnBhSoPOqLrkYSQtf2Spghgb1M/BlXRzSZEgNZgKVo77fbrF
         k+pu5OEwLQilnbkGBDRcA79MA/tk4fH3rqH317P+8hMrajc5pVnLZhflUPGqEjqNOOw+
         d1ZS3jJ0QIhCHWa3yy51qvPncQmSbz0rHciUwTmQPeFHiKLxNDMGYtHNnsfOZGZZB/Nw
         5x1Fi8h34u3Llcisvjwo6I/JfB1MvFfTyzfyWoMTT9iEqSpy7E8i6TO+NrT1a0Fzv/lJ
         4M+A==
X-Gm-Message-State: AOAM532/bpk359/2UTdqfkCD7nV6AGPlp2uF+LUE2Zwe8RnT1XO7QbbR
        hqSZUEisCw6oi2ossvqqAMX5idbBOp5faTwy9sqOOSO5QDZh+gwUx4XaIBDAmsIvC5V0u7mMbZO
        aYs2CYsfVzLfuc0swsdgoaw47F8mNQEuRyVw+D19A8awOX23HkVhvsvVKflqZd84Lmgp+XA==
X-Received: by 2002:a50:8a90:: with SMTP id j16mr79246edj.334.1610470929599;
        Tue, 12 Jan 2021 09:02:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyDHJGwpmID7vGEmchAGLYPUhl79CLGRmOSBC8qi63KuMX4RczqOR1Etpey2J8Bo3/qcZhlA==
X-Received: by 2002:a50:8a90:: with SMTP id j16mr79236edj.334.1610470929364;
        Tue, 12 Jan 2021 09:02:09 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bm12sm1423257ejb.117.2021.01.12.09.02.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:02:08 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] perf_event: update perf_event test for the new CAP_PERFMON capability
Date:   Tue, 12 Jan 2021 18:02:07 +0100
Message-Id: <20210112170207.642289-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Only run the test if the new capability is defined in the policy and
grant it to the test domains instead of CAP_SYS_ADMIN. Even though
CAP_SYS_ADMIN should still allow everything that CAP_PERFMON allows,
this backwards compat fallback might be dropped in the future, so let's
use only CAP_PERFMON in the test.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile           |  2 ++
 policy/test_perf_event.te | 28 ++++++++++++++--------------
 tests/Makefile            |  2 ++
 tests/perf_event/test     |  2 +-
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index 6c49091..fb16a35 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -126,8 +126,10 @@ TARGETS += test_tun_tap.te
 endif
 
 ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifeq ($(shell grep -q perfmon $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS += test_perf_event.te
 endif
+endif
 
 ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS += test_lockdown.te
diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
index 275cebf..fb05120 100644
--- a/policy/test_perf_event.te
+++ b/policy/test_perf_event.te
@@ -10,18 +10,18 @@ unconfined_runs_test(test_perf_t)
 typeattribute test_perf_t testdomain;
 typeattribute test_perf_t perfdomain;
 
-allow test_perf_t self:capability { sys_admin };
+allow test_perf_t self:capability2 { perfmon };
 allow test_perf_t self:perf_event { open cpu kernel tracepoint read write };
 allow_lockdown_confidentiality(test_perf_t)
 
-################# Deny capability { sys_admin } ##########################
-type test_perf_no_admin_t;
-domain_type(test_perf_no_admin_t)
-unconfined_runs_test(test_perf_no_admin_t)
-typeattribute test_perf_no_admin_t testdomain;
-typeattribute test_perf_no_admin_t perfdomain;
+################# Deny capability2 { perfmon } ##########################
+type test_perf_no_cap_t;
+domain_type(test_perf_no_cap_t)
+unconfined_runs_test(test_perf_no_cap_t)
+typeattribute test_perf_no_cap_t testdomain;
+typeattribute test_perf_no_cap_t perfdomain;
 
-allow test_perf_no_admin_t self:perf_event { open cpu kernel tracepoint read write };
+allow test_perf_no_cap_t self:perf_event { open cpu kernel tracepoint read write };
 
 ################# Deny perf_event { open } ##########################
 type test_perf_no_open_t;
@@ -30,7 +30,7 @@ unconfined_runs_test(test_perf_no_open_t)
 typeattribute test_perf_no_open_t testdomain;
 typeattribute test_perf_no_open_t perfdomain;
 
-allow test_perf_no_open_t self:capability { sys_admin };
+allow test_perf_no_open_t self:capability2 { perfmon };
 allow test_perf_no_open_t self:perf_event { cpu kernel tracepoint read write };
 
 ################# Deny perf_event { cpu } ##########################
@@ -40,7 +40,7 @@ unconfined_runs_test(test_perf_no_cpu_t)
 typeattribute test_perf_no_cpu_t testdomain;
 typeattribute test_perf_no_cpu_t perfdomain;
 
-allow test_perf_no_cpu_t self:capability { sys_admin };
+allow test_perf_no_cpu_t self:capability2 { perfmon };
 allow test_perf_no_cpu_t self:perf_event { open kernel tracepoint read write };
 allow_lockdown_confidentiality(test_perf_no_cpu_t)
 
@@ -51,7 +51,7 @@ unconfined_runs_test(test_perf_no_kernel_t)
 typeattribute test_perf_no_kernel_t testdomain;
 typeattribute test_perf_no_kernel_t perfdomain;
 
-allow test_perf_no_kernel_t self:capability { sys_admin };
+allow test_perf_no_kernel_t self:capability2 { perfmon };
 allow test_perf_no_kernel_t self:perf_event { open cpu tracepoint read write };
 
 ################# Deny perf_event { tracepoint } ##########################
@@ -61,7 +61,7 @@ unconfined_runs_test(test_perf_no_tracepoint_t)
 typeattribute test_perf_no_tracepoint_t testdomain;
 typeattribute test_perf_no_tracepoint_t perfdomain;
 
-allow test_perf_no_tracepoint_t self:capability { sys_admin };
+allow test_perf_no_tracepoint_t self:capability2 { perfmon };
 allow test_perf_no_tracepoint_t self:perf_event { open cpu kernel read write };
 allow_lockdown_confidentiality(test_perf_no_tracepoint_t)
 
@@ -72,7 +72,7 @@ unconfined_runs_test(test_perf_no_read_t)
 typeattribute test_perf_no_read_t testdomain;
 typeattribute test_perf_no_read_t perfdomain;
 
-allow test_perf_no_read_t self:capability { sys_admin };
+allow test_perf_no_read_t self:capability2 { perfmon };
 allow test_perf_no_read_t self:perf_event { open cpu kernel tracepoint write };
 allow_lockdown_confidentiality(test_perf_no_read_t)
 
@@ -83,7 +83,7 @@ unconfined_runs_test(test_perf_no_write_t)
 typeattribute test_perf_no_write_t testdomain;
 typeattribute test_perf_no_write_t perfdomain;
 
-allow test_perf_no_write_t self:capability { sys_admin };
+allow test_perf_no_write_t self:capability2 { perfmon };
 allow test_perf_no_write_t self:perf_event { open cpu kernel tracepoint read };
 allow_lockdown_confidentiality(test_perf_no_write_t)
 
diff --git a/tests/Makefile b/tests/Makefile
index 4c00b5f..4484f10 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -107,8 +107,10 @@ SUBDIRS += tun_tap
 endif
 
 ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifeq ($(shell grep -q perfmon $(POLDEV)/include/support/all_perms.spt && echo true),true)
 SUBDIRS += perf_event
 endif
+endif
 
 ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
 SUBDIRS += lockdown
diff --git a/tests/perf_event/test b/tests/perf_event/test
index 1c2e4a9..c7de9bd 100755
--- a/tests/perf_event/test
+++ b/tests/perf_event/test
@@ -57,7 +57,7 @@ if ($sys_admin) {
 
     # Deny capability { sys_admin } - EACCES perf_event_open(2)
     $result =
-      system "runcon -t test_perf_no_admin_t $basedir/perf_event $v 2>&1";
+      system "runcon -t test_perf_no_cap_t $basedir/perf_event $v 2>&1";
     ok( $result >> 8 eq 1 );
 }
 
-- 
2.29.2

