Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AA6C001E0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjHIUky (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjHIUkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:40:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A2196
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:40:52 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-765a7768f1dso17777785a.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691613651; x=1692218451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkoXBwXrQ5LRt3UU4emrLWsDPN+ezmGSl2c5buk89ik=;
        b=g4f0iiwcitLyy+60gbzurysjLMW91jB6Eaz5ph9TIpnOCI7kBeS676tsTfhSWU0xBU
         7UwqNR9IUKhqWu9W31ysLK2+mlEeqLez4EIyMuZKe493fub0KSQ2Dqcl5DVQu+JhZLQu
         hZYtbCaT23sx21vQTBlu+/dLDEDGdyx2pyh10fv4K0vcOZEwE4KOafTSJpG0UGv13yCu
         bj78tZf3MYLxhcSu2CU5elrbyJvWt8FF7KtJOiEYgBl9VlabGdWeH3IBcmLYDdLT+4jg
         DU87xIQcW66FrSZzDEqXX2tXMV+cNdlWjqHIg3Ukig7qZrjXZ5yI5WJirpEl/BLqjeTg
         ixeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613651; x=1692218451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkoXBwXrQ5LRt3UU4emrLWsDPN+ezmGSl2c5buk89ik=;
        b=jDEWGIHx5a/mWG7xJn0Pw78oEPKKTARAOCPrUhWskkTpF+FwKhh36NyYk/1O3Bmig3
         EAsfQtXdMOOkFP7WGN7bvNB4s/MMS16yzedspTafX9uDvrf9LkT8AXKocBbKYv+KQRG4
         v7EVo14CQsvvuPXw8irfg6zxRF7IUpQONGg4BBy77bXoJpHXt1yt/gZRex5bTChO8RoS
         iTVuQhwDxo8Ry/5+sMg7Ag6rs74Azwpe0rrXRRy/5Xdj2C/Ucg5pspSZnItsTv1v4hOT
         dEoJkPOp+cdg4q+FcX193EoTnIB8ll/tSK1icN9cF/jlW65KzjEuADFnUkDdiBRClpEW
         Nk8w==
X-Gm-Message-State: AOJu0YwrUCKxdqcM/5j4ESdwwPBQDTFHH2fvIL/MUJ08gTjzpDSsHHVm
        hTRX78Sn1gk/5PBQbamXKCCbTotjTRg=
X-Google-Smtp-Source: AGHT+IHk0YDVq5PgKX9slMF8FrrqbeZ0TYyzpH2ROASrd/SagKSLaD/TXqnJ6buqwIrBjtvAY5ZxAA==
X-Received: by 2002:a05:620a:45a4:b0:76c:7d2a:2dbf with SMTP id bp36-20020a05620a45a400b0076c7d2a2dbfmr123088qkb.57.1691613650928;
        Wed, 09 Aug 2023 13:40:50 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b0041020e8e261sm711295qtx.1.2023.08.09.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:40:50 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, cgzones@googlemail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/7 v2] libsepol/cil: Do not call ebitmap_init twice for an ebitmap
Date:   Wed,  9 Aug 2023 16:40:41 -0400
Message-ID: <20230809204046.110783-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809204046.110783-1-jwcart2@gmail.com>
References: <20230809204046.110783-1-jwcart2@gmail.com>
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
2.41.0

