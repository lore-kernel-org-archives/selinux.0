Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443E8C43381
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1689460231
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352837AbhCCEXD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345708AbhCBRXU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Mar 2021 12:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614705683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHNB+5YZgXBfA0K39vt0sHpCGigtHRCAUiPyDemWU5Y=;
        b=bYsTnksvsYzyfN4eioANM2xsp50yNgxBBEUaLbvjvx+nTeRZsXTrl/zwvHV34MHpVw6ml/
        VKsjxOfXgUTDgLpAMQfXu7dQK2vMuFY9DAga71VKSLAWtPBiPBYqPsaTGmZsEcdqGuNqZ9
        E3/rnco0L/CkbYwt768n4kx+aVC0VYE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-_KJsPXgqPoG13KTXVlhpVQ-1; Tue, 02 Mar 2021 12:21:21 -0500
X-MC-Unique: _KJsPXgqPoG13KTXVlhpVQ-1
Received: by mail-ej1-f72.google.com with SMTP id 3so8924512ejx.17
        for <selinux@vger.kernel.org>; Tue, 02 Mar 2021 09:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHNB+5YZgXBfA0K39vt0sHpCGigtHRCAUiPyDemWU5Y=;
        b=tpsmOpjlEh/Uth1rMHeq5g8pspDACU2S0fxB9Zt8xbRGK6Hrjhb92pJFijyzq75r8M
         xT7F98oAD/qoGKXJk47RKFGSB5EhqqbybZTquGg7RwDYCdmh47Bfee0RajV7+d+Vbk3Q
         TXZjB0PleeGT4NkDXf9tQeLcadke3d2CbXRMMSkwZRH95Qx+jsl20uTXBbIEzLeYnw/u
         I0LlA3DZToJEOj1p+rK5Cpu7BSD/5+sy+uywCpcY8sVgzm4Pni6hwFM+YQWJ0m9SQRRv
         fR7uoASUoHSEeOnAEikTduStT4p3/SKjUXgjY0sotqLBIvVwzGgeNjo31ppt0Hn6M2kv
         /LWA==
X-Gm-Message-State: AOAM531SY3P7yimguvG/6tZ30lcteVWn5C13GzK1I4jlVf1t/xmcBk9z
        JqKyAEW+LnOEkvcHGhXsZuRGlRy4VfZ3b9aAY42ULAhrLNdDhJyYr6kRIIdXNb6phrh743+WVv+
        fit9oVQsmeQ06wZvVnKmFKdznSSmwRDLgV2xGz02X10LMQYDargfCG7E6Sg1sXl6tGjjEsQ==
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr16045144ejj.204.1614705680471;
        Tue, 02 Mar 2021 09:21:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvtE1cWfHsNC7O2dFjkaE7ITWawNVgp/oVpVA4Y6kciETS8Q8v+CPX36NhGpEAsk4/K+UPdg==
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr16045132ejj.204.1614705680305;
        Tue, 02 Mar 2021 09:21:20 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id pk5sm17922560ejb.119.2021.03.02.09.21.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:21:19 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 3/3] perf_event: fix CAP_SYS_ADMIN references
Date:   Tue,  2 Mar 2021 18:21:14 +0100
Message-Id: <20210302172114.443689-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302172114.443689-1-omosnace@redhat.com>
References: <20210302172114.443689-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the references to CAP_SYS_ADMIN in comments and variable names to
refer to CAP_PERFMON or just "capability" to avoid confusion. As of
commit 259751492b58 ("perf_event: update perf_event test for the new
CAP_PERFMON capability"), CAP_PERFMON is tested as the main capability
that gates access to perf events, rather than CAP_SYS_ADMIN, which is
now used only as a compatibility fallback.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/perf_event/test | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/perf_event/test b/tests/perf_event/test
index 561a634..380d9cc 100755
--- a/tests/perf_event/test
+++ b/tests/perf_event/test
@@ -6,7 +6,7 @@ BEGIN {
     $basedir =~ s|(.*)/[^/]*|$1|;
 
     $test_count = 8;
-    $sys_admin  = 0;
+    $capability = 0;
 
     # allow info to be shown during tests
     $v = $ARGV[0];
@@ -21,9 +21,9 @@ BEGIN {
 
     $level = `cat /proc/sys/kernel/perf_event_paranoid`;
     chomp($level);
-    if ( $level >= 2 ) {    # These tests require CAP_SYS_ADMIN
+    if ( $level >= 2 ) {    # These tests require CAP_PERFMON
         $test_count += 1;
-        $sys_admin = 1;
+        $capability = 1;
     }
 
     if ( $v eq "-v" ) {
@@ -56,9 +56,9 @@ print "Test perf_event\n";
 $result = system "runcon -t test_perf_t $basedir/perf_event $v $event_id";
 ok( $result eq 0 );
 
-if ($sys_admin) {
+if ($capability) {
 
-    # Deny capability { sys_admin } - EACCES perf_event_open(2)
+    # Deny capability { perfmon } - EACCES perf_event_open(2)
     $result = system
       "runcon -t test_perf_no_cap_t $basedir/perf_event $v $event_id 2>&1";
     ok( $result >> 8 eq 1 );
-- 
2.29.2

