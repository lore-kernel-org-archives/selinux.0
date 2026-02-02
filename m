Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CE1FF1AE
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042963; cv=none; b=uhJ2r5vZ6nGbIfU73oZ/8AvLIhhjK1TzeT7LeFyW1XJDgQKZsWYDjNTF8E7RErvTvoJAmQhJ4VsaCe7dtDKqpA5ibSZ+8N7EghazXJLidZhqQsizRF342qksqDz2GEWOuYMoe+mAZkNtgFpycOIaIlcyiGM6MKK41mfsmN4mXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042963; c=relaxed/simple;
	bh=dliDADN2jrxb4xlv6Nq7kbyzES2zvzIV+NUGhrans+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9X2usSqro+gRMkhoEQ83exn4X3UpdRL6CG1PnKt+T8kSlTHSlBqTU88n3qsjUrAyfOxbtGElCE98OUUpMQfKYFGWJlIEY5cbIBE3QLYBZOqRq1ic6xTTqfHdW1NoKiVJf1vhRSfuiBWItLcuGLC8buixp7UyuE0GiwHmTjCkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ABdYyxfr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ABdYyxfr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042960;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3utVrnJlai4strQnswwvtjtxK9VKvI5WsaB9L+99yk=;
	b=ABdYyxfrzjjpu5nzBMfV2VJGL8c8tF71DhQqQL5+Uqr4BafxhT0YvQrnqRW7kaZzna43S4
	3yIAjwBmtCBQb+gplthUbNhHh3hlv9VHGj0KQmAgYB0TWAO0FPaBGVo1y9FQo2LR3jndtt
	7rS5f08xUCb4y5ETlGz97Qcs0tqTZ0YhOd9gyQHs+U6f3Ltr8L3FoFlJcbqgTIcJ4jHdNb
	X67jqL1/Dy+EBkterqKKYQurCik7HrFgDKH2qm3IPYe0EqlQq4Lpdd82x550lI47LqRPWs
	6PHBAqFwC6KI1Uy00oZH743MyLaXdWHjamQsIYjPdIU2ablmrykybugvKVCeog==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/4] libselinux: use C11 atomics
Date: Mon,  2 Feb 2026 15:35:52 +0100
Message-ID: <20260202143554.97209-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260202143554.97209-1-cgoettsche@seltendoof.de>
References: <20260202143554.97209-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use standard C11 atomics for compatibility.
Also explicitly use atomic types to ensure well-defined behavior even on
obscure platforms.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c          | 12 ++++++------
 libselinux/src/label_file.c     | 31 +++++++------------------------
 libselinux/src/label_file.h     | 32 ++++++--------------------------
 libselinux/src/label_internal.h |  5 +++--
 4 files changed, 22 insertions(+), 58 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 2c510290..40ba9f0b 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -127,14 +127,14 @@ int selabel_validate(struct selabel_lookup_rec *contexts)
 	bool validated;
 	int rc;
 
-	validated = __atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
+	validated = atomic_load_explicit(&contexts->validated, memory_order_acquire);
 	if (validated)
 		return 0;
 
 	__pthread_mutex_lock(&contexts->lock);
 
 	/* Check if another thread validated the context while we waited on the mutex */
-	validated = __atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
+	validated = atomic_load_explicit(&contexts->validated, memory_order_acquire);
 	if (validated) {
 		__pthread_mutex_unlock(&contexts->lock);
 		return 0;
@@ -142,7 +142,7 @@ int selabel_validate(struct selabel_lookup_rec *contexts)
 
 	rc = selinux_validate(&contexts->ctx_raw);
 	if (rc == 0)
-		__atomic_store_n(&contexts->validated, true, __ATOMIC_RELEASE);
+		atomic_store_explicit(&contexts->validated, true, memory_order_release);
 
 	__pthread_mutex_unlock(&contexts->lock);
 
@@ -166,14 +166,14 @@ static int selabel_fini(const struct selabel_handle *rec,
 	if (!translating)
 		return 0;
 
-	ctx_trans = __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
+	ctx_trans = atomic_load_explicit(&lr->ctx_trans, memory_order_acquire);
 	if (ctx_trans)
 		return 0;
 
 	__pthread_mutex_lock(&lr->lock);
 
 	/* Check if another thread translated the context while we waited on the mutex */
-	ctx_trans = __atomic_load_n(&lr->ctx_trans, __ATOMIC_ACQUIRE);
+	ctx_trans = atomic_load_explicit(&lr->ctx_trans, memory_order_acquire);
 	if (ctx_trans) {
 		__pthread_mutex_unlock(&lr->lock);
 		return 0;
@@ -181,7 +181,7 @@ static int selabel_fini(const struct selabel_handle *rec,
 
 	rc = selinux_raw_to_trans_context(lr->ctx_raw, &ctx_trans);
 	if (rc == 0)
-		__atomic_store_n(&lr->ctx_trans, ctx_trans, __ATOMIC_RELEASE);
+		atomic_store_explicit(&lr->ctx_trans, ctx_trans, memory_order_release);
 
 	__pthread_mutex_unlock(&lr->lock);
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b785eab6..de6937f5 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -578,6 +578,7 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bo
 	uint32_t data_u32, ctx_id, lineno;
 	uint16_t data_u16, regex_len;
 	uint8_t data_u8;
+	bool compiled;
 	int rc;
 
 	rspec->from_mmap = true;
@@ -663,8 +664,8 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating, bo
 	/*
 	 * Read pcre regex related data
 	 */
-	rc = regex_load_mmap(mmap_area, &rspec->regex, do_load_precompregex,
-			     &rspec->regex_compiled);
+	rc = regex_load_mmap(mmap_area, &rspec->regex, do_load_precompregex, &compiled);
+	rspec->regex_compiled = compiled;
 	if (rc < 0)
 		return -1;
 
@@ -1637,11 +1638,7 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 					if (file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == LABEL_FILE_KIND_ALL || lspec->file_kind == file_kind) {
 						struct lookup_result *r;
 
-#ifdef __ATOMIC_RELAXED
-						__atomic_store_n(&lspec->any_matches, true, __ATOMIC_RELAXED);
-#else
-#error "Please use a compiler that supports __atomic builtins"
-#endif
+						atomic_store_explicit(&lspec->any_matches, true, memory_order_relaxed);
 
 						if (strcmp(lspec->lr.ctx_raw, "<<none>>") == 0) {
 							errno = ENOENT;
@@ -1704,11 +1701,7 @@ static struct lookup_result *lookup_check_node(struct spec_node *node, const cha
 				struct lookup_result *r;
 
 				if (rc == REGEX_MATCH) {
-#ifdef __ATOMIC_RELAXED
-					__atomic_store_n(&rspec->any_matches, true, __ATOMIC_RELAXED);
-#else
-#error "Please use a compiler that supports __atomic builtins"
-#endif
+					atomic_store_explicit(&rspec->any_matches, true, memory_order_relaxed);
 				}
 
 				if (strcmp(rspec->lr.ctx_raw, "<<none>>") == 0) {
@@ -2123,12 +2116,7 @@ static void spec_node_stats(const struct spec_node *node)
 	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
 		const struct literal_spec *lspec = &node->literal_specs[i];
 
-#ifdef __ATOMIC_RELAXED
-		any_matches = __atomic_load_n(&node->literal_specs[i].any_matches, __ATOMIC_RELAXED);
-#else
-#error "Please use a compiler that supports __atomic builtins"
-#endif
-
+		any_matches = atomic_load_explicit(&node->literal_specs[i].any_matches, memory_order_relaxed);
 		if (!any_matches) {
 			COMPAT_LOG(SELINUX_WARNING,
 				"Warning!  No matches for (%s, %s, %s)\n",
@@ -2141,12 +2129,7 @@ static void spec_node_stats(const struct spec_node *node)
 	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
 		const struct regex_spec *rspec = &node->regex_specs[i];
 
-#ifdef __ATOMIC_RELAXED
-		any_matches = __atomic_load_n(&rspec->any_matches, __ATOMIC_RELAXED);
-#else
-#error "Please use a compiler that supports __atomic builtins"
-#endif
-
+		any_matches = atomic_load_explicit(&rspec->any_matches, memory_order_relaxed);
 		if (!any_matches) {
 			COMPAT_LOG(SELINUX_WARNING,
 				"Warning!  No matches for (%s, %s, %s)\n",
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 8fcf74e3..5c17fe41 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -85,8 +85,8 @@ struct regex_spec {
 	uint16_t prefix_len;			/* length of fixed path prefix */
 	uint8_t inputno;			/* Input number of source file */
 	uint8_t file_kind;			/* file type */
-	bool regex_compiled;			/* whether the regex is compiled */
-	bool any_matches;			/* whether any pathname match */
+	atomic_bool regex_compiled;		/* whether the regex is compiled */
+	atomic_bool any_matches;		/* whether any pathname match */
 	bool from_mmap;				/* whether this spec is from an mmap of the data */
 };
 
@@ -98,7 +98,7 @@ struct literal_spec {
 	uint16_t prefix_len;			/* length of fixed path prefix, i.e. length of the literal match */
 	uint8_t inputno;			/* Input number of source file */
 	uint8_t file_kind;			/* file type */
-	bool any_matches;			/* whether any pathname match */
+	atomic_bool any_matches;		/* whether any pathname match */
 	bool from_mmap;				/* whether this spec is from an mmap of the data */
 };
 
@@ -410,14 +410,7 @@ static int compile_regex(struct regex_spec *spec, char *errbuf, size_t errbuf_si
 	 * init_routine does not take a parameter, it's not possible
 	 * to use, so we generate the same effect with atomics and a
 	 * mutex */
-#ifdef __ATOMIC_RELAXED
-	regex_compiled =
-		__atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
-#else
-	/* GCC <4.7 */
-	__sync_synchronize();
-	regex_compiled = spec->regex_compiled;
-#endif
+	regex_compiled = atomic_load_explicit(&spec->regex_compiled, memory_order_acquire);
 	if (regex_compiled) {
 		return 0; /* already done */
 	}
@@ -425,14 +418,7 @@ static int compile_regex(struct regex_spec *spec, char *errbuf, size_t errbuf_si
 	__pthread_mutex_lock(&spec->regex_lock);
 	/* Check if another thread compiled the regex while we waited
 	 * on the mutex */
-#ifdef __ATOMIC_RELAXED
-	regex_compiled =
-		__atomic_load_n(&spec->regex_compiled, __ATOMIC_ACQUIRE);
-#else
-	/* GCC <4.7 */
-	__sync_synchronize();
-	regex_compiled = spec->regex_compiled;
-#endif
+	regex_compiled = atomic_load_explicit(&spec->regex_compiled, memory_order_acquire);
 	if (regex_compiled) {
 		__pthread_mutex_unlock(&spec->regex_lock);
 		return 0;
@@ -474,13 +460,7 @@ static int compile_regex(struct regex_spec *spec, char *errbuf, size_t errbuf_si
 	}
 
 	/* Done. */
-#ifdef __ATOMIC_RELAXED
-	__atomic_store_n(&spec->regex_compiled, true, __ATOMIC_RELEASE);
-#else
-	/* GCC <4.7 */
-	spec->regex_compiled = true;
-	__sync_synchronize();
-#endif
+	atomic_store_explicit(&spec->regex_compiled, true, memory_order_release);
 	__pthread_mutex_unlock(&spec->regex_lock);
 	return 0;
 }
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 743dbf94..dd233533 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -10,6 +10,7 @@
 
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdatomic.h>
 #include <stdio.h>
 #include <selinux/selinux.h>
 #include <selinux/label.h>
@@ -70,10 +71,10 @@ extern void digest_gen_hash(struct selabel_digest *digest);
 
 struct selabel_lookup_rec {
 	char * ctx_raw;
-	char * ctx_trans;
+	char * _Atomic ctx_trans;
 	pthread_mutex_t lock;	/* lock for validation and translation */
 	unsigned int lineno;
-	bool validated;
+	atomic_bool validated;
 };
 
 struct selabel_handle {
-- 
2.51.0

