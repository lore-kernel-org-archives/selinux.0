Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851DC433E6
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98ABB64E90
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352826AbhCCEWM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:22:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345162AbhCBRXG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Mar 2021 12:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614705682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGLKeJsTCVPCK6I2wE3MEL6d/T2TVTL1cBAdptEt+2A=;
        b=ZR76/ug9vk6q4tok4yp6e8KJkukAt6yCtc5DXhJ/ySH/vGKxZ2ebgtMsuscFx4lDzAuOta
        YRp9urUG+ib8ZF6BoHK+NYsJ4BUxPvPEoOglJVjN1aXZkqigBdBnbh/6tY9JqBlpYhVEef
        D4jmRQX9x5Gv2B5grVfZjIBcTbawUuk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-qFJSM6FbPo6cDbOaIXn37w-1; Tue, 02 Mar 2021 12:21:20 -0500
X-MC-Unique: qFJSM6FbPo6cDbOaIXn37w-1
Received: by mail-ed1-f70.google.com with SMTP id t27so8497496edi.2
        for <selinux@vger.kernel.org>; Tue, 02 Mar 2021 09:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGLKeJsTCVPCK6I2wE3MEL6d/T2TVTL1cBAdptEt+2A=;
        b=GHPThRu4eM3u+VN77+FfFVWe8GY6KVhT29uGXR+stB3ZNc4VEaF4d7rSBrbYBk6SN2
         ClxgX4ZzvaEPvvJm/KDqiMVTwTcX/bm4jDOsAxdNSPWcJPpo4lMY4SOh/u2K5l3vRzIX
         Vlf/m6GVZYpiNHVi9YnHgix19kwLR85av7glqWz2POp//Zh0yL1WUnxvvhUqh+GROfR0
         NR+u9qI3wme0G3f2G5j9ECdF9iJH6DOb2yslPyh6aZOkOxRxL/j6lXjgNtmMqKhs0L5c
         dLhNXkn4t0r9KQZHgsFb+1FogEJnPg3EPxZ4JBcPLF3FWKw/fG4mkIC7/Th13/IOoGa2
         YEtA==
X-Gm-Message-State: AOAM530y51WOBDemYeqiGanqJ/Mt3xIAppkyGdwM/btVnslwPi96wE+0
        KOZTpnvqaO8I1WGFmcyKvRAwEP8wHeLub+dpOo3ww59itq9e89iX/vr8WEKA/pCGmqtYTjIa5VA
        Ba6CD6JrfRU8s7hV5hivGsNg2jl1kzMXwEa8F1Zc9h/Rpvv1OBeJufZEIH8y6OiFVaGClog==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr22169823ejb.39.1614705679324;
        Tue, 02 Mar 2021 09:21:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzQg49f1yYauSQ7TR0nFE2zl5QZ8+QT4IS/V9tvMlDN0VrPkSOAGd60POcW456NJw2xq6d8A==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr22169809ejb.39.1614705679084;
        Tue, 02 Mar 2021 09:21:19 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id pk5sm17922560ejb.119.2021.03.02.09.21.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:21:18 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/3] perf_event: fix wrong use of perf_event_open(2) API
Date:   Tue,  2 Mar 2021 18:21:13 +0100
Message-Id: <20210302172114.443689-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302172114.443689-1-omosnace@redhat.com>
References: <20210302172114.443689-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

1. attr.type is not a bit field, but an enum. Use PERF_TYPE_TRACEPOINT,
   which is equivalent to current code (PERF_TYPE_HARDWARE == 0).
2. attr.config for PERF_TYPE_TRACEPOINT is the ID of the trace event to
   monitor; PERF_COUNT_HW_INSTRUCTIONS is meaningful only for
   PERF_TYPE_HARDWARE. Replace it by the ID of "ftrace:function"
   obtained from tracefs. "ftrace:function" usually has the ID of 1,
   which is the numeric value of PERF_COUNT_HW_INSTRUCTIONS, so this
   should be functionally equivalent.

Fixes: b9e1eb2db689 ("selinux-testsuite: Add perf_event tests")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/perf_event/perf_event.c | 16 ++++++++++++----
 tests/perf_event/test         | 29 ++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/tests/perf_event/perf_event.c b/tests/perf_event/perf_event.c
index 1557303..453aa91 100644
--- a/tests/perf_event/perf_event.c
+++ b/tests/perf_event/perf_event.c
@@ -20,8 +20,9 @@ enum {
 static void print_usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-f|-m] [-v]\n"
+		"usage:  %s [-f|-m] [-v] EVENT_ID\n"
 		"Where:\n\t"
+		"EVENT_ID  target ftrace event ID\n\n\t"
 		"-f  Read perf_event info using read(2)\n\t"
 		"-m  Read perf_event info using mmap(2)\n\t"
 		"    Default is to use read(2) and mmap(2)\n\t"
@@ -39,7 +40,7 @@ static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
 int main(int argc, char **argv)
 {
 	int opt, result, page_size, mmap_size, fd;
-	long long count;
+	long long count, event_id;
 	bool verbose = false;
 	char *context;
 	void *base;
@@ -64,6 +65,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if ((argc - optind) != 1)
+		print_usage(argv[0]);
+
+	event_id = atoll(argv[optind]);
+	if (event_id < 0)
+		print_usage(argv[0]);
+
 	if (verbose) {
 		result = getcon(&context);
 		if (result < 0) {
@@ -76,9 +84,9 @@ int main(int argc, char **argv)
 
 	/* Test perf_event { open cpu kernel tracepoint } */
 	memset(&pe_attr, 0, sizeof(struct perf_event_attr));
-	pe_attr.type = PERF_TYPE_HARDWARE | PERF_TYPE_TRACEPOINT;
+	pe_attr.type = PERF_TYPE_TRACEPOINT;
 	pe_attr.size = sizeof(struct perf_event_attr);
-	pe_attr.config = PERF_COUNT_HW_INSTRUCTIONS;
+	pe_attr.config = event_id;
 	pe_attr.disabled = 1;
 	pe_attr.exclude_hv = 1;
 
diff --git a/tests/perf_event/test b/tests/perf_event/test
index 1d337e9..561a634 100755
--- a/tests/perf_event/test
+++ b/tests/perf_event/test
@@ -48,45 +48,56 @@ BEGIN {
     plan tests => $test_count;
 }
 
+$event_id = `cat /sys/kernel/debug/tracing/events/ftrace/function/id`;
+chomp($event_id);
+
 # perf_event { open cpu kernel tracepoint read write };
 print "Test perf_event\n";
-$result = system "runcon -t test_perf_t $basedir/perf_event $v";
+$result = system "runcon -t test_perf_t $basedir/perf_event $v $event_id";
 ok( $result eq 0 );
 
 if ($sys_admin) {
 
     # Deny capability { sys_admin } - EACCES perf_event_open(2)
-    $result = system "runcon -t test_perf_no_cap_t $basedir/perf_event $v 2>&1";
+    $result = system
+      "runcon -t test_perf_no_cap_t $basedir/perf_event $v $event_id 2>&1";
     ok( $result >> 8 eq 1 );
 }
 
 # Deny perf_event { open } - EACCES perf_event_open(2)
-$result = system "runcon -t test_perf_no_open_t $basedir/perf_event $v 2>&1";
+$result =
+  system "runcon -t test_perf_no_open_t $basedir/perf_event $v $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { cpu } - EACCES perf_event_open(2)
-$result = system "runcon -t test_perf_no_cpu_t $basedir/perf_event $v 2>&1";
+$result =
+  system "runcon -t test_perf_no_cpu_t $basedir/perf_event $v $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { kernel } - EACCES perf_event_open(2)
-$result = system "runcon -t test_perf_no_kernel_t $basedir/perf_event $v 2>&1";
+$result = system
+  "runcon -t test_perf_no_kernel_t $basedir/perf_event $v $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { tracepoint } - EACCES perf_event_open(2)
 $result =
-  system "runcon -t test_perf_no_tracepoint_t $basedir/perf_event $v 2>&1";
+  system
+  "runcon -t test_perf_no_tracepoint_t $basedir/perf_event $v $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { read } - EACCES mmap(2)
-$result = system "runcon -t test_perf_no_read_t $basedir/perf_event -m $v 2>&1";
+$result = system
+  "runcon -t test_perf_no_read_t $basedir/perf_event -m $v $event_id 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Deny perf_event { read } - EACCES read(2)
-$result = system "runcon -t test_perf_no_read_t $basedir/perf_event -f $v 2>&1";
+$result = system
+  "runcon -t test_perf_no_read_t $basedir/perf_event -f $v $event_id 2>&1";
 ok( $result >> 8 eq 7 );
 
 # Deny perf_event { write } - EACCES ioctl(2) write
-$result = system "runcon -t test_perf_no_write_t $basedir/perf_event $v 2>&1";
+$result =
+  system "runcon -t test_perf_no_write_t $basedir/perf_event $v $event_id 2>&1";
 ok( $result >> 8 eq 2 );
 
 exit;
-- 
2.29.2

