Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB61DC77B6C
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 21:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDLVE2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjDLVEQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 17:04:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA5683D5
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:14 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id o7so9772746qvs.0
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681333450; x=1683925450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVp13DBBQSoGrp6dwy9+yC8OUCGE1HeNdpOjesuTIm0=;
        b=OtAu5OMRHzIMxC0rlriTjMR3RlvwYuESOMykyDqWtdaFnddCvtIYlJzd+xnCcBrGhY
         Hu26vzLF15i2rwcnq9QXtlhKiZ+BzuWpIuFvOhzVc4wwVfUfqZpKxEsdIwvh29t3AlWw
         pYrH/PChnnZtvtT4Ap/KO9H/CA2sKL9Se32VEMvn4+XoXuJOpaWjE9jyxUmI4ys1Zp2d
         Wo1udBOq27rBTD0rf0rfUqh8/FeA91jAtntpI2UDXIoK1FaoN2PeZxDn0nx4BKdCef15
         zVqmNhIlaobGlwM/zUSeZ4UJ+K4indKNnax0QLifNJ6XgqgT/VbfrBew/CA6CL70AfhS
         rIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333450; x=1683925450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVp13DBBQSoGrp6dwy9+yC8OUCGE1HeNdpOjesuTIm0=;
        b=lBbQWXuYFHsP9uK/42JzzucQJcKwYavECcICrdpf8rCisydxji4GodPYmsThfeVbcB
         YfaDL1D+JXI7aQTIdxagn0VHv4tuljawtJtxP/GBAA70NG90ZZZSU0eBzNHgRZUwmcHq
         cOj/aaTCCcs4wULNMCSORlWleGnYO/TZ6RXlUfQERZi4s+Fa+RZhjpFbhl9DXLiD9Sx7
         Oy1x3YMQvze2RcIXJb69zkY6XK7qtjjbyB8v6OnczBellMuJMaBtGRDoVROYrYm871/P
         sHzBLVyBr4tzeXWAbxYaj7q31QxnZd6JRq5z1pN+8SJGtSkQSIbcnMDw7UfYYLi7u47T
         7Pdw==
X-Gm-Message-State: AAQBX9f41uftJQl4y69w8cEw654Nf14cf3UFtp7pDX4qgnVdOycEQW2R
        AwoGFc06vGGtLSjpbgTE7kBE4ozEw8s=
X-Google-Smtp-Source: AKy350bJDM9K1XMi2zSMuE0pvfmHZ7dwIvWYUZjqMocmmL1H7tzLDmZwJH8MuXkhg4gOuoKdBMkCXg==
X-Received: by 2002:a05:6214:21ae:b0:5ef:4c85:2cd0 with SMTP id t14-20020a05621421ae00b005ef4c852cd0mr176900qvc.36.1681333450612;
        Wed, 12 Apr 2023 14:04:10 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id oe6-20020a056214430600b005e16003edc9sm5025758qvb.104.2023.04.12.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:04:10 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6] libsepol/cil: Do not call ebitmap_init twice for an ebitmap
Date:   Wed, 12 Apr 2023 17:04:02 -0400
Message-Id: <20230412210406.522892-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412210406.522892-1-jwcart2@gmail.com>
References: <20230412210406.522892-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While it does no harm to call ebitmap_init() twice for an ebitmap,
since it is just memsetting the ebitmap to 0, it is poor practice.

In the function cil_type_matches() in cil_find.c, either ebitmap_and()
or ebitmap_set_bit() will be called. The function ebitmap_and() will
call ebitmap_init() on the destination ebitmap, but ebitmap_set_bit()
does not.

Instead of calling ebitmap_init() before the call to cil_type_matches(),
let cil_type_matches() make the call if it is going to call
ebitmap_set_bit(). It can also call ebitmap_destroy() on an error.

Since we are removing the call to ebitmap_init() in cil_self_match_any(),
cleanup some other things in the function (like using the FLAVOR()
macro and using ebitmap_is_empty()).

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_find.c | 60 +++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index 8b755277..0246d133 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -85,29 +85,34 @@ static int cil_type_matches(ebitmap_t *matches, struct cil_symtab_datum *d1, str
 	enum cil_flavor f1 = FLAVOR(d1);
 	enum cil_flavor f2 = FLAVOR(d2);
 
-	if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
-		struct cil_type *t1 = (struct cil_type *)d1;
-		struct cil_type *t2 = (struct cil_type *)d2;
-		if (t1->value == t2->value) {
-			ebitmap_set_bit(matches, t1->value, 1);
-		}
-	} else if (f1 == CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
-		struct cil_typeattribute *a = (struct cil_typeattribute *)d1;
-		struct cil_type *t = (struct cil_type *)d2;
-		if (ebitmap_get_bit(a->types, t->value)) {
-			ebitmap_set_bit(matches, t->value, 1);
-		}
-	} else if (f1 != CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
-		struct cil_type *t = (struct cil_type *)d1;
-		struct cil_typeattribute *a = (struct cil_typeattribute *)d2;
-		if (ebitmap_get_bit(a->types, t->value)) {
-			ebitmap_set_bit(matches, t->value, 1);
-		}
-	} else {
-		/* Both are attributes */
+	if (f1 == CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
 		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
 		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
 		rc = ebitmap_and(matches, a1->types, a2->types);
+	} else {
+		ebitmap_init(matches);
+		if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
+			struct cil_type *t1 = (struct cil_type *)d1;
+			struct cil_type *t2 = (struct cil_type *)d2;
+			if (t1->value == t2->value) {
+				rc = ebitmap_set_bit(matches, t1->value, 1);
+			}
+		} else if (f1 == CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
+			struct cil_typeattribute *a = (struct cil_typeattribute *)d1;
+			struct cil_type *t = (struct cil_type *)d2;
+			if (ebitmap_get_bit(a->types, t->value)) {
+				rc = ebitmap_set_bit(matches, t->value, 1);
+			}
+		} else { // f1 != CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE
+			struct cil_type *t = (struct cil_type *)d1;
+			struct cil_typeattribute *a = (struct cil_typeattribute *)d2;
+			if (ebitmap_get_bit(a->types, t->value)) {
+				rc = ebitmap_set_bit(matches, t->value, 1);
+			}
+		}
+		if (rc != SEPOL_OK) {
+			ebitmap_destroy(matches);
+		}
 	}
 
 	return rc;
@@ -115,31 +120,28 @@ static int cil_type_matches(ebitmap_t *matches, struct cil_symtab_datum *d1, str
 
 /* s1 is the src type that is matched with a self
  * s2, and t2 are the source and type of the other rule
+ * Assumes there is a match between s1 and s2
  */
 static int cil_self_match_any(struct cil_symtab_datum *s1, struct cil_symtab_datum *s2, struct cil_symtab_datum *t2)
 {
 	int rc;
-	struct cil_tree_node *n1 = NODE(s1);
-	if (n1->flavor != CIL_TYPEATTRIBUTE) {
+
+	if (FLAVOR(s1) != CIL_TYPEATTRIBUTE) {
 		rc = cil_type_match_any(s1, t2);
 	} else {
 		struct cil_typeattribute *a = (struct cil_typeattribute *)s1;
 		ebitmap_t map;
-		ebitmap_init(&map);
 		rc = cil_type_matches(&map, s2, t2);
 		if (rc < 0) {
-			ebitmap_destroy(&map);
-			goto exit;
+			return rc;
 		}
-		if (map.node == NULL) {
-			rc = CIL_FALSE;
-			goto exit;
+		if (ebitmap_is_empty(&map)) {
+			return CIL_FALSE;
 		}
 		rc = ebitmap_match_any(&map, a->types);
 		ebitmap_destroy(&map);
 	}
 
-exit:
 	return rc;
 }
 
-- 
2.39.2

