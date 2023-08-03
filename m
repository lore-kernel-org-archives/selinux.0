Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51433C001DB
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 16:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjHCQXf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbjHCQXe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 12:23:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E4330DB
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 09:23:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1421926a12.0
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691079811; x=1691684611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBLHW0O+U7ltOxkiaFrPl4r80XrqUswnN0F1DvZlWLA=;
        b=mB8w1jQbaC8Q1WlNj/4u2wL8hOjcm1/8ypR5btJc19g9yJcVb+sKE8ql2bSToUL/zd
         yfwBhCex1rK0PF94R4zy2g9JVkXaJ7esMLlqCMc3mqQaylkXgDM2cTAdL6jaNWkkHAdo
         8Hi65/ssUO68Pya9bZJCNDUHwhvI2W3hecsoY1rvxt8DwVsnqMORkpTAlDOcqjJBugp5
         jOjsSkFmfTjnFHiALh/kv+TAmrdWquKPOuMwlbGbNpxz9I9etFaw176CYRWqGpIJWrO3
         EuknuVFn8+dbSgXtAnkiZnKKeJwSoSGOAeo2+7t1OpB6QtcNSeihiyPEWnPlmPYf5AsM
         A2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079811; x=1691684611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBLHW0O+U7ltOxkiaFrPl4r80XrqUswnN0F1DvZlWLA=;
        b=hvzTd2//HfCAfV89fEq16Y854P/YSrKpyezbk7qxjjC1ZIA7KY2J01nzOF72nJFlAY
         2h9pXGYLrNq4UOlxRNlOikI35TzWWW32rmAemU+tlPXSDo+mX6NwhrIjSg3USbOyU2kz
         61TGQQP8zGvVmX4Nsx/D6//wPJNU9tBUnDZ+ga2gGHFyvyKvVjpzfmfOZsmMKzTGXyo/
         yrHCi28u9oJYybEKjTrB+dq1iyiJ8fFcoaghQtXu36mBOj0Q56q2YPl5kRdAzVQX+m+W
         1TEVNIh4hHIw9CJK48qfgSB3xUQjmRgGZUND3gWpTI0L4jmQxd1cMTf8ggW8XFrFS1W6
         QMaA==
X-Gm-Message-State: ABy/qLaAGaXJRQz82PUkoNUB6IRXSco2L4mnyPE1rmLzPUAX//WL3eLb
        tJJt6vdJiO2csnA9rHPPuDxUwtD0uSIZ9stiN7Y=
X-Google-Smtp-Source: APBJJlG7RWPPi3QFRApq/pCxEbT8RTUyN1XcvgB839p4/1HRkvONhFhsKItY216hKA6wVxAwupRvEQ==
X-Received: by 2002:a05:6402:1b05:b0:522:3a89:a79d with SMTP id by5-20020a0564021b0500b005223a89a79dmr7726482edb.2.1691079810936;
        Thu, 03 Aug 2023 09:23:30 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-150-191.77.0.pool.telefonica.de. [77.0.150.191])
        by smtp.gmail.com with ESMTPSA id u4-20020a05640207c400b0051d9ee1c9d3sm348edy.84.2023.08.03.09.23.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:23:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] libselinux: misc label cleanup
Date:   Thu,  3 Aug 2023 18:23:24 +0200
Message-Id: <20230803162326.302824-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803162326.302824-1-cgzones@googlemail.com>
References: <20230803162326.302824-1-cgzones@googlemail.com>
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

