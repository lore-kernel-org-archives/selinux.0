Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA557C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhLIQyx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhLIQyx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:54:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0800C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so21953475edv.1
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eNwA3EUJFE+m3irceKXjnopYjD8/reD5rPigCO8qSjA=;
        b=pFxXXbBz14u5Ou0Gtq97LDORZDocIcnUhWKZFjZ/12iqDfTJMMzlfumOfiQWp3diES
         P3jsg2Qmib+2IhrEiYmbh8hdc+pYHMICVCF8JLeU0ue1wBGLkrhefYaISyNQi92Ihxgq
         QBazmzPozbG7kDtVvUkX4FLrLNigbn7geRSz6SmH/A/ymncbvBwtHodPskcpKChnradg
         Q5RuTbdzTuxdELthEw+sz0N+9AvIGrG9PnNhEcHHtW47mIC9ZZ204JhQQhCXCw6z1MDa
         j3KA80oAYmvUuS7bth7DNOKK1gSxeuyn4/D65oZdvBKt/BFvVutFgsAiWlKAhPDiJuh4
         l3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNwA3EUJFE+m3irceKXjnopYjD8/reD5rPigCO8qSjA=;
        b=AgtkyCMli7nqmluOLDadSAAtC+m4Z4ucWn4GUq3mFCJyt9jCVgOZObPBhHtwDWbydr
         PISwcqHuMYX3bhL63bA69goSIAwMyZMCQHwzfKV1bWigf0QCE9dm65orxVxHNF95Rql6
         5zA10sGvYoS90pSdWTl0ehcIVFtvDf5DBQT+FghoDMGep5aaFpaHwZSeuTZideC4SHn0
         bD6JNEZEeoLysBWaQ1/2qeh9DTZuJ3nvkileuRsOL8E8zdkhBsFk0Ffir0hGOauTFeYf
         mhw7MtXF1Hr1M0WWaY3L6xJES3OuBNUb+OfCzSplUH0Ai53n3a5M0v2nfyW+AG7HPixp
         zJWQ==
X-Gm-Message-State: AOAM533zbhthMcQ+UK4ai9z40iKnoB8UpUC8YbtAFIrTyrz00r+FwIkx
        e2FqX795BOb32vzv9pX64+JySY8hxW8=
X-Google-Smtp-Source: ABdhPJwqJJUzwiLS21bsCmdtWn0V0Q2usXxGUQLnP1FI3bPW4MaZG4lJSTPfB67BGRyPmE17AHjXMQ==
X-Received: by 2002:a17:906:dbef:: with SMTP id yd15mr16555338ejb.354.1639068581564;
        Thu, 09 Dec 2021 08:49:41 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:41 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 09/36] libsepol: use reallocarray wrapper to avoid overflows
Date:   Thu,  9 Dec 2021 17:49:01 +0100
Message-Id: <20211209164928.87459-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
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
index 33a11a15..5f762aba 100644
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
@@ -4117,7 +4117,7 @@ exit:
 static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
 {
 	int rc = -1;
-	char *d = NULL;
+	char *d = NULL, *d_tmp;
 	size_t d_len = 0;
 	size_t read_len = 0;
 	size_t max_len = 1 << 17; // start at 128KB, this is enough to hold about half of all the existing pp files
@@ -4133,12 +4133,13 @@ static int fp_to_buffer(FILE *fp, char **data, size_t *data_len)
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
2.34.1

