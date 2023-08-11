Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F78C41513
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHKQ1w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjHKQ1v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF90273E
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c4923195dso298175466b.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771269; x=1692376069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBLHW0O+U7ltOxkiaFrPl4r80XrqUswnN0F1DvZlWLA=;
        b=sX7yhtM8oH5mQ8RQp8DcuwDdvJxN7sc88gND1BeF+HugGLm08JmDO+ZDFBT8jQ2UgC
         HYU2vlioZm0Rz3YYcsDpphbEQAYWfQrZqRTRYhcwT2grHYpRdYaYu8ZOGJoVwLDyokJk
         k7iorO7TO+3Eo/03zpicbnL9ZIoVWJPlrjP6AcMGmGNA8b8Jx+/fC+DZZbKn2FqssBdn
         Y2SWv4FpbCsPIeJr2a7ywdWhKUxgs6jJtrv//ws5LJpWcVVsCVG7S6M6pCFrccdspXQD
         vTg+J2q6kTwqexpJRnNhH6n5+60IBUu/Ld677kVHLrtYHWKTjDKmTKGTYgiFUStEO9mV
         F4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771269; x=1692376069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBLHW0O+U7ltOxkiaFrPl4r80XrqUswnN0F1DvZlWLA=;
        b=PZFF4qyPYFWlSW7bWEiK+0QTu67y7DJXXtjQKS5jJ41fnPF7LDsPMTV24IT7vQ/zV2
         vvyL5o1rNoeMX4WUKsS0FzowWCWnfrWK90PnrExBBSZ+VYNzUY/NF7xASB4UvrxIW7JF
         Pc9MBFv4eNrWv62zpwyVsjnVXpnJZvt3fOEl6s/Ip0OrTl8MbHwTdf1gVVulUIMYf9H9
         iYyqZ9vbav1HPf/kduMrB8EwTpxQOT6jZOxYxp59xJcYXAZ8U9tjekTnMXXJnffGG5oA
         MMWPgZnfO4XfEws3Lf67JxZ1kn5rMfUXjogO9UVclDl6GUK92KH6hj8ComOdlFJDuf/x
         kKyQ==
X-Gm-Message-State: AOJu0Ywe42clN3t6O0hNgkPrSGFDkcRi0fzLE5vXEZZ7hI2FSOV3iJxo
        xaqxUsMK0T0Zhzl6vpLibJt1U0HUK+kiow==
X-Google-Smtp-Source: AGHT+IG7DI3JPHKb2dK8+Dc9ds0vLNsF8STXLvtpglKPFgtXzT+HAvSj2rzV817TCI9VdQbEOEg3CQ==
X-Received: by 2002:a17:907:75d9:b0:99b:f53c:3648 with SMTP id jl25-20020a17090775d900b0099bf53c3648mr2279473ejc.72.1691771269042;
        Fri, 11 Aug 2023 09:27:49 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 02/24] libselinux: misc label cleanup
Date:   Fri, 11 Aug 2023 18:27:09 +0200
Message-Id: <20230811162731.50697-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop unused parameter from selabel_is_digest_set().  It is only written
to but writes to the function local copy of the pointer are void.

Constify read-only handle parameter of selabel_validate() and
compat_validate().

Constify read-only from-address parameter of digest_add_specfile().

Constify read-only function pointer array initfuncs.

Merge malloc(3) and memset(3) calls into calloc(3).

Simplify boolean assignment.

Drop duplicate include file.

Drop return at end of void function.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c          | 17 +++++++----------
 libselinux/src/label_internal.h |  6 +++---
 libselinux/src/label_support.c  |  4 +---
 libselinux/src/matchpathcon.c   |  2 +-
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 586e5e5e..a2efa99c 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -45,7 +45,7 @@ typedef int (*selabel_initfunc)(struct selabel_handle *rec,
 				const struct selinux_opt *opts,
 				unsigned nopts);
 
-static selabel_initfunc initfuncs[] = {
+static const selabel_initfunc initfuncs[] = {
 	&selabel_file_init,
 	CONFIG_MEDIA_BACKEND(selabel_media_init),
 	CONFIG_X_BACKEND(selabel_x_init),
@@ -56,8 +56,7 @@ static selabel_initfunc initfuncs[] = {
 
 static inline struct selabel_digest *selabel_is_digest_set
 				    (const struct selinux_opt *opts,
-				    unsigned n,
-				    struct selabel_digest *entry)
+				    unsigned n)
 {
 	struct selabel_digest *digest = NULL;
 
@@ -77,8 +76,7 @@ static inline struct selabel_digest *selabel_is_digest_set
 			if (!digest->specfile_list)
 				goto err;
 
-			entry = digest;
-			return entry;
+			return digest;
 		}
 	}
 	return NULL;
@@ -121,7 +119,7 @@ static inline int selabel_is_validate_set(const struct selinux_opt *opts,
 	return 0;
 }
 
-int selabel_validate(struct selabel_handle *rec,
+int selabel_validate(const struct selabel_handle *rec,
 		     struct selabel_lookup_rec *contexts)
 {
 	int rc = 0;
@@ -133,7 +131,7 @@ int selabel_validate(struct selabel_handle *rec,
 	if (rc < 0)
 		goto out;
 
-	contexts->validated = 1;
+	contexts->validated = true;
 out:
 	return rc;
 }
@@ -215,15 +213,14 @@ struct selabel_handle *selabel_open(unsigned int backend,
 		goto out;
 	}
 
-	rec = (struct selabel_handle *)malloc(sizeof(*rec));
+	rec = (struct selabel_handle *)calloc(1, sizeof(*rec));
 	if (!rec)
 		goto out;
 
-	memset(rec, 0, sizeof(*rec));
 	rec->backend = backend;
 	rec->validating = selabel_is_validate_set(opts, nopts);
 
-	rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
+	rec->digest = selabel_is_digest_set(opts, nopts);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
 		if (rec->digest)
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 782c6aa8..273a630a 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -63,7 +63,7 @@ struct selabel_digest {
 };
 
 extern int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
-						    char *from_addr,
+						    const char *from_addr,
 						    size_t buf_len,
 						    const char *path);
 extern void digest_gen_hash(struct selabel_digest *digest);
@@ -118,7 +118,7 @@ struct selabel_handle {
  * Validation function
  */
 extern int
-selabel_validate(struct selabel_handle *rec,
+selabel_validate(const struct selabel_handle *rec,
 		 struct selabel_lookup_rec *contexts) ;
 
 /*
@@ -136,7 +136,7 @@ extern void __attribute__ ((format(printf, 1, 2)))
 	} while (0)
 
 extern int
-compat_validate(struct selabel_handle *rec,
+compat_validate(const struct selabel_handle *rec,
 		struct selabel_lookup_rec *contexts,
 		const char *path, unsigned lineno) ;
 
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 54fd49a5..df474cba 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -10,7 +10,6 @@
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
-#include <errno.h>
 #include "label_internal.h"
 
 /*
@@ -138,7 +137,6 @@ void  digest_gen_hash(struct selabel_digest *digest)
 	Sha1Finalise(&context, (SHA1_HASH *)digest->digest);
 	free(digest->hashbuf);
 	digest->hashbuf = NULL;
-	return;
 }
 
 /**
@@ -154,7 +152,7 @@ void  digest_gen_hash(struct selabel_digest *digest)
  * Return %0 on success, -%1 with @errno set on failure.
  */
 int  digest_add_specfile(struct selabel_digest *digest, FILE *fp,
-				    char *from_addr, size_t buf_len,
+				    const char *from_addr, size_t buf_len,
 				    const char *path)
 {
 	unsigned char *tmp_buf;
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index bf2da083..9a9bafb0 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -35,7 +35,7 @@ void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
 	myprintf_compat = 1;
 }
 
-int compat_validate(struct selabel_handle *rec,
+int compat_validate(const struct selabel_handle *rec,
 		    struct selabel_lookup_rec *contexts,
 		    const char *path, unsigned lineno)
 {
-- 
2.40.1

