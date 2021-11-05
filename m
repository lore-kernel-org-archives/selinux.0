Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B9DC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781D761108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhKEPsl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhKEPsl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5AC06120A
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m14so33819447edd.0
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T4zoCLSNn+UWbrdzmPSjDWsR005sBygbIz7VlCCB5B8=;
        b=c1ki+bE2CMkS/q7u1zjC8j7abeF2GrfNtMn9G7bzPM14YjJ2S8ZtEDp5gthrxx6H98
         hh78gHsZo2PlRxtNbo7O7rUJguyzzgHGuxyOb5icQabowm11Xf+M0DOKv0YExjk4Zkjs
         qf36TedJJRO+rXlIkQ5ircrozZIGyXky2OBgvYql9E9uSUCvqUItuT5pAdLX1r3h1JH8
         B+2qfr2wSswYYyvkvjMX/zPi+7c2Dbh1nPwzERkYf7KcDP1Tdz6xDoJmFxt0BE5YGoXk
         UtGq44Bdq0i9+sZldEpKnpqL52Jc3ypRTxQgeBrzuF9hAEc2s28Je9toIG6U5SKZmzFC
         lXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4zoCLSNn+UWbrdzmPSjDWsR005sBygbIz7VlCCB5B8=;
        b=iET412o96kkn7jJVn3V0JY6mC0+3ixlkK/Dd8DvqEWxGNRdCZ2QjpYnRst0+RX/Nbl
         zGJQm/XtuWSyMTOdvtVdhcL24ExDlwaymHBiVBLzqisbgdGD5ffb1vrQOdYkyvdln69+
         CUFI/Tpb+38SA1lNOZ4skJdfw3t+ShlKLvUbEJTohDjfL26EF7zhh6jb09lUWNPbYETY
         XROGZHt54vVGofrLDLVw1KLnN6R4u3JkCugJU9ecuYrMFC6K/2iLbuhoJgPVcCKv2L63
         YcKi/kr2oUtOaR3IO1eFbhyPjDwyHWr1G2H3svfvfGE3HGaynkqboGGfzb+JSTCBTN03
         oB1Q==
X-Gm-Message-State: AOAM531QKvFuv0+qquKZHRDPJ46q8zVIc7/aJFpDr+l/NR2TzktAsIWo
        QknC+TCyjKChuVr9o10ZTmBWQoHQuvc=
X-Google-Smtp-Source: ABdhPJyXd5EuqLPCF7hXLAwdzH+gL4E+QrDHxip4u3gVcjFDuHOAG21wLvomdgpMiwjiPL9+XwZohw==
X-Received: by 2002:a05:6402:42c8:: with SMTP id i8mr10586261edc.373.1636127158752;
        Fri, 05 Nov 2021 08:45:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 22/36] libsepol: split validation of datum array gaps and entries
Date:   Fri,  5 Nov 2021 16:45:24 +0100
Message-Id: <20211105154542.38434-23-cgzones@googlemail.com>
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
2.33.1

