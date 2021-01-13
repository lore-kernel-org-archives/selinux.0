Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81250C433DB
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 10:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DB8206EC
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 10:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAMKTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:19:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbhAMKTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 05:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610533067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LKzB1uZMIIVa5UzH3QJxuOtzAlHtoqyYhwAWMiEQlak=;
        b=Iu6mBLX7Xvd9+LLy7/eH0+cbt3dpWbiyYgiZ21rA4d4ZW/lICOHNslB1dHfmo0WApMkGC/
        mwxOVnTqrp878VNfKukPz9stxHl+VAKN6d3Ni0xSUU2HD5xn6ULK4UbN+o09y/NSB10gQZ
        EB3Xd9cc4wlvurznmkvKyu5whjzFIng=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-t7lC_2YcMOWSS-XyNVp-1w-1; Wed, 13 Jan 2021 05:17:45 -0500
X-MC-Unique: t7lC_2YcMOWSS-XyNVp-1w-1
Received: by mail-ed1-f71.google.com with SMTP id f19so637940edq.20
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 02:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKzB1uZMIIVa5UzH3QJxuOtzAlHtoqyYhwAWMiEQlak=;
        b=hcNv4kcJJLo0oDLiPhT3Q5eyvYHyQPq2h5QOkMnuxmrap2V2GLxwnu9EIPHyfcwuR+
         iWEN3x3zq74GiSQFnOIo1evbJFk9N1zJoUxyK09vweo8HcCmMYZ7/S7gGZgiDjfDif3B
         YIRIRq3UBn/HLSSCJuLnFrnlzqucUzg7MvwAu3XFwIMj7ciIWy4Yo900a1IbgMNDFAkD
         p5WRQ7LNSNC4ckSSQ8x6t2J1gBK0WFr/wIP+05kRyhwegZv33KqqHkFTkl36nl6dugD9
         7HJsutlkrTcjyfHLF2zZokL4ehgJH9k/Mk29keInW6l3kNEtn3Idwva3glj6rDyTdoHI
         8UzA==
X-Gm-Message-State: AOAM531f/jQsG4CiI2wT27fU+Z59+HgzUisOHDLTVE5ln4zaFmxl0ml4
        tNw9ZoD1IqGtPoWtmtdaLJjl6A436nIHWRCzYB4H5odYiPlCOCPzQjajsxQy661LaO3hvtiqvmm
        kSCFNcSKZ36k3AONUoNcLaa1MOQ/DmNAWpTJy7cQXgXHLL8Oqf79clASqkdN+ag5pzE48OQ==
X-Received: by 2002:a17:906:d146:: with SMTP id br6mr1015447ejb.331.1610533064125;
        Wed, 13 Jan 2021 02:17:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4d1Q7SzcQbOcNhV/kY7pNPkELNqKGoLJPV6RnLfMY0MjR6CeVO87CkRlYTpvUdlRj99/D2Q==
X-Received: by 2002:a17:906:d146:: with SMTP id br6mr1015430ejb.331.1610533063883;
        Wed, 13 Jan 2021 02:17:43 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id rl7sm523804ejb.107.2021.01.13.02.17.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 02:17:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2] perf_event: update perf_event test for the new CAP_PERFMON capability
Date:   Wed, 13 Jan 2021 11:17:42 +0100
Message-Id: <20210113101742.49397-1-omosnace@redhat.com>
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

v2: fix syntax check warning

 policy/Makefile           |  2 ++
 policy/test_perf_event.te | 28 ++++++++++++++--------------
 tests/Makefile            |  2 ++
 tests/perf_event/test     |  3 +--
 4 files changed, 19 insertions(+), 16 deletions(-)

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
index 1c2e4a9..1d337e9 100755
--- a/tests/perf_event/test
+++ b/tests/perf_event/test
@@ -56,8 +56,7 @@ ok( $result eq 0 );
 if ($sys_admin) {
 
     # Deny capability { sys_admin } - EACCES perf_event_open(2)
-    $result =
-      system "runcon -t test_perf_no_admin_t $basedir/perf_event $v 2>&1";
+    $result = system "runcon -t test_perf_no_cap_t $basedir/perf_event $v 2>&1";
     ok( $result >> 8 eq 1 );
 }
 
-- 
2.29.2

