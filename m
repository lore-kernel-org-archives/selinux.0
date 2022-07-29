Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC88C00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiG2ME0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiG2MEY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9355587F7B
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lekwp2+k18inaPiX9G1L4k74QP1pdsetvo6xop+Kblk=;
        b=bqmzrtds+japEd0so9Q6StfNeaj/fYtuHjevH4vBmw4Idup3UFyAeqh7bYMceWhBgUsrHr
        BWN0yFWjMd6LlrJFuh5jjHCGV8SjS0S9aOfL3W4hMjW3c9/8Bbgl3aONxsmFwlf31kRndR
        v3nswR/wJNXJbN15qqfkPYqKZKvSXdY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-G6I6YKwSP6eTjpCDIsQNtA-1; Fri, 29 Jul 2022 08:03:04 -0400
X-MC-Unique: G6I6YKwSP6eTjpCDIsQNtA-1
Received: by mail-wr1-f69.google.com with SMTP id c7-20020adfc6c7000000b0021db3d6961bso1142344wrh.23
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=Lekwp2+k18inaPiX9G1L4k74QP1pdsetvo6xop+Kblk=;
        b=79u3rUq63XEAsiTMNdhx3E44L2U4W+jmJ+Ht7/+ZlRv2Sk/UYo7tdLZhmGsky/q9bI
         PSKpOPksH0hFFPeqKyDk1QKxT9P+n2Ke+aDFdvtVEsyDYYaBPzGivPRBW8wEKfNpEGKO
         HPWCAodYVaGC1tFlabOwYXA68PLs5S3k7jICOkZPV1xVPQ0iujybpKMSGfTMzidMzZRK
         8RV7hBihmIIXCtoE6mGYHpDK90Sa1PJbzPPpHPybP048kWZ5QSBr8U9dyhoo5tdFXnYL
         feA44bdH91U+11VcCAH2y4g+UqI/9EyZ3NdjUvM8u5jbSCCxGmaZ/Ffja9Z64RlytGZj
         0xLQ==
X-Gm-Message-State: ACgBeo3aXcF756YyAddVS5/MQBQsAbdnCLxFeMcSrDM5gy8Q28rN+u22
        1E8feG/Mh4l5wX34fA2FMfcBxW+ZBbIKFiAlOUhmEo8hhBJXByRJkFdrQeomZKi/1mHc+Q2Of1d
        aBG197AMIyE+K9z6s/IN30H4vUFcDNAjv94Ig0tePeUfZBj0e9wpEiZ87zySRLWGxxTncrg==
X-Received: by 2002:a5d:4b81:0:b0:21e:e3c8:7055 with SMTP id b1-20020a5d4b81000000b0021ee3c87055mr2236430wrt.519.1659096182625;
        Fri, 29 Jul 2022 05:03:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7me49zztZdpVQFIFzKAHxXaFT9wECAIKhpfMbyg/nsOr5ruTLA9LIJyaUNqcFwCBjf3ZxJpw==
X-Received: by 2002:a5d:4b81:0:b0:21e:e3c8:7055 with SMTP id b1-20020a5d4b81000000b0021ee3c87055mr2236406wrt.519.1659096182319;
        Fri, 29 Jul 2022 05:03:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.03.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:03:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 20/24] tests/binder: check only the type part of the context
Date:   Fri, 29 Jul 2022 14:02:25 +0200
Message-Id: <20220729120229.207584-21-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This will allow running the testsuite from other contexts than the usual
unconfined.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/binder/binder_common.h    |  1 +
 tests/binder/service_provider.c | 31 +++++++++++++++++++------------
 tests/binder/test               |  2 +-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
index 319b5dd..e516617 100644
--- a/tests/binder/binder_common.h
+++ b/tests/binder/binder_common.h
@@ -14,6 +14,7 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <selinux/selinux.h>
+#include <selinux/context.h>
 #include <linux/android/binder.h>
 #if HAVE_BINDERFS
 #include <linux/android/binderfs.h>
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
index 56d8a43..f47365c 100644
--- a/tests/binder/service_provider.c
+++ b/tests/binder/service_provider.c
@@ -1,14 +1,14 @@
 #include "binder_common.h"
 
-static char *expected_ctx;
+static char *expected_type;
 static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size);
 
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s -e expected_ctx] [-f file] [-n] [-m|-p|-t] [-v]\n"
+		"usage:  %s [-e expected_type] [-f file] [-n] [-m|-p|-t] [-v]\n"
 		"Where:\n\t"
-		"-e  Expected security context.\n\t"
+		"-e  Expected security type.\n\t"
 		"-f  Write a line to the file when listening starts.\n\t"
 		"-n  Use the /dev/binderfs name service.\n\t"
 		"-m  Use BPF map fd for transfer.\n\t"
@@ -162,23 +162,30 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 		case BR_TRANSACTION_SEC_CTX: {
 			struct binder_transaction_data_secctx *txn_ctx =
 				(struct binder_transaction_data_secctx *)ptr;
-
 			if (verbose) {
 				printf("\tclient context:\n\t\t%s\n",
 				       (char *)txn_ctx->secctx);
 				print_trans_data(&txn_ctx->transaction_data);
 			}
 
-			if (expected_ctx) {
-				int result = strcmp(expected_ctx,
-						    (char *)txn_ctx->secctx);
-				if (result) {
+			if (expected_type) {
+				context_t ctx = context_new((const char *)txn_ctx->secctx);
+
+				if (!ctx) {
+					fprintf(stderr,
+						"Service Provider context_new: %s\n",
+						strerror(errno));
+					exit(82);
+				}
+
+				if (strcmp(expected_type, context_type_get(ctx))) {
 					fprintf(stderr, "Service Provider received incorrect context:\n");
 					fprintf(stderr, "Expected: %s\nReceived: %s\n",
-						expected_ctx,
-						(char *)txn_ctx->secctx);
+						expected_type,
+						context_type_get(ctx));
 					exit(80);
 				}
+				context_free(ctx);
 			}
 
 			if (txn_ctx->transaction_data.code == TEST_SERVICE_SEND_FD)
@@ -240,14 +247,14 @@ int main(int argc, char **argv)
 	} __attribute__((packed)) writebuf;
 	unsigned int readbuf[32];
 
-	expected_ctx = NULL;
+	expected_type = NULL;
 	fd_type = BINDER_FD;
 	fd_type_str = "SP";
 
 	while ((opt = getopt(argc, argv, "e:f:nvmpt")) != -1) {
 		switch (opt) {
 		case 'e':
-			expected_ctx = optarg;
+			expected_type = optarg;
 			break;
 		case 'f':
 			flag_file = optarg;
diff --git a/tests/binder/test b/tests/binder/test
index 9914759..95af41a 100755
--- a/tests/binder/test
+++ b/tests/binder/test
@@ -163,7 +163,7 @@ if ($test_binder_ctx) {
     $sp_pid = service_start(
         "service_provider",
         "-t test_binder_provider_t",
-        "$n $v -e unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
+        "$n $v -e test_binder_client_t"
     );
 
 # 8 Verify that authorized client and service provider can communicate with the binder service manager.
-- 
2.37.1

