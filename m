Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404CC4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjKAQjV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQjU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:39:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E8123
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:39:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso1185366b.0
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856756; x=1699461556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAlBVvkI2I5E+pK3aaQGYi3UgGWdj02dTU8aSSoMiHA=;
        b=dF8EhrdPqvUQ8/ibpnxyx2pe9fYsEAkhz8oVCSzyr3m6xVEpoREkycGoSKCyJtayPh
         x41lQVU9biZaPV16Z8HwF7PxYKWDioYVMnxQEOKqCqMlsUKSuk/X6p5E6BTvkXGZm3kJ
         vK2FI87UG68lsUl8nGTMDbXUcpAZ+0js1b+JPArye787ZzBqtJucU0hU/Kw4aZWCEbGs
         CgJAwsllXfGl7GfhF68khbOP2wI9K7+SmT5xNLFlcYfsSHE1Xxom0+0XwsgJTb99ZigX
         pTPpsEyO8AOuaN79STn/r6omzJeHQ2707M3QKDmP4C9imQEaBbJSNLntqjIwkAU1ocBe
         vEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856756; x=1699461556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAlBVvkI2I5E+pK3aaQGYi3UgGWdj02dTU8aSSoMiHA=;
        b=Wsa4d9AVIRwNS/BubDGdEFLKvXpziFo2OCj1jQVAhsKS1cwHHlSWsAk3MlASEF9dJh
         pFFUrleSBhsTyIUAVYX5OJ30qlaitxfGNQgm84i1gs+8hCrtRYnsFwRrbvgCq8iYndwA
         meGy5y2n1mZwz/A15Y5EQioXIZRTre7CsfH8bxCBeEMMxPlzQeLP7cbD9ZgjMR0mAqpQ
         lL21jHOmaKqe1OVIwi0RIlV+3FvfUXtIG4FmonK/XH0tNxxQWrhe8uWFjUdZojeer2LT
         jpFewB1N255d+LRUSI5R/tbONpZFQr3HaVg7jyGiV1c2l5isYzxDxi9tkOp9N719TFZG
         cWPQ==
X-Gm-Message-State: AOJu0Yz5WfQYYLI01zre/n+hy7Fd9nAUteRdckwp/YT/K8s7PMCmxZ60
        zkK2J3T/u95qQdpsPUJMEgEoMio+Oso=
X-Google-Smtp-Source: AGHT+IEYo8M6ceIjkIN4xN2vga7/2yac7853sv8/QJlps2qpCi4+d163GKwPkq0wGSij37XcRaAAtQ==
X-Received: by 2002:a17:907:2da3:b0:9bd:c592:e0ce with SMTP id gt35-20020a1709072da300b009bdc592e0cemr2127753ejc.51.1698856755798;
        Wed, 01 Nov 2023 09:39:15 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170906ca4300b009ae3d711fd9sm122954ejb.69.2023.11.01.09.39.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:39:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: rework saturation check
Date:   Wed,  1 Nov 2023 17:39:11 +0100
Message-ID: <20231101163911.178218-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101163911.178218-1-cgzones@googlemail.com>
References: <20231101163911.178218-1-cgzones@googlemail.com>
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

Rework the saturation checks to actually check if there is enough data
available for the announced size before allocating actual memory.
This only works for input via mapped memory, since the remaining size
for streams is not easily available.

Application like setools do currently not benefit from this change,
since they load the policy via a stream.  There are currently multiple
interfaces to load a policy, so reworking them to use mapped memory by
default might be subject for future work.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c         |  2 +-
 libsepol/src/context.c       |  2 +-
 libsepol/src/module_to_cil.c |  2 +-
 libsepol/src/policydb.c      | 16 ++++++++--------
 libsepol/src/private.h       | 22 ++++++++++++++++------
 libsepol/src/services.c      |  2 +-
 6 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 6ab49c5e..f379d8d8 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -601,7 +601,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, uint32_t vers)
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
-	if (!nel) {
+	if (zero_or_saturated(nel, fp, sizeof(uint32_t) * 3)) {
 		ERR(fp->handle, "table is empty");
 		goto bad;
 	}
diff --git a/libsepol/src/context.c b/libsepol/src/context.c
index 5cc90afb..5ee21724 100644
--- a/libsepol/src/context.c
+++ b/libsepol/src/context.c
@@ -297,7 +297,7 @@ int context_from_string(sepol_handle_t * handle,
 	char *con_cpy = NULL;
 	sepol_context_t *ctx_record = NULL;
 
-	if (zero_or_saturated(con_str_len)) {
+	if (con_str_len == 0 || con_str_len == SIZE_MAX) {
 		ERR(handle, "Invalid context length");
 		goto err;
 	}
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index d2868019..1d0a507c 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -122,7 +122,7 @@ static int get_line(char **start, char *end, char **line)
 
 	for (len = 0; p < end && *p != '\n' && *p != '\0'; p++, len++);
 
-	if (zero_or_saturated(len)) {
+	if (len == 0 || len == SIZE_MAX) {
 		rc = 0;
 		goto exit;
 	}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f608aba4..00a986e8 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2854,7 +2854,7 @@ static int ocontext_read_xen(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
-				if (is_saturated(c->sid[0]))
+				if (c->sid[0] > 127)
 					return -1;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
@@ -2960,7 +2960,7 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
-				if (is_saturated(c->sid[0]))
+				if (c->sid[0] > 127)
 					return -1;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
@@ -3857,7 +3857,7 @@ static int scope_index_read(scope_index_t * scope_index,
 	if (rc < 0)
 		return -1;
 	scope_index->class_perms_len = le32_to_cpu(buf[0]);
-	if (is_saturated(scope_index->class_perms_len))
+	if (is_saturated(scope_index->class_perms_len, fp, sizeof(uint32_t) * 3))
 		return -1;
 	if (scope_index->class_perms_len == 0) {
 		scope_index->class_perms_map = NULL;
@@ -3913,7 +3913,7 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 		if (rc < 0) 
 			return -1;
 		nprim = le32_to_cpu(buf[0]);
-		if (is_saturated(nprim))
+		if (nprim == UINT32_MAX)
 			return -1;
 		nel = le32_to_cpu(buf[1]);
 		for (j = 0; j < nel; j++) {
@@ -4036,7 +4036,7 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 		goto cleanup;
 	scope->scope = le32_to_cpu(buf[0]);
 	scope->decl_ids_len = le32_to_cpu(buf[1]);
-	if (zero_or_saturated(scope->decl_ids_len)) {
+	if (zero_or_saturated(scope->decl_ids_len, fp, sizeof(uint32_t))) {
 		ERR(fp->handle, "invalid scope with no declaration");
 		goto cleanup;
 	}
@@ -4120,8 +4120,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 {
 
 	unsigned int i, j, r_policyvers;
-	uint32_t buf[5];
-	size_t len, nprim, nel;
+	uint32_t buf[5], nprim;
+	size_t len, nel;
 	char *policydb_str;
 	const struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
@@ -4315,7 +4315,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (rc < 0)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
-		if (is_saturated(nprim))
+		if (is_saturated(nprim, fp, sizeof(uint32_t) * 3))
 			goto bad;
 		nel = le32_to_cpu(buf[1]);
 		if (nel && !nprim) {
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 1833b497..d1fe66b6 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -44,13 +44,23 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
 
-#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
-# define is_saturated(x) (x == (typeof(x))-1 || (x) > (1U << 16))
-#else
-# define is_saturated(x) (x == (typeof(x))-1)
-#endif
+static inline int exceeds_available_bytes(size_t x, const struct policy_file *fp, size_t req_elem_size)
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
+#define is_saturated(x, fp, req_elem_size) ((x) == (typeof(x))-1 || exceeds_available_bytes(x, fp, req_elem_size))
 
-#define zero_or_saturated(x) ((x == 0) || is_saturated(x))
+#define zero_or_saturated(x, fp, req_elem_size) ((x) == 0 || is_saturated(x, fp, req_elem_size))
 
 #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
 
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 51bd56a0..f9280d89 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1748,7 +1748,7 @@ int str_read(char **strp, struct policy_file *fp, size_t len)
 	int rc;
 	char *str;
 
-	if (zero_or_saturated(len)) {
+	if (zero_or_saturated(len, fp, sizeof(char))) {
 		errno = EINVAL;
 		return -1;
 	}
-- 
2.42.0

