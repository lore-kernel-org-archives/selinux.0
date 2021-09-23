Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9DC433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A703860FC1
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 10:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbhIWKRz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240383AbhIWKRz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 06:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632392182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U7pCbMK+PWMJRRwHbP4h2tYp5rub24F2amGE1DhxsWQ=;
        b=aV2IzgIyTGIHz64RMT+8Qa5b+X8XtqvzuSC/aWIBOdeaUPO66mGPyzM0uNGe96mHKAaqhk
        LcRnoft8U5hNmIkWmMogQlF7DVjDvLv1QFAe4bSXXnkHY0CgXa9a1gwwp3APgU/pHj5QvU
        VWpToUrCz4ni6yXRm0um3/5peUaHCKU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-KFjPoAigPuWFWcXbI66nHQ-1; Thu, 23 Sep 2021 06:16:21 -0400
X-MC-Unique: KFjPoAigPuWFWcXbI66nHQ-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a05640217cc00b003cde58450f1so6329936edy.9
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 03:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7pCbMK+PWMJRRwHbP4h2tYp5rub24F2amGE1DhxsWQ=;
        b=DSuudHJxdZUlUD3gcP2fPKzcXQXrLQ3OSTjdRt8SRAsao00+UKz2bZYjxztNaQFRsJ
         SY8aGLGdWq5F+/peayD9G9Osh5vW7g8yWQgtHM7dJhJYIiuBnl2GFVJHi+o5HHixuW0I
         MyaEnw8o2hgqzboDhc5rSuTysYDJWfIVhB4dn9mVc43a+Tfc1IEGQ1SVeJ2QyiD7+78E
         NHhVyYA4Bcxq5EBo7IAPInoaLPcr/t82aYPprw53WRKsdWxoGqMSRiLofY5VOCxF/4gp
         qqVvzusAH2SqQfCFxGxB6oQ/L/joGzNq1bRuI7R+lP7RKNfkgmAu8QFRfSrYJY+inuHg
         Qmvg==
X-Gm-Message-State: AOAM532E0ryDjRpKnt4zBfSoHhCMA0RJvKNfHXgRnr2UVFpZ5IyeFH94
        2gbQKvrPelxBTu3W4fB/K5kI/eg5EFJJ9tlrmAKT3DfMpF2H8ZV3++hdeg3vCNxaFpQ5kwajlF+
        H8Tf0CRNgUpkz4ZNxlcgbTQEifI1Jjhzb+Yvg34DKllp2xOq9255fg3EfDbMrYRHMG6UWjQ==
X-Received: by 2002:a50:cfc1:: with SMTP id i1mr4367875edk.251.1632392179943;
        Thu, 23 Sep 2021 03:16:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ/U2npbaxf2c993ekaKZb6VSWsxQFAd+ORsN6vqvN6mI1jakDKPgDZOC7vFnja6enmeXiKA==
X-Received: by 2002:a50:cfc1:: with SMTP id i1mr4367851edk.251.1632392179640;
        Thu, 23 Sep 2021 03:16:19 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t4sm3270192edc.2.2021.09.23.03.16.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:16:19 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/perf_event: don't assume CPU#0 is online
Date:   Thu, 23 Sep 2021 12:16:18 +0200
Message-Id: <20210923101618.599881-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The perf_event test currently uses hard-coded 0 as the CPU index.
Howver, if CPU#0 happens to be offline, the test then fails because
perf_event_open(2) returns -ENODEV.

To fix this, try to find the index of the first online CPU and use that
instead of the hard-coded value.

Verified to work well on a machine with the first 8 CPU cores offline.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/perf_event/perf_event.c | 23 ++++++++++++++---------
 tests/perf_event/test         | 32 +++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/tests/perf_event/perf_event.c b/tests/perf_event/perf_event.c
index 453aa91..0e8bdce 100644
--- a/tests/perf_event/perf_event.c
+++ b/tests/perf_event/perf_event.c
@@ -20,13 +20,14 @@ enum {
 static void print_usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-f|-m] [-v] EVENT_ID\n"
+		"usage:  %s [-f|-m] [-v] CPU EVENT_ID\n"
 		"Where:\n\t"
+		"CPU       target CPU (must be online)\n\n\t"
 		"EVENT_ID  target ftrace event ID\n\n\t"
-		"-f  Read perf_event info using read(2)\n\t"
-		"-m  Read perf_event info using mmap(2)\n\t"
-		"    Default is to use read(2) and mmap(2)\n\t"
-		"-v  Print information\n", progname);
+		"-f        Read perf_event info using read(2)\n\t"
+		"-m        Read perf_event info using mmap(2)\n\t"
+		"          Default is to use read(2) and mmap(2)\n\t"
+		"-v        Print information\n", progname);
 	exit(-1);
 }
 
@@ -39,7 +40,7 @@ static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
 
 int main(int argc, char **argv)
 {
-	int opt, result, page_size, mmap_size, fd;
+	int opt, result, page_size, mmap_size, fd, cpu;
 	long long count, event_id;
 	bool verbose = false;
 	char *context;
@@ -65,10 +66,14 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if ((argc - optind) != 1)
+	if ((argc - optind) != 2)
 		print_usage(argv[0]);
 
-	event_id = atoll(argv[optind]);
+	cpu = atoi(argv[optind]);
+	if (cpu < 0)
+		print_usage(argv[0]);
+
+	event_id = atoll(argv[optind + 1]);
 	if (event_id < 0)
 		print_usage(argv[0]);
 
@@ -90,7 +95,7 @@ int main(int argc, char **argv)
 	pe_attr.disabled = 1;
 	pe_attr.exclude_hv = 1;
 
-	fd = perf_event_open(&pe_attr, -1, 0, -1, 0);
+	fd = perf_event_open(&pe_attr, -1, cpu, -1, 0);
 	if (fd < 0) {
 		fprintf(stderr, "Failed perf_event_open(): %s\n",
 			strerror(errno));
diff --git a/tests/perf_event/test b/tests/perf_event/test
index 380d9cc..c336477 100755
--- a/tests/perf_event/test
+++ b/tests/perf_event/test
@@ -48,56 +48,70 @@ BEGIN {
     plan tests => $test_count;
 }
 
+# find some CPU that is online
+for ( $cpu = 0 ; -e "/sys/devices/system/cpu/cpu$cpu" ; $cpu++ ) {
+
+    # if the "online" file doesn't exist, the CPU can't be offline
+    last unless -e "/sys/devices/system/cpu/cpu$cpu/online";
+
+    $online = `cat /sys/devices/system/cpu/cpu$cpu/online`;
+    chomp($online);
+    last if ( $online eq "1" );
+}
+
 $event_id = `cat /sys/kernel/debug/tracing/events/ftrace/function/id`;
 chomp($event_id);
 
 # perf_event { open cpu kernel tracepoint read write };
 print "Test perf_event\n";
-$result = system "runcon -t test_perf_t $basedir/perf_event $v $event_id";
+$result = system "runcon -t test_perf_t $basedir/perf_event $v $cpu $event_id";
 ok( $result eq 0 );
 
 if ($capability) {
 
     # Deny capability { perfmon } - EACCES perf_event_open(2)
     $result = system
-      "runcon -t test_perf_no_cap_t $basedir/perf_event $v $event_id 2>&1";
+      "runcon -t test_perf_no_cap_t $basedir/perf_event $v $cpu $event_id 2>&1";
     ok( $result >> 8 eq 1 );
 }
 
 # Deny perf_event { open } - EACCES perf_event_open(2)
 $result =
-  system "runcon -t test_perf_no_open_t $basedir/perf_event $v $event_id 2>&1";
+  system
+  "runcon -t test_perf_no_open_t $basedir/perf_event $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { cpu } - EACCES perf_event_open(2)
 $result =
-  system "runcon -t test_perf_no_cpu_t $basedir/perf_event $v $event_id 2>&1";
+  system
+  "runcon -t test_perf_no_cpu_t $basedir/perf_event $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { kernel } - EACCES perf_event_open(2)
 $result = system
-  "runcon -t test_perf_no_kernel_t $basedir/perf_event $v $event_id 2>&1";
+  "runcon -t test_perf_no_kernel_t $basedir/perf_event $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { tracepoint } - EACCES perf_event_open(2)
 $result =
   system
-  "runcon -t test_perf_no_tracepoint_t $basedir/perf_event $v $event_id 2>&1";
+"runcon -t test_perf_no_tracepoint_t $basedir/perf_event $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 1 );
 
 # Deny perf_event { read } - EACCES mmap(2)
 $result = system
-  "runcon -t test_perf_no_read_t $basedir/perf_event -m $v $event_id 2>&1";
+  "runcon -t test_perf_no_read_t $basedir/perf_event -m $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 6 );
 
 # Deny perf_event { read } - EACCES read(2)
 $result = system
-  "runcon -t test_perf_no_read_t $basedir/perf_event -f $v $event_id 2>&1";
+  "runcon -t test_perf_no_read_t $basedir/perf_event -f $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 7 );
 
 # Deny perf_event { write } - EACCES ioctl(2) write
 $result =
-  system "runcon -t test_perf_no_write_t $basedir/perf_event $v $event_id 2>&1";
+  system
+  "runcon -t test_perf_no_write_t $basedir/perf_event $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 2 );
 
 exit;
-- 
2.31.1

