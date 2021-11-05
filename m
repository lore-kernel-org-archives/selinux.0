Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F71C43219
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A62461108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhKEPse (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhKEPsd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217D8C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m14so33818038edd.0
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FyyVZbCFe9V3RPN8wdAKTt8hZXKpI15hbdHylXt5bx4=;
        b=oDQGz1XHcfp4lnHmpFsYwBcY7NMAh2jeSss8QxjCMS66L9y4hpda2FISGzt8/2L1Ft
         Zc1DhYkrqMBMUIoD0QbcKAfHghJCJ8iFIj+nbKebB1FzdT1yhdtTH4wFRd9yzbn6L46a
         TdFpkj3F0cgHa6RAfD0+Td4DxCuHV371SnXWkReL2nb1IXiaEnQTbkExmbKKd4Yh73k/
         wjUztPx0g325Hk+5793/UyRqSBGJoQXhxRW1gj34YTggV2wbDAaSNS2ggSEnR65O2AIS
         9GCEANYE6QAlvbNL4Sl89R2wK5Areg1hN0MwMbSvyxrGKwp/zebBhM9U+yEPxyHK2vFD
         BjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FyyVZbCFe9V3RPN8wdAKTt8hZXKpI15hbdHylXt5bx4=;
        b=ibfF2oVnENLNtsbncogDAVfiPN8yVcoX4bF6AZ7C4R3maNu6kGTKN6RyGi/S9CINQv
         q3mr5ZcJyDc+MmhqYs2aBeyK3ntgcO+S6PlxErDMvIoTk4DHcEyVS8d30EGT1Un2Nhzu
         OyGvpUvJQ874SO2Xci8igOniFDMVv1QpxQWrHIzoAHR22bj5Pub0jVtCdKBduPMxqx5g
         NXhx9lSAKcLLYN+iwtPl22hVHLhsse0LAugIo9v2CneK0xYl9NjqlWGqDOQR+XbDDEAP
         Q7snYdgfqlUv+KEIFM55/ODcxHy9CqIFGwblRiAevu2LabzlqGHvMmjlmOm3/HZ7HfD1
         aW5w==
X-Gm-Message-State: AOAM5311IPakjDosBNJOFqi1Fa1Vq0W4D7Kb81TF1rnP2lWlt3bh48uW
        m0ZaX/UiRr7SCygrD2ujvfyt+zbbbEM=
X-Google-Smtp-Source: ABdhPJybOOdsmSmyfMwPXQp+G+JX3u5HveH/kBDQiMDsTVGwWLp+I2Au6HdiX5GNl4bJBsnl50godA==
X-Received: by 2002:a05:6402:5190:: with SMTP id q16mr41348249edd.123.1636127151615;
        Fri, 05 Nov 2021 08:45:51 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 09/36] libsepol: use reallocarray wrapper to avoid overflows
Date:   Fri,  5 Nov 2021 16:45:11 +0100
Message-Id: <20211105154542.38434-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use a wrapper to guard `realloc(p, a * b)` type allocations, to detect
multiplication overflows, which result in too few memory being
allocated.

Use a custom implementation if the used C library does not offer one.

Also use temporary variables for realloc(3) results in add_i_to_a() and
fp_to_buffer().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/Makefile           |  6 ++++++
 libsepol/src/kernel_to_common.c |  4 ++--
 libsepol/src/module_to_cil.c    |  9 +++++----
 libsepol/src/optimize.c         |  5 +++--
 libsepol/src/private.h          | 11 +++++++++++
 libsepol/src/services.c         |  6 +++---
 libsepol/src/user_record.c      |  5 +++--
 libsepol/src/users.c            | 12 ++++++------
 libsepol/src/util.c             | 11 +++++++----
 9 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index dc8b1773..13410c67 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -29,6 +29,12 @@ LOBJS += $(sort $(patsubst %.c,%.lo,$(sort $(wildcard $(CILDIR)/src/*.c)) $(CIL_
 override CFLAGS += -I$(CILDIR)/include
 endif
 
+# check for reallocarray(3) availability
+H := \#
+ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+override CFLAGS += -DHAVE_REALLOCARRAY
+endif
+
 LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=$(LIBMAP),-z,defs
 
 LN=ln
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index a7453d3c..51df8c25 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -161,7 +161,7 @@ int strs_add(struct strs *strs, char *s)
 		char **new;
 		unsigned i = strs->size;
 		strs->size *= 2;
-		new = realloc(strs->list, sizeof(char *)*strs->size);
+		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
 			sepol_log_err("Out of memory");
 			return -1;
@@ -220,7 +220,7 @@ int strs_add_at_index(struct strs *strs, char *s, unsigned index)
 		while (index >= strs->size) {
 			strs->size *= 2;
 		}
-		new = realloc(strs->list, sizeof(char *)*strs->size);
+		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
 			sepol_log_err("Out of memory");
 			return -1;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ad0880bd..84e49c5b 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -453,7 +453,7 @@ static int stack_push(struct stack *stack, void *ptr)
 	void *new_stack;
 
 	if (stack->pos + 1 == stack->size) {
-		new_stack = realloc(stack->stack, sizeof(*stack->stack) * (stack->size * 2));
+		new_stack = reallocarray(stack->stack, stack->size * 2, sizeof(*stack->stack));
 		if (new_stack == NULL) {
 			goto exit;
 		}
@@ -4123,7 +4123,7 @@ exit:
 static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 {
 	int rc = -1;
-	char *d = NULL;
+	char *d = NULL, *d_tmp;
 	size_t d_len = 0;
 	size_t read_len = 0;
 	size_t max_len = 1 << 17; // start at 128KB, this is enough to hold about half of all the existing pp files
@@ -4139,12 +4139,13 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 		d_len += read_len;
 		if (d_len == max_len) {
 			max_len *= 2;
-			d = realloc(d, max_len);
-			if (d == NULL) {
+			d_tmp = realloc(d, max_len);
+			if (d_tmp == NULL) {
 				log_err("Out of memory");
 				rc = -1;
 				goto exit;
 			}
+			d = d_tmp;
 		}
 	}
 
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index f8298fb7..8a048702 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -59,8 +59,9 @@ static int type_vec_append(struct type_vec *v, uint32_t type)
 {
 	if (v->capacity == v->count) {
 		unsigned int new_capacity = v->capacity * 2;
-		uint32_t *new_types = realloc(v->types,
-					      new_capacity * sizeof(*v->types));
+		uint32_t *new_types = reallocarray(v->types,
+						   new_capacity,
+						   sizeof(*v->types));
 		if (!new_types)
 			return -1;
 
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index d3d65a57..a8cc1472 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -92,3 +92,14 @@ static inline void* mallocarray(size_t nmemb, size_t size) {
 
 	return malloc(nmemb * size);
 }
+
+#ifndef HAVE_REALLOCARRAY
+static inline void* reallocarray(void *ptr, size_t nmemb, size_t size) {
+	if (size && nmemb > (size_t)-1 / size) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	return realloc(ptr, nmemb * size);
+}
+#endif
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index edcdde21..0f36ac53 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -94,7 +94,7 @@ static void push(char *expr_ptr)
 		else
 			new_stack_len = stack_len * 2;
 
-		new_stack = realloc(stack, new_stack_len * sizeof(*stack));
+		new_stack = reallocarray(stack, new_stack_len, sizeof(*stack));
 		if (!new_stack) {
 			ERR(NULL, "unable to allocate stack space");
 			return;
@@ -449,8 +449,8 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 			else
 				new_expr_list_len = expr_list_len * 2;
 
-			new_expr_list = realloc(expr_list,
-					new_expr_list_len * sizeof(*expr_list));
+			new_expr_list = reallocarray(expr_list,
+					new_expr_list_len, sizeof(*expr_list));
 			if (!new_expr_list) {
 				ERR(NULL, "failed to allocate expr buffer stack");
 				rc = -ENOMEM;
diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index c1356a6b..404fa3a8 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -183,8 +183,9 @@ int sepol_user_add_role(sepol_handle_t * handle,
 	if (!role_cp)
 		goto omem;
 
-	roles_realloc = realloc(user->roles,
-				sizeof(char *) * (user->num_roles + 1));
+	roles_realloc = reallocarray(user->roles,
+				     user->num_roles + 1,
+				     sizeof(char *));
 	if (!roles_realloc)
 		goto omem;
 
diff --git a/libsepol/src/users.c b/libsepol/src/users.c
index b895b7f5..a7406214 100644
--- a/libsepol/src/users.c
+++ b/libsepol/src/users.c
@@ -226,17 +226,17 @@ int sepol_user_modify(sepol_handle_t * handle,
 		void *tmp_ptr;
 
 		/* Ensure reverse lookup array has enough space */
-		tmp_ptr = realloc(policydb->user_val_to_struct,
-				  (policydb->p_users.nprim +
-				   1) * sizeof(user_datum_t *));
+		tmp_ptr = reallocarray(policydb->user_val_to_struct,
+				  policydb->p_users.nprim + 1,
+				  sizeof(user_datum_t *));
 		if (!tmp_ptr)
 			goto omem;
 		policydb->user_val_to_struct = tmp_ptr;
 		policydb->user_val_to_struct[policydb->p_users.nprim] = NULL;
 
-		tmp_ptr = realloc(policydb->sym_val_to_name[SYM_USERS],
-				  (policydb->p_users.nprim +
-				   1) * sizeof(char *));
+		tmp_ptr = reallocarray(policydb->sym_val_to_name[SYM_USERS],
+				  policydb->p_users.nprim + 1,
+				  sizeof(char *));
 		if (!tmp_ptr)
 			goto omem;
 		policydb->sym_val_to_name[SYM_USERS] = tmp_ptr;
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 902c63c5..b7230564 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -40,6 +40,8 @@ struct val_to_name {
  * 0).  Return 0 on success, -1 on out of memory. */
 int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a)
 {
+	uint32_t *new;
+
 	if (cnt == NULL || a == NULL)
 		return -1;
 
@@ -48,17 +50,18 @@ int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a)
 	 * than be smart about it, for now we realloc() the array each
 	 * time a new uint32_t is added! */
 	if (*a != NULL)
-		*a = (uint32_t *) realloc(*a, (*cnt + 1) * sizeof(uint32_t));
+		new = (uint32_t *) reallocarray(*a, *cnt + 1, sizeof(uint32_t));
 	else {			/* empty list */
 
 		*cnt = 0;
-		*a = (uint32_t *) malloc(sizeof(uint32_t));
+		new = (uint32_t *) malloc(sizeof(uint32_t));
 	}
-	if (*a == NULL) {
+	if (new == NULL) {
 		return -1;
 	}
-	(*a)[*cnt] = i;
+	new[*cnt] = i;
 	(*cnt)++;
+	*a = new;
 	return 0;
 }
 
-- 
2.33.1

