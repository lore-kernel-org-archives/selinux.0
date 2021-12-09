Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C36C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhLIQz0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241345AbhLIQzX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78220C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z5so21858336edd.3
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oO1z/sdb+6MKKOccuPbUWTe/s1K4E+DsLzWKOcVaE9U=;
        b=q0Dfj4oL8mKtaIbxumPk9Alybl4Yon47PpD4IZny8ETa/5w1UnPpDQAEKxLP6E+xDz
         l2Wytf7EszkJPFD04hH8yNxwRvg95d1yCSHxP6/sLeTWNFm5spqiATrDdd2Cl3PfHWHo
         TcjAeJUcZlU2pynvg2zFk1yjAWrCM2wuGTl7XvcnWze7o/fSh/cIGdvbvrA4cT9HwhLM
         b1bXTQ7Ur5dKvN1WIqAq2Hxtpds+DfzPimP5B18+xzJyMSR+d5RvAU99TMntpct1Iuto
         Dz3snqMqk/VUWuTU1SCQIrTCQiEAICnt7LEDTu+NkPVWO+CWtKpmGseMaxEzC37dg2h/
         AIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oO1z/sdb+6MKKOccuPbUWTe/s1K4E+DsLzWKOcVaE9U=;
        b=jcHReVXoQHjrMmuF8jgGfwGkecmtrpzQYfmLq5TEDNTOW/Uo/JcHXfdbCkswLt9Gtr
         4mMErc0xYs5AS3V5rUnxk/TNbz3TF5Kjx7sGphsrbGc4YUJie3MDjJzFGi+Iw0roRO3s
         SfKvgO83bHNrDsHBDji2WCAMqzN/LZsQYPGwUaBdMLElY32HF/eem8t4O9q0GBlx6kCg
         YrwLhWCbMXNpBCBmoAH+mxLbFanpMkispdBAF5bOnGkJBEI90ckesAd82IpoSOUnNmmh
         KadtAo1i3dI/C3JIyPjFg30Zt5Eh6u5cDkJaaPEbP/jc2uRHKwAGwJTXVfXk7yraTA5r
         xH7A==
X-Gm-Message-State: AOAM530giQIepRZuhTszHr/P+dffz62v59D5qy+G/jrx9LzHwTVkUWFd
        XhxwqFhIej1Uy6LKbg4un6zCFrYOYcQ=
X-Google-Smtp-Source: ABdhPJzKpD8P6FtQ56tY49svoHHXB6u6qKpqlyymlw/X1Aq7jiKHypQ8rQGGNxzvc7+Yp1jWXkOYAw==
X-Received: by 2002:a17:906:d54c:: with SMTP id cr12mr16508062ejc.56.1639068589991;
        Thu, 09 Dec 2021 08:49:49 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:49 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 22/36] libsepol: split validation of datum array gaps and entries
Date:   Thu,  9 Dec 2021 17:49:14 +0100
Message-Id: <20211209164928.87459-23-cgzones@googlemail.com>
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

Split the validation of array datums regarding their gaps and entries to
simplify further checking of common classes, booleans, levels and
categories.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 112 ++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 39 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5804d247..d4dfab5c 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -6,11 +6,19 @@
 #include "debug.h"
 #include "policydb_validate.h"
 
+#define bool_xor(a, b) (!(a) != !(b))
+#define bool_xnor(a, b) !bool_xor(a, b)
+
 typedef struct validate {
 	uint32_t nprim;
 	ebitmap_t gaps;
 } validate_t;
 
+typedef struct map_arg {
+	validate_t *flavors;
+	sepol_handle_t *handle;
+	int mls;
+} map_arg_t;
 
 static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitmap_t *gaps)
 {
@@ -211,6 +219,13 @@ bad:
 	return -1;
 }
 
+static int validate_class_datum_wrapper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	map_arg_t *margs = args;
+
+	return validate_class_datum(margs->handle, d, margs->flavors);
+}
+
 static int validate_role_datum(sepol_handle_t *handle, role_datum_t *role, validate_t flavors[])
 {
 	if (validate_value(role->s.value, &flavors[SYM_ROLES]))
@@ -231,6 +246,13 @@ bad:
 	return -1;
 }
 
+static int validate_role_datum_wrapper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	map_arg_t *margs = args;
+
+	return validate_role_datum(margs->handle, d, margs->flavors);
+}
+
 static int validate_type_datum(sepol_handle_t *handle, type_datum_t *type, validate_t flavors[])
 {
 	if (validate_value(type->s.value, &flavors[SYM_TYPES]))
@@ -247,6 +269,13 @@ bad:
 	return -1;
 }
 
+static int validate_type_datum_wrapper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	map_arg_t *margs = args;
+
+	return validate_type_datum(margs->handle, d, margs->flavors);
+}
+
 static int validate_mls_semantic_cat(mls_semantic_cat_t *cat, validate_t *cats)
 {
 	for (; cat; cat = cat->next) {
@@ -310,32 +339,25 @@ bad:
 	return -1;
 }
 
-static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	map_arg_t *margs = args;
+
+	return validate_user_datum(margs->handle, d, margs->flavors);
+}
+
+static int validate_datum_array_gaps(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
 	unsigned int i;
 
 	for (i = 0; i < p->p_classes.nprim; i++) {
-		if (p->class_val_to_struct[i]) {
-			if (ebitmap_get_bit(&flavors[SYM_CLASSES].gaps, i))
-				goto bad;
-			if (validate_class_datum(handle, p->class_val_to_struct[i], flavors))
-				goto bad;
-		} else {
-			if (!ebitmap_get_bit(&flavors[SYM_CLASSES].gaps, i))
-				goto bad;
-		}
+		if (bool_xnor(p->class_val_to_struct[i], ebitmap_get_bit(&flavors[SYM_CLASSES].gaps, i)))
+			goto bad;
 	}
 
 	for (i = 0; i < p->p_roles.nprim; i++) {
-		if (p->role_val_to_struct[i]) {
-			if (ebitmap_get_bit(&flavors[SYM_ROLES].gaps, i))
-				goto bad;
-			if (validate_role_datum(handle, p->role_val_to_struct[i], flavors))
-				goto bad;
-		} else {
-			if (!ebitmap_get_bit(&flavors[SYM_ROLES].gaps, i))
-				goto bad;
-		}
+		if (bool_xnor(p->role_val_to_struct[i], ebitmap_get_bit(&flavors[SYM_ROLES].gaps, i)))
+			goto bad;
 	}
 
 	/*
@@ -344,34 +366,43 @@ static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate
 	 */
 	if (p->policyvers < POLICYDB_VERSION_AVTAB || p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
 		for (i = 0; i < p->p_types.nprim; i++) {
-			if (p->type_val_to_struct[i]) {
-				if (ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i))
-					goto bad;
-				if (validate_type_datum(handle, p->type_val_to_struct[i], flavors))
-					goto bad;
-			} else {
-				if (!ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i))
-					goto bad;
-			}
+			if (bool_xnor(p->type_val_to_struct[i], ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i)))
+				goto bad;
 		}
 	}
 
 	for (i = 0; i < p->p_users.nprim; i++) {
-		if (p->user_val_to_struct[i]) {
-			if (ebitmap_get_bit(&flavors[SYM_USERS].gaps, i))
-				goto bad;
-			if (validate_user_datum(handle, p->user_val_to_struct[i], flavors))
-				goto bad;
-		} else {
-			if (!ebitmap_get_bit(&flavors[SYM_USERS].gaps, i))
-				goto bad;
-		}
+		if (bool_xnor(p->user_val_to_struct[i], ebitmap_get_bit(&flavors[SYM_USERS].gaps, i)))
+			goto bad;
 	}
 
 	return 0;
 
 bad:
-	ERR(handle, "Invalid datum arrays");
+	ERR(handle, "Invalid datum array gaps");
+	return -1;
+}
+
+static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	map_arg_t margs = { flavors, handle, p->mls };
+
+	if (hashtab_map(p->p_classes.table, validate_class_datum_wrapper, &margs))
+		goto bad;
+
+	if (hashtab_map(p->p_roles.table, validate_role_datum_wrapper, &margs))
+		goto bad;
+
+	if (hashtab_map(p->p_types.table, validate_type_datum_wrapper, &margs))
+		goto bad;
+
+	if (hashtab_map(p->p_users.table, validate_user_datum_wrapper, &margs))
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid datum array entries");
 	return -1;
 }
 
@@ -762,7 +793,10 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_scopes(handle, p->scope, p->global))
 		goto bad;
 
-	if (validate_datum_arrays(handle, p, flavors))
+	if (validate_datum_array_gaps(handle, p, flavors))
+		goto bad;
+
+	if (validate_datum_array_entries(handle, p, flavors))
 		goto bad;
 
 	validate_array_destroy(flavors);
-- 
2.34.1

