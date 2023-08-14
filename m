Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AF1C07E8C
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjHNNVS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjHNNUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386451715
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so612345266b.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019241; x=1692624041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBLHW0O+U7ltOxkiaFrPl4r80XrqUswnN0F1DvZlWLA=;
        b=I0Gs77FwvSzk1nUeKXxtPeBDa82M1WHqIlNIKZLfVfEv9L5OXEn13Dw7j8sTuIIG82
         lUexmaSaGq0tdOAI4su6BjztXHJN/7A0gZCcvWLgGm7is0hfM1kv4YLQA4XovDMcliys
         kgIzABM23uO31TomuQGIWlq/8g95JB4ERMb8MuH4+jT3tlu+bnSCWl9OgJGSExLCWzPA
         w8qIMK1t01okSOrgvJNTzenhno/xN50hSn2hlpVdkAscAzlMkkAecNH/KEgS2fGS3Sic
         Eq0oa0N4JxDBPmAi+wHBeOi8wtL6Usrbt4bas/VDW8G5VREi0U23YPRt3zrKxrMG826Y
         vHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019241; x=1692624041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBLHW0O+U7ltOxkiaFrPl4r80XrqUswnN0F1DvZlWLA=;
        b=A+kRN7DcBZdf+79TWxdWPz3HBEZpARtvKRylAaH/Ea4Aa5eJmIuzvVxSnKSe5B1HHm
         lmTw6k4CCsDhDXwihAhwCaTazWMq3xIoWHlOxLH83lwu+gWYyW1Qxm5rpe6tjgsQQ8Tk
         G4jxe+OLVziMOLb8YoEEz9rKzkwYM3G74QacvkK92Eb9/fX2BnUL5GbL4QNvFKCf/+0a
         d6/RnSIkpzejnnAVgCzBnj0fjon6a0qUsNGkXljYK0wMSMnMcbEIEc/6VK3spIrp+XwW
         4Y6wG2mbLd1YiGYL+4BRSHULLhAo0s47bf5LS8fCdaIj6zsnhipSuYrnUQHzRqWAp4V6
         LDNQ==
X-Gm-Message-State: AOJu0Ywz0hDJsnRBIaMx049PbGE2DY7+zc7NGjaX/mYr4eCdV0lSh0Vg
        ry5yC+eehglCTlvMOjurzuKWm+bcVRHeokOijrk=
X-Google-Smtp-Source: AGHT+IFvKK3YYbe7bi/hGztikjdedqrj3aIVuiAQ94egHZn8FeCkkhjnLmMT74RMBBD4+tErOeEYlA==
X-Received: by 2002:a17:907:7634:b0:992:6064:f32b with SMTP id jy20-20020a170907763400b009926064f32bmr7701430ejc.46.1692019240504;
        Mon, 14 Aug 2023 06:20:40 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 02/27] libselinux: misc label cleanup
Date:   Mon, 14 Aug 2023 15:20:00 +0200
Message-Id: <20230814132025.45364-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
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

