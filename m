Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0745C4167D
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjKINve (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINvc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BAC2D5B
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso149350566b.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537888; x=1700142688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKRhSWjN+2wNUbQcTfizTF9WbNhyKNFAuMWdEbj3f84=;
        b=TdRl51R2xybSzkRGtba3BUYYtjM5xP6UaaYNb3Kg80RPVzMpysxDp/Tza2QWW21mr8
         +w0SkisOpOGBtDyiq+S8U8o/QgaomDbitm2i4mQr6bRM1W8JCEfWX7GNcp8iJSVf5BxB
         TmBmUQaXjcsS1aK2MFZdHyiwGjTGxo5zaQWiuDCvnpGxwI9NGaN2XfhgSlDNV5Ad0Mft
         AAtRmcASMsVmR4K3t3kM1IIcBJ/qPvKRwFknZuNGLJOdK9YkkwMK1kByAfZNjcVT2LmX
         rrZ5q4/BPOaFWJvcF5Xk5IJ93X8in1gSRyGotbs47O9aFz54j9DymBm0Sd8lSVvxBqPt
         rIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537888; x=1700142688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKRhSWjN+2wNUbQcTfizTF9WbNhyKNFAuMWdEbj3f84=;
        b=M0SCXGbUl+M8Qgeek7QVsgWTbvlUtsc26KK8IfHtXBc9whARPKLkLPb6I5w+yqvmYQ
         6NOLTD1Krf9I3RHn/up/QFkIlifJNnhtdSiZvcv6/QJWfODevKK8g4+XZBgSsnKvUFZh
         tm0bx7wOJeTVsBHremuUGzD2vR8Gq/kZ76NUk9YTkkfaxm9/YU5y42JeRd1BUwY3U9y/
         fWfG4J/2t+7IckEaSH9GeYJJQteLbmadpO1rW6gpxEk1VOX7OWlTmu1H3+9+aKtw34Nz
         Qi+T69NWf2yOa3LbA2WBnrEC3zHn05SYntIsbEoxcGT37kbiuK179lH2eTh0wdKqzvOR
         70BQ==
X-Gm-Message-State: AOJu0YyuZqpkg7+WEHvmdZoUcPcixmI9xWrsPCkU26bAJQxuEjo765f1
        /9r7PQJqIERNEgRKqUeeREGfy9b2Ql8=
X-Google-Smtp-Source: AGHT+IE9bCluVNmroDGnFW3s6mmd8hfdoudvRYQLOv7Qlg6EPZyNm2KxIp7/5E4D4VcQtF43wnqNEA==
X-Received: by 2002:a17:907:9304:b0:9d3:85b9:afdf with SMTP id bu4-20020a170907930400b009d385b9afdfmr4330176ejc.3.1699537888082;
        Thu, 09 Nov 2023 05:51:28 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906038400b0099bc8bd9066sm2581530eja.150.2023.11.09.05.51.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:27 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/4] libsepol: enhance saturation check
Date:   Thu,  9 Nov 2023 14:51:20 +0100
Message-ID: <20231109135121.42380-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135121.42380-1-cgzones@googlemail.com>
References: <20231109135121.42380-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Several values while parsing kernel policies, like symtab sizes or
string lengths, are checked for saturation.  They may not be set to the
maximum value, to avoid overflows or occupying a reserved value, and
many of those sizes must not be 0.  This is currently handled via the
two macros is_saturated() and zero_or_saturated().

Both macros are tweaked for the fuzzer, because the fuzzer can create
input with huge sizes.  While there is no subsequent data to provide
the announced sizes, which will be caught later, memory of the requested
size is allocated, which would lead to OOM reports.  Thus the sizes for
the fuzzer are limited to 2^16.  This has the drawback of the fuzzer
not checking the complete input space.

Check the sizes in question for actual enough bytes available in the
input.  This is (only) possible for mapped memory, which the fuzzer
uses.

Application like setools do currently not benefit from this change,
since they load the policy via a stream.  There are currently multiple
interfaces to load a policy, so reworking them to use mapped memory by
default might be subject for future work.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   keep is_saturated() and zero_or_saturated() unchanged
---
 libsepol/src/avtab.c    |  2 +-
 libsepol/src/policydb.c |  9 ++++++---
 libsepol/src/private.h  | 22 ++++++++++++++++------
 libsepol/src/services.c |  2 +-
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 7c2328b7..b2fa8d85 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -600,7 +600,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, uint32_t vers)
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(nel)) {
+	if (zero_or_saturated(nel) || exceeds_available_bytes(fp, nel, sizeof(uint32_t) * 3)) {
 		ERR(fp->handle, "table is empty");
 		goto bad;
 	}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index bc7bc9dc..6ba4f916 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3857,7 +3857,8 @@ static int scope_index_read(scope_index_t * scope_index,
 	if (rc < 0)
 		return -1;
 	scope_index->class_perms_len = le32_to_cpu(buf[0]);
-	if (is_saturated(scope_index->class_perms_len))
+	if (is_saturated(scope_index->class_perms_len) ||
+	    exceeds_available_bytes(fp, scope_index->class_perms_len, sizeof(uint32_t) * 3))
 		return -1;
 	if (scope_index->class_perms_len == 0) {
 		scope_index->class_perms_map = NULL;
@@ -4036,7 +4037,8 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 		goto cleanup;
 	scope->scope = le32_to_cpu(buf[0]);
 	scope->decl_ids_len = le32_to_cpu(buf[1]);
-	if (zero_or_saturated(scope->decl_ids_len)) {
+	if (zero_or_saturated(scope->decl_ids_len) ||
+	    exceeds_available_bytes(fp, scope->decl_ids_len, sizeof(uint32_t))) {
 		ERR(fp->handle, "invalid scope with no declaration");
 		goto cleanup;
 	}
@@ -4315,7 +4317,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (rc < 0)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
-		if (is_saturated(nprim))
+		if (is_saturated(nprim) ||
+		    exceeds_available_bytes(fp, nprim, sizeof(uint32_t) * 3))
 			goto bad;
 		nel = le32_to_cpu(buf[1]);
 		if (nel && !nprim) {
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 1833b497..1500bbc2 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -44,13 +44,23 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
 
-#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
-# define is_saturated(x) (x == (typeof(x))-1 || (x) > (1U << 16))
-#else
-# define is_saturated(x) (x == (typeof(x))-1)
-#endif
+static inline int exceeds_available_bytes(const struct policy_file *fp, size_t x, size_t req_elem_size)
+{
+	size_t req_size;
+
+	/* Remaining input size is only available for mmap'ed memory */
+	if (fp->type != PF_USE_MEMORY)
+		return 0;
+
+	if (__builtin_mul_overflow(x, req_elem_size, &req_size))
+		return 1;
+
+	return req_size > fp->len;
+}
+
+#define is_saturated(x) ((x) == (typeof(x))-1)
 
-#define zero_or_saturated(x) ((x == 0) || is_saturated(x))
+#define zero_or_saturated(x) (((x) == 0) || is_saturated(x))
 
 #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
 
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 51bd56a0..aa1ad52c 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1748,7 +1748,7 @@ int str_read(char **strp, struct policy_file *fp, size_t len)
 	int rc;
 	char *str;
 
-	if (zero_or_saturated(len)) {
+	if (zero_or_saturated(len) || exceeds_available_bytes(fp, len, sizeof(char))) {
 		errno = EINVAL;
 		return -1;
 	}
-- 
2.42.0

