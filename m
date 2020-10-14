Return-Path: <SRS0=aJPZ=DV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004F6C43457
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 07:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DAE212CC
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 07:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4unMhRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgJNHha (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Oct 2020 03:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbgJNHha (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Oct 2020 03:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602661048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66Eq0dFwMhvLQTFlDF2jrnsvL4WOOvrHdlI8DQmL1J0=;
        b=a4unMhRkWlInHaIYxLcw8svt8ry8t7qoaGHcBZ4gtltglZqWG0l1qzKBooWCyaeNVx5hqK
        4ZswN9qq4wksCb2Ft8/qDtxqk+pfKjV3XndVb6GMiUKY0Lrz0YeIWVvMY4urqdojdYFNm9
        GrQ5X9tjlTE/5SK+tPSedYrb+GrKjpg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-p56ReDL7M8uwrg8Qvbk3mg-1; Wed, 14 Oct 2020 03:37:26 -0400
X-MC-Unique: p56ReDL7M8uwrg8Qvbk3mg-1
Received: by mail-wr1-f69.google.com with SMTP id u15so929097wrn.4
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2020 00:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66Eq0dFwMhvLQTFlDF2jrnsvL4WOOvrHdlI8DQmL1J0=;
        b=GHS0G/rjaZD81584/hqMhYor6d3Dz/sCZ0o+2Q/jcxeOYaPc2wO0mQz7S3Lucf8YQE
         QE3m78n3/kym+4odQz5gie/EUk4jn3XufVTWTSM4O9NGR/VHPTjKP9EgDd8VaB9FlKrM
         tQYitvUJ3OKvNRJj0np9Uo8DBJevEKSYnmT5oBDIr5XX3FhL708dOY3YjghPQSpBLvfR
         afffzWJDnIkFaUQHs2dJfuCKhxv/aVZxITYgTzUXD1pJxKI97BKbF7A4apTR0qVn1nn8
         Dj7YMh/10ntV6GvoAb3g3LDjurGUDGTGg5tsqVV5OqNe/6vT03F0QZFXyZmIXN8f1W9p
         2gqA==
X-Gm-Message-State: AOAM5318JzI0ewfCTjahreFzZ9MRVyfdtPBEu/4oRbwmziodp60oQYEH
        i8GdFHs/98ON0bB+epAS7QvJSy7IqNpsE+wAmim2jj54HP35J8Xs2f3JgE/DqGVm/UFApBFs46y
        gfH6Venb+R1Ezilw0fA==
X-Received: by 2002:a1c:7c01:: with SMTP id x1mr1959547wmc.57.1602661045071;
        Wed, 14 Oct 2020 00:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnyl21Ri3x6xAoLYAbS28wPN2N81j/+O0XzquCShwS4GcrtNrBWx4MacyyydqQNPYmh11uuQ==
X-Received: by 2002:a1c:7c01:: with SMTP id x1mr1959532wmc.57.1602661044806;
        Wed, 14 Oct 2020 00:37:24 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id h1sm3406997wrx.33.2020.10.14.00.37.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:37:24 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/1] tests/keys: fix the KEYCTL_DH_COMPUTE parameter values
Date:   Wed, 14 Oct 2020 09:37:21 +0200
Message-Id: <20201014073721.392783-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014073721.392783-1-omosnace@redhat.com>
References: <20201014073721.392783-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The KEYCTL_DH_COMPUTE key payloads are interpreted as MPI-formatted
numbers. Even though the generic DH algorithm implementation doesn't
look at the actual values when setting the parameters (and probably only
validates them later when doing the actual operation), this isn't
necessarily true for other implementations. Specifically, the Intel QAT
driver checks if the prime size is one of 1536, 2048, 3072, or 4096
bits, causing the KEYCTL_DH_COMPUTE operation to fail with -EINVAL.

While it is questionable if the QAT implementation should reject unusual
prime sizes (it should use a fallback to generic instead), let's just
make sure we pass valid numbers to avoid similar validation errors.

I verified on a machine with an Intel QAT device that this patch makes
the testsuite pass there.

Fixes: 2d7aad8a1f8c ("selinux-testsuite: Add keys tests")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/keys/keyctl.c          |  8 ++++----
 tests/keys/keyring_service.c |  8 ++++----
 tests/keys/keys_common.h     | 28 +++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
index 5aff8d8..e13c655 100644
--- a/tests/keys/keyctl.c
+++ b/tests/keys/keyctl.c
@@ -72,15 +72,15 @@ int main(int argc, char *argv[])
 	 * required by the keyctl(KEYCTL_DH_COMPUTE, ..) function.
 	 * These require key { create write } permissions.
 	 */
-	private = add_key("user", "private", payload, strlen(payload),
-			  KEY_SPEC_PROCESS_KEYRING);
+	private = add_key("user", "private", payload_private,
+			  sizeof(payload_private), KEY_SPEC_PROCESS_KEYRING);
 	if (private < 0) {
 		fprintf(stderr, "Failed add_key(private): %s\n",
 			strerror(errno));
 		exit(5);
 	}
 
-	prime = add_key("user", "prime", payload, strlen(payload),
+	prime = add_key("user", "prime", payload_prime, sizeof(payload_prime),
 			KEY_SPEC_PROCESS_KEYRING);
 	if (prime < 0) {
 		fprintf(stderr, "Failed add_key(prime): %s\n",
@@ -88,7 +88,7 @@ int main(int argc, char *argv[])
 		exit(5);
 	}
 
-	base = add_key("user", "base", payload, strlen(payload),
+	base = add_key("user", "base", payload_base, sizeof(payload_base),
 		       KEY_SPEC_PROCESS_KEYRING);
 	if (base < 0) {
 		fprintf(stderr, "Failed add_key(base): %s\n",
diff --git a/tests/keys/keyring_service.c b/tests/keys/keyring_service.c
index e5dcab0..9913653 100644
--- a/tests/keys/keyring_service.c
+++ b/tests/keys/keyring_service.c
@@ -91,15 +91,15 @@ int main(int argc, char **argv)
 		printf("\tKEYCTL_JOIN_SESSION_KEYRING newkey ID: 0x%x\n",
 		       newring);
 
-	private = add_key("user", "private", payload, strlen(payload),
-			  KEY_SPEC_SESSION_KEYRING);
+	private = add_key("user", "private", payload_private,
+			  sizeof(payload_private), KEY_SPEC_SESSION_KEYRING);
 	if (private < 0) {
 		fprintf(stderr, "Failed add_key(private): %s\n",
 			strerror(errno));
 		exit(6);
 	}
 
-	prime = add_key("user", "prime", payload, strlen(payload),
+	prime = add_key("user", "prime", payload_prime, sizeof(payload_prime),
 			KEY_SPEC_SESSION_KEYRING);
 	if (prime < 0) {
 		fprintf(stderr, "Failed add_key(prime): %s\n",
@@ -107,7 +107,7 @@ int main(int argc, char **argv)
 		exit(6);
 	}
 
-	base = add_key("user", "base", payload, strlen(payload),
+	base = add_key("user", "base", payload_base, sizeof(payload_base),
 		       KEY_SPEC_SESSION_KEYRING);
 	if (base < 0) {
 		fprintf(stderr, "Failed add_key(base): %s\n",
diff --git a/tests/keys/keys_common.h b/tests/keys/keys_common.h
index df15280..55cc4eb 100644
--- a/tests/keys/keys_common.h
+++ b/tests/keys/keys_common.h
@@ -11,6 +11,28 @@
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 
-/* This is used as the payload for each add_key() */
-static const char payload[] =
-	" -----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDN4FHsPjlJf03r9KfNt1Ma9/D6\nQDEiR/cfhZrNUPgHRresult+E4dj52VJSonPFJ6HaLlUi5pZq2t1LqPNrMfFKCNn12m+\nWw4aduBJM7u1RUPSNxrlfDAJZkdtNALOO/ds3U93hZrxOYNetzbnjILDu5JT1nbI\n4aC60SkdlCw1TxmvXwIDAQAB\n-----END PUBLIC KEY-----\n";
+/* dummy values - the prime was genearted using `openssl dhparam -C` */
+static const unsigned char payload_prime[] = {
+	0x96, 0xC1, 0xFA, 0xA4, 0xD4, 0xAB, 0xD6, 0x6D, 0x6F, 0x99,
+	0x3A, 0xCC, 0xD4, 0x74, 0x71, 0xE9, 0x5B, 0x77, 0xA4, 0x5E,
+	0x68, 0x81, 0x04, 0x83, 0xE4, 0x92, 0x3C, 0xDD, 0x4B, 0xCA,
+	0x16, 0x83, 0xB4, 0x5B, 0x1A, 0x0A, 0x80, 0xA3, 0xFA, 0xCD,
+	0x24, 0xA5, 0xFF, 0x46, 0x49, 0x86, 0x7B, 0x42, 0xDC, 0x39,
+	0x20, 0x2A, 0x6A, 0x86, 0x17, 0x12, 0x95, 0x3F, 0x13, 0xAD,
+	0x5E, 0x98, 0x67, 0xAE, 0xA2, 0xA5, 0x78, 0x9D, 0x6D, 0x7D,
+	0x78, 0xF6, 0xB2, 0x85, 0x7A, 0xA4, 0xB2, 0xC1, 0x96, 0x03,
+	0x09, 0x15, 0x66, 0xBE, 0xFD, 0xA6, 0x63, 0xEA, 0xF6, 0xC4,
+	0x61, 0x1A, 0x78, 0x9E, 0x9C, 0x82, 0x53, 0x8A, 0xCF, 0x07,
+	0x90, 0x89, 0xE5, 0x28, 0x4A, 0x53, 0x77, 0x92, 0x72, 0xCB,
+	0xBD, 0x17, 0x51, 0xE9, 0xC6, 0x34, 0xC4, 0xC9, 0x9A, 0x6A,
+	0xFE, 0x55, 0x58, 0xD6, 0x7D, 0x3F, 0x67, 0xCD, 0xAF, 0x5C,
+	0xCB, 0x46, 0x9B, 0xD1, 0x25, 0x43, 0x80, 0xE0, 0xA6, 0x80,
+	0x1A, 0x15, 0xE6, 0xC6, 0x24, 0xB5, 0x8F, 0xC1, 0xA5, 0xAF,
+	0x23, 0xCD, 0xA9, 0x21, 0x1E, 0x1E, 0xA1, 0x6A, 0xC9, 0xA7,
+	0x17, 0xE9, 0xF5, 0x00, 0x94, 0x84, 0x7B, 0xF2, 0xD8, 0x28,
+	0xE2, 0x8A, 0xC5, 0x58, 0x34, 0xE8, 0xCE, 0xFD, 0x72, 0xA4,
+	0xC7, 0xEB, 0x93, 0x87, 0xC7, 0x54, 0x3D, 0x23, 0x75, 0x77,
+	0x50, 0x73
+};
+static const unsigned char payload_base[] = { 0x02 };
+static const unsigned char payload_private[] = { 42 };
-- 
2.26.2

